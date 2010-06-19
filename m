From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Sat, 19 Jun 2010 10:39:06 +0800
Message-ID: <AANLkTimF2iotSHsjFQFtHYo89yuXZRcYvHNvJm79g4Dw@mail.gmail.com>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
	<4C1A2A9C.3000902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3717824523
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 04:39:08 +0200 (CEST)
Received: by gyd10 with SMTP id 10so1380545gyd.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2010 19:39:07 -0700 (PDT)
In-Reply-To: <4C1A2A9C.3000902@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/17 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > Should snd_mixer_selem_get_playback_volume() perform range check ?
>
> No, it's the responsibility of the control implementation to return
> valid values (and to check that values that are being set are valid).
>
>
> Regards,
> Clemens
> _
>

The root cause of the bug is gnome-volume-control allow user to set
PA_VOLUME to 150% and PA return the value outside the allowed range of the
"master" volume control of the pulse device

http://git.gnome.org/browse/gnome-media/commit/?id=cfe5cf8d6826f2eacf0d2b109381ec61dda50185
