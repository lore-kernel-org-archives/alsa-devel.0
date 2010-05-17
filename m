From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] add API to allow disabling period
 interrupts
Date: Mon, 17 May 2010 18:54:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005171851430.6856@eeebox2.perex-int.cz>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
	<AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
	<4BF12593.3040001@ladisch.de>
	<AANLkTimzbkgLopAzthKsrLPbv7IyK6fOgz8sNwZKMDU3@mail.gmail.com>
	<alpine.LNX.2.00.1005171611250.6856@eeebox2.perex-int.cz>
	<AANLkTinVjyUT6iXzGCvmwKPO0EinMzKjjdTcR7nWYl8G@mail.gmail.com>
	<alpine.LNX.2.00.1005171821330.6856@eeebox2.perex-int.cz>
	<AANLkTikHAC8FntaVnGXvQab9yRZG5DW-Jg_EyZNtY9-j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1099408220-1274115286=:6856"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E8E7246F0
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 18:54:47 +0200 (CEST)
In-Reply-To: <AANLkTikHAC8FntaVnGXvQab9yRZG5DW-Jg_EyZNtY9-j@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1099408220-1274115286=:6856
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 17 May 2010, pl bossart wrote:

>>>> 2) The avail_min parameter in sw_params was overlooked. The lowlevel
>>>> =C2=A0 drivers can use this value to compute the wake-up point and set=
 hw
>>>> =C2=A0 appropriately, to do wake-up at requested time. We can add a su=
pport
>>>> =C2=A0 functions like "return how many samples are expected to be tran=
sferred
>>>> =C2=A0 for next wake-up point" to linux/sound/pcm.h. In case when this=
 value
>>>> =C2=A0 is high, no interrupts (wake ups) will be processed in the driv=
er. If
>>>> =C2=A0 hardware cannot do the precise transfers, we can program a syst=
em
>>>> =C2=A0 timer as the wake-up source.
>>>
>>> Isn't the interrupt-related behavior defined when you setup the DMA
>>> linked list. i.e when hw_params are frozen? The problem with sw_params
>>> is that they can change at any time, and the hardware may not support
>>> this. I have no idea how you would modify the HDAudio controller
>>> behavior dynamically for example.
>>
>> Look my last sentence - we should use another timing source like system
>> timer in this case.
>
> Sorry, I misunderstood what you meant by 'precise transfers'. If we
> use a system timer, we would need to keep track of the drift between
> audio clock and system time as PulseAudio does it. Would your proposal
> entail moving this interpolation code into the kernel and let
> PulseAudio only program avail_min?

I think that this is not job for the driver. The driver should just
obtain the current DMA position at the wake-up time and eventually store=20
the monotonic clock for a drift handling in the user space. Note that=20
even with IRQs, the actual DMA position can be delayed a bit (irq=20
processing).

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1099408220-1274115286=:6856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1099408220-1274115286=:6856--
