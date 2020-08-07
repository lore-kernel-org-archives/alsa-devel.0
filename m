Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6874C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:15:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60372206B5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C6BAT6Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60372206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2B851663;
	Tue, 11 Aug 2020 10:14:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2B851663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597133749;
	bh=knKHSu7+qyeC4nbP35pTFnuFbl5n4ki6oqaukqbjQVQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6BAT6Gl0+XKfZWy8j85zfHecnxg+/CAYzLD2iH2TiP7eKxxKLIpeZQsWleNX0GTg
	 CGMxNVUmfNG6uYdibtPLuXM1HkNIMR8IskTNb81eiMETGv3X5JPlRUL+Kh6aB/6WOF
	 w0voL+5T+Sfa4zU/LeGw/o7XU+owuwyEhLDPS/tc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D15EF80171;
	Tue, 11 Aug 2020 10:14:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0892FF80218; Fri,  7 Aug 2020 13:44:27 +0200 (CEST)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C3E4F801F7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2020 13:44:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C3E4F801F7
Received: by mail-wr1-f66.google.com with SMTP id c15so1370989wrs.11
 for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2020 04:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N8musXdCYjKNkXhIeUBafzXyS9da0FtZxFcd8OoiZgU=;
 b=hNjOUdQPFv4KgJR4sbPvsymsY/Qo2usadIvK8odOFCyDi1g1foUnnowGfvH2hIzPGA
 PUDHPxtdnk6yv/ank+i5f0P84ULea55z3GEZAimIzwcItisc5WqT954225v96+UIQQ7Y
 /CZ4q012m8IvX2RlIEdb5cOrtP7CbQq0Uena//bRRfgl02Y7sKy1qVtDYG1rk7bVkmcY
 NwJ5zKi1eWtSDMiqyWfE4GQYJlcRlTm9dkziU25/3HZrrp1dXAPcCioomxNJ//xSYzP0
 erNnmK73nDA/bGheoUvX8Om4yyVwGmbqKvfo21hLpoBn8hlvTmHsVnN3rWVTfT5JVnTq
 DIgQ==
X-Gm-Message-State: AOAM531BDPR86HscAk8fyX9Za3aWDcU0rGx2K7zt8cDNOAbN9NkApvj0
 D0iercuTnwuxX25RsYnj+I0=
X-Google-Smtp-Source: ABdhPJxvn7J2DKLgtpo4L81vi7ot+MvhlFdzMe5TulnmTigW2FE/oEUvy/2eSWYpCzwErtyG5KFlaQ==
X-Received: by 2002:a05:6000:11c1:: with SMTP id
 i1mr12351441wrx.277.1596800656407; 
 Fri, 07 Aug 2020 04:44:16 -0700 (PDT)
Received: from pi3 ([194.230.155.117])
 by smtp.googlemail.com with ESMTPSA id i66sm10625022wma.35.2020.08.07.04.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 04:44:15 -0700 (PDT)
Date: Fri, 7 Aug 2020 13:44:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/41] spi / fbdev / cpufreq / usb / mmc / hwmon /
 ARM: Prepare for multiplatform S3C
Message-ID: <20200807114411.GA9589@pi3>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200807113330.GC5435@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807113330.GC5435@sirena.org.uk>
X-Mailman-Approved-At: Tue, 11 Aug 2020 10:14:05 +0200
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org,
 Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-spi@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>, Andi Shyti <andi@etezian.org>,
 Jason Cooper <jason@lakedaemon.net>, linux-samsung-soc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-fbdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-mmc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-input@vger.kernel.org, linux-clk@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, Takashi Iwai <tiwai@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Simtec Linux Team <linux@simtec.co.uk>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Felipe Balbi <balbi@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Sangbeom Kim <sbkim73@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, patches@opensource.cirrus.com
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

On Fri, Aug 07, 2020 at 12:33:30PM +0100, Mark Brown wrote:
> On Thu, Aug 06, 2020 at 08:19:32PM +0200, Krzysztof Kozlowski wrote:
> 
> > I intend to take it through Samsung SoC tree so all Acks are welcomed.
> 
> Any issue with me applying the ASoC bits and sending you a branch?  This
> seems like it might run into some of the subsystem wide cleanups we've
> got going on.

Five ASoC patches:
 - ARM: s3c24xx: move iis pinctrl config into boards
 - ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS
 - ASoC: samsung: rx1950: turn into platform driver
 - ASoC: samsung: neo1973: turn into platform driver
 - ASoC: samsung: h1940: turn into platform driver
apply cleanly on current next so I guess they could go through your tree
without problems.  Providing me a branch would be great in such case, so
please go ahead.

Thanks!

Best regards,
Krzysztof
