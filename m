From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [GIT PULL] ASoC: Samsung: Updates for v3.8
Date: Sat, 24 Nov 2012 11:13:28 +0900
Message-ID: <000301cdc9e9$4e781d30$eb685790$@com>
References: <000001cdc95c$c1d7ec20$4587c460$@com>
 <20121123145945.GU4529@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A3BC26509D
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2012 03:13:36 +0100 (CET)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDY005ZKZIJCGA0@mailout4.samsung.com> for
 alsa-devel@alsa-project.org; Sat, 24 Nov 2012 11:13:34 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDY0066EZILVUB0@mmp2.samsung.com> for
 alsa-devel@alsa-project.org; Sat, 24 Nov 2012 11:13:34 +0900 (KST)
In-reply-to: <20121123145945.GU4529@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: sachin.kamat@linaro.org, alsa-devel@alsa-project.org, 'Sangsu Park' <sangsu4u.park@samsung.com>, 'Padmavathi Venna' <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi,
Thanks for review.

> There's some problems with this binding.  The main one is the gpios
> property the format of which isn't specified at all.  
All of above gpio property is i2s.
That is, 
+	gpios = <&gpz 0 2 0 0>, -> SCLK
+		<&gpz 1 2 0 0>,   ->  CDCLK
+		<&gpz 2 2 0 0>,   -> LRCK
+		<&gpz 3 2 0 0>,   -> SDI
+		<&gpz 4 2 0 0>,   -> SDO[0]
+		<&gpz 5 2 0 0>,   -> SDO[1]
+		<&gpz 6 2 0 0>;   -> SDO[2]

Do you want like a below one?
+sclk-gpios = <&gpz 0 2 0 0>, 
+cdclk-gpios = <&gpz 1 2 0 0>, ...


> The requirement for an alias is also very odd, where does that come from?

I don't know that Which one is odd. Please let me know.
 
> Some of the code also looks very peculiar, like the fact that it's
> generating a clock name i2s_opclk%d rather than hard coding the clock,
> the physical clock would normally be resolved based on the struct
> device.

This is to handle all of Samsung SOCs i2c clock mux.
Please look at below clk_lookup table

In case of 6410, clk_lookup
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &clk_audio_bus0.clk),
+	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk0", &clk_i2s1),
+	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk1", &clk_audio_bus1.clk),
+#ifdef CONFIG_CPU_S3C6410
+	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk0", &clk_i2s2),
+	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk1", &clk_audio_bus2.clk),

In case of exynos5, clk_lookup
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &exynos5_clk_sclk_i2s.clk),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &exynos5_clk_i2s_bus.clk),

We try to handle clock source of i2s by only i2s_opclk0 and i2s_opclk1.
Each SOCs have different clock source.
Is this wrong approach?

Thanks,
Sangbeom.
