From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 2/5 v4] drm/i2c/adv7511: Add audio support
Date: Fri, 8 Apr 2016 17:12:58 +0100
Message-ID: <5707D88A.3010400@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
 <d56087fae14074198f6c1bc749ce4da3cab62324.1460047238.git.joabreu@synopsys.com>
 <5707D249.5040707@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 by alsa0.perex.cz (Postfix) with ESMTP id BD107265132
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 18:13:47 +0200 (CEST)
In-Reply-To: <5707D249.5040707@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Jose Abreu <Jose.Abreu@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: architt@codeaurora.org, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, CARLOS.PALMINHA@synopsys.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi Lars,


On 08-04-2016 16:46, Lars-Peter Clausen wrote:
> On 04/07/2016 06:53 PM, Jose Abreu wrote:
>> This patch adds audio support for the ADV7511 HDMI transmitter
>> using ALSA SoC.
>>
>> The code was ported from Analog Devices linux tree from
>> commit 1770c4a1e32b ("Merge remote-tracking branch
>> 'xilinx/master' into xcomm_zynq"), which is available at:
>> 	- https://github.com/analogdevicesinc/linux/
> The reason why this driver is still out of tree, is because there has been
> no conclusion yet on how to go forward with the whole HDMI integration. So
> this is not going to get merged until that issue has been addressed.

Ok, will then drop the patches related with adv7511 but will update with your
comments so that when this HDMI issue is addressed I can send again the patches.
Is this okay?

>
> [...]
>> +- adi,enable-audio: If set the ADV7511 driver will register a codec interface
>> +  into ALSA SoC.
> This is not a description of the hardware.

Is this okay: "adi,enable-audio: Set this boolean parameter if ADV7511
transmitter routes audio signals" ?

>
> [...]
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index 964b7de..539c091 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -33,6 +33,7 @@ struct snd_compr_stream;
>>  #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
>>  #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
>>  #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
>> +#define SND_SOC_DAIFMT_SPDIF		8 /* SPDIF */
> This needs to be a separate patch.

Ok.

>
>
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

Best regards,
Jose Miguel Abreu
