From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] add API to allow disabling period
 interrupts
Date: Mon, 17 May 2010 16:42:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005171611250.6856@eeebox2.perex-int.cz>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
	<AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
	<4BF12593.3040001@ladisch.de>
	<AANLkTimzbkgLopAzthKsrLPbv7IyK6fOgz8sNwZKMDU3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-302215130-1274105588=:6856"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DB3124693
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 16:42:29 +0200 (CEST)
In-Reply-To: <AANLkTimzbkgLopAzthKsrLPbv7IyK6fOgz8sNwZKMDU3@mail.gmail.com>
Content-ID: <alpine.LNX.2.00.1005171617140.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, pl bossart <bossart.nospam@gmail.com>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-302215130-1274105588=:6856
Content-Type: TEXT/PLAIN; CHARSET=UTF-8; FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.LNX.2.00.1005171613221.6856@eeebox2.perex-int.cz>

On Mon, 17 May 2010, Jassi Brar wrote:

> On Mon, May 17, 2010 at 8:16 PM, Clemens Ladisch <clemens@ladisch.de> wro=
te:
>> Jassi Brar wrote:
>>> I am in favor of support variable hw_interrupt at lowest level, i.e, in
>>> ring buffer driver, instead of disabling hw_interrupt altogether.
>>
>> Removing the constant-sized periods restriction would certainly be
>> useful. =C2=A0However, it doesn't look as if anybody has the time to red=
esign
>> the ALSA API, the kernel framework and all the drivers.
> No need to redesign ALSA API and certainly no need to change _any_ driver=
,
> just like this interrupt disable call is optional so would period resize =
be.
>
> I only ask to make this newly added call as period-resize rather than
> a special case of period-disable.

This is very good point. But I have two comments:

1) Period-disable function is OK, but it should not have a name "no
    period irq": SNDRV_PCM_INFO_PERIOD_DISABLE or DISABLE_PERIOD looks
    better. This change does imply to set the period size automatically in
    the driver - probably to highest value (applications cannot choose/set
    the period size in this operation mode - it's useless anyway).
2) The avail_min parameter in sw_params was overlooked. The lowlevel
    drivers can use this value to compute the wake-up point and set hw
    appropriately, to do wake-up at requested time. We can add a support
    functions like "return how many samples are expected to be transferred
    for next wake-up point" to linux/sound/pcm.h. In case when this value
    is high, no interrupts (wake ups) will be processed in the driver. If
    hardware cannot do the precise transfers, we can program a system
    timer as the wake-up source.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
--8323584-302215130-1274105588=:6856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-302215130-1274105588=:6856--
