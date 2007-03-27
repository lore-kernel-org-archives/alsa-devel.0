From: Adrian Bunk <bunk@stusta.de>
Subject: [3/5] 2.6.21-rc5: known regressions
Date: Tue, 27 Mar 2007 03:59:43 +0200
Message-ID: <20070327015943.GA16477@stusta.de>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933934AbXC0CAs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, CIJOML <cijoml@volny.cz>, v4l-dvb-maintainer@linuxtv.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, perex@suse.cz, alsa-devel@alsa-project.org, Tino Keitel <tino.keitel@gmx.de>, Marcelo Tosatti <marcelo@kvack.org>, Oliver Neukum <oneukum@suse.de>, greg@kroah.com, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : Oops when changing DVB-T adapter
References : http://lkml.org/lkml/2007/3/9/212
Submitter  : CIJOML <cijoml@volny.cz>
Status     : unknown


Subject    : snd_intel8x0: divide error: 0000
References : http://lkml.org/lkml/2007/3/5/252
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Status     : unknown


Subject    : USB: iPod doesn't work  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2007/3/21/320
Submitter  : Tino Keitel <tino.keitel@gmx.de>
Caused-By  : Marcelo Tosatti <marcelo@kvack.org>
             commit 1d619f128ba911cd3e6d6ad3475f146eb92f5c27
Handled-By : Oliver Neukum <oneukum@suse.de>
Status     : problem is being debuggged
