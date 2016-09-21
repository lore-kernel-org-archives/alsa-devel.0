From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH_1/2=5D_ASoC=3A_cs4341=3A_Add_driv?=
 =?utf-8?q?er_for_CS4341_CODEC?=
Date: Wed, 21 Sep 2016 11:59:53 +0300
Message-ID: <1474448393.244848188@f267.i.mail.ru>
References: <1473352169-23954-1-git-send-email-shc_work@mail.ru>
 <6d495e97-4677-4f1b-9a19-b3c92e4ca606@EX4.ad.cirrus.com>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f267.i.mail.ru (f267.i.mail.ru [94.100.179.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F07C265ACA
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 10:59:56 +0200 (CEST)
In-Reply-To: <6d495e97-4677-4f1b-9a19-b3c92e4ca606@EX4.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?IkhhbmRyaWdhbiwgUGF1bCI=?= <Paul.Handrigan@cirrus.com>
Cc: =?UTF-8?B?IkF1c3RpbiwgQnJpYW4i?= <Brian.Austin@cirrus.com>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.com>, =?UTF-8?B?YWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn?= <alsa-devel@alsa-project.org>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

>On 9/8/16, 11:29 AM, "Alexander Shiyan" < shc_work@mail.ru > wrote:
>
...
>>+config SND_SOC_CS4341
>>+tristate "Cirrus Logic CS4341 CODEC"
>>+depends on SPI_MASTER
>>+select REGMAP_SPI
>>+help
>>+  Enable support for Cirrus Logic (Crystal) CS4341 CODEC.
>>+
>This devices primary interface is I2C.  That should be added as well since
>i2c is read/write and spi is write only.

I can add I2C support, but can not test this.

...
>>+snd_soc_update_bits(codec, CS4341_REG_MODE2, CS4341_MODE2_DIF,
>>+    bits24 ? CS4341_MODE2_DIF_RJ_24 :
>>+    CS4341_MODE2_DIF_RJ_16);
>>+break;
>>+default:
>>+dev_err(codec->dev, "Unsupported DAI format\n");
>>+return -EINVAL;
>>+}
>
>Can we use regmap_update_bits where we can?

So you say that regmap_update_bits() is prefferred than snd_soc_update_bits() ?

---
