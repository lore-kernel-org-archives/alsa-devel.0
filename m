From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH v4] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Fri, 30 Mar 2018 15:32:38 +0530
Message-ID: <46a63f05-fa45-6919-0ff4-6764bf79f0c8@amd.com>
References: <1522054560-31088-1-git-send-email-akshu.agrawal@amd.com>
 <20180327184621.gzyzqcnvi6quajxw@sriram-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0088.outbound.protection.outlook.com [104.47.37.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 37F682671B9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 12:02:48 +0200 (CEST)
In-Reply-To: <20180327184621.gzyzqcnvi6quajxw@sriram-VirtualBox>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriram.oqensourz@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Daniel Kurtz <djkurtz@chromium.org>, broonie@kernel.org, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On 3/28/2018 12:16 AM, Sriram Periyasamy wrote:
> On Mon, Mar 26, 2018 at 02:26:00PM +0530, Akshu Agrawal wrote:
>> This enables/disables and sets auxiliary clock at 25Mhz. It uses
>> common clock framework for proper ref counting. This approach will
>> save power in comparison to keeping it always On in firmware.
>>
>> V2: Correcting the pin to OSCOUT1 from OSCOUT2
>> V3: Fix error/warnings from kbuild test
>> V4: Fix build errors for platform which do not support CONFIG_COMMON_CLK
>>
> 
> Please consider adding the change history across versions below
> the marker --- which is the standard way of doing.
>

Accepted.

>> TEST= aplay -vv <file>
>> check register to see clock enabled
>> kill aplay
>> check register to see clock disabled
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   sound/soc/amd/acp-da7219-max98357a.c | 144 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 142 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
>> index 99c6b5c..3c77803 100644
>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> 
> <snip>
> 
>> @@ -98,13 +117,27 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
>>   		return ret;
>>   	}
>>   
>> +	acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
> 
> Consider adding the error handling, for example if CONFIG_COMMON_CLK is not
> defined for this platform, then clk_get may return error.
> 

Accepted.

>> +	ret = clk_prepare_enable(acpd7219_clk);
>> +	if (ret < 0) {
>> +		dev_err(rtd->dev, "can't enable oscillator clock %d\n", ret);
>> +		return ret;
> 
> One return statement is enough here.
> 

Accepted.

>> +	}
>> +
>>   	return ret;
>>   }
>>   
>>   static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
>>   {
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_card *card = rtd->card;
>> +	struct clk *acpd7219_clk;
>> +
>>   	clk_disable_unprepare(da7219_dai_clk);
>>   
>> +	acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
> 
> Error handling here as well.
> 

Accepted.

>> +	clk_disable_unprepare(acpd7219_clk);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -237,9 +270,113 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
>>   	.num_controls = ARRAY_SIZE(cz_mc_controls),
>>   };
>>
> 
> <snip>
>    
>> +
>> +static int register_acpd7219_clocks(struct platform_device *pdev)
>> +{
>> +	struct clk_init_data init = {};
>> +	struct clk *acp_clks;
>> +	struct clk_lookup *acp_clks_lookup;
>> +	struct cz_clock *cz_clock_obj;
>> +	struct resource *res;
>> +	struct device dev = pdev->dev;
>> +
>> +	cz_clock_obj = kzalloc(sizeof(struct cz_clock), GFP_KERNEL);
>> +	if (!cz_clock_obj)
>> +		return -ENOMEM;
>> +
>> +	cz_clock_obj->acp_clks_name = "acpd7219-clks";
>> +
>> +	init.parent_names = NULL;
>> +	init.num_parents = 0;
>> +	init.name = cz_clock_obj->acp_clks_name;
>> +	init.ops = &acpd7219_clks_ops;
>> +	cz_clock_obj->acp_clks_hw.init = &init;
>> +
>> +	acp_clks = devm_clk_register(&dev, &cz_clock_obj->acp_clks_hw);
>> +	if (IS_ERR(acp_clks))
>> +	{
>> +		dev_err(&dev, "Failed to register DAI clocks: %ld\n",
>> +			 PTR_ERR(acp_clks));
>> +		return -EINVAL;
>> +	}
>> +	cz_clock_obj->acp_clks = acp_clks;
>> +
>> +	acp_clks_lookup = clkdev_create(acp_clks, cz_clock_obj->acp_clks_name,
>> +					"%s", dev_name(&dev));
>> +	if (!acp_clks_lookup)
>> +		dev_warn(&dev, "Failed to create DAI clkdev");
> 
> Error not handled on purpose?
>

Yes, just warning.

>> +	else
>> +		cz_clock_obj->acp_clks_lookup = acp_clks_lookup;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Failed to get misc io resource.\n");
> 
> Shouldn't be clkdev_drop used here to free up?
> 

Accepted.

>> +		return -EINVAL;
>> +	}
>> +	cz_clock_obj->res_base = devm_ioremap_nocache(&pdev->dev, res->start,
>> +					resource_size(res));
>> +	if (!cz_clock_obj->res_base)
> 
> Here as well.
> clkdev_drop is not called when the driver is removed?
>

Accepted.

> Thanks,
> Sriram.
>
