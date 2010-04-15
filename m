From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Thu, 15 Apr 2010 23:19:33 +0200
Message-ID: <4BC782E5.7070900@tremplin-utc.net>
References: <4BC4E812.6050602@tremplin-utc.net>	<s5h633u5zx1.wl%tiwai@suse.de>	<4BC5A566.8060106@tremplin-utc.net> <s5hy6gqvx9n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy6gqvx9n.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Frank Griffin <ftg@roadrunner.com>
List-Id: alsa-devel@alsa-project.org

Op 14-04-10 18:01, Takashi Iwai schreef:
:
>>
>> I don't fully grasp the meaning of bdl_pos_adj, so I don't know if it's
>> a bug to not play correctly when forcing it to 0. Is it?
> 
> It might be that this was for reducing the load by position
> correction mechanism.  You might see the hd-audio kernel thread in a
> high CPU usage.  This might be fixed also by position_fix=1, though. 
Yes, I had added this option after a regression in the previous kernel
which causes the hd-audio thread to take 50% of a CPU. Eventually, it
was fixed and not needed anymore. So I guess in the case of my laptop,
this is not really a regression, because everything is fine with the
default values.

In the case of Frank, this looks more like a regression, or at least a
bug to solve, because this happens with the default options. However,
this report should be taken with care, because this happens on a
2.6.33.2 kernel made by Mandriva, containing many alsa patches of
2.6.34. Frank, how possible would it be to test a 2.6.34-rc4 kernel from
Linus?

If this bug is confirmed, Takashi, do you know any way to choose
automatically position_fix=1 when needed?

See you,
Eric
