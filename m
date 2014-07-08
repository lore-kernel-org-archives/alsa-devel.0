From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH] ASoC: omap-dmic: Use devm_snd_soc_register_component
Date: Tue, 8 Jul 2014 17:18:13 +0530
Message-ID: <CAKDJKT5+2jCDKzF9CcXZKksTmP4kep=p+6E7tJ_KuXi3yTX=Og@mail.gmail.com>
References: <1404629414-3263-1-git-send-email-badarkhe.manish@gmail.com>
	<53BA68B1.5040309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <53BA68B1.5040309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Mon, Jul 7, 2014 at 3:00 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 07/06/2014 09:50 AM, Manish Badarkhe wrote:
>> Replaced snd_soc_register_component with its devres equivalent,
>> devm_snd_soc_register_component.
>>
>> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
>> ---
>> :100644 100644 6925d71... 011e30e... M        sound/soc/omap/omap-dmic.c
>>  sound/soc/omap/omap-dmic.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
>> index 6925d71..011e30e 100644
>> --- a/sound/soc/omap/omap-dmic.c
>> +++ b/sound/soc/omap/omap-dmic.c
>> @@ -490,7 +490,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
>>       }
>>
>>
>> -     ret = snd_soc_register_component(&pdev->dev, &omap_dmic_component,
>> +     ret = devm_snd_soc_register_component(&pdev->dev, &omap_dmic_component,
>>                                        &omap_dmic_dai, 1);
>
> Would you align the parameters at the same time?

Sure, will do it and send next version.

Regards
Manish Badarkhe
