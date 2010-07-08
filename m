From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Thu, 08 Jul 2010 17:10:47 +0900
Message-ID: <4C358807.1000502@samsung.com>
References: <4C355AC2.8090502@samsung.com>
	<AANLkTikHkQfmD5GPL9D-kbL7SuNksNA9tbhvoDqBeuur@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 8639810386B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 10:10:50 +0200 (CEST)
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L58006OVC1ZRE80@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 08 Jul 2010 17:10:47 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5800AIXC1Z4G@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 08 Jul 2010 17:10:47 +0900 (KST)
In-reply-to: <AANLkTikHkQfmD5GPL9D-kbL7SuNksNA9tbhvoDqBeuur@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
> On Thu, Jul 8, 2010 at 1:57 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch add sound support for the Aquila board based on S5PC110.
>>
>> The Aquila board is based on Samsung SoC(S5PC110) and include
>> WM8994 codec over I2Sv5 to support sound. As there is currently
>> no driver for the I2Sv5, the code to use I2Sv5 is deleted
>> on this patch.
>>
>> After I2Sv5 driver is posted in a few weeks, I will post incremental
>> patch which some codes for using I2Sv5. The owner of I2Sv5 said that
>> he will post I2Sv5 driver after a few weeks.
> 
> I don't plan to create a copy of an almost copy of s3c64xx-i2s.c
> Please try to use the existing sound/soc/s3c24xx/s3c64xx-i2s-v4.c
> I intend to only enhance that code to enable features of 'v4', 'v5' etc.
> 

As your comment, I did modify some codes to use sound/soc/s3c24xx/
s3c64xx-i2s-v4.c instead of I2Sv5. When I try to compile kernel 
with arch/arm/configs/s5pv210_defconfig.

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 0c5d8a5..c09b402 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -135,6 +135,7 @@ config SND_S3C64XX_SOC_SMARTQ
 config SND_S5PC110_SOC_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA - WM8994"
 	depends on SND_S3C24XX_SOC && MACH_AQUILA
+	select SND_S3C64XX_SOC_I2S_V4
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on aquila
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 13311c8..64376b2 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -32,7 +32,8 @@
 
 #undef S3C_IIS_V2_SUPPORTED
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
+	|| defined(CONFIG_CPU_S5PV210)
 #define S3C_IIS_V2_SUPPORTED
 #endif
 

When compiling kernel, it is occurred below error because 
arch/arm/mach-s5pv210/include/mach/gpio-bank-*.h file 
isn't included to upstream kernel.

sound/soc/s3c34xx/s3c64xx-i2s-v4.c included the header files
in arch/arm/mach-s3c64xx/include/*.

What is your opinion for this error?

- compile error log :
CHK     include/generated/compile.h
CC      sound/soc/s3c24xx/s3c64xx-i2s-v4.o
sound/soc/s3c24xx/s3c64xx-i2s-v4.c:19: fatal error:mach/gpio-bank-c.h:
 No such file or directory

Thank you,
Chanwoo Choi
