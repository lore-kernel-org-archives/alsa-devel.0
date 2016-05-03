From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: separate capture
 and playback
Date: Tue, 3 May 2016 11:16:58 +0200
Message-ID: <CAFqH_50D5PQOkpCDefds3Nyktvitoe2Wx=YcXM2POox1ooO=0g@mail.gmail.com>
References: <1449657147-26959-1-git-send-email-john@metanate.com>
 <CAFqH_52C4JKno4uyt54UdWKAJKM4FPGRiQaQQ9_H-Mz1Cr+Hqg@mail.gmail.com>
 <20160430070049.GF14612@serenity.lan>
 <57282532.7000402@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 12492264F23
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 11:17:01 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id d62so1519880iof.1
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 02:17:01 -0700 (PDT)
In-Reply-To: <57282532.7000402@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sugar <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, John Keeping <john@keeping.me.uk>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

2016-05-03 6:12 GMT+02:00 sugar <sugar.zhang@rock-chips.com>:
> Hi John,
>
>
> On 4/30/2016 15:00, John Keeping Wrote:
>>
>> Hi Enric,
>>
>> On Fri, Apr 29, 2016 at 04:59:27PM +0200, Enric Balletbo Serra wrote:
>>>
>>> 2015-12-09 11:32 GMT+01:00 John Keeping <john@metanate.com>:
>>>>
>>>> If we only clear the tx/rx state when both are disabled it is not
>>>> possible to start/stop one multiple times while the other is running.
>>>> Since the two are independently controlled, treat them as such and
>>>> remove the false dependency between capture and playback.
>>>>
>>>> Signed-off-by: John Keeping <john@metanate.com>
>>>> ---
>>>>   sound/soc/rockchip/rockchip_i2s.c | 72
>>>> +++++++++++++++++----------------------
>>>>   1 file changed, 32 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/sound/soc/rockchip/rockchip_i2s.c
>>>> b/sound/soc/rockchip/rockchip_i2s.c
>>>> index 83b1b9c..acc6225 100644
>>>> --- a/sound/soc/rockchip/rockchip_i2s.c
>>>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>>>> @@ -82,8 +82,8 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev
>>>> *i2s, int on)
>>>>                                     I2S_DMACR_TDE_ENABLE,
>>>> I2S_DMACR_TDE_ENABLE);
>>>>
>>>>                  regmap_update_bits(i2s->regmap, I2S_XFER,
>>>> -                                  I2S_XFER_TXS_START |
>>>> I2S_XFER_RXS_START,
>>>> -                                  I2S_XFER_TXS_START |
>>>> I2S_XFER_RXS_START);
>>>> +                                  I2S_XFER_TXS_START,
>>>> +                                  I2S_XFER_TXS_START);
>>>>
>>>>                  i2s->tx_start = true;
>>>>          } else {
>>>> @@ -92,27 +92,23 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev
>>>> *i2s, int on)
>>>>                  regmap_update_bits(i2s->regmap, I2S_DMACR,
>>>>                                     I2S_DMACR_TDE_ENABLE,
>>>> I2S_DMACR_TDE_DISABLE);
>>>>
>>>> -               if (!i2s->rx_start) {
>>>> -                       regmap_update_bits(i2s->regmap, I2S_XFER,
>>>> -                                          I2S_XFER_TXS_START |
>>>> -                                          I2S_XFER_RXS_START,
>>>> -                                          I2S_XFER_TXS_STOP |
>>>> -                                          I2S_XFER_RXS_STOP);
>>>> +               regmap_update_bits(i2s->regmap, I2S_XFER,
>>>> +                                  I2S_XFER_TXS_START,
>>>> +                                  I2S_XFER_TXS_STOP);
>>>>
>>>> -                       regmap_update_bits(i2s->regmap, I2S_CLR,
>>>> -                                          I2S_CLR_TXC | I2S_CLR_RXC,
>>>> -                                          I2S_CLR_TXC | I2S_CLR_RXC);
>>>> +               regmap_update_bits(i2s->regmap, I2S_CLR,
>>>> +                                  I2S_CLR_TXC,
>>>> +                                  I2S_CLR_TXC);
>>>>
>>>> -                       regmap_read(i2s->regmap, I2S_CLR, &val);
>>>> +               regmap_read(i2s->regmap, I2S_CLR, &val);
>>>>
>>>> -                       /* Should wait for clear operation to finish */
>>>> -                       while (val) {
>>>> -                               regmap_read(i2s->regmap, I2S_CLR, &val);
>>>> -                               retry--;
>>>> -                               if (!retry) {
>>>> -                                       dev_warn(i2s->dev, "fail to
>>>> clear\n");
>>>> -                                       break;
>>>> -                               }
>>>> +               /* Should wait for clear operation to finish */
>>>> +               while (val & I2S_CLR_TXC) {
>>>> +                       regmap_read(i2s->regmap, I2S_CLR, &val);
>>>> +                       retry--;
>>>> +                       if (!retry) {
>>>> +                               dev_warn(i2s->dev, "fail to clear\n");
>>>> +                               break;
>>>>                          }
>>>>                  }
>>>>          }
>>>> @@ -128,8 +124,8 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev
>>>> *i2s, int on)
>>>>                                     I2S_DMACR_RDE_ENABLE,
>>>> I2S_DMACR_RDE_ENABLE);
>>>>
>>>>                  regmap_update_bits(i2s->regmap, I2S_XFER,
>>>> -                                  I2S_XFER_TXS_START |
>>>> I2S_XFER_RXS_START,
>>>> -                                  I2S_XFER_TXS_START |
>>>> I2S_XFER_RXS_START);
>>>> +                                  I2S_XFER_RXS_START,
>>>> +                                  I2S_XFER_RXS_START);
>>>>
>>>>                  i2s->rx_start = true;
>>>>          } else {
>>>> @@ -138,27 +134,23 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev
>>>> *i2s, int on)
>>>>                  regmap_update_bits(i2s->regmap, I2S_DMACR,
>>>>                                     I2S_DMACR_RDE_ENABLE,
>>>> I2S_DMACR_RDE_DISABLE);
>>>>
>>>> -               if (!i2s->tx_start) {
>>>> -                       regmap_update_bits(i2s->regmap, I2S_XFER,
>>>> -                                          I2S_XFER_TXS_START |
>>>> -                                          I2S_XFER_RXS_START,
>>>> -                                          I2S_XFER_TXS_STOP |
>>>> -                                          I2S_XFER_RXS_STOP);
>>>> +               regmap_update_bits(i2s->regmap, I2S_XFER,
>>>> +                                  I2S_XFER_RXS_START,
>>>> +                                  I2S_XFER_RXS_STOP);
>>>>
>>>> -                       regmap_update_bits(i2s->regmap, I2S_CLR,
>>>> -                                          I2S_CLR_TXC | I2S_CLR_RXC,
>>>> -                                          I2S_CLR_TXC | I2S_CLR_RXC);
>>>> +               regmap_update_bits(i2s->regmap, I2S_CLR,
>>>> +                                  I2S_CLR_RXC,
>>>> +                                  I2S_CLR_RXC);
>>>>
>>>> -                       regmap_read(i2s->regmap, I2S_CLR, &val);
>>>> +               regmap_read(i2s->regmap, I2S_CLR, &val);
>>>>
>>>> -                       /* Should wait for clear operation to finish */
>>>> -                       while (val) {
>>>> -                               regmap_read(i2s->regmap, I2S_CLR, &val);
>>>> -                               retry--;
>>>> -                               if (!retry) {
>>>> -                                       dev_warn(i2s->dev, "fail to
>>>> clear\n");
>>>> -                                       break;
>>>> -                               }
>>>> +               /* Should wait for clear operation to finish */
>>>> +               while (val & I2S_CLR_RXC) {
>>>> +                       regmap_read(i2s->regmap, I2S_CLR, &val);
>>>> +                       retry--;
>>>> +                       if (!retry) {
>>>> +                               dev_warn(i2s->dev, "fail to clear\n");
>>>> +                               break;
>>>>                          }
>>>>                  }
>>>>          }
>>>> --
>>>> 2.6.3.462.gbe2c914
>>>
>>>
>>> Using my Veyron Jerry Chromebook wiht latest kernel I found that the
>>> speakers doesn't work. Bisect points to this patch as the offending
>>> commit. However your changes looks reasonable the fact is that
>>> reverting the patch makes the audio work again on my device. I need to
>>> dig a bit more into the issue, but meanwhile, any idea on what is
>>> happening ? Can I ask which device did you test?
>>
>>
>> I tested this on a Radxa Rock2 square.  This change fixed an issue I
>> found when running separate processes for playback and recording (I was
>> testing with arecord and speaker-test IIRC) but I don't think that
>> should be relevant.  I just read through the patch again and I can't see
>> anything obviously wrong so I'm afraid I don't have any idea what's
>> causing the problem you're seeing.
>>
> Do you have test playback/capture at the same time? I think you may
> reproduce this issue if you do as follows:
>
> step 1: tinyplay test.wav -D 0 -d 0 -p 1024 -n 4 &
> step 2: tinycap r.wav -D 0 -d 0 -p 1024 -n 4 &
>
> you will find that there is no music now.
>
> because of this problem, we enable tx/rx at the same time to WA this issue.
>

I can confirm that reverting John's patch audio playback/capture at
the same time works on my Veyron Jerry Chromebook.

> May I know what's the issue that you met before?
>>
>>
>> John
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>>
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
