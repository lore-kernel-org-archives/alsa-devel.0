From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 2/4] ALSA: hda - add DP mst verb support
Date: Tue, 8 Mar 2016 07:49:44 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190467FD2E@SHSMSX103.ccr.corp.intel.com>
References: <1457362666-53937-1-git-send-email-libin.yang@linux.intel.com>
 <1457362666-53937-3-git-send-email-libin.yang@linux.intel.com>
 <s5h7fhedyod.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D190467FCCE@SHSMSX103.ccr.corp.intel.com>
 <s5hbn6p5sgr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 501AF260541
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 08:49:47 +0100 (CET)
In-Reply-To: <s5hbn6p5sgr.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, March 08, 2016 3:39 PM
> To: Yang, Libin
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin,
> Mengdong
> Subject: Re: [alsa-devel] [PATCH 2/4] ALSA: hda - add DP mst verb
> support
> 
> On Tue, 08 Mar 2016 07:54:44 +0100,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Tuesday, March 08, 2016 12:46 AM
> > > To: libin.yang@linux.intel.com
> > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> > > Subject: Re: [alsa-devel] [PATCH 2/4] ALSA: hda - add DP mst verb
> > > support
> > >
> > > On Mon, 07 Mar 2016 15:57:44 +0100,
> > > libin.yang@linux.intel.com wrote:
> > > >
> > > > +int snd_hda_set_dev_select(struct hda_codec *codec, hda_nid_t
> nid,
> > > int dev_id)
> > > > +{
> > > > +	int ret, dev;
> > > > +	unsigned long timeout;
> > > > +
> > > > +	/* not support dp_mst will always return 0, using first dev_entry
> > > */
> > > > +	if (!codec->dp_mst)
> > > > +		return 0;
> > > > +
> > > > +	/* If Device List Length is 0, the pin is not multi stream capable.
> > > > +	 */
> > > > +	if ((snd_hda_get_num_devices(codec, nid) + 1) == 0)
> > > > +		return 0;
> > >
> > > I don't understand what this code is for.  Why +1?
> >
> > Sorry, it should be if ((snd_hda_get_num_devices(codec, nid)) == 0).
> > 0 means not MST capable. Thanks for point it out.
> >
> > >
> > > > +
> > > > +	/* Behavior of setting index being equal to or greater than
> > > > +	 * Device List Length is not predictable
> > > > +	 */
> > > > +	if ((snd_hda_get_num_devices(codec, nid) + 1) <= dev_id)
> > > > +		return 0;
> > >
> > > Ditto.  And, calling the same function twice?
> >
> > (snd_hda_get_num_devices(codec, nid) + 1) means the device entry
> number.
> > If the (snd_hda_get_num_devices(codec, nid) + 1) == 3, it means there
> are
> > only 3 device entries. And dev_id being 0, 1, 2 is legal. It dev_id is 3 or
> greater,
> > it is illegal.
> 
> So, shouldn't it be like below?
>     if (dev_id >= num_devices)
>         return 0;
> 
> Also my point is that you don't need to call snd_hda_get_num_devices()
> twice.  It can be stored locally.

Get it. I will store it locally.

Regards,
Libin

> 
> 
> Takashi
