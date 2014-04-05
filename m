From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Sun, 6 Apr 2014 00:33:54 +0800
Message-ID: <CAFRkauA_e1VPadEOwQgRjapErhK77FO=UVOV4CuNnmmq0sW1aA@mail.gmail.com>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
 <CAFRkauBYAZDrrbGkZH3jGKzMJHYMEN00yXgLWtk+9m_dwDqB_w@mail.gmail.com>
 <2009B58E-4C0C-456B-B7D3-5ADC68931CE5@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 8562F264F40
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 18:39:25 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id hw13so2048718qab.31
 for <alsa-devel@alsa-project.org>; Sat, 05 Apr 2014 09:39:21 -0700 (PDT)
In-Reply-To: <2009B58E-4C0C-456B-B7D3-5ADC68931CE5@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

2014-04-05 20:48 GMT+08:00 Austin, Brian <Brian.Austin@cirrus.com>:
>
> On Apr 4, 2014, at 8:59 PM, Axel Lin <axel.lin@ingics.com> wrote:
>
> 2014-04-05 1:00 GMT+08:00 Brian Austin <brian.austin@cirrus.com>:
>
> On Fri, 4 Apr 2014, Axel Lin wrote:
>
>
>        ret = regmap_read(cs42l52->regmap, CS42L52_CHIP, &reg);
> -       devid = reg & CS42L52_CHIP_ID_MASK;
> +       devid = (reg & CS42L52_CHIP_ID_MASK) >> 3;
>
>
>
> What you added does the same thing as what was already there.
> The CHIP_ID is E0.
>
>
> Use CS42L52_CHIP_REV_A1 as example:
> 11100001 -> CS42L52_CHIP_REV_A1
> BIT[0:2] REVID
> BIT[3:7] CHIPID (CS42L52: 11100)
>
> Current code displays:
> 0xE1 for REVID (because it uses 0xFF as mask)
> 0xE0 for CHIPID
>
> I would expect the driver displays:
> 01 for REVID
> 11100 (0x1C) for CHIPID.
>
> Which it does not, but your addition of the  correct mask for REV_ID does.
> But this block of code only checks devid to make sure we are this device.
> Nothing more.
>
> I think current code mixes REVID & CHIPID.
>
>
> Only for the print statement. Not the DEVICE ID check.
>
> That is why I change the define of CS42L52_CHIP_ID to 0x1C
> and change CS42L52_CHIP_ID_MASK  to (0x1F << 3).
> In my point of view, the chip id is 0x1C rather than 0xE0,
>
>
> CHIP_ID is E0

You still think the chipid is E0 here for CS42L52.
Then I'll say the way you interpret the chipid is inconsistent for different
Cirrus Logic chips.

For example:
CS42L51 also has similar bit difines for REV_ID and CHIP_ID.

BIT[0:2]: REV_ID
BIT[3:7]: CHIP_ID (The chip id fields in binary is: 11011)

In cs42l51.h:  it defines CS42L51_CHIP_ID to 0x1B rather than 0xDB.

>
> we got the chip id by reading BIT[3:7] of register 01h.
>
>
>
>
>        if (devid != CS42L52_CHIP_ID) {
>                ret = -ENODEV;
>                dev_err(&i2c_client->dev,
> @@ -1259,7 +1259,7 @@ static int cs42l52_i2c_probe(struct i2c_client
> *i2c_client,
>        }
>
>        dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision:
> %02X\n",
> -                       reg & 0xFF);
> +                       reg & CS42L52_CHIP_REV_MASK);
>
>
>
> This works
>
>
>
>        /* Set Platform Data */
>        if (cs42l52->pdata.mica_diff_cfg)
> -#define CS42L52_CHIP_ID                                0xE0
> -#define CS42L52_CHIP_ID_MASK                   0xF8
> +#define CS42L52_CHIP_ID                                0x1C
> +#define CS42L52_CHIP_ID_MASK                   (0x1F << 3)
> #define CS42L52_CHIP_REV_A0                     0x00
> #define CS42L52_CHIP_REV_A1                     0x01
> #define CS42L52_CHIP_REV_B0                     0x02
> -#define CS42L52_CHIP_REV_MASK                  0x03
> +#define CS42L52_CHIP_REV_B1                    0x03
>
>
>
> If you used this it would be cool, but your not so I don't see the need for
> it.
>
> So if you want to add the code to actually display the REV_ID I would ack
> that, but I dont see anything that this patch actually fixes.
>
>
> I think to actually display the REV_ID or not is another topic.
> This patch does is to fix the display value.
> (see above example, both chipid and revid are different from original code).
>
>
> Then just fix the display value. which is the 1 line that fixes the
> REV_MASK. That's a bug
> the rest of the current code works just fine.

Well, I sent a patch to simply fix the REV_MASK.
>
> Thanks
>
