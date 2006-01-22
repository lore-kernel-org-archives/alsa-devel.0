From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
Date: Sun, 22 Jan 2006 16:34:07 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601221632250.9516@tm8103.perex-int.cz>
References: <20060119174600.GT19398@stusta.de> <s5hmzhr7xsr.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr> <200601201844.29873.pzad@pobox.sk>
 <Pine.LNX.4.61.0601210958010.21704@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932236AbWAVPeK@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601210958010.21704@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 21 Jan 2006, Jan Engelhardt wrote:

> >> Ah, so http://alphagate.hopto.org/quad_dsp/ which I had created
> >> is The Right Thing?
> >
> >This will work for your card, but not for emu10k1.
> 
> Does emu10k1 provide no adsp, how does it work?

It supports multi-open and then the application can set channel routing 
specific per file descriptor (alsa-lib does this setup for user offering 
only abstract device names like front, rear, center_lfe, surround40, 
surround51 etc.).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
