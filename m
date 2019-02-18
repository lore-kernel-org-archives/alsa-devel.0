From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: samsung: i2s: Fix the secondary platform
 device registration
Date: Mon, 18 Feb 2019 12:41:10 +0100
Message-ID: <36e84820-f75a-4dbb-e148-1aebad0d26ba@samsung.com>
References: <CGME20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678@epcas2p4.samsung.com>
        <20190215144809.28007-1-s.nawrocki@samsung.com>
        <CAJKOXPdViVjS9ZzbBy94+UPK6-DEbCdPx-vsAa-SvrntyNunAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJKOXPdViVjS9ZzbBy94+UPK6-DEbCdPx-vsAa-SvrntyNunAA@mail.gmail.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/18/19 09:31, Krzysztof Kozlowski wrote:
> On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:

>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index 6bf0f55d1e51..e36c44e2f1bb 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>>
>>  static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
>>  {
>> -       if (priv->pdev_sec) {
>> -               platform_device_del(priv->pdev_sec);
>> -               priv->pdev_sec = NULL;
>> -       }
>> +       platform_device_unregister(priv->pdev_sec);
>> +       priv->pdev_sec = NULL;
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Although I think that you might need to re-order calls in
> samsung_i2s_remove(). In general they should be in exact reverse order
> of probe(). In this case, clk_disable_unprepare(priv->clk) should be
> after unregistering secondary device. If order has to be different
> because of some reasons - could you document them in comment?

Makes sense, I will change the order and resend both patches.

Thanks,
Sylwester
