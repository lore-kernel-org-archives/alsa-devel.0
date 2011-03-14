From: =?ISO-8859-2?Q?Prchal_Ji=F8=ED?= <jiri.prchal@aksignal.cz>
Subject: Re: PROBLEM: Asoc driver in 2.6.37.3 for AT91SAM9260 /
 TLV320AIC3X is broken
Date: Mon, 14 Mar 2011 07:35:06 +0100
Message-ID: <4D7DB71A.3020401@aksignal.cz>
References: <4D79E428.2060408@aksignal.cz>
	<20110311170516.f2e923fb.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 486D21037EA
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 07:35:11 +0100 (CET)
In-Reply-To: <20110311170516.f2e923fb.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: sedji.gaouaou@atmel.com, slapin@ossfans.org, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org



Dne 11.3.2011 16:05, Jarkko Nikula napsal(a):
> On Fri, 11 Mar 2011 09:58:16 +0100
> Prchal Ji=F8=ED <jiri.prchal@aksignal.cz> wrote:
> =

>> So I change file snd-soc-afeb9260.c, diff is attached, and Kconfig and M=
akefile too.
>> In version 2.6.35.11 it works good, but MMC/SD card doesn't work. (Somet=
hing is broken it that driver just in this
>> version). I need to work sound and SD card.
>> I thing the problem is somewhere between "tlv320aic3x-codec 0-001a: prob=
e" and "i2c-core: driver [tlv320aic3x-codec]
>> registered". In version 2.6.35.11 there is I2C communication, in 2.6.37 =
and higher nothing on I2C.
>> I also try to put newer alsa 1.0.24 to kernel 2.6.37.3 without any impro=
vement.
> =

> Just to make sure, have you added I2C_BOARD_INFO("tlv320aic3x", 0x1a)
> to afeb9260_i2c_devices[] in arch/arm/mach-at91/board-afeb-9260v1.c?

Yes, I have it.
> =

>> Trying to put older alsa (but same version?) from kernel 2.6.35.11 to 2.=
6.37.3 produce soundcard, but when try to play
>> kernel oops, "cannot dereference null pointer" and freezes.
>>
>> I try many versions of
>> /* Digital audio interface glue - connects codec <--> CPU */
>> static struct snd_soc_dai_link afeb9260_dai =3D {
>> 	.name =3D "TLV320AIC3X", //AIC3X
>> 	.stream_name =3D "AIC3X",
>> 	.cpu_dai_name =3D "atmel-ssc-dai.0", //atmel-ssc-dai
>> 	.codec_dai_name =3D "tlv320aic3x-hifi", //aic3x, aic3x-hifi, tlv320aic3x
>> 	.platform_name =3D "atmel-pcm-audio", //atmel_pcm-audio
>> 	.codec_name =3D "tlv320aic3x-codec.0-001a", //tlv320aic3x-codec.0-0x1a
>> 	.init =3D afeb9260_aic3x_init,
>> 	.ops =3D &afeb9260_ops,
>> };
> =

> codec_name and codec_dai_name look ok here.
> =
