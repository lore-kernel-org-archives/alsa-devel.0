From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: new pcm format(s)
Date: Thu, 22 Aug 2002 08:12:49 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020822151249.46675.qmail@web11507.mail.yahoo.com>
References: <s5hy9azrlsf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA18967
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 17:12:51 +0200
In-Reply-To: <s5hy9azrlsf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > the SNDRV_PCM_FMTBIT_ are now defined as 64-bit unsigned integers.
> > But I think it would be worthwhile in the long run to use subformats.
> 
> it's only on the kernel side for ease of use.
> the api itself allows up to 256 (or more) formats.
> so we can change it at any time.

Agreed. Then it is mostly a matter of choosing the right use for subformats
(currently: none).

> > I built the ALSA framework (RC2) with those changes, but then all drivers
> > must be updated (e.g. dummy.c at line 207) to call snd_pcm_format_width()
> > with 2 parameters: the format AND the subformat. Is this something you
> > think would be possible?
> 
> is it needed to be a subformat?

With RC3, no. The SNDRV_PCM_FMTBIT_ enums being defined as 64-bit unsigned
values, I can add the 4 variants of G726 and possibly move up the
SNDRV_PCM_FORMAT_SPECIAL a bit higher. BTW, which version of GSM does ALSA
support (there are several variants, too)?

> also, note that runtime->format is not a mask but a value.
> hence you can combine the format and subformat in each 16bit if
> necessary.

Yes, this is the way it was done until now (in the driver and library). But
then again, it is a choice. So what is the purpose of the subformat in your
view, and how do you want me to proceed further (as I am obviously inclined in
having this contributed back to the ALSA framework)?

Guilhem.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
