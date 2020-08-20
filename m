Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D964C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:56:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1152063A
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O9gxKrC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1152063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21A7E16B0;
	Fri, 21 Aug 2020 09:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21A7E16B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597996591;
	bh=nsNGQJZxzCJX90d0zifGxofIrP5Uj65BXC5524x/10c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O9gxKrC8qXro3Trym0nA+Affa+xXUH0dqTBr5w68U/vti8WakJ5WC8a91e0037gso
	 t7Hix4FtPFTKsOCxg6bG6AtynEz+o6xAFXuHylm0O2qpq4W2d5LYWgFpH9mmH5zfXR
	 POYjRtCqdp+W4HaOJ6JCmK8vM6Duf4AzOTkEVF6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BBDDF80479;
	Fri, 21 Aug 2020 09:36:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1BA2F80228; Thu, 20 Aug 2020 17:59:29 +0200 (CEST)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACCBEF80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 17:59:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACCBEF80114
Received: by mail-wr1-f67.google.com with SMTP id y3so2524223wrl.4
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 08:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AICl07wj2rdeLbaUuIr48jZgNAhD7HLePnLKN8bK9F8=;
 b=U+8GXSxm2xZqIHW8lYQBln3CScuqFITVZOPZi77tGJp03wrQQI80l00YViX5R3nRzT
 RAu+W+5Iiceau5c+yEpwzCBitBP2onNv1juzq5MxQzJJhrJGNo2f51E5F6C2FMQA9wHB
 OoI548hctOxE9IfSZHwBvjgr0yoFTAdH+WwSJ5nZooibJkgXXTOCdlRRZw2esom3r/0w
 4ozfyrbQD66EaImeKb/4hmbom8ItIOEg1712RY2plsu0sJ+ZhSpYEmOXArmFtg0wC47G
 bOHPfUq9UpPie8jRHkJr6G8CV6zvUuiwXTTP4x+otEMnjY6+VbImCFjmO5eKg+jtZ44n
 wkgA==
X-Gm-Message-State: AOAM533hwlHNZsP06r5WYxETN10QIGH1JUbBgs61gMO21glYxUjQWE3T
 xBf22fbt1R+q9ejDM9L6GJc=
X-Google-Smtp-Source: ABdhPJywyymogpnt/oOUmaLTWNdzju8F9YvcCdpX66tCuBP6i1vn7QobEV9VEvGit4tTroGXYziTeA==
X-Received: by 2002:adf:b353:: with SMTP id k19mr3772990wrd.159.1597939158768; 
 Thu, 20 Aug 2020 08:59:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
 by smtp.googlemail.com with ESMTPSA id l11sm4693828wme.11.2020.08.20.08.59.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Aug 2020 08:59:18 -0700 (PDT)
Date: Thu, 20 Aug 2020 17:59:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Simtec Linux Team <linux@simtec.co.uk>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Ben Dooks <ben-linux@fluff.org>, Sebastian Reichel <sre@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
 Andi Shyti <andi@etezian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 patches@opensource.cirrus.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/41] spi / fbdev / cpufreq / usb / mmc / hwmon /
 ARM: Prepare for multiplatform S3C
Message-ID: <20200820155913.GA21395@kozik-lap>
References: <20200806181932.2253-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Fri, 21 Aug 2020 09:36:14 +0200
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
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

On Thu, Aug 06, 2020 at 08:19:32PM +0200, Krzysztof Kozlowski wrote:
> Hi All,
> 
> Shortly
> =======
> This is a continuation of Arnd's work from 2019 [1].  The goal is to
> cleanup, merge and finally make the Samsung S3C24xx and S3C64xx
> architectures multiplatform.  The multiplatform did not happen yet
> here... just cleaning up and merging into one mach-s3c.
> 
> I intend to take it through Samsung SoC tree so all Acks are welcomed.
> 
> Changes since v1
> ================
> 1. Rebased,
> 2. Addressed comments (including mine),
> 3. Few new patches.
> 
> Please see individual changelogs (per patch).
> 
> [1] https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=185855&state=*
>

Hi All,

I applied second part of the set which finishes this step of S3C
cleanup. Thanks to Arnd for the work!

Best regards,
Krzysztof

