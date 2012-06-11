From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 2/3] ASoC: Ux500: Add machine-driver
Date: Mon, 11 Jun 2012 14:22:33 +0200
Message-ID: <4FD5E309.4080301@stericsson.com>
References: <1339070437-15150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120611053432.GP4218@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
	[207.126.144.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 50908243BF
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 14:23:01 +0200 (CEST)
In-Reply-To: <20120611053432.GP4218@opensource.wolfsonmicro.com>
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


>> +static inline const char *get_mclk_str(enum mclk mclk_sel)
>> +{
>> +	switch (mclk_sel) {
>> +	case MCLK_SYSCLK:
>> +		return "MCLK_SYSCLK";
>> +	case MCLK_ULPCLK:
>> +		return "MCLK_ULPCLK";
> 
> Why not just drop the MCLK_ from the strings?  I'd expect that'll be
> implied by the context...


I like having some kind of prefix before the alternatives in my enums,
even if you could figure out what its for without it.

> 
>> +	/* Digital interface - Clocks */
>> +	SOC_SINGLE("Digital Interface Master Generator Switch",
>> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
>> +		1, 0),
> 
> This enables and disables a 256fs (or similar ratio) clock output from
> the device?


This is the clocking of the digital interface which is used together with the
bit-clock switches when we are in gated mode (see discussions regarding these
parameters in earlier review of the codec-driver).

> 
>> +	SOC_SINGLE("Digital Interface 0 Bit-clock Switch",
>> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
>> +		1, 0),
>> +	SOC_SINGLE("Digital Interface 1 Bit-clock Switch",
>> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
>> +		1, 0),
> 
> I suspect that these are doing what DAIFMT_CONT is for...


See comment above.
