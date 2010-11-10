From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] Fix Atmel soc audio boards Kconfig
	dependency
Date: Thu, 11 Nov 2010 10:54:08 +1300
Message-ID: <4CDB1480.3080109@bluewatersys.com>
References: <4CDAFA56.2050504@bluewatersys.com> <1289423099.3284.52.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id D201F10380F
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 22:53:07 +0100 (CET)
In-Reply-To: <1289423099.3284.52.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, gwossum@acm.org
List-Id: alsa-devel@alsa-project.org

On 11/11/2010 10:04 AM, Liam Girdwood wrote:
> On Thu, 2010-11-11 at 09:02 +1300, Ryan Mallon wrote:
>   
>> Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
>> audio SAM9G20-EK and PlayPaq boards. Fixes link errors on missing
>> clk_set_parent and clk_set_rate when building without
>> AT91_PROGRAMMABLE_CLOCKS.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>>     
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
>   
Just realised that the PlayPaq board only appears in the sound/soc/atmel
directory. I cannot find a board file for it under either
arch/arm/mach-at91 or arch/avr32/. The updated patch below only changes
the dependency for the SAM9G20-EK board since I think the PlayPaq is
actually AVR32, and therefore should not depend on
AT91_PROGRAMMABLE_CLOCKS. This patch replaces my previous one.

---
Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
audio  SAM9G20-EK board. Fixes link errors on missing clk_set_parent and
clk_set_rate when building without AT91_PROGRAMMABLE_CLOCKS.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index e720d5e..a614181 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -16,7 +16,8 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
+                   AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
 	help
