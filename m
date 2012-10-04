From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
Date: Thu, 04 Oct 2012 11:21:46 +0200
Message-ID: <506D552A.2000506@gmail.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com> <506A9C65.5040309@ti.com>
 <20121002093753.GU4360@opensource.wolfsonmicro.com>
 <506AC303.9080906@gmail.com> <506ACACE.4030308@ti.com>
 <506AEF57.2000306@gmail.com> <20121002164116.GT5641@beef>
 <506B1B46.2070006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070905020901050407020000"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 092D0262629
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 11:19:31 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so121453bku.38
 for <alsa-devel@alsa-project.org>; Thu, 04 Oct 2012 02:21:52 -0700 (PDT)
In-Reply-To: <506B1B46.2070006@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Porter <mporter@ti.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070905020901050407020000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 02.10.2012 18:50, Daniel Mack wrote:
> On 02.10.2012 18:41, Matt Porter wrote:
>> On Tue, Oct 02, 2012 at 03:42:47PM +0200, Daniel Mack wrote:
>>> On 02.10.2012 13:06, Sekhar Nori wrote:
>>>> On 10/2/2012 4:03 PM, Daniel Mack wrote:
>>>>> On 02.10.2012 11:37, Mark Brown wrote:
>>>>>> On Tue, Oct 02, 2012 at 10:48:53AM +0300, Peter Ujfalusi wrote:
>>>>>>
>>>>>>> I also agree that ifdef is not a good solution.
>>>>>>> It is better to have this information passed as device_data and via DT it can
>>>>>>> be decided based on the compatible property for the device.
>>>>>>
>>>>>> That's not really the problem here - the problem is that the APIs used
>>>>>> to get the SRAM are DaVinci only so it's not possible to build on OMAP
>>>>>> or other platforms.  The SRAM code needs to move to a standard API.
>>>>>
>>>>> What about following Matt Porter's idea and ignore the SRAM code
>>>>> entirely and port the entire PCM code to generic dmaengine code first?
>>>>> The EDMA driver needs to learn support for cyclic DMA for that, and I
>>>>> might give that a try in near future.
>>>>>
>>>>> Later on, the SRAM ping-pong code can get added back using genalloc
>>>>> functions, as Sekhar proposed. That needs to be done by someone who has
>>>>> access to a Davinci board though, I only have a AM33xx/OMAP here.
>>>>
>>>> We cannot "get rid" of SRAM code and add it back "later". It is required
>>>> for most DaVinci parts. The SRAM code can be converted to use genalloc
>>>> (conversion should be straightforward and I can help test it) and the
>>>> code that uses SRAM can probably keep using the private EDMA API till
>>>> the dmaengine EDMA driver has cyclic DMA support. Matt has already
>>>> posted patches to move private EDMA APIs to a common location. That
>>>> should keep AM335x build from breaking. Is this something that is feasible?
>>>
>>> Yes - by "later" I just meant in a subsequent patch. But you're probably
>>> right, we can also do that first.
>>>
>>> I'm looking at that right now and the problem seems that we don't have a
>>> sane way to dynamically look up gen_pools independently of the actual
>>> run-time platform. All users of gen_pools seem to know which platform
>>> they run on and access a platform-specific pool. So I don't currently
>>> see how we could implement multi-platform code, gen_pools are fine but
>>> don't solve the problem here.
>>>
>>> Would it be an idea to add a char* member to gen_pools and a function
>>> that can be used to dynamically look it up again? If a buffer with a
>>> certain name exists, we can use it and install that ping-pong buffer,
>>> otherwise we just don't. While that would be easy to do, it's a
>>> tree-wide change.
>>>
>>> Is there a better way that I miss?
>>
>> At the high level there's two platform models we have to handle, the
>> boot from board file !DT case, and then the boot from DT case. Since
>> Davinci is just starting DT conversion, we mostly care about the !DT
>> base in which the struct gen_pool * is passed in pdata to the ASoC
>> driver. It is then selectable on a per-platform basis where the decision
>> should be made.
>>
>> Given a separate discussion with Sekhar, we're only going to have one
>> SRAM pool on any DaVinci part right now...this was only a question on
>> L138 anyway. But regardless, the created gen_pool will be passed via
>> pdata.
> 
> I thought about this too, as mmp does it that way.
> 
>> Since DT conversion is starting and we need to consider that now,
>> the idea there is to use the DT-based generic sram driver [1] such that
>> when we do boot from DT on Davinci, the genpool is provided via phandle
>> and the pointer extracted with the OF helpers that are part of the
>> series.
> 
> A phandle is the cleanest way I think, yes.
> 
>> That's pretty much it. I'm reworking the backend support as discussed
>> with Sekhar wrt to my uio_pruss series. I can post a standalone series
>> that just replaces sram_* with genalloc for davinci ASoC.
> 
> As you can also test it, it would be easiest if you came up with a patch
> for that, yes. I can have a look at the dma bits laters, once my OMAP
> board finally works with the code as it currently stands. I'm still
> fighting with the mcasp driver right now ...

I quickly prepared two patches to change that, so that topic is out of
the way. But I did only compile-test them on OMAP - could you check on
your Davinci platform? Note that these apply on top of the patch in
discussion here (which isn't applied to the asoc tree yet).


Daniel


--------------070905020901050407020000
Content-Type: text/x-patch;
 name="0001-ARM-davinci-pass-SRAM-gen_pool-to-mcasp-platform-dat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ARM-davinci-pass-SRAM-gen_pool-to-mcasp-platform-dat.pa";
 filename*1="tch"

>From 7b55ed59364e7798586fc4d3692919741c164b3f Mon Sep 17 00:00:00 2001
From: Daniel Mack <zonque@gmail.com>
Date: Thu, 4 Oct 2012 11:11:07 +0200
Subject: [PATCH 1/2] ARM: davinci: pass SRAM gen_pool to mcasp platform data

This is needed to decouple the Davinci specific parts from the McASP
driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-davinci/board-da830-evm.c   |  2 ++
 arch/arm/mach-davinci/board-da850-evm.c   |  2 ++
 arch/arm/mach-davinci/board-dm355-evm.c   |  5 ++++-
 arch/arm/mach-davinci/board-dm365-evm.c   |  2 ++
 arch/arm/mach-davinci/board-dm644x-evm.c  |  5 ++++-
 arch/arm/mach-davinci/board-dm646x-evm.c  |  3 +++
 arch/arm/mach-davinci/board-neuros-osd2.c |  5 ++++-
 arch/arm/mach-davinci/include/mach/sram.h |  1 +
 arch/arm/mach-davinci/sram.c              | 17 +++++++++--------
 include/linux/platform_data/davinci_asp.h |  1 +
 10 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 0031864..47973b2 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -33,6 +33,7 @@
 #include <mach/usb.h>
 #include <mach/aemif.h>
 #include <mach/spi.h>
+#include <mach/sram.h>
 
 #define DA830_EVM_PHY_ID		""
 /*
@@ -214,6 +215,7 @@ static struct snd_platform_data da830_evm_snd_data = {
 	.version	= MCASP_VERSION_2,
 	.txnumevt	= 1,
 	.rxnumevt	= 1,
+	.sram_pool	= davinci_sram_pool,
 };
 
 /*
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 0149fb4..b74db6c 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -44,6 +44,7 @@
 #include <mach/mux.h>
 #include <mach/aemif.h>
 #include <mach/spi.h>
+#include <mach/sram.h>
 
 #define DA850_EVM_PHY_ID		"davinci_mdio-0:00"
 #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
@@ -758,6 +759,7 @@ static struct snd_platform_data da850_evm_snd_data = {
 	.version	= MCASP_VERSION_2,
 	.txnumevt	= 1,
 	.rxnumevt	= 1,
+	.sram_pool	= davinci_sram_pool,
 };
 
 static const short da850_evm_mcasp_pins[] __initconst = {
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 1c7b1f4..9b0c6df 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -31,6 +31,7 @@
 #include <mach/nand.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/sram.h>
 
 #include "davinci.h"
 
@@ -113,7 +114,9 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.scl_pin        = 14,
 };
 
-static struct snd_platform_data dm355_evm_snd_data;
+static struct snd_platform_data dm355_evm_snd_data = {
+	.sram_pool = davinci_sram_pool,
+};
 
 static int dm355evm_mmc_gpios = -EINVAL;
 
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 688a9c5..9eaec56 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -38,6 +38,7 @@
 #include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/keyscan.h>
+#include <mach/sram.h>
 
 #include <media/tvp514x.h>
 
@@ -176,6 +177,7 @@ static struct at24_platform_data eeprom_info = {
 
 static struct snd_platform_data dm365_evm_snd_data = {
 	.asp_chan_q = EVENTQ_3,
+	.sram_pool = davinci_sram_pool,
 };
 
 static struct i2c_board_info i2c_info[] = {
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index d34ed55..448341f 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -38,6 +38,7 @@
 #include <mach/mmc.h>
 #include <mach/usb.h>
 #include <mach/aemif.h>
+#include <mach/sram.h>
 
 #include "davinci.h"
 
@@ -262,7 +263,9 @@ static struct platform_device rtc_dev = {
 	.id             = -1,
 };
 
-static struct snd_platform_data dm644x_evm_snd_data;
+static struct snd_platform_data dm644x_evm_snd_data = {
+	.sram_pool = davinci_sram_pool,
+};
 
 /*----------------------------------------------------------------------*/
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 958679a..1ee6d1f 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -43,6 +43,7 @@
 #include <mach/clock.h>
 #include <mach/cdce949.h>
 #include <mach/aemif.h>
+#include <mach/sram.h>
 
 #include "davinci.h"
 #include "clock.h"
@@ -336,6 +337,7 @@ static struct snd_platform_data dm646x_evm_snd_data[] = {
 		.tdm_slots      = 2,
 		.serial_dir     = dm646x_iis_serializer_direction,
 		.asp_chan_q     = EVENTQ_0,
+		.sram_pool	= davinci_sram_pool,
 	},
 	{
 		.tx_dma_offset  = 0x400,
@@ -345,6 +347,7 @@ static struct snd_platform_data dm646x_evm_snd_data[] = {
 		.tdm_slots      = 32,
 		.serial_dir     = dm646x_dit_serializer_direction,
 		.asp_chan_q     = EVENTQ_0,
+		.sram_pool	= davinci_sram_pool,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index f6b9fc7..74b31b9 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -37,6 +37,7 @@
 #include <mach/nand.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/sram.h>
 
 #include "davinci.h"
 
@@ -125,7 +126,9 @@ static struct platform_device davinci_fb_device = {
 	.num_resources = 0,
 };
 
-static struct snd_platform_data dm644x_ntosd2_snd_data;
+static struct snd_platform_data dm644x_ntosd2_snd_data = {
+	.sram_pool	= davinci_sram_pool,
+};
 
 static struct gpio_led ntosd2_leds[] = {
 	{ .name = "led1_green", .gpio = GPIO(10), },
diff --git a/arch/arm/mach-davinci/include/mach/sram.h b/arch/arm/mach-davinci/include/mach/sram.h
index 111f7cc..0394121 100644
--- a/arch/arm/mach-davinci/include/mach/sram.h
+++ b/arch/arm/mach-davinci/include/mach/sram.h
@@ -23,5 +23,6 @@
  */
 extern void *sram_alloc(size_t len, dma_addr_t *dma);
 extern void sram_free(void *addr, size_t len);
+extern struct gen_pool *davinci_sram_pool;
 
 #endif /* __MACH_SRAM_H */
diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index db0f778..a938361 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -15,7 +15,8 @@
 #include <mach/common.h>
 #include <mach/sram.h>
 
-static struct gen_pool *sram_pool;
+struct gen_pool *davinci_sram_pool;
+EXPORT_SYMBOL_GPL(davinci_sram_pool);
 
 void *sram_alloc(size_t len, dma_addr_t *dma)
 {
@@ -24,10 +25,10 @@ void *sram_alloc(size_t len, dma_addr_t *dma)
 
 	if (dma)
 		*dma = 0;
-	if (!sram_pool || (dma && !dma_base))
+	if (!davinci_sram_pool || (dma && !dma_base))
 		return NULL;
 
-	vaddr = gen_pool_alloc(sram_pool, len);
+	vaddr = gen_pool_alloc(davinci_sram_pool, len);
 	if (!vaddr)
 		return NULL;
 
@@ -40,7 +41,7 @@ EXPORT_SYMBOL(sram_alloc);
 
 void sram_free(void *addr, size_t len)
 {
-	gen_pool_free(sram_pool, (unsigned long) addr, len);
+	gen_pool_free(davinci_sram_pool, (unsigned long) addr, len);
 }
 EXPORT_SYMBOL(sram_free);
 
@@ -58,12 +59,12 @@ static int __init sram_init(void)
 
 	if (len) {
 		len = min_t(unsigned, len, SRAM_SIZE);
-		sram_pool = gen_pool_create(ilog2(SRAM_GRANULARITY), -1);
-		if (!sram_pool)
+		davinci_sram_pool = gen_pool_create(ilog2(SRAM_GRANULARITY), -1);
+		if (!davinci_sram_pool)
 			status = -ENOMEM;
 	}
-	if (sram_pool)
-		status = gen_pool_add(sram_pool, SRAM_VIRT, len, -1);
+	if (davinci_sram_pool)
+		status = gen_pool_add(davinci_sram_pool, SRAM_VIRT, len, -1);
 	WARN_ON(status < 0);
 	return status;
 }
diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 8c618e1..0cd22f7 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -73,6 +73,7 @@ struct snd_platform_data {
 	 * when compared to previous behavior.
 	 */
 	unsigned enable_channel_combine:1;
+	struct gen_pool *sram_pool;
 	unsigned sram_size_playback;
 	unsigned sram_size_capture;
 
-- 
1.7.11.4


--------------070905020901050407020000
Content-Type: text/x-patch;
 name="0002-ALSA-ASoC-McASP-use-gen_pool-from-platform-data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-ASoC-McASP-use-gen_pool-from-platform-data.patch"

>From 465846f6fd1ea39534f32b984d352b5bc6928889 Mon Sep 17 00:00:00 2001
From: Daniel Mack <zonque@gmail.com>
Date: Thu, 4 Oct 2012 11:12:28 +0200
Subject: [PATCH 2/2] ALSA: ASoC: McASP: use gen_pool from platform data

This makes the gen_pool SRAM usage a runtime decision.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-pcm.c | 59 +++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 7ac5a19..f47b8f3 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
+#include <linux/genalloc.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -261,26 +262,27 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
 	}
 }
 
-#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
+#ifdef CONFIG_GENERIC_ALLOCATOR
 static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
-		struct snd_pcm_hardware *ppcm)
+			 struct snd_pcm_hardware *ppcm, struct gen_pool *pool)
 {
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
 	struct snd_dma_buffer *iram_dma = NULL;
+	unsigned long iram_virt = 0;
 	dma_addr_t iram_phys = 0;
-	void *iram_virt = NULL;
 
 	if (buf->private_data || !size)
 		return 0;
 
 	ppcm->period_bytes_max = size;
-	iram_virt = sram_alloc(size, &iram_phys);
+	iram_virt = gen_pool_alloc(pool, size);
 	if (!iram_virt)
 		goto exit1;
+	iram_phys = gen_pool_virt_to_phys(pool, iram_virt);
 	iram_dma = kzalloc(sizeof(*iram_dma), GFP_KERNEL);
 	if (!iram_dma)
 		goto exit2;
-	iram_dma->area = iram_virt;
+	iram_dma->area = (void *) iram_virt;
 	iram_dma->addr = iram_phys;
 	memset(iram_dma->area, 0, size);
 	iram_dma->bytes = size;
@@ -288,12 +290,40 @@ static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
 	return 0;
 exit2:
 	if (iram_virt)
-		sram_free(iram_virt, size);
+		gen_pool_free(pool, iram_virt, size);
 exit1:
 	return -ENOMEM;
 }
+
+static void free_sram(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct snd_dma_buffer *iram_dma = buf->private_data;
+	struct davinci_pcm_dma_params *params, *pa;
+
+	if (!buf || !rtd || !iram_dma)
+		return;
+
+	pa = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	params = &pa[substream->stream];
+
+	gen_pool_free(params->sram_pool, (unsigned long) iram_dma->area,
+		      iram_dma->bytes);
+}
+#else
+static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
+			 struct snd_pcm_hardware *ppcm, struct gen_pool *pool)
+{
+	return 0;
+}
+
+static void free_sram(struct snd_pcm_substream *substream)
+{
+}
 #endif
 
+
 /*
  * Only used with ping/pong.
  * This is called after runtime->dma_addr, period_bytes and data_type are valid
@@ -680,9 +710,11 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 
 	ppcm = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 			&pcm_hardware_playback : &pcm_hardware_capture;
-#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
-	allocate_sram(substream, params->sram_size, ppcm);
-#endif
+
+	if (params->sram_pool)
+		allocate_sram(substream, params->sram_size, ppcm,
+			      params->sram_pool);
+
 	snd_soc_set_runtime_hwparams(substream, ppcm);
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -811,7 +843,6 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 	int stream;
 
 	for (stream = 0; stream < 2; stream++) {
-		struct snd_dma_buffer *iram_dma;
 		substream = pcm->streams[stream].substream;
 		if (!substream)
 			continue;
@@ -823,13 +854,7 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 		dma_free_writecombine(pcm->card->dev, buf->bytes,
 				      buf->area, buf->addr);
 		buf->area = NULL;
-#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
-		iram_dma = buf->private_data;
-		if (iram_dma) {
-			sram_free(iram_dma->area, iram_dma->bytes);
-			kfree(iram_dma);
-		}
-#endif
+		free_sram(substream);
 	}
 }
 
-- 
1.7.11.4


--------------070905020901050407020000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070905020901050407020000--
