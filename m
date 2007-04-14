From: Adrian Bunk <bunk@stusta.de>
Subject: [2/3] 2.6.21-rc6: known regressions
Date: Sat, 14 Apr 2007 02:38:01 +0200
Message-ID: <20070414003801.GT5907@stusta.de>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754154AbXDNAk7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Hans-Georg Rist <hg.rist@web.de>, perex@suse.cz, alsa-devel@alsa-project.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andi Kleen <ak@suse.de>, Oliver Neukum <oneukum@suse.de>, greg@kroah.com, linux-usb-devel@lists.sourceforge.net, Tino Keitel <tino.keitel@gmx.de>, Marcelo Tosatti <marcelo@kvack.org>, CIJOML <cijoml@volny.cz>, Markus Rechberger <markus.rechberger@amd.com>, v4l-dvb-maintainer@linuxtv.org
List-Id: alsa-devel@alsa-project.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : snd_hda_intel doesn't work with ASUS M2V mainboard
References : http://bugzilla.kernel.org/show_bug.cgi?id=8273
Submitter  : Hans-Georg Rist <hg.rist@web.de>
Status     : unknown


Subject    : snd_intel8x0: divide error: 0000
References : http://lkml.org/lkml/2007/3/5/252
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Status     : unknown


Subject    : hal daemon crashes after pulling a USB serial device
References : http://www.opensubscriber.com/message/linux-usb-devel@lists.sourceforge.net/6369800.html
Submitter  : Andi Kleen <ak@suse.de>
Handled-By : Oliver Neukum <oneukum@suse.de>
Status     : problem is being debugged


Subject    : USB: iPod doesn't work  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2007/3/21/320
Submitter  : Tino Keitel <tino.keitel@gmx.de>
Caused-By  : Marcelo Tosatti <marcelo@kvack.org>
             commit 1d619f128ba911cd3e6d6ad3475f146eb92f5c27
Handled-By : Oliver Neukum <oneukum@suse.de>
Status     : problem is being debuggged


Subject    : USB: Oops when changing DVB-T adapter
References : http://lkml.org/lkml/2007/3/9/212
Submitter  : CIJOML <cijoml@volny.cz>
Handled-By : Markus Rechberger <markus.rechberger@amd.com>
Patch      : http://lkml.org/lkml/2007/4/5/154
Status     : patches available
