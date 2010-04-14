From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Wed, 14 Apr 2010 16:36:36 +0200
Message-ID: <4BC5D2F4.4010500@tremplin-utc.net>
References: <4BC4E812.6050602@tremplin-utc.net>	<s5h633u5zx1.wl%tiwai@suse.de>	<4BC5A566.8060106@tremplin-utc.net>	<4BC5AD08.8040606@tremplin-utc.net> <s5hy6gqxiev.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy6gqxiev.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Frank Griffin <ftg@roadrunner.com>
List-Id: alsa-devel@alsa-project.org

On 14/04/10 15:39, Takashi Iwai wrote:
:
> 
> bdl_pos_adj is really a workaround for devices that report wrong DMA
> position (or at the wrong timing).  I guess position_fix=1 may fix
> better.
> 
> Although the driver already has a dynamic switching of position_fix
> method, it checks only the very first read.  If it gives a (more or
> less) sane value, it prefers the position-buffer method (corresponding
> to position_fix=2) rather than reading LPIB register
> (position_fix=1).
> 
> It seems, however, that more devices work sanely with LPIB reg
> nowdays.  This wasn't the case formerly.  So, it might be better to
> use position_fix=1 as default for modern systems...
Frank,
Could you check that for you too adding "position_fix=1" fixes the problem?

To do so, edit /etc/modprobe.conf and add this line at end:
options snd-hda-intel position_fix=1

You need to reboot for this to be taken into account.

Cheers,
Eric
