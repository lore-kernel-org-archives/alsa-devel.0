From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Add ssm2518 support
Date: Wed, 22 May 2013 20:16:36 +0200
Message-ID: <519D0B84.70307@metafoo.de>
References: <1369242013-27672-1-git-send-email-lars@metafoo.de>
 <20130522175705.GU1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id AEFC6260899
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:14:04 +0200 (CEST)
In-Reply-To: <20130522175705.GU1627@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 05/22/2013 07:57 PM, Mark Brown wrote:
> On Wed, May 22, 2013 at 07:00:13PM +0200, Lars-Peter Clausen wrote:
>> This patch adds a ASoC CODEC driver for the SSM2516. The SSM2516 is a stereo
>> Class-D audio amplifier with an I2S interface for audio in and a built-in
>> dynamic range control processor.
> 
> I'll apply this but 

I'll send a v2 with your comments fixed.

> 
>> +	if (slots == 0) {
>> +		return regmap_update_bits(ssm2518->regmap,
>> +			SSM2518_REG_SAI_CTRL1, SSM2518_SAI_CTRL1_SAI_MASK,
>> +			SSM2518_SAI_CTRL1_SAI_I2S);
>> +	}
> 
> You've got quite a few single statement if () blocks with { } which
> shouldn't be there.
> 

I prefer to only do this for single single-line statements.


[...]
> 
>> +	switch (freq) {
>> +	case 2048000:
> 
> Looks like the user can't select 0 for the SYSCLK, I'd expect that to be
> possible for systems that can reprogram the clock so that they can avoid
> having constraints set when they don't need them.
> 

Makes sense.

>> +	} else if (i2c->dev.of_node) {
>> +		ssm2518->enable_gpio = of_get_gpio(i2c->dev.of_node, 0);
>> +		if (ssm2518->enable_gpio == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
> 
> Why are other errors being ignored here?

To make the property optional. But I think it might be better to only allow
-ENOENT and treat everything else as an error in this case.

Thanks,
- Lars
