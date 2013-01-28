From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: 3.7 HDMI channel map regression
Date: Sun, 27 Jan 2013 19:18:27 -0600
Message-ID: <20130128011827.GA30485@lintop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I recently updated my HTPC from 3.6.11 to 3.7.2 and this caused my RL
and FC channels to swap, and my RR and LFE channels to swap for PCM
audio.  Doing a git bisect identified
d45e6889ee69456a4d5b1bbb32252f460cd48fa9 "ALSA: hda - Provide the
proper channel mapping for generic HDMI driver" as the commit that
caused my channels to swap.  The commit doesn't revert cleanly on
3.7.4, and I haven't really looked to see what the correct fix might
be.

Some info that may be relevant, the sound card is a:

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)

The machine is running Fedora 18 and audio goes over HDMI to a 5.1
receiver.  I'm not really sure what other info you might need, but
let me know if you need something else or have any patches you would
like me to test.

Thanks,
Shawn
