From: Jens Rottmann <JRottm@gmx.de>
Subject: Re: [PATCH] streamline TLV320AIC23 drivers
Date: Tue, 1 Aug 2017 23:07:32 +0200
Message-ID: <90b75c85-1eaa-016f-71c5-a84cb554c731@gmx.de>
References: <b4127646-565b-ab16-0a8f-1fd6c263389e@ADLINKtech.com>
 <20170428171115.6zc5nhspvkkgevs7@rob-hp-laptop>
 <0ea2a5f8-8af0-598d-ad49-23501176efbb@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 82471266CC9
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 23:08:01 +0200 (CEST)
In-Reply-To: <0ea2a5f8-8af0-598d-ad49-23501176efbb@yahoo.com>
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
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Rob,
repeatedly got no response. Hope I'll get through this time.
Regards, Jens

-------- Original Message --------
Subject: Re: [PATCH] streamline TLV320AIC23 drivers
Date: Sat, 6 May 2017 00:39:20 +0200
From: Jens Rottmann <JRottm@yahoo.com>
To: Rob Herring
CC: Mark Rutland, Jaroslav Kysela, Takashi Iwai, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood, Mark Brown

Hi Rob,
sorry for the delay.

> On Fri, Apr 21, 2017 at 09:22:02PM +0200, Jens Rottmann wrote:
>> - Remove Eukrea naming, i.MX is from Freescale, TLV320AIC23 is from TI,
>>   driver was written by Eukrea, but it's DT capable, so it's not exclusive:
>>   - Kconfig option title
>>   - 'model' option
>>   - driver 'compatible' string
>> [...]
>> CONFIG variable and files have not been renamed, though, so no need to
>> change old defconfigs.

On 04/28/2017 19:11, Rob Herring answered:
> Perhaps change the filename. [...]

I wanted to avoid the churn, but ok. In that case:

Do you want me to change all indentifiers inside driver, too?
eukrea_tlv320_probe() --> imx_tlv320aic23_probe()

Do you want me to also rename the CONFIG var?
CONFIG_SND_SOC_EUKREA_TLV320 --> CONFIG_SND_SOC_IMX_TLV320
I'd adapt in-tree defconfigs, but would unavoidably break
out-of-tree defconfigs...

>> -  - fsl,mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
>> +  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
>> +  - fsl,mux-int-port	: Dito, deprecated.
>> -  - fsl,mux-ext-port	: The external port of the i.MX audio muxer.
>> +  - mux-ext-port	: The external port of the i.MX audio muxer.
>> +  - fsl,mux-ext-port	: Dito, deprecated.

> Is this used elsewhere? This is FSL specific, so you should keep the
> prefix.

.../sound/soc/fsl$ egrep 'property.*mux-(int|ext)-port' *
eukrea-tlv320.c: ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
eukrea-tlv320.c: ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
fsl-asoc-card.c: ret = of_property_read_u32(np, "mux-int-port", &int_port);
fsl-asoc-card.c: ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
imx-es8328.c:    ret = of_property_read_u32(np, "mux-int-port", &int_port);
imx-es8328.c:    ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
imx-sgtl5000.c:  ret = of_property_read_u32(np, "mux-int-port", &int_port);
imx-sgtl5000.c:  ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
imx-wm8962.c:    ret = of_property_read_u32(np, "mux-int-port", &int_port);
imx-wm8962.c:    ret = of_property_read_u32(np, "mux-ext-port", &ext_port);

All drivers use mux-int|ext-port without prefix, tlv320 is the only
odd driver out, that's why I did this streamlining patch in the 1st place.

I would rather not have to change all other drivers to match the tlv320 one.

Thanks,
Jens
