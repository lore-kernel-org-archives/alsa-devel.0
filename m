From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v4 1/2] ucm: Load device-specific
 configuration file based on the card long name
Date: Sun, 15 Jan 2017 10:01:15 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A19C50@shsmsx102.ccr.corp.intel.com>
References: <cover.1484381554.git.mengdong.lin@linux.intel.com>
 <d8b6cfb75c226c59f4ca6e15c419eb2955b582fa.1484381554.git.mengdong.lin@linux.intel.com>
 <s5hinpgivbp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id E66BE2654AD
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 11:01:20 +0100 (CET)
In-Reply-To: <s5hinpgivbp.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Sunday, January 15, 2017 4:25 PM
> 
> On Sat, 14 Jan 2017 09:23:55 +0100,
> mengdong.lin@linux.intel.com wrote:
> >
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> >
> > Intel DSP platform drivers are used by many different devices. For
> > user space to differentiate them, ASoC machine drivers may use the DMI
> > info
> > (vendor-product-version-board) as card long name. Possible card long
> > names
> > are:
> > DellInc.-XPS139343-01-0310JH
> > ASUSTeKCOMPUTERINC.-T100TA-1.0-T100TA
> > Circuitco-MinnowboardMaxD0PLATFORM-D0-MinnowBoardMAX
> > ...
> >
> > And user space can define configuration files like
> > longname\longname.conf for a specific device.
> 
> Do you mean a file name containing a backslash?
> I didn't find the relevant code in your patch...

No, the file name doesn't contain a backslash. It means we're using the card long name as both the directory name that contains the UCM config file and the name of the config file itself.
E.g. for the laptop Dell XPS 13, UCM will try to find a directory "DellInc.-XPS139343-01-0310JH", and then find the file " DellInc.-XPS139343-01-0310JH.conf" under the directory. If it cannot find the this file, it will fall back to open file "broadwell-rt286.conf" under directory "broadwell-rt286".

Sorry, I didn't give a clear explanation here. I'll revise the comments.

[snip]
 
> > +/* find the card in the local machine and store the card long name */
> > +static int get_card_long_name(snd_use_case_mgr_t *mgr) {
> > +	const char *card_name = mgr->card_name;
> > +	snd_ctl_t *handle;
> > +	int card, err;
> > +	snd_ctl_card_info_t *info;
> > +	const char *_name, *_long_name;
> > +
> > +	snd_ctl_card_info_alloca(&info);
> > +
> > +	card = -1;
> > +	if (snd_card_next(&card) < 0 || card < 0) {
> > +		uc_error("no soundcards found...");
> > +		return -1;
> > +	}
> > +
> > +	while (card >= 0) {
> > +		char name[32];
> > +
> > +		sprintf(name, "hw:%d", card);
> > +		err = snd_ctl_open(&handle, name, 0);
> > +		if (err < 0) {
> > +			uc_error("control open (%i): %s", card,
> > +				 snd_strerror(err));
> > +			goto next_card;
> > +		}
> > +
> > +		err = snd_ctl_card_info(handle, info);
> > +		if (err < 0) {
> > +			uc_error("control hardware info (%i): %s", card,
> > +				 snd_strerror(err));
> > +			snd_ctl_close(handle);
> > +			goto next_card;
> > +		}
> > +
> > +		/* Find the local card by comparing the given name with the
> > +		 * card name and long name. User may open a card by its
> long
> > +		 * name, so the given card name may be a long name.
> > +		 */
> > +		_name = snd_ctl_card_info_get_name(info);
> > +		_long_name = snd_ctl_card_info_get_longname(info);
> > +		if (!strncmp(card_name, _name, MAX_CARD_LONG_NAME)
> > +		    || !strncmp(card_name, _long_name,
> MAX_CARD_LONG_NAME)) {
> > +			strncpy(mgr->card_long_name, _long_name,
> > +				MAX_CARD_LONG_NAME - 1);
> 
> It's safer to assure the NUL-terminated string in mgr->card_name & co.  Then
> the above strncmp() can be a simple strcmp().

Okay. I'll add check  and assure this when receiving the mgr->card_name from the application.

Thanks
Mengdong
