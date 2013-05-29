From: Alan Stern <stern@rowland.harvard.edu>
Subject: Improving or replacing snd_printk()
Date: Wed, 29 May 2013 15:27:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305291516090.885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi:

Messages produced by snd_printk() aren't as informative as they could
be -- especially when CONFIG_SND_VERBOSE_PRINTK isn't enabled, which is
the case on most systems.

The routine uses printk() rather then dev_dbg(), dev_info(), or
dev_err().  As a result, the messages don't say what driver or device
is involved.  We just get something like:

[15919.883604] cannot submit urb (err = -18)

That's not much help to anybody.  If you didn't know what an urb was, 
you wouldn't even realize that this referred to a USB device.  And if 
you had multiple USB audio devices, you wouldn't know which one it 
referred to.

Has there been any thought of improving snd_printk(), or even better,
changing the call sites to use the dev_*() routines instead?

Alan Stern
