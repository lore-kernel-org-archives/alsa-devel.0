From: Frank Griffin <ftg@roadrunner.com>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Sat, 17 Apr 2010 11:21:13 -0400
Message-ID: <4BC9D1E9.1090705@roadrunner.com>
References: <4BC4E812.6050602@tremplin-utc.net>	<s5h633u5zx1.wl%tiwai@suse.de>	<4BC5A566.8060106@tremplin-utc.net> <s5hy6gqvx9n.wl%tiwai@suse.de> <4BC782E5.7070900@tremplin-utc.net>
Reply-To: ftg@roadrunner.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BC782E5.7070900@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

=C3=89ric Piel wrote:
> In the case of Frank, this looks more like a regression, or at least =
a
> bug to solve, because this happens with the default options. However,
> this report should be taken with care, because this happens on a
> 2.6.33.2 kernel made by Mandriva, containing many alsa patches of
> 2.6.34. Frank, how possible would it be to test a 2.6.34-rc4 kernel f=
rom
> Linus?
>
>  =20

Done.  2.6.34-rc4 compiled with standard configuration and without=20
"options snd-hda-intel position_fix=3D1" in modprobe.conf works perfect=
ly:=20
normal sound and normal playback speed.
