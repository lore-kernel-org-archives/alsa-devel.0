From: Florian Meier <florian.meier@koalo.de>
Subject: Re: [PATCH] ASoC: Add support for BCM2708
Date: Wed, 22 May 2013 19:16:41 +0200
Message-ID: <519CFD79.3050002@koalo.de>
References: <519CD1CC.8070507@koalo.de> <20130522163942.GQ1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130522163942.GQ1627@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, swarren@wwwdotorg.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 22.05.2013 18:39, Mark Brown wrote:
> On Wed, May 22, 2013 at 04:10:20PM +0200, Florian Meier wrote:
> 
>> This driver adds support for digital audio (I2S)
>> for the BCM2708 SoC that is used by the
>> Raspberry Pi. External audio codecs can be
>> connected to the Raspberry Pi via P5 header.
> 
> Split this up into a patch series, for example one per CPU side driver
> and one per machine driver.  I've given the code a relatively quick run
> through here, it looks mostly sensible though DT would be nice but
> there's a few comments.
> 
>> +static inline void bcm2708_i2s_write_reg(struct bcm2708_i2s_dev *dev,
>> +					   int reg, u32 val)
>> +{
>> +	dev_dbg(dev->dev, "I2S write to register %p = %x\n",
>> +			dev->clk_base + reg, val);
>> +	__raw_writel(val, dev->i2s_base + reg);
>> +}
> 
> This all looks like you want to use regmap-mmio.........

Thank you for your comments! I will have a look at them and send a new
patch series taking them into account.
Before that I will create a patch for the DMA engine driver.
