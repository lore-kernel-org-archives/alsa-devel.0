From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi"
 devices initialization
Date: Mon, 18 Feb 2019 12:33:40 +0100
Message-ID: <8b28c8d6-c8bb-4b31-403b-023f49108e6f@samsung.com>
References: <CGME20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204@epcas2p2.samsung.com>
        <20190215144809.28007-1-s.nawrocki@samsung.com>
        <20190215144809.28007-2-s.nawrocki@samsung.com>
        <CAJKOXPfF7+Qp1DLR_YJJOXH-YMQqWbxr0Hp=cKU+7mc9oKTUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJKOXPfF7+Qp1DLR_YJJOXH-YMQqWbxr0Hp=cKU+7mc9oKTUtA@mail.gmail.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/18/19 12:00, Krzysztof Kozlowski wrote:
> On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:

>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index e36c44e2f1bb..4a6dd86459bc 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1339,20 +1339,34 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
>>  /* Create platform device for the secondary PCM */
>>  static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>>  {
[...]
>> +       ret = platform_device_add(pdev_sec);
>>         if (ret < 0) {
>> -               dev_info(&pdev->dev, "device_attach() failed\n");
>> +               platform_device_put(pdev_sec);
>>                 return ret;
>>         }
>>
>> -       priv->pdev_sec = pdev;
>> +       priv->pdev_sec = pdev_sec;
>> +
>> +       ret = device_attach(&pdev_sec->dev);
>> +       if (ret < 0) {
>> +               dev_info(&pdev_sec->dev, "device_attach() failed\n");
> 
> Don't you need here platform_device_unregister()?

It's in i2s_delete_secondary_device(), but it might be better
indeed to add it here and move the priv->pdev_sec assignment
to the end making it a last step. 

-- 
Thanks,
Sylwester
