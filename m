From: Frank Griffin <ftg@roadrunner.com>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Wed, 14 Apr 2010 11:39:08 -0400
Message-ID: <4BC5E19C.8060509@roadrunner.com>
References: <4BC4E812.6050602@tremplin-utc.net>	<s5h633u5zx1.wl%tiwai@suse.de>	<4BC5A566.8060106@tremplin-utc.net>	<4BC5AD08.8040606@tremplin-utc.net> <s5hy6gqxiev.wl%tiwai@suse.de> <4BC5D2F4.4010500@tremplin-utc.net>
Reply-To: ftg@roadrunner.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BC5D2F4.4010500@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

=C3=89ric Piel wrote:
> Frank,
> Could you check that for you too adding "position_fix=3D1" fixes the =
problem?
>
> To do so, edit /etc/modprobe.conf and add this line at end:
> options snd-hda-intel position_fix=3D1
>
> You need to reboot for this to be taken into account.
>
>  =20
That fixes not only the playback speed, but also the fact that the=20
failing system had no sound since the problem started (the acceleration=
=20
was noticed in movie playback).

Thanks !
