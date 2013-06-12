From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: add device tree support
Date: Wed, 12 Jun 2013 10:56:46 -0600
Message-ID: <51B8A84E.9010106@wwwdotorg.org>
References: <1370983240-4976-1-git-send-email-swarren@wwwdotorg.org>
 <20130612164628.GN1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 122D3265038
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 18:56:51 +0200 (CEST)
In-Reply-To: <20130612164628.GN1403@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 06/12/2013 10:46 AM, Mark Brown wrote:
> On Tue, Jun 11, 2013 at 02:40:40PM -0600, Stephen Warren wrote:
> 
>> +- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's
>> LDO1_EN pin.
> 
> Why gpios and not gpio?

For some reason, GPIO properties have always been named "gpios" rather
than "gpio", even when only a single entry is expected. I don't really
understand why, but I've been asked (or seen others asked) to
s/gpio/gpios/ in DT bindings before. I explicitly CC'd Grant and Rob
here in case they can shed any light.

>> -	if (rt5640->pdata.ldo1_en) { +	if
>> (gpio_is_valid(rt5640->pdata.ldo1_en)) { ret =
>> devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en, 
>> GPIOF_OUT_INIT_HIGH,
> 
> Unfortunately gpio_is_valid() is unhelpful for platform data since
> often zero is a valid GPIO but it's also the default "do nothing"
> platform data.  It's therefore better to either include a check for
> non-zero as well or have code that takes a zero in the platform
> data and sets it to a negative value instead.

I think people filling in platform data should simply be required to
put a valid/correct value in that field. There aren't any users of
this, so it's not like adding a new field where
backwards-compatibility might be a concern (and even then, updating
all users of this platform data type wouldn't be hard), and it should
be obvious if you get it wrong.
