From: Alex Riesen <fork0@users.sourceforge.net>
Subject: 2.6.3-rc1: intel8x0 broken
Date: Mon, 9 Feb 2004 22:46:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040209214622.GA1944@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

I have a Gigabyte GA-I8IPE1000 Pro motherboard with a built-in 82801EB
(Intel Corp. 82801EB AC'97 Audio Controller).

The thing stopped produce any sound since Linus' last alsa update.
Reverting to the previous state of alsa driver works, of course.

Nothing in logs, no errors from programs. It is an SMT P4(ht), 1Gb, no
highmem.

Alsa-library is 1.0.2. I also tried to upgrade ac97 and intel8x0 code in
the kernel up to 1.0.2c (where it differed). Didn't change a thing.
(Strangely, there _are_ differences between 1.0.2c and the code in
kernel, even though pulling from linux-sound.bkbits.net/linux-sound does
no pulls anything).

I read the thread "intel8x0 has stopped working", started by James
Courtier-Dutton on alsa-devel, but can't figure out how to apply
anything of the discussion to my situation :)
