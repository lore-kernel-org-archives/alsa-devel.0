From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Tue, 28 Apr 2009 02:23:09 +0200
Message-ID: <20090428002309.GA29572@x61>
References: <20090420184024.GA10155@dose.home.local> <s5hmyab15bh.wl%tiwai@suse.de> <20090420194659.GA11399@dose.home.local> <s5h8wluinon.wl%tiwai@suse.de> <20090421073219.GA5866@dose.home.local> <s5hfxg2cv6m.wl%tiwai@suse.de> <20090421183936.GA21935@dose.home.local> <s5hws9a5ewr.wl%tiwai@suse.de> <20090424142113.GA18668@dose.home.local> <s5hskjy5d2t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758752AbZD1AXX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hskjy5d2t.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 16:41:14 +0200, Takashi Iwai wrote:
> At Fri, 24 Apr 2009 16:21:13 +0200,
> Tino Keitel wrote:
> > 
> > On Fri, Apr 24, 2009 at 16:01:40 +0200, Takashi Iwai wrote:
> > 
> > [...]
> > 
> > > The codec communication looks a bit unstable on this device...
> > > Does this still happen on the latest 2.6.30 version?
> > 
> > Yes, at least with 2.6.30-rc3. I reloaded snd-hda-intel a few times,
> > and at some point /etc/init.d/alsa-utils start complained, I guess
> > because some index numbers in  the mixer changed.
> 
> And this happens because the codec doesn't respond properly any more.
> So, something triggers to screw up the communication with the codec.
> I have no idea right now.  Possibly you can bisect the changes against
> sound/pci/hda/patch_sigmatel.c...

The problem is that I don't have a reliable way to trigger this bug. It
just happens sometimes.

I just saw another, major problem: line in doesn't work anymore with
2.6.29 and also 2.6.30-rc3 (no usable input level). It works with
2.6.27.20.

So it seems that all newer kernels are pretty broken on this hardware
regarding sound.

Regards,
Tino
