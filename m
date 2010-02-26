From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 26 Feb 2010 13:18:36 +0800
Message-ID: <4f3252891002252118k64a65330v6febc070ea43b0af@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 103BD103800
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 06:18:37 +0100 (CET)
Received: by pvg16 with SMTP id 16so715021pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 21:18:36 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/16 Lennart Poettering <mznyfn@0pointer.de>

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
>
Refer to http://pulseaudio.org/wiki/BadDecibel

If (when flat volumes are enabled in PulseAudio) the playback volume of one
stream changes whenever another stream is played, this is most likely caused
be incorrect dB attenuation data exposed by the ALSA kernel driver.

This seem to the software attenuation of the playback volume when PA
software mix two or more playback streams
