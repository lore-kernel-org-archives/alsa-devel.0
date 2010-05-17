From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH 1/3] add API to allow disabling period
	interrupts
Date: Mon, 17 May 2010 11:05:15 -0500
Message-ID: <AANLkTinVjyUT6iXzGCvmwKPO0EinMzKjjdTcR7nWYl8G@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
	<AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
	<4BF12593.3040001@ladisch.de>
	<AANLkTimzbkgLopAzthKsrLPbv7IyK6fOgz8sNwZKMDU3@mail.gmail.com>
	<alpine.LNX.2.00.1005171611250.6856@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
	[209.85.211.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 7690E246BF
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 18:05:18 +0200 (CEST)
Received: by ywh6 with SMTP id 6so2592186ywh.16
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 09:05:15 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1005171611250.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> 2) The avail_min parameter in sw_params was overlooked. The lowlevel
> =A0 drivers can use this value to compute the wake-up point and set hw
> =A0 appropriately, to do wake-up at requested time. We can add a support
> =A0 functions like "return how many samples are expected to be transferred
> =A0 for next wake-up point" to linux/sound/pcm.h. In case when this value
> =A0 is high, no interrupts (wake ups) will be processed in the driver. If
> =A0 hardware cannot do the precise transfers, we can program a system
> =A0 timer as the wake-up source.

Isn't the interrupt-related behavior defined when you setup the DMA
linked list. i.e when hw_params are frozen? The problem with sw_params
is that they can change at any time, and the hardware may not support
this. I have no idea how you would modify the HDAudio controller
behavior dynamically for example.
