Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD4C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:17:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B0120767
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rP4zH3QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B0120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 887591691;
	Tue, 14 Apr 2020 20:16:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 887591691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586888259;
	bh=EH8Xyy1nwED1YhAp2btLlY3S4BcbTGe3pFkZEmzY0IY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rP4zH3QSOsr/LWTa5LL0vsU7thz5ErnIfT/OYrOP21PtAwFunFl5G3NsM0v8166JI
	 zhi+++umRZ8/sjvA3J1ycuKz80k1sKTogUebC+DVLRgnrhF5RxI/gjbV8wLu5dBAIe
	 C1iukZWoGO1zIFd+d8CxdzHzpGbNqfJjaGBK21Ow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEE46F8014E;
	Tue, 14 Apr 2020 20:16:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70C72F8013D; Tue, 14 Apr 2020 20:16:46 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4734F800F5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 20:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4734F800F5
IronPort-SDR: ZdzoIN6nVgsTOaVc5iiVsizMLkdtvvpp2NZ9Qlbwi8lDhbmf3Ny9zPZq2gB8qxLEfboG3ctaA+
 focBkO7MjxqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 11:16:40 -0700
IronPort-SDR: UTuFLX3YOUg8m9hrWrHUhi1cMN2h/wTqDRLz9NHdi6CPDlX7fPOuzVtWbxYKhaZV2FS9Ax5d7P
 ElkvrfUZ78EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="253272826"
Received: from svarahab-mobl.amr.corp.intel.com (HELO [10.212.190.40])
 ([10.212.190.40])
 by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 11:16:34 -0700
Subject: Re: [RFC PATCH 01/16] ASoC: pcm512x: expose 6 GPIOs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-2-pierre-louis.bossart@linux.intel.com>
 <20200414170934.GA34613@smile.fi.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31e956de-8f62-1857-5153-b163ff7d56e1@linux.intel.com>
Date: Tue, 14 Apr 2020 12:52:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414170934.GA34613@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Matthias Reichl <hias@horus.com>,
 tiwai@suse.de, Linus Walleij <linus.walleij@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Daniel Matuschek <daniel@hifiberry.com>,
 linux-clk@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
 linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 broonie@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



>> +static int pcm512x_gpio_get_direction(struct gpio_chip *chip,
>> +				      unsigned int offset)
>> +{
>> +	struct pcm512x_priv *pcm512x = gpiochip_get_data(chip);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_read(pcm512x->regmap, PCM512x_GPIO_EN, &val);
>> +	if (ret < 0)
>> +		return ret;
> 
>> +	val = (val >> offset) & 1;
>> +
>> +	/* val is 0 for input, 1 for output, return inverted */
>> +	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> 
> This better to read as simple conditional, like
> 
> 	if (val & BIT(offset))
> 		return ..._OUT;
> 	return ..._IN;
> 
>> +}

ok

> 
> ...
> 
>> +static int pcm512x_gpio_direction_output(struct gpio_chip *chip,
>> +					 unsigned int offset,
>> +					 int value)
>> +{
>> +	struct pcm512x_priv *pcm512x = gpiochip_get_data(chip);
>> +	unsigned int reg;
>> +	int ret;
>> +
>> +	/* select Register GPIOx output for OUTPUT_x (1..6) */
>> +	reg = PCM512x_GPIO_OUTPUT_1 + offset;
> 
>> +	ret = regmap_update_bits(pcm512x->regmap, reg, 0x0f, 0x02);
> 
> Magic numbers detected.
> 
>> +	if (ret < 0)
> 
> Drop unnecessary ' < 0' parts where it makes sense, like here.

did you mean use  if (ret) or drop the test altogether?

There's no standard style for regmap functions so I used what was used 
in the rest of this driver.

Mark?

> 
>> +		return ret;
>> +
> 
>> +	/* enable output x */
> 
> (1)
> 
>> +	ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_EN,
>> +				 BIT(offset), BIT(offset));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* set value */
> 
> (2)
> 
> With this (1)->(2) ordering it may be a glitch. So, first set value (if
> hardware allows you, otherwise it seems like a broken one), and then switch
> it to output.

good suggestion, thanks.

> 
>> +	return regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_CONTROL_1,
>> +				  BIT(offset), value << offset);
> 
> You are using many times BIT(offset) mask above, perhaps
> 	int mask = BIT(offset);
> 
> Also, more robust is to use ternary here: 'value ? BIT(offset) : 0'.
> Rationale: think what happen with value != 1 (theoretical possibility in the
> future).

ok

> 
>> +}
> 
> ...
> 
>> +static int pcm512x_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
> 
>> +	return (val >> offset) & 1;
> 
> Don't forget to use BIT() macro.
> 
> 	return !!(val & BIT(offset));

There's a point where this becomes less readable IMHO, but fine.
The !! gives me a headache...

>> +static void pcm512x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>> +			     int value)
>> +{
>> +	struct pcm512x_priv *pcm512x = gpiochip_get_data(chip);
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_CONTROL_1,
>> +				 BIT(offset), value << offset);
> 
> value ? BIT(offset) : 0

ok

> 
>> +	if (ret < 0)
> 
>> +		pr_debug("%s: regmap_update_bits failed: %d\n", __func__, ret);
> 
> No __func__ in debug messages.
> Use dev_dbg() when we have struct device available.

Not sure we do, will look into this.

>> +static const struct gpio_chip template_chip = {
> 
> Give better name, please. E.g. pcm512x_gpio_chip.

ok

>> +	/* expose 6 GPIO pins, numbered from 1 to 6 */
>> +	pcm512x->chip = template_chip;
>> +	pcm512x->chip.parent = dev;
>> +
>> +	ret = devm_gpiochip_add_data(dev, &pcm512x->chip, pcm512x);
> 
>> +	if (ret != 0) {
> 
> if (ret)

ok
