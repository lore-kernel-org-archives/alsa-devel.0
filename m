From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Fri, 18 Jun 2010 07:39:07 +0800
Message-ID: <AANLkTin7y2JzkaCYb4p69uDfWOo4cTa85in0Q3l7RwbD@mail.gmail.com>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
	<4C1A2A9C.3000902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 34D6F1037F1
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 01:39:11 +0200 (CEST)
Received: by vws6 with SMTP id 6so2062375vws.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2010 16:39:08 -0700 (PDT)
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
>

If it is the responsibility of the driver/external plugin to keep the value
inside the allowed range

your patch actually help those buggy driver/external plugin hide the bug
only
