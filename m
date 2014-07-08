From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH] ASoC: omap-hdmi: Use devm_snd_soc_register_component
Date: Tue, 8 Jul 2014 17:17:33 +0530
Message-ID: <CAKDJKT5_AZD=EpPRsX7XL7eAEux5jGzx9+8M5hNvvuUKrAouxw@mail.gmail.com>
References: <1404629383-3225-1-git-send-email-badarkhe.manish@gmail.com>
	<53BA688B.3080901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <53BA688B.3080901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Mon, Jul 7, 2014 at 2:59 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 07/06/2014 09:49 AM, Manish Badarkhe wrote:
>> Replaced snd_soc_register_component with its devres equivalent,
>> devm_snd_soc_register_component.
>>
>> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
>> ---
>> :100644 100644 eb9c392... 1dc95b5... M        sound/soc/omap/omap-hdmi.c
>>  sound/soc/omap/omap-hdmi.c |    4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
>> index eb9c392..1dc95b5 100644
>> --- a/sound/soc/omap/omap-hdmi.c
>> +++ b/sound/soc/omap/omap-hdmi.c
>> @@ -322,7 +322,7 @@ static int omap_hdmi_probe(struct platform_device *pdev)
>>       }
>>
>>       dev_set_drvdata(&pdev->dev, hdmi_data);
>> -     ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
>> +     ret = devm_snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
>>                                        &omap_hdmi_dai, 1);
>
> As with the omap-mcbsp:
> Can you align the parameters as well?

Sure, will do it and send next version.

Regards
Manish Badarkhe
