From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] ASoC: remove NULL pointer check for
	clk_disable_unprepare
Date: Sun, 21 May 2017 03:42:10 +0900
Message-ID: <CAK7LNAR22B6EHnF=JtJ+9Veq9exgW+BB_T4zLwccFP_6C3j7xA@mail.gmail.com>
References: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
 <20170520180403.mqwfrcjsyukv3phr@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82]) by alsa0.perex.cz (Postfix) with ESMTP id 493A226684C
 for <alsa-devel@alsa-project.org>; Sat, 20 May 2017 20:42:33 +0200 (CEST)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com
 [209.85.213.179]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id v4KIgBJW013753
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 03:42:12 +0900
Received: by mail-yb0-f179.google.com with SMTP id 187so17156848ybg.0
 for <alsa-devel@alsa-project.org>; Sat, 20 May 2017 11:42:12 -0700 (PDT)
In-Reply-To: <20170520180403.mqwfrcjsyukv3phr@kozik-lap>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Support Opensource <support.opensource@diasemi.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Krzysztof,


2017-05-21 3:04 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Sun, May 21, 2017 at 02:42:38AM +0900, Masahiro Yamada wrote:
>> After long term efforts of fixing non-common clock implementations,
>> clk_disable() is a no-op for a NULL pointer input, and this is now
>> tree-wide consistent.
>>
>> All clock consumers can safely call clk_disable(_unprepare) without
>> NULL pointer check.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  sound/soc/codecs/adau17x1.c                | 3 +--
>>  sound/soc/codecs/da7213.c                  | 3 +--
>>  sound/soc/codecs/da7218.c                  | 3 +--
>>  sound/soc/codecs/da7219-aad.c              | 5 ++---
>>  sound/soc/codecs/da7219.c                  | 3 +--
>>  sound/soc/codecs/es8328.c                  | 3 +--
>>  sound/soc/codecs/wm8731.c                  | 3 +--
>>  sound/soc/davinci/davinci-evm.c            | 3 +--
>>  sound/soc/fsl/imx-audmux.c                 | 6 ++----
>>  sound/soc/intel/boards/bytcr_rt5640.c      | 2 +-
>>  sound/soc/intel/boards/cht_bsw_rt5645.c    | 3 +--
>>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 ++----
>>  sound/soc/samsung/i2s.c                    | 3 +--
>>  13 files changed, 16 insertions(+), 30 deletions(-)
>>
>
> (...)
>
>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index af3ba4d..3a06acd 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1122,8 +1122,7 @@ static int i2s_runtime_suspend(struct device *dev)
>>       i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
>>       i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
>>
>> -     if (i2s->op_clk)
>> -             clk_disable_unprepare(i2s->op_clk);
>> +     clk_disable_unprepare(i2s->op_clk);
>>       clk_disable_unprepare(i2s->clk);
>
> I think the check in i2s_runtime_resume() should be removed then as well
> to keep it symmetrical. Otherwise it looks suspicious.


Hmm, you have a point.  We will lose the symmetry.

If samsung/i2s.c is only used with the common clock framework,
we can omit the NULL pointer check for clk_prepare_enable()
because it is also a no-op for NULL clk input
(it returns 0).

At this moment, this is not consistent for non-common clock implementations,
though.



-- 
Best Regards
Masahiro Yamada
