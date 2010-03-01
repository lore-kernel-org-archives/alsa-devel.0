From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Mon, 1 Mar 2010 08:51:49 +0800
Message-ID: <4f3252891002281651h3db0694btb1c5cb9693f3cdc9@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 67F791037F9
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 01:51:51 +0100 (CET)
Received: by pxi17 with SMTP id 17so2035563pxi.2
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 16:51:49 -0800 (PST)
In-Reply-To: <20100215192451.GA17938@tango.0pointer.de>
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

2010/2/16 Lennart Poettering <mznyfn@0pointer.de>

> Heya,
>
>
> Invalid dB data from the driver is a real problem for the "flat
> volume" logic in PA. We basically allow each app to control the full
> hw volume range individually, and then set the hw volume to the max of
> what all apps wanted and attenuate the other streams accordingly. On
> the Aureon this doesn't work at all, since the attenuation of the
> streams is miscalculated due to the invalid dB data.
>
> Lennart
>
>
But PA also did not provide dB information to alsa application through
alsa-pulse plugin

amixer -D pulse
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 65536 [100%] [on]
  Front Right: Playback 65536 [100%] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 65536
  Front Left: Capture 65536 [100%] [on]
  Front Right: Capture 65536 [100%] [on]
