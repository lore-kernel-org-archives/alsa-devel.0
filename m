From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sun, 29 Aug 2010 09:35:32 +0800
Message-ID: <AANLkTim1uX9vWq6E0CfiJi7PzwqzCz7O-Wy5k7cH81LN@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EE0D2436C
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 03:35:33 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2642232eyd.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 18:35:32 -0700 (PDT)
In-Reply-To: <4C77CE1D.2070501@canonical.com>
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

2010/8/27 David Henningsson <david.henningsson@canonical.com>

> So I've discovered that my sound card has a "PCM Playback Volume"
> control, but changing that control does not alter the volume. This is
> not only confusing but also a problem for PulseAudio. (PA merges this
> control into it's overall volume, and so when the user moves PA's volume
> control, in some ranges nothing happens.)
>

The "PCM Playback Volume" is a hardware volume control for those AC97 codec
( the name is "Wave" in Windows )

The "PCM Playback Volume" is most likely softvol on HDA Intel since it is
defined in HDA-Intel.conf

AFAIK, aplay has an option to disable softvol by using SND_PCM_NO_SOFTVOL

   --disable-softvol   disable software volume control (softvol)
