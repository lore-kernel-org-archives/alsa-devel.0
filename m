From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs4341: Add driver for CS4341
 CODEC
Date: Wed, 28 Sep 2016 21:20:21 +0000
Message-ID: <089b5613-3355-41df-92bf-5d0d7b10c220@EX4.ad.cirrus.com>
References: <1474448393.244848188@f267.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 978E32670AE
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 23:20:23 +0200 (CEST)
In-Reply-To: <1474448393.244848188@f267.i.mail.ru>
Content-Language: en-US
Content-ID: <8B6F8B6BB3D7B44EA5F4EF3950ECCCB6@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 9/21/16, 3:59 AM, "Alexander Shiyan" <shc_work@mail.ru> wrote:

>>On 9/8/16, 11:29 AM, "Alexander Shiyan" < shc_work@mail.ru > wrote:
>>
>...
>>>+config SND_SOC_CS4341
>>>+tristate "Cirrus Logic CS4341 CODEC"
>>>+depends on SPI_MASTER
>>>+select REGMAP_SPI
>>>+help
>>>+  Enable support for Cirrus Logic (Crystal) CS4341 CODEC.
>>>+
>>This devices primary interface is I2C.  That should be added as well
>>since
>>i2c is read/write and spi is write only.
>
>I can add I2C support, but can not test this.

OK, that is fine.  We can add a patch to support I2C after that.
>
>...
>>>+snd_soc_update_bits(codec, CS4341_REG_MODE2, CS4341_MODE2_DIF,
>>>+    bits24 ? CS4341_MODE2_DIF_RJ_24 :
>>>+    CS4341_MODE2_DIF_RJ_16);
>>>+break;
>>>+default:
>>>+dev_err(codec->dev, "Unsupported DAI format\n");
>>>+return -EINVAL;
>>>+}
>>
>>Can we use regmap_update_bits where we can?
>
>So you say that regmap_update_bits() is prefferred than
>snd_soc_update_bits() ?

Yes.
>
>---
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>https://urldefense.proofpoint.com/v2/url?u=http-3A__mailman.alsa-2Dproject
>.org_mailman_listinfo_alsa-2Ddevel&d=DQICAg&c=O3LcjD-V2Iepl5V0N1424A&r=NJt
>NI3T_InLOY17xIGk4jdUC7XljFdoy6miaxhGHOOI&m=D9AVC8o2an1rQHYC1xfoGKGHyAfKmCk
>0R0ahr8l8n3Q&s=EaM-NwVFymokJtsVOM7graacnT_2n68TY32zeMkDSbw&e= 
