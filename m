From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs
Date: Mon, 9 Sep 2002 13:20:28 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209091317130.6898-100000@cmn37.stanford.edu>
References: <s5hwupvzcop.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwupvzcop.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > > Sure, it is included at the end of the email. I found the
> > > > same problem yesterday in an ens1371 based soundcard.
> > > 
> > > I've fixed the problem in CVS for intel8x0
> > 
> > Something else has changed, I now get a:
> 
> could you check where the error is returned (e.g. by primitive printk's)
> ? i guess somewhere in snd_ac97_mixer in pci/ac97_codec.c, but not
> sure...

I sprinkled some printks around till I got this:

Sep  9 13:18:46 pc1 kernel: intel8x0 create
Sep  9 13:18:46 pc1 kernel: PCI: Setting latency timer of device 00:1f.5 
to 64
Sep  9 13:18:47 pc1 kernel: intel8x0 end create
Sep  9 13:18:47 pc1 kernel: ac97_mixer begin
Sep  9 13:18:47 pc1 kernel: ac97_mixer before reset to defaults
Sep  9 13:18:47 pc1 kernel: ac97_mixer after udelay(50)
Sep  9 13:18:47 pc1 kernel: ac97_mixer after access_ok
Sep  9 13:18:47 pc1 kernel: ac97_mixer after ready_ok
Sep  9 13:18:47 pc1 kernel: ac97_mixer end
Sep  9 13:18:47 pc1 kernel: ac97_mixer begin
Sep  9 13:18:47 pc1 kernel: ac97_mixer before reset to defaults
Sep  9 13:18:47 pc1 kernel: ac97_mixer after udelay(50)
Sep  9 13:18:48 pc1 kernel: ac97_mixer fail with ENXIO
Sep  9 13:18:48 pc1 kernel: Intel ICH soundcard not found or device busy

For some reason ac97_mixer is being called twice, the second time it fails 
at around line 1513 (a loop with timeout). I don't know what would be the 
proper behavior. Let me know if you need more debugging info. 

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
