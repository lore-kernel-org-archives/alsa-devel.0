From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Sat, 5 Apr 2014 10:04:16 +0800
Message-ID: <CAFRkauCfAN+VwMEW7N-EkvrSdUi-XDe4gm=WDQJPKAttbT-aQg@mail.gmail.com>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
 <alpine.DEB.2.02.1404041646460.3451@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id A0C46265864
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 04:04:17 +0200 (CEST)
Received: by mail-qc0-f181.google.com with SMTP id x3so4247051qcv.40
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 19:04:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1404041646460.3451@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

2014-04-05 5:50 GMT+08:00 Brian Austin <brian.austin@cirrus.com>:
>
>> On Fri, 4 Apr 2014, Axel Lin wrote:
>>
>>>
>>>         dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision:
>>> %02X\n",
>>> -                       reg & 0xFF);
>>> +                       reg & CS42L52_CHIP_REV_MASK);
>
>
>>> #define CS42L52_CHIP_REV_B0                     0x02
>>> -#define CS42L52_CHIP_REV_MASK                  0x03
>>> +#define CS42L52_CHIP_REV_B1                    0x03
>
>
> Correct me if I'm wrong, but it looks like you added CS42L52_CHIP_REV_MASK
> and then replaced that define with CS42L52_CHIP_REV_B1?

The diff looks like that but...
Actually what I did is fix CS42L52_CHIP_REV_MASK, it should be 0x07.
and while at it, I also add CS42L52_CHIP_REV_B1 (0x03).

-#define CS42L52_CHIP_REV_MASK                  0x03
+#define CS42L52_CHIP_REV_B1                    0x03
+#define CS42L52_CHIP_REV_MASK                  0x07

Regards,
Axel
