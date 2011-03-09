From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] WARNING: at fs/sysfs/dir.c:455 sysfs_add_one+0x83/0x95
Date: Wed, 09 Mar 2011 12:21:53 -0500
Message-ID: <1299691313.15854.267.camel@gandalf.stny.rr.com>
References: <1299685189.15854.182.camel@gandalf.stny.rr.com>
	 <20110309155309.GA30598@suse.de>
	 <1299687658.15854.227.camel@gandalf.stny.rr.com>
	 <s5hfwqwnt9s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfwqwnt9s.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <gregkh@suse.de>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-09 at 17:38 +0100, Takashi Iwai wrote:

> Could you try the patch below?  Totally untested.

It seems to work. I added the patch and the warning is gone, and removed
it, and it reappeared. Now, I don't have and speakers attached to this
test box, so I never tested if sound works ;)

> 
> 
> Takashi
> 
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] sound: Use sound_register_*() for additional OSS minor devices
> 
> Since OSS driver creates the device entries for /dev/audio* and
> /dev/dspW* by itself without coping with sound_core, it leads to
> conflicts with others and let sysfs spewing warnings.
> 
> This patch rewrites the registration part of OSS driver to use
> the standard method also for additional minor devices.

Reported-by: Steven Rostedt <rostedt@goodmis.org> (with ktest.pl)
Tested-by: Steven Rostedt <rostedt@goodmis.org> (with ktest.pl)

-- Steve

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
