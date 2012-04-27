From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 6/8] ASoC: Ux500: Add platform-driver
Date: Fri, 27 Apr 2012 10:46:38 +0200
Message-ID: <4F9A5CEE.7070900@stericsson.com>
References: <1334914394-27518-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423183140.GV8318@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 6984010BE30
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 10:46:44 +0200 (CEST)
In-Reply-To: <20120423183140.GV8318@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/23/2012 08:31 PM, Mark Brown wrote:

> On Fri, Apr 20, 2012 at 11:33:14AM +0200, Ola Lilja wrote:
>> Add platform-driver handling all DMA-activities.
> 
> Overall this looks really good, but it depends on the stream print thing
> as well.  There's a few very nitpicky issues also:
> 
>> -config SND_SOC_UX500_MSP_I2S
>> +config SND_SOC_UX500_PLAT_MSP_I2S
> 
> Should be in the previous patch.


True.

> 
>> -snd-soc-ux500-msp-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
>> -obj-$(CONFIG_SND_SOC_UX500_MSP_I2S) += snd-soc-ux500-msp-i2s.o
>> +snd-soc-ux500-plat-msp-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
>> +obj-$(CONFIG_SND_SOC_UX500_PLAT_MSP_I2S) += snd-soc-ux500-plat-msp-i2s.o
> 
> Likewise.


True.

> 
>> +	dev_dbg(dev, "%s: Init runtime private data.\n", __func__);
>> +	ux500_pcm_data = kzalloc(sizeof(struct ux500_pcm), GFP_KERNEL);
>> +	if (ux500_pcm_data == NULL)
>> +		return -ENOMEM;
>> +	ux500_pcm_data->msp_id = dai->id;
> 
> devm_kzalloc()?


I will change.
