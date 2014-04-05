From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Sat, 5 Apr 2014 09:59:00 +0800
Message-ID: <CAFRkauBYAZDrrbGkZH3jGKzMJHYMEN00yXgLWtk+9m_dwDqB_w@mail.gmail.com>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A0B4F265855
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 03:59:01 +0200 (CEST)
Received: by mail-qa0-f50.google.com with SMTP id o15so3820820qap.23
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 18:59:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1404041128380.3451@heelrod>
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

2014-04-05 1:00 GMT+08:00 Brian Austin <brian.austin@cirrus.com>:
> On Fri, 4 Apr 2014, Axel Lin wrote:
>
>>
>>         ret = regmap_read(cs42l52->regmap, CS42L52_CHIP, &reg);
>> -       devid = reg & CS42L52_CHIP_ID_MASK;
>> +       devid = (reg & CS42L52_CHIP_ID_MASK) >> 3;
>
>
> What you added does the same thing as what was already there.
> The CHIP_ID is E0.

Use CS42L52_CHIP_REV_A1 as example:
11100001 -> CS42L52_CHIP_REV_A1
BIT[0:2] REVID
BIT[3:7] CHIPID (CS42L52: 11100)

Current code displays:
0xE1 for REVID (because it uses 0xFF as mask)
0xE0 for CHIPID

I would expect the driver displays:
01 for REVID
11100 (0x1C) for CHIPID.

I think current code mixes REVID & CHIPID.
That is why I change the define of CS42L52_CHIP_ID to 0x1C
and change CS42L52_CHIP_ID_MASK  to (0x1F << 3).
In my point of view, the chip id is 0x1C rather than 0xE0,
we got the chip id by reading BIT[3:7] of register 01h.


>
>
>>         if (devid != CS42L52_CHIP_ID) {
>>                 ret = -ENODEV;
>>                 dev_err(&i2c_client->dev,
>> @@ -1259,7 +1259,7 @@ static int cs42l52_i2c_probe(struct i2c_client
>> *i2c_client,
>>         }
>>
>>         dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision:
>> %02X\n",
>> -                       reg & 0xFF);
>> +                       reg & CS42L52_CHIP_REV_MASK);
>
>
> This works
>>
>>
>>         /* Set Platform Data */
>>         if (cs42l52->pdata.mica_diff_cfg)
>> -#define CS42L52_CHIP_ID                                0xE0
>> -#define CS42L52_CHIP_ID_MASK                   0xF8
>> +#define CS42L52_CHIP_ID                                0x1C
>> +#define CS42L52_CHIP_ID_MASK                   (0x1F << 3)
>> #define CS42L52_CHIP_REV_A0                     0x00
>> #define CS42L52_CHIP_REV_A1                     0x01
>> #define CS42L52_CHIP_REV_B0                     0x02
>> -#define CS42L52_CHIP_REV_MASK                  0x03
>> +#define CS42L52_CHIP_REV_B1                    0x03
>
>
> If you used this it would be cool, but your not so I don't see the need for
> it.
>
> So if you want to add the code to actually display the REV_ID I would ack
> that, but I dont see anything that this patch actually fixes.

I think to actually display the REV_ID or not is another topic.
This patch does is to fix the display value.
(see above example, both chipid and revid are different from original code).

>
> -Brian
