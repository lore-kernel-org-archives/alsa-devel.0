From: Petr Cvek <petrcvekcz@gmail.com>
Subject: Re: ASoC: pxa: possible regressions
Date: Wed, 8 Aug 2018 11:07:11 +0200
Message-ID: <3ff3c732-b598-f2c3-9a0a-cc92f234326b@gmail.com>
References: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
 <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EC21B88B4B49456C2F8EAA39"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, broonie@kernel.org, philipp.zabel@gmail.com, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------EC21B88B4B49456C2F8EAA39
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Dne 8.8.2018 v 07:38 Daniel Mack napsal(a):
> 
>> My setup has only a few changes from
>> vanilla (change to using devm_snd_soc_register_card+devm_gpio_request).
> 
> Care to share these changes, or ideally rebase them on top of 4.18-next 
> for mainline inclusion? Also, I'm curious what mainline version you used 
> to be based on that worked for you.

I was planning to send patches before I've found regressions in the 
current -next.

I think I've had the first working version somewhere around 3.13, but I 
was updating versions only sporadically and fixing audio had low 
priority (higher priority got iwmmxt compiler, platform init source 
code, charger, USB, MMC and IrDA). Some versions until now worked, some 
didn't.

The last version I've used and where the sound worked was 
4.14.0-rc7-next from somewhere around 3rd November 2017. The patch for 
sound subsystem should be the same as the current one.

The current patch is based on vanilla 4.18.0-rc6-next-20180726.

> 
>> 2) wrong units (sample rate vs osc rate)
>>
>> Commit 05739375f1c0a1048 ("ASoC: pxa-ssp: remove .set_pll() and
>> .set_clkdiv() callbacks"). The function pxa_ssp_hw_params() get's called
>> with sample rate so:
>>
>>     /* The values in the table are for 16 bits */
>>     if (width == 32)
>>         acds--;
>>
>>     ret = pxa_ssp_set_pll(priv, bclk);
>>     if (ret < 0)
>>         return ret;
>>
>>     ssacd = pxa_ssp_read_reg(ssp, SSACD);
>>     ssacd &= ~(SSACD_ACDS(7) | SSACD_SCDB_1X);
>>
>> pxa_ssp_set_pll() will try to set something like 8000, 44100, ... and
>> not the speed of an oscilator. The line should be probably:
>>
>>     ret = pxa_ssp_set_pll(priv, m->pll);
>>
>> and there is a previous call to pxa_ssp_set_pll():
> 
> Ah, yes. Does changing that fix it for you?
> 

Nope it just allows the code to proceed behind.

The fixing 3) (SSCR0_MOD check) has the same effect. It just postpones 
the closing of the device until a valid termination of aplay.

> 
>> 3) setup fails
>>
>> Recent changes in ASoC PXA DMA are causing a fail of a condition in
>> pxa_ssp_hw_params():
>>
>>     if ((sscr0 & SSCR0_MOD) && !ttsa) {
> 
> What are the values of sscr0 and ttsa in your case? Can you cross-check 
> that with a kernel that doesn't have my recent changes?
> 

-> full values in the attached log (the flag is set in the switch case 
and ttsa is zeroed)

On 4.14 (not sure, if it is the correct SSP controller)

Idle:

SSCR0:
	# devmem 0x41000000 32
	0x4000003F <- 31 bit is SSCR0_MOD
SSCR1:
	# devmem 0x41000004 32
	0x00C01D80
SSTSA:
	# devmem 0x41000030 32
	0x00000000 <- is "ttsa" variable
SSRSA:
	# devmem 0x41000034 32
	0x00000000
SSTSS:
	# devmem 0x41000038 32
	0x00000000

Playing noise:

SSCR0:
	# devmem 0x41000000 32
	0x400000BF <- 31 bit is SSCR0_MOD
SSCR1:
	# devmem 0x41000004 32
	0x00E01D80
SSTSA:
	# devmem 0x41000030 32
	0x00000000 <- is "ttsa" variable
SSRSA:
	# devmem 0x41000034 32
	0x00000000
SSTSS:
	# devmem 0x41000038 32
	0x00000000

.. so the time slots are correctly disabled.

>> 4) names are not unique
>>
>> The initialization of magician_dai structure wants to have (at least in
>> the past versions) for the .name item:
>>
>>     static struct snd_soc_dai_link magician_dai[] = {
>>     {
>>         .name = "uda1380",
>>         .stream_name = "UDA1380 Playback",
>>         .cpu_dai_name = "pxa-ssp-dai.0",
>>         ...
>>     {
>>         .name = "uda1380",
>>         .stream_name = "UDA1380 Capture",
>>         .cpu_dai_name = "pxa2xx-i2s",
>>
>> my personal branch has them named as "uda1380_playback" and
>> "uda1380_capture".
> 
> Care to send a patch for that as well, please?

If this is a correct solution then yes.

> 
>> 5) Unbalanced references
>>
>> When trying to play a sound (with quick-and-dirty workarounds for
>> problems above):
>>
>>     # cat /dev/urandom | aplay -
>>
>> the system will crash when terminating aplay (stopping playback). The
>> backtrace:
> 
> So you did hear a sound?

No, nothing went through. Only clicking was probably caused by muting 
the speaker output.

> 
> That seems fine. The question is why there are are unbalanced calls to 
> snd_dmaengine_pcm_close_release_chan(). Could you dig a bit further 
> maybe and add some printk()?

Yes I did, patch with asserts and matching log attached. It gets really 
ugly but though. It is full dump of changes, so there is a conversion of 
magician-audio driver for module_platform_driver (wasn't able to load it 
from vanilla from around 3.13) and some bugfixes in uda codec 
(uda1380-hifi removed because it didn't work with split magician I2S/SSP 
channels and I didn't test it lately, and a bugfix for name/register 
settings).

Petr

--------------EC21B88B4B49456C2F8EAA39
Content-Type: text/x-patch;
 name="0001-ASoC-pxa-magician-testing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ASoC-pxa-magician-testing.patch"

>From 4235ede8483cb177ff26d7344699a6481a222cc7 Mon Sep 17 00:00:00 2001
From: Petr Cvek <petrcvekcz@gmail.com>
Date: Fri, 3 Aug 2018 06:21:41 +0200
Subject: [PATCH] ASoC pxa magician testing

---
 sound/arm/pxa2xx-pcm-lib.c |  23 +++++-
 sound/core/pcm_dmaengine.c |   7 ++
 sound/core/pcm_native.c    |  97 +++++++++++++----------
 sound/soc/codecs/uda1380.c |  56 +++++++++-----
 sound/soc/pxa/magician.c   | 152 +++++++++++++++++++------------------
 sound/soc/pxa/pxa-ssp.c    | 139 ++++++++++++++++++++++++++++++++-
 sound/soc/pxa/pxa2xx-i2s.c |  49 ++++++++++++
 sound/soc/soc-core.c       |  15 ++++
 sound/soc/soc-pcm.c        |  25 ++++++
 9 files changed, 428 insertions(+), 135 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 7931789d4a9f..1a3affb0b691 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -29,7 +29,7 @@ static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 	.period_bytes_max	= 8192 - 32,
 	.periods_min		= 1,
 	.periods_max		= 256,
-	.buffer_bytes_max	= 128 * 1024,
+	.buffer_bytes_max	= 16 * 1024,	//original value fails to allocate (128 * 1024 too big)
 	.fifo_size		= 32,
 };
 
@@ -42,23 +42,29 @@ int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct dma_slave_config config;
 	int ret;
 
+pr_info("pxa2xx_pcm_hw_params A1\n");
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	if (!dma_params)
 		return 0;
 
+pr_info("pxa2xx_pcm_hw_params A2\n");
 	ret = snd_hwparams_to_dma_slave_config(substream, params, &config);
 	if (ret)
 		return ret;
 
+pr_info("pxa2xx_pcm_hw_params A3\n");
 	snd_dmaengine_pcm_set_config_from_dai_data(substream,
 			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
 			&config);
 
+pr_info("pxa2xx_pcm_hw_params A4\n");
 	ret = dmaengine_slave_config(chan, &config);
 	if (ret)
 		return ret;
 
+pr_info("pxa2xx_pcm_hw_params A5\n");
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+pr_info("pxa2xx_pcm_hw_params A6 fin\n");
 
 	return 0;
 }
@@ -99,10 +105,13 @@ int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = pxa2xx_pcm_hardware;
 
+pr_info("pxa2xx_pcm_open B1\n");
+
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	if (!dma_params)
 		return 0;
 
+pr_info("pxa2xx_pcm_open B2\n");
 	/*
 	 * For mysterious reasons (and despite what the manual says)
 	 * playback samples are lost if the DMA count is not a multiple
@@ -113,15 +122,19 @@ int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret)
 		return ret;
 
+pr_info("B3\n");
+
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
 	if (ret)
 		return ret;
+pr_info("B4\n");
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
 		return ret;
+pr_info("B5 fin?\n");
 
 	return snd_dmaengine_pcm_open(
 		substream, dma_request_slave_channel(rtd->cpu_dai->dev,
@@ -185,13 +198,18 @@ int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
+pr_info("C1 pxa2xx_soc_pcm_new\n");
+
 	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+pr_info("C2 from dma_coerce_mask_and_coherent %i\n",ret);
 	if (ret)
 		return ret;
 
+
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
 		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
+pr_info("C3play from pxa2xx_pcm_preallocate_dma_buffer %i\n",ret);
 		if (ret)
 			goto out;
 	}
@@ -199,6 +217,9 @@ int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
+pr_info("C4capt from pxa2xx_pcm_preallocate_dma_buffer %i\n",ret);
+
+		//WTF konstrukce
 		if (ret)
 			goto out;
 	}
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 8eb58c709b14..124952e8a3f4 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -18,6 +18,9 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
+
+#define DEBUG 1
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/dmaengine.h>
@@ -369,11 +372,15 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+pr_info("GGG1 %i\n",prtd->dma_chan->client_count);
 
 	dmaengine_synchronize(prtd->dma_chan);
+pr_info("GGG2\n");
 	dma_release_channel(prtd->dma_chan);
+pr_info("GGG3\n");
 	kfree(prtd);
 
+pr_info("GGG4\n");
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close_release_chan);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 66c90f486af9..57a66a5dd21d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -990,7 +990,7 @@ static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime;
 	unsigned int channel;
-	
+
 	channel = info->channel;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
@@ -1011,7 +1011,7 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_channel_info info;
 	int res;
-	
+
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
 	res = snd_pcm_channel_info(substream, &info);
@@ -1111,7 +1111,7 @@ static int snd_pcm_action_single(const struct action_ops *ops,
 				 int state)
 {
 	int res;
-	
+
 	res = ops->pre_action(substream, state);
 	if (res < 0)
 		return res;
@@ -1221,7 +1221,7 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream, int state)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
 	runtime->hw_ptr_jiffies = jiffies;
-	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
+	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) /
 							    runtime->rate;
 	runtime->status->state = state;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
@@ -1909,7 +1909,7 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
 	int result = 0;
-	
+
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
@@ -2145,7 +2145,7 @@ static int snd_pcm_hw_rule_rate(struct snd_pcm_hw_params *params,
 	return snd_interval_list(hw_param_interval(params, rule->var),
 				 snd_pcm_known_rates.count,
 				 snd_pcm_known_rates.list, hw->rates);
-}		
+}
 
 static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
@@ -2158,7 +2158,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 	t.openmax = 0;
 	t.integer = 1;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
-}		
+}
 
 int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
@@ -2185,98 +2185,98 @@ int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				  snd_pcm_hw_rule_sample_bits, NULL,
-				  SNDRV_PCM_HW_PARAM_FORMAT, 
+				  SNDRV_PCM_HW_PARAM_FORMAT,
 				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mul, NULL,
 				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_PERIOD_TIME, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_BUFFER_TIME, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_PERIODS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_muldivk, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_TIME, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_mul, NULL,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_PERIODS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_muldivk, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_TIME, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				  snd_pcm_hw_rule_muldivk, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				  snd_pcm_hw_rule_muldivk, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_TIME, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
@@ -2340,7 +2340,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				  snd_pcm_hw_rule_buffer_bytes_max, substream,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
 	if (err < 0)
@@ -2354,7 +2354,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	}
 
 	if (!(hw->rates & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))) {
-		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 					  snd_pcm_hw_rule_rate, hw,
 					  SNDRV_PCM_HW_PARAM_RATE, -1);
 		if (err < 0)
@@ -2374,11 +2374,17 @@ static void pcm_release_private(struct snd_pcm_substream *substream)
 
 void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 {
+
+pr_info("DDD1 snd_pcm_release_substream %i\n",substream->ref_count);
+
 	substream->ref_count--;
 	if (substream->ref_count > 0)
 		return;
 
+pr_info("DDD2\n");
+
 	snd_pcm_drop(substream);
+pr_info("DDD3\n");
 	if (substream->hw_opened) {
 		if (substream->ops->hw_free &&
 		    substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
@@ -2386,13 +2392,16 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
 	}
+pr_info("DDD4\n");
 	if (pm_qos_request_active(&substream->latency_pm_qos_req))
 		pm_qos_remove_request(&substream->latency_pm_qos_req);
 	if (substream->pcm_release) {
 		substream->pcm_release(substream);
 		substream->pcm_release = NULL;
 	}
+pr_info("DDD5\n");
 	snd_pcm_detach_substream(substream);
+pr_info("DDD6\n");
 }
 EXPORT_SYMBOL(snd_pcm_release_substream);
 
@@ -2555,18 +2564,28 @@ static int snd_pcm_release(struct inode *inode, struct file *file)
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_file *pcm_file;
 
+pr_info("CCC1 snd_pcm_release\n");
+
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
+pr_info("CCC2\n");
 	if (snd_BUG_ON(!substream))
 		return -ENXIO;
 	pcm = substream->pcm;
 	mutex_lock(&pcm->open_mutex);
+pr_info("CCC3\n");
 	snd_pcm_release_substream(substream);
+pr_info("CCC4\n");
 	kfree(pcm_file);
+pr_info("CCC5\n");
 	mutex_unlock(&pcm->open_mutex);
+pr_info("CCC6\n");
 	wake_up(&pcm->open_wait);
+pr_info("CCC7\n");
 	module_put(pcm->card->module);
+pr_info("CCC8\n");
 	snd_card_file_remove(pcm->card, file);
+pr_info("CCC9\n");
 	return 0;
 }
 
@@ -2682,7 +2701,7 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irq(substream);
 	return err;
 }
-		
+
 static int snd_pcm_delay(struct snd_pcm_substream *substream,
 			 snd_pcm_sframes_t *delay)
 {
@@ -2698,7 +2717,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 		*delay = n;
 	return err;
 }
-		
+
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			    struct snd_pcm_sync_ptr __user *_sync_ptr)
 {
@@ -2712,7 +2731,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
 		return -EFAULT;
 	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
-		return -EFAULT;	
+		return -EFAULT;
 	status = runtime->status;
 	control = runtime->control;
 	if (sync_ptr.flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
@@ -2750,7 +2769,7 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int arg;
-	
+
 	if (get_user(arg, _arg))
 		return -EFAULT;
 	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
@@ -2970,7 +2989,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 {
 	snd_pcm_uframes_t *frames = arg;
 	snd_pcm_sframes_t result;
-	
+
 	switch (cmd) {
 	case SNDRV_PCM_IOCTL_FORWARD:
 	{
@@ -3181,7 +3200,7 @@ static vm_fault_t snd_pcm_mmap_status_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3217,7 +3236,7 @@ static vm_fault_t snd_pcm_mmap_control_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3309,7 +3328,7 @@ static vm_fault_t snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 	unsigned long offset;
 	struct page * page;
 	size_t dma_bytes;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3452,9 +3471,9 @@ EXPORT_SYMBOL(snd_pcm_mmap_data);
 static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 {
 	struct snd_pcm_file * pcm_file;
-	struct snd_pcm_substream *substream;	
+	struct snd_pcm_substream *substream;
 	unsigned long offset;
-	
+
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 584a032b3cb1..5cd0e4e5d471 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -140,6 +140,8 @@ static void uda1380_sync_cache(struct snd_soc_component *component)
 	u8 data[3];
 	u16 *cache = uda1380->reg_cache;
 
+pr_info("D1 uda1380_sync_cache\n");
+
 	/* Sync reg_cache with the hardware */
 	for (reg = 0; reg < UDA1380_MVOL; reg++) {
 		data[0] = reg;
@@ -149,6 +151,9 @@ static void uda1380_sync_cache(struct snd_soc_component *component)
 			dev_err(component->dev, "%s: write to reg 0x%x failed\n",
 				__func__, reg);
 	}
+
+pr_info("D2 fin\n");
+
 }
 
 static int uda1380_reset(struct snd_soc_component *component)
@@ -203,8 +208,8 @@ static const char *uda1380_deemp[] = {
 };
 static const char *uda1380_input_sel[] = {
 	"Line",
-	"Mic + Line R",
 	"Line L",
+	"Mic + Line R",
 	"Mic",
 };
 static const char *uda1380_output_sel[] = {
@@ -227,8 +232,8 @@ static const char *uda1380_sel_ns[] = {
 };
 static const char *uda1380_mix_control[] = {
 	"off",
-	"PCM only",
 	"before sound processing",
+	"PCM only",
 	"after sound processing"
 };
 static const char *uda1380_sdet_setting[] = {
@@ -423,6 +428,8 @@ static int uda1380_set_dai_fmt_both(struct snd_soc_dai *codec_dai,
 	struct snd_soc_component *component = codec_dai->component;
 	int iface;
 
+pr_info("E1 uda1380_set_dai_fmt_both\n");
+
 	/* set up DAI based upon fmt */
 	iface = uda1380_read_reg_cache(component, UDA1380_IFACE);
 	iface &= ~(R01_SFORI_MASK | R01_SIM | R01_SFORO_MASK);
@@ -437,11 +444,13 @@ static int uda1380_set_dai_fmt_both(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_MSB:
 		iface |= R01_SFORI_MSB | R01_SFORO_MSB;
 	}
+pr_info("E2\n");
 
 	/* DATAI is slave only, so in single-link mode, this has to be slave */
 	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
 		return -EINVAL;
 
+pr_info("E3 fin\n");
 	uda1380_write_reg_cache(component, UDA1380_IFACE, iface);
 
 	return 0;
@@ -453,10 +462,14 @@ static int uda1380_set_dai_fmt_playback(struct snd_soc_dai *codec_dai,
 	struct snd_soc_component *component = codec_dai->component;
 	int iface;
 
+pr_info("F1 uda1380_set_dai_fmt_playback\n");
+
 	/* set up DAI based upon fmt */
 	iface = uda1380_read_reg_cache(component, UDA1380_IFACE);
 	iface &= ~R01_SFORI_MASK;
 
+pr_info("F2\n");
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		iface |= R01_SFORI_I2S;
@@ -468,11 +481,15 @@ static int uda1380_set_dai_fmt_playback(struct snd_soc_dai *codec_dai,
 		iface |= R01_SFORI_MSB;
 	}
 
+pr_info("F3\n");
+
 	/* DATAI is slave only, so this has to be slave */
 	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
 		return -EINVAL;
+pr_info("F4\n");
 
 	uda1380_write(component, UDA1380_IFACE, iface);
+pr_info("F5 fin\n");
 
 	return 0;
 }
@@ -513,6 +530,8 @@ static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct uda1380_priv *uda1380 = snd_soc_component_get_drvdata(component);
 	int mixer = uda1380_read_reg_cache(component, UDA1380_MIXER);
 
+pr_info("G1 uda1380_trigger\n");
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -527,6 +546,9 @@ static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 		schedule_work(&uda1380->work);
 		break;
 	}
+
+pr_info("G2 fin\n");
+
 	return 0;
 }
 
@@ -537,6 +559,8 @@ static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	u16 clk = uda1380_read_reg_cache(component, UDA1380_CLK);
 
+pr_info("H1 uda1380_pcm_hw_params\n");
+
 	/* set WSPLL power and divider if running from this clock */
 	if (clk & R00_DAC_CLK) {
 		int rate = params_rate(params);
@@ -559,12 +583,19 @@ static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
 		uda1380_write(component, UDA1380_PM, R02_PON_PLL | pm);
 	}
 
+pr_info("H2\n");
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		clk |= R00_EN_DAC | R00_EN_INT;
 	else
 		clk |= R00_EN_ADC | R00_EN_DEC;
 
+pr_info("H3\n");
+
 	uda1380_write(component, UDA1380_CLK, clk);
+
+pr_info("H4 fin\n");
+
 	return 0;
 }
 
@@ -654,22 +685,8 @@ static const struct snd_soc_dai_ops uda1380_dai_ops_capture = {
 };
 
 static struct snd_soc_dai_driver uda1380_dai[] = {
-{
-	.name = "uda1380-hifi",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = UDA1380_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = UDA1380_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = &uda1380_dai_ops,
-},
+// NOTICE first field of the array was unused and in
+// certain versions didn't work with magician
 { /* playback only - dual interface */
 	.name = "uda1380-hifi-playback",
 	.playback = {
@@ -783,6 +800,9 @@ static int uda1380_i2c_probe(struct i2c_client *i2c,
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_uda1380, uda1380_dai, ARRAY_SIZE(uda1380_dai));
+
+pr_info("uda1380_i2c_probe ret=%i\n",ret);
+
 	return ret;
 }
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 935a248e5bf6..2c83c8ef8eb7 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -44,7 +44,10 @@ static int magician_in_sel = MAGICIAN_MIC;
 static void magician_ext_control(struct snd_soc_dapm_context *dapm)
 {
 
+pr_info("I1 magician_ext_control\n");
+
 	snd_soc_dapm_mutex_lock(dapm);
+pr_info("I2\n");
 
 	if (magician_spk_switch)
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Speaker");
@@ -54,6 +57,7 @@ static void magician_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Headphone Jack");
 	else
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Headphone Jack");
+pr_info("I3\n");
 
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
@@ -65,10 +69,13 @@ static void magician_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Headset Mic");
 		break;
 	}
+pr_info("I4\n");
 
 	snd_soc_dapm_sync_unlocked(dapm);
 
+pr_info("I5\n");
 	snd_soc_dapm_mutex_unlock(dapm);
+pr_info("I6 fin\n");
 }
 
 static int magician_startup(struct snd_pcm_substream *substream)
@@ -93,11 +100,14 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	unsigned int width;
 	int ret = 0;
 
+pr_info("J1 magician_playback_hw_params\n");
+
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_MSB |
 			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
+pr_info("J2\n");
 
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
@@ -105,17 +115,22 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+pr_info("J3\n");
 	width = snd_pcm_format_physical_width(params_format(params));
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 0, 1, width);
 	if (ret < 0)
 		return ret;
 
+pr_info("J4\n");
+
 	/* set audio clock as clock source */
 	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0,
 			SND_SOC_CLOCK_OUT);
 	if (ret < 0)
 		return ret;
 
+pr_info("J5 fin\n");
+
 	return 0;
 }
 
@@ -175,11 +190,18 @@ static int magician_set_hp(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
+pr_info("K1 magician_set_hp\n");
+
 	if (magician_hp_switch == ucontrol->value.integer.value[0])
 		return 0;
 
+pr_info("K2\n");
+
 	magician_hp_switch = ucontrol->value.integer.value[0];
 	magician_ext_control(&card->dapm);
+
+pr_info("K3 fin\n");
+
 	return 1;
 }
 
@@ -195,11 +217,16 @@ static int magician_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
+pr_info("L1 magician_set_spk %i\n",ucontrol->value.integer.value[0]);
+
 	if (magician_spk_switch == ucontrol->value.integer.value[0])
 		return 0;
 
+pr_info("L2\n");
 	magician_spk_switch = ucontrol->value.integer.value[0];
+pr_info("L3\n");
 	magician_ext_control(&card->dapm);
+pr_info("L4 fin\n");
 	return 1;
 }
 
@@ -213,11 +240,17 @@ static int magician_get_input(struct snd_kcontrol *kcontrol,
 static int magician_set_input(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
+
+pr_info("M1 magician_set_input\n");
+
 	if (magician_in_sel == ucontrol->value.enumerated.item[0])
 		return 0;
 
+pr_info("M2\n");
+
 	magician_in_sel = ucontrol->value.enumerated.item[0];
 
+pr_info("M3\n");
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
 		gpio_set_value(EGPIO_MAGICIAN_IN_SEL1, 1);
@@ -226,13 +259,20 @@ static int magician_set_input(struct snd_kcontrol *kcontrol,
 		gpio_set_value(EGPIO_MAGICIAN_IN_SEL1, 0);
 	}
 
+pr_info("M4 fin\n");
 	return 1;
 }
 
 static int magician_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
+
+pr_info("N1 magician_spk_power\n");
+
 	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, SND_SOC_DAPM_EVENT_ON(event));
+
+pr_info("N2 fin\n");
+
 	return 0;
 }
 
@@ -292,22 +332,24 @@ static const struct snd_kcontrol_new uda1380_magician_controls[] = {
 /* magician digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link magician_dai[] = {
 {
-	.name = "uda1380",
+	.name = "uda1380_playback",
 	.stream_name = "UDA1380 Playback",
 	.cpu_dai_name = "pxa-ssp-dai.0",
 	.codec_dai_name = "uda1380-hifi-playback",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "uda1380-codec.0-0018",
 	.ops = &magician_playback_ops,
+	.playback_only = true,
 },
 {
-	.name = "uda1380",
+	.name = "uda1380_capture",
 	.stream_name = "UDA1380 Capture",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "uda1380-hifi-capture",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "uda1380-codec.0-0018",
 	.ops = &magician_capture_ops,
+	.capture_only   = true,
 }
 };
 
@@ -324,109 +366,71 @@ static struct snd_soc_card snd_soc_card_magician = {
 	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
-	.fully_routed = true,
-};
-
-static struct platform_device *magician_snd_device;
-
-/*
- * FIXME: move into magician board file once merged into the pxa tree
- */
-static struct uda1380_platform_data uda1380_info = {
-	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
-	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
-	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
+	.fully_routed = true,	//no change if false
 };
 
-static struct i2c_board_info i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("uda1380", 0x18),
-		.platform_data = &uda1380_info,
-	},
-};
-
-static int __init magician_init(void)
-{
+static int magician_audio_probe(struct platform_device *pdev){
 	int ret;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
 
-	if (!machine_is_magician())
-		return -ENODEV;
+pr_info("magician_audio_probe AAA1\n");
 
-	adapter = i2c_get_adapter(0);
-	if (!adapter)
-		return -ENODEV;
-	client = i2c_new_device(adapter, i2c_board_info);
-	i2c_put_adapter(adapter);
-	if (!client)
-		return -ENODEV;
+	snd_soc_card_magician.dev = &pdev->dev;
 
-	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
+	ret = devm_gpio_request(&pdev->dev, EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
 	if (ret)
-		goto err_request_spk;
-	ret = gpio_request(EGPIO_MAGICIAN_EP_POWER, "EP_POWER");
+		goto err_pdev;
+	ret = devm_gpio_request(&pdev->dev, EGPIO_MAGICIAN_EP_POWER, "EP_POWER");
 	if (ret)
-		goto err_request_ep;
-	ret = gpio_request(EGPIO_MAGICIAN_MIC_POWER, "MIC_POWER");
+		goto err_pdev;
+	ret = devm_gpio_request(&pdev->dev, EGPIO_MAGICIAN_MIC_POWER, "MIC_POWER");
 	if (ret)
-		goto err_request_mic;
-	ret = gpio_request(EGPIO_MAGICIAN_IN_SEL0, "IN_SEL0");
+		goto err_pdev;
+	ret = devm_gpio_request(&pdev->dev, EGPIO_MAGICIAN_IN_SEL0, "IN_SEL0");
 	if (ret)
-		goto err_request_in_sel0;
-	ret = gpio_request(EGPIO_MAGICIAN_IN_SEL1, "IN_SEL1");
+		goto err_pdev;
+	ret = devm_gpio_request(&pdev->dev, EGPIO_MAGICIAN_IN_SEL1, "IN_SEL1");
 	if (ret)
-		goto err_request_in_sel1;
+		goto err_pdev;
 
 	gpio_set_value(EGPIO_MAGICIAN_IN_SEL0, 0);
 
-	magician_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!magician_snd_device) {
-		ret = -ENOMEM;
-		goto err_pdev;
-	}
+	platform_set_drvdata(pdev, &snd_soc_card_magician);
 
-	platform_set_drvdata(magician_snd_device, &snd_soc_card_magician);
-	ret = platform_device_add(magician_snd_device);
+	ret = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_magician);
+	pr_info("magician_audio_probe devm_snd_soc_register_card ret=%i\n",ret);
 	if (ret) {
-		platform_device_put(magician_snd_device);
+pr_err("devm_snd_soc_register_card() failed: %d (EEXIST=-17, EPROBE_DEFER=-517)\n", ret);
 		goto err_pdev;
 	}
 
-	return 0;
+pr_info("magician_audio_probe ALL OK\n");
 
+	return 0;
 err_pdev:
-	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
-err_request_in_sel1:
-	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
-err_request_in_sel0:
-	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
-err_request_mic:
-	gpio_free(EGPIO_MAGICIAN_EP_POWER);
-err_request_ep:
-	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
-err_request_spk:
 	return ret;
 }
 
-static void __exit magician_exit(void)
-{
-	platform_device_unregister(magician_snd_device);
-
+static int magician_audio_remove(struct platform_device *pdev){
 	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, 0);
 	gpio_set_value(EGPIO_MAGICIAN_EP_POWER, 0);
 	gpio_set_value(EGPIO_MAGICIAN_MIC_POWER, 0);
 
-	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
-	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
-	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
-	gpio_free(EGPIO_MAGICIAN_EP_POWER);
-	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
+pr_info("exiting magician SoC driver\n");
+	return 0;
 }
 
-module_init(magician_init);
-module_exit(magician_exit);
+static struct platform_driver magician_audio_driver = {
+    .driver     = {
+        .name   = "magician-audio",
+        .owner  = THIS_MODULE,
+    },
+    .probe      = magician_audio_probe,
+    .remove     = magician_audio_remove,
+};
+
+module_platform_driver(magician_audio_driver);
 
 MODULE_AUTHOR("Philipp Zabel");
 MODULE_DESCRIPTION("ALSA SoC Magician");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:magician-audio");
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 69033e1a84e6..f20d5ce30ebc 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -14,6 +14,8 @@
  *  o Test network mode for > 16bit sample size
  */
 
+#define DEBUG 1
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -69,8 +71,14 @@ static void pxa_ssp_enable(struct ssp_device *ssp)
 {
 	uint32_t sscr0;
 
+pr_info("U1 pxa_ssp_enable\n");
+
+
 	sscr0 = __raw_readl(ssp->mmio_base + SSCR0) | SSCR0_SSE;
 	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
+
+pr_info("U2 fin\n");
+
 }
 
 static void pxa_ssp_disable(struct ssp_device *ssp)
@@ -84,10 +92,16 @@ static void pxa_ssp_disable(struct ssp_device *ssp)
 static void pxa_ssp_set_dma_params(struct ssp_device *ssp, int width4,
 			int out, struct snd_dmaengine_dai_dma_data *dma)
 {
+
+pr_info("V1 pxa_ssp_set_dma_params\n");
+
 	dma->addr_width = width4 ? DMA_SLAVE_BUSWIDTH_4_BYTES :
 				   DMA_SLAVE_BUSWIDTH_2_BYTES;
 	dma->maxburst = 16;
 	dma->addr = ssp->phys_base + SSDR;
+
+pr_info("V2 fin\n");
+
 }
 
 static int pxa_ssp_startup(struct snd_pcm_substream *substream,
@@ -98,19 +112,25 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 	struct snd_dmaengine_dai_dma_data *dma;
 	int ret = 0;
 
+pr_info("W1 pxa_ssp_startup\n");
+
+
 	if (!cpu_dai->active) {
 		clk_prepare_enable(ssp->clk);
 		pxa_ssp_disable(ssp);
 	}
+pr_info("W2\n");
 
 	dma = kzalloc(sizeof(struct snd_dmaengine_dai_dma_data), GFP_KERNEL);
 	if (!dma)
 		return -ENOMEM;
 	dma->chan_name = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
 		"tx" : "rx";
+pr_info("W3\n");
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma);
 
+pr_info("W4 fin %i\n",ret);
 	return ret;
 }
 
@@ -120,13 +140,20 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 
+pr_info("WWW1 pxa_ssp_shutdown\n");
+
 	if (!cpu_dai->active) {
+pr_info("WWW2\n");
 		pxa_ssp_disable(ssp);
+pr_info("WWW3\n");
 		clk_disable_unprepare(ssp->clk);
+pr_info("WWW4\n");
 	}
 
 	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
+pr_info("WWW5\n");
 	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
+pr_info("WWW6\n");
 }
 
 #ifdef CONFIG_PM
@@ -182,6 +209,9 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
  */
 static void pxa_ssp_set_scr(struct ssp_device *ssp, u32 div)
 {
+
+pr_info("X1 pxa_ssp_set_scr\n");
+
 	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
 
 	if (ssp->type == PXA25x_SSP) {
@@ -192,6 +222,9 @@ static void pxa_ssp_set_scr(struct ssp_device *ssp, u32 div)
 		sscr0 |= (div - 1) << 8;     /* 1..4096 */
 	}
 	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
+
+pr_info("X2 fin\n");
+
 }
 
 /*
@@ -203,6 +236,9 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 
+pr_info("Y1 pxa_ssp_set_dai_sysclk\n");
+
+
 	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
 		~(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 
@@ -221,6 +257,8 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		clk_id = PXA_SSP_CLK_EXT;
 	}
 
+pr_info("Y2 sscr0=%08x\n",sscr0);
+
 	dev_dbg(&ssp->pdev->dev,
 		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
 		cpu_dai->id, clk_id, freq);
@@ -228,6 +266,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	switch (clk_id) {
 	case PXA_SSP_CLK_NET_PLL:
 		sscr0 |= SSCR0_MOD;
+pr_info("Y2b BUG\n");
 		break;
 	case PXA_SSP_CLK_PLL:
 		/* Internal PLL is fixed */
@@ -243,6 +282,8 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case PXA_SSP_CLK_NET:
 		priv->sysclk = freq;
 		sscr0 |= SSCR0_NCS | SSCR0_MOD;
+pr_info("Y2c BUG\n");
+
 		break;
 	case PXA_SSP_CLK_AUDIO:
 		priv->sysclk = 0;
@@ -253,6 +294,8 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		return -ENODEV;
 	}
 
+pr_info("Y3\n");
+
 	/* The SSP clock must be disabled when changing SSP clock mode
 	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
 	if (ssp->type != PXA3xx_SSP)
@@ -261,6 +304,8 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	if (ssp->type != PXA3xx_SSP)
 		clk_prepare_enable(ssp->clk);
 
+pr_info("Y4 fin\n");
+
 	return 0;
 }
 
@@ -270,11 +315,18 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 static int pxa_ssp_set_pll(struct ssp_priv *priv, unsigned int freq)
 {
 	struct ssp_device *ssp = priv->ssp;
+
+pr_info("Z1 pxa_ssp_set_pll\n");
+
 	u32 ssacd = pxa_ssp_read_reg(ssp, SSACD) & ~0x70;
 
+pr_info("Z2\n");
+
 	if (ssp->type == PXA3xx_SSP)
 		pxa_ssp_write_reg(ssp, SSACDD, 0);
 
+pr_info("Z3!!!!!!!!!! %i\n",freq);
+
 	switch (freq) {
 	case 5622000:
 		break;
@@ -323,8 +375,12 @@ static int pxa_ssp_set_pll(struct ssp_priv *priv, unsigned int freq)
 		return -EINVAL;
 	}
 
+pr_info("Z4\n");
+
 	pxa_ssp_write_reg(ssp, SSACD, ssacd);
 
+pr_info("Z5 fin\n");
+
 	return 0;
 }
 
@@ -338,15 +394,24 @@ static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	struct ssp_device *ssp = priv->ssp;
 	u32 sscr0;
 
+pr_info("ZZZ1 pxa_ssp_set_dai_tdm_slot\n");
+
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
+
+pr_info("ZZZ2 %08x\n",sscr0);
+
 	sscr0 &= ~(SSCR0_MOD | SSCR0_SlotsPerFrm(8) | SSCR0_EDSS | SSCR0_DSS);
 
+pr_info("ZZZ3 %08x\n",sscr0);
+
 	/* set slot width */
 	if (slot_width > 16)
 		sscr0 |= SSCR0_EDSS | SSCR0_DataSize(slot_width - 16);
 	else
 		sscr0 |= SSCR0_DataSize(slot_width);
 
+pr_info("ZZZ4 %08x\n",sscr0);
+
 	if (slots > 1) {
 		/* enable network mode */
 		sscr0 |= SSCR0_MOD;
@@ -357,7 +422,12 @@ static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 		/* set active slot mask */
 		pxa_ssp_write_reg(ssp, SSTSA, tx_mask);
 		pxa_ssp_write_reg(ssp, SSRSA, rx_mask);
+	} else {
+		//sscr0 &= ~SSCR0_MOD;
 	}
+
+pr_info("ZZZ5 %08x\n",sscr0);
+
 	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 
 	return 0;
@@ -407,6 +477,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
+pr_info("!!!!! pxa_ssp_set_dai_fmt %i\n",fmt );
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_DSP_A:
@@ -487,8 +559,13 @@ static int pxa_ssp_configure_dai_fmt(struct ssp_priv *priv)
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |= SSPSP_FSRT;
 		/* fall through */
+pr_info("!!XXX1a %08x\n",sscr0);
+
 	case SND_SOC_DAIFMT_DSP_B:
 		sscr0 |= SSCR0_MOD | SSCR0_PSP;
+
+pr_info("!!XXX1b %08x\n",sscr0);
+
 		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
 		break;
 
@@ -559,7 +636,11 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	int bclk = rate * chn * (width / 8);
 	int ret;
 
+pr_info("AA1 pxa_ssp_hw_params\n");
+
+
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
+pr_info("AA2\n");
 
 	/* Network mode with one active slot (ttsa == 1) can be used
 	 * to force 16-bit frame width on the wire (for S16_LE), even
@@ -569,17 +650,24 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		((chn == 2) && (ttsa != 1)) || (width == 32),
 		substream->stream == SNDRV_PCM_STREAM_PLAYBACK, dma_data);
 
+pr_info("AA3\n");
+
 	/* we can only change the settings if the port is not in use */
 	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
 		return 0;
+pr_info("AA4\n");
 
 	ret = pxa_ssp_configure_dai_fmt(priv);
 	if (ret < 0)
 		return ret;
 
+pr_info("AA5\n");
+
 	/* clear selected SSP bits */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
 
+pr_info("AA6 0x%08x\n",sscr0);
+
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -594,8 +682,13 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
 		break;
 	}
+
+pr_info("AA7\n");
+
 	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 
+pr_info("AA8 %i\n",bclk);
+
 	if (sscr0 & SSCR0_ACS) {
 		ret = pxa_ssp_set_pll(priv, bclk);
 
@@ -604,14 +697,19 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		 * all is fine. Otherwise, look up the closest rate
 		 * from the table and also set the dividers.
 		 */
+pr_info("AA8b %i\n",ret);
 
 		if (ret < 0) {
 			const struct pxa_ssp_clock_mode *m;
 			int ssacd, acds;
 
 			for (m = pxa_ssp_clock_modes; m->rate; m++) {
-				if (m->rate == rate)
+				if (m->rate == rate) {
+
+pr_info("AA8b rate=%i ?= %i\n",rate,m->rate);
+
 					break;
+				}
 			}
 
 			if (!m->rate)
@@ -623,7 +721,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 			if (width == 32)
 				acds--;
 
-			ret = pxa_ssp_set_pll(priv, bclk);
+			ret = pxa_ssp_set_pll(priv, m->pll);
 			if (ret < 0)
 				return ret;
 
@@ -642,6 +740,8 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		pxa_ssp_set_scr(ssp, bclk / rate);
 	}
 
+pr_info("AA9\n");
+
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	       sspsp = pxa_ssp_read_reg(ssp, SSPSP);
@@ -681,16 +781,23 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+pr_info("AA10 ttsa=%08x\n",ttsa);
+
 	/* When we use a network mode, we always require TDM slots
 	 * - complain loudly and fail if they've not been set up yet.
 	 */
 	if ((sscr0 & SSCR0_MOD) && !ttsa) {
 		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
-		return -EINVAL;
+		//return -EINVAL;
+
 	}
 
+pr_info("AA11\n");
+
 	dump_registers(ssp);
 
+pr_info("AA12 fin\n");
+
 	return 0;
 }
 
@@ -702,9 +809,14 @@ static void pxa_ssp_set_running_bit(struct snd_pcm_substream *substream,
 	uint32_t sspsp = pxa_ssp_read_reg(ssp, SSPSP);
 	uint32_t sssr = pxa_ssp_read_reg(ssp, SSSR);
 
+pr_info("AB1 pxa_ssp_set_running_bit\n");
+
+
 	if (value && (sscr0 & SSCR0_SSE))
 		pxa_ssp_write_reg(ssp, SSCR0, sscr0 & ~SSCR0_SSE);
 
+pr_info("AB2\n");
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (value)
 			sscr1 |= SSCR1_TSRE;
@@ -717,13 +829,20 @@ static void pxa_ssp_set_running_bit(struct snd_pcm_substream *substream,
 			sscr1 &= ~SSCR1_RSRE;
 	}
 
+pr_info("AB3\n");
+
 	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
 
+pr_info("AB4\n");
+
 	if (value) {
 		pxa_ssp_write_reg(ssp, SSSR, sssr);
 		pxa_ssp_write_reg(ssp, SSPSP, sspsp);
 		pxa_ssp_write_reg(ssp, SSCR0, sscr0 | SSCR0_SSE);
 	}
+
+pr_info("AB5 fin\n");
+
 }
 
 static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -734,6 +853,8 @@ static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct ssp_device *ssp = priv->ssp;
 	int val;
 
+pr_info("AC1 pxa_ssp_trigger\n");
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		pxa_ssp_enable(ssp);
@@ -760,8 +881,12 @@ static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 		ret = -EINVAL;
 	}
 
+pr_info("AC2\n");
+
 	dump_registers(ssp);
 
+pr_info("AC3 fin %i\n",ret);
+
 	return ret;
 }
 
@@ -771,10 +896,14 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 	struct ssp_priv *priv;
 	int ret;
 
+pr_info("AD1 pxa_ssp_probe\n");
+
 	priv = kzalloc(sizeof(struct ssp_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+pr_info("AD2\n");
+
 	if (dev->of_node) {
 		struct device_node *ssp_handle;
 
@@ -807,8 +936,12 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		}
 	}
 
+pr_info("AD3\n");
+
 	priv->dai_fmt = (unsigned int) -1;
+pr_info("AD4\n");
 	snd_soc_dai_set_drvdata(dai, priv);
+pr_info("AD5 fin\n");
 
 	return 0;
 
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 42820121e5b9..9d9b14adccb3 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -102,12 +102,17 @@ static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
+pr_info("O1 pxa2xx_i2s_startup\n");
+
+
 	if (IS_ERR(clk_i2s))
 		return PTR_ERR(clk_i2s);
 
+pr_info("O2\n");
 	if (!cpu_dai->active)
 		SACR0 = 0;
 
+pr_info("O3 fin\n");
 	return 0;
 }
 
@@ -116,15 +121,24 @@ static int pxa_i2s_wait(void)
 {
 	int i;
 
+pr_info("P1 pxa_i2s_wait\n");
+
 	/* flush the Rx FIFO */
 	for (i = 0; i < 16; i++)
 		SADR;
+
+pr_info("P2 fin\n");
+
 	return 0;
 }
 
 static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
+
+pr_info("Q1 pxa2xx_i2s_set_dai_fmt\n");
+
+
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -135,6 +149,8 @@ static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		break;
 	}
 
+pr_info("Q2\n");
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		pxa_i2s.master = 1;
@@ -145,6 +161,9 @@ static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	default:
 		break;
 	}
+
+pr_info("Q3 fin\n");
+
 	return 0;
 }
 
@@ -163,19 +182,33 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
 
+pr_info("R1 pxa2xx_i2s_hw_params\n");
+
+
 	if (WARN_ON(IS_ERR(clk_i2s)))
 		return -EINVAL;
+
+pr_info("R2\n");
+
 	clk_prepare_enable(clk_i2s);
+pr_info("R3\n");
 	clk_ena = 1;
+pr_info("R4\n");
 	pxa_i2s_wait();
 
+pr_info("R5\n");
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_data = &pxa2xx_i2s_pcm_stereo_out;
 	else
 		dma_data = &pxa2xx_i2s_pcm_stereo_in;
 
+pr_info("R6\n");
+
 	snd_soc_dai_set_dma_data(dai, substream, dma_data);
 
+pr_info("R7\n");
+
 	/* is port used by another stream */
 	if (!(SACR0 & SACR0_ENB)) {
 		SACR0 = 0;
@@ -185,11 +218,16 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		SACR0 |= SACR0_RFTH(14) | SACR0_TFTH(1);
 		SACR1 |= pxa_i2s.fmt;
 	}
+
+pr_info("R8\n");
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		SAIMR |= SAIMR_TFS;
 	else
 		SAIMR |= SAIMR_RFS;
 
+pr_info("R9\n");
+
 	switch (params_rate(params)) {
 	case 8000:
 		SADIV = 0x48;
@@ -214,6 +252,8 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+pr_info("R10 fin\n");
+
 	return 0;
 }
 
@@ -222,6 +262,8 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	int ret = 0;
 
+pr_info("S1 pxa2xx_i2s_trigger\n");
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -240,6 +282,8 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		ret = -EINVAL;
 	}
 
+pr_info("S2 fin %i\n",ret);
+
 	return ret;
 }
 
@@ -300,6 +344,9 @@ static int pxa2xx_i2s_resume(struct snd_soc_dai *dai)
 
 static int pxa2xx_i2s_probe(struct snd_soc_dai *dai)
 {
+
+pr_info("T1 pxa2xx_i2s_probe\n");
+
 	clk_i2s = clk_get(dai->dev, "I2SCLK");
 	if (IS_ERR(clk_i2s))
 		return PTR_ERR(clk_i2s);
@@ -320,6 +367,8 @@ static int pxa2xx_i2s_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &pxa2xx_i2s_pcm_stereo_out,
 		&pxa2xx_i2s_pcm_stereo_in);
 
+pr_info("T2 fin ok\n");
+
 	return 0;
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81b27923303d..b794cfb583f4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -17,6 +17,8 @@
 //   o Add more codecs and platforms to ensure good API coverage.
 //   o Support TDM on PCM and I2S
 
+#define DEBUG 1
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -1531,12 +1533,14 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	rtd->pmdown_time = pmdown_time;
 
 	ret = soc_probe_dai(cpu_dai, order);
+pr_info("JJJ1 soc_probe_link_dais %i\n",ret);
 	if (ret)
 		return ret;
 
 	/* probe the CODEC DAI */
 	for (i = 0; i < rtd->num_codecs; i++) {
 		ret = soc_probe_dai(rtd->codec_dais[i], order);
+pr_info("JJJ2 %i %i\n",i,ret);
 		if (ret)
 			return ret;
 	}
@@ -1548,6 +1552,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	/* do machine specific initialization */
 	if (dai_link->init) {
 		ret = dai_link->init(rtd);
+pr_info("JJJ3 %i\n",ret);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: failed to init %s: %d\n",
 				dai_link->name, ret);
@@ -1559,6 +1564,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
 
 	ret = soc_post_component_init(rtd, dai_link->name);
+pr_info("JJJ4 %i\n",ret);
 	if (ret)
 		return ret;
 
@@ -1581,6 +1587,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		if (!component->driver->use_dai_pcm_id)
 			continue;
 
+pr_info("JJJ5\n");
+
 		if (rtd->dai_link->no_pcm)
 			num += component->driver->be_pcm_base;
 		else
@@ -1590,6 +1598,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	if (cpu_dai->driver->compress_new) {
 		/*create compress_device"*/
 		ret = cpu_dai->driver->compress_new(rtd, num);
+pr_info("JJJ6 %i\n",ret);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
@@ -1599,18 +1608,23 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 
 		if (!dai_link->params) {
 			/* create the pcm */
+
 			ret = soc_new_pcm(rtd, num);
+pr_info("JJJ7 from soc_new_pcm %i\n",ret);
+
 			if (ret < 0) {
 				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 				       dai_link->stream_name, ret);
 				return ret;
 			}
 			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+pr_info("JJJ8 from soc_link_dai_pcm_new %i\n",ret);
 			if (ret < 0)
 				return ret;
 			ret = soc_link_dai_pcm_new(rtd->codec_dais,
 						   rtd->num_codecs, rtd);
 			if (ret < 0)
+pr_info("JJJ9 from soc_link_dai_pcm_new %i\n",ret);
 				return ret;
 		} else {
 			INIT_DELAYED_WORK(&rtd->delayed_work,
@@ -1618,6 +1632,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 
 			/* link the DAI widgets */
 			ret = soc_link_dai_widgets(card, dai_link, rtd);
+pr_info("JJJ10 from soc_link_dai_widgets %i\n",ret);
 			if (ret)
 				return ret;
 		}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 98be04b543ae..8998d20c7807 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -10,6 +10,8 @@
 // Authors: Liam Girdwood <lrg@ti.com>
 //          Mark Brown <broonie@opensource.wolfsonmicro.com>
 
+#define DEBUG 1
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -449,6 +451,8 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_component *component;
 
+pr_info("FFF1 soc_pcm_components_close\n");
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -459,7 +463,10 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 		    !component->driver->ops->close)
 			continue;
 
+pr_info("FFF2 %s\n",substream->name);
+
 		component->driver->ops->close(substream);
+pr_info("FFF3\n");
 	}
 
 	return 0;
@@ -692,10 +699,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i;
+pr_info("EEE1 soc_pcm_close\n");
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+pr_info("EEE2\n");
 	snd_soc_runtime_deactivate(rtd, substream->stream);
+pr_info("EEE3\n");
 
 	/* clear the corresponding DAIs rate when inactive */
 	if (!cpu_dai->active)
@@ -706,12 +716,16 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		if (!codec_dai->active)
 			codec_dai->rate = 0;
 	}
+pr_info("EEE4\n");
 
 	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
+pr_info("EEE5\n");
 
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
+pr_info("EEE6\n");
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
 		if (codec_dai->driver->ops->shutdown)
@@ -721,7 +735,9 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	if (rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
 
+pr_info("EEE7\n");
 	soc_pcm_components_close(substream, NULL);
+pr_info("EEE8\n");
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
@@ -742,6 +758,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 					  SND_SOC_DAPM_STREAM_STOP);
 	}
 
+pr_info("EEE9\n");
+
 	mutex_unlock(&rtd->pcm_mutex);
 
 	for_each_rtdcom(rtd, rtdcom) {
@@ -751,12 +769,15 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		pm_runtime_put_autosuspend(component->dev);
 	}
 
+pr_info("EEE10\n");
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
 	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+pr_info("EEE11\n");
 
 	return 0;
 }
@@ -3075,6 +3096,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 				(rtd->num_codecs > 1) ?
 				"multicodec" : rtd->codec_dai->name, num);
 
+pr_info("!!!HHH1 soc_new_pcm %i %i\n",playback,capture);
 		ret = snd_pcm_new(rtd->card->snd_card, new_name, num, playback,
 			capture, &pcm);
 	}
@@ -3153,7 +3175,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		if (!component->driver->pcm_new)
 			continue;
 
+// NOTICE pxa2xx_soc_pcm_new called here, contains pxa2xx_pcm_preallocate_dma_buffer
+pr_info("!!!HHH2\n");
 		ret = component->driver->pcm_new(rtd);
+pr_info("!!!HHH3 %i\n",ret);
 		if (ret < 0) {
 			dev_err(component->dev,
 				"ASoC: pcm constructor failed: %d\n",
-- 
2.18.0


--------------EC21B88B4B49456C2F8EAA39
Content-Type: text/x-log;
 name="magician_sound.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="magician_sound.log"

modprobe snd-soc-pxa_ssp
modprobe snd-soc-pxa2xx_i2s
modprobe snd-soc-uda1380
modprobe snd-soc-pxa2xx
modprobe snd-soc-magician
alsactl restore
=====
[ 1230.308722] !!pxa UDC queue 80fbffd2
[ 1231.047868] pxa2xx-i2s pxa2xx-i2s: ASoC: dai register pxa2xx-i2s #1
[ 1231.047928] pxa2xx-i2s pxa2xx-i2s: ASoC: dynamically register DAI pxa2xx-i2s
[ 1231.047983] pxa2xx-i2s pxa2xx-i2s: ASoC: Registered DAI 'pxa2xx-i2s'
[ 1231.915193] uda1380-codec 0-0018: ASoC: dai register 0-0018 #2
[ 1231.915253] uda1380-codec 0-0018: ASoC: dynamically register DAI 0-0018
[ 1231.915297] uda1380-codec 0-0018: ASoC: Registered DAI 'uda1380-hifi-playback'
[ 1231.915319] uda1380-codec 0-0018: ASoC: dynamically register DAI 0-0018
[ 1231.915352] uda1380-codec 0-0018: ASoC: Registered DAI 'uda1380-hifi-capture'
[ 1231.915388] uda1380_i2c_probe ret=0
[ 1233.244748] magician_audio_probe AAA1
[ 1233.245366] magician-audio magician-audio: ASoC: binding uda1380_playback
[ 1233.255132] magician-audio magician-audio: ASoC: binding uda1380_capture
[ 1233.467018] uda1380-codec 0-0018: ASoC: adding Playback widget
[ 1233.467092] uda1380-codec 0-0018: ASoC: adding Capture widget
[ 1233.535174] uda1380-codec 0-0018: Control not supported for path Right PGA -> [Mic + Line R] -> Right ADC
[ 1233.540103] uda1380-codec 0-0018: ASoC: no dapm match for Right PGA --> Mic + Line R --> Right ADC
[ 1233.542096] uda1380-codec 0-0018: ASoC: Failed to add route Right PGA -> Mic + Line R -> Right ADC
[ 1233.542872] uda1380-codec 0-0018: Control not supported for path Right PGA -> [Line] -> Right ADC
[ 1233.543170] uda1380-codec 0-0018: ASoC: no dapm match for Right PGA --> Line --> Right ADC
[ 1233.547803] uda1380-codec 0-0018: ASoC: Failed to add route Right PGA -> Line -> Right ADC
[ 1233.549405] magician-audio magician-audio: ASoC: probe Magician dai link 0 late -2
[ 1233.551888] JJJ1 soc_probe_link_dais 0
[ 1233.552159] JJJ2 0 0
[ 1233.552292] magician-audio magician-audio: ASoC: probe Magician dai link 1 late -2
[ 1233.552305] JJJ1 soc_probe_link_dais 0
[ 1233.552742] JJJ2 0 0
[ 1233.552887] magician-audio magician-audio: ASoC: probe Magician dai link 0 late -1
[ 1233.552900] JJJ1 soc_probe_link_dais 0
[ 1233.553027] JJJ2 0 0
[ 1233.553124] magician-audio magician-audio: ASoC: probe Magician dai link 1 late -1
[ 1233.553135] JJJ1 soc_probe_link_dais 0
[ 1233.553250] JJJ2 0 0
[ 1233.553345] magician-audio magician-audio: ASoC: probe Magician dai link 0 late 0
[ 1233.553360] AD1 pxa_ssp_probe
[ 1233.556087] AD2
[ 1233.556359] AD3
[ 1233.558818] AD4
[ 1233.559085] AD5 fin
[ 1233.559178] JJJ1 soc_probe_link_dais 0
[ 1233.559299] JJJ2 0 0
[ 1233.665046] magician-audio magician-audio: ASoC: probe Magician dai link 1 late 0
[ 1233.665111] T1 pxa2xx_i2s_probe
[ 1233.665758] T2 fin ok
[ 1233.665911] JJJ1 soc_probe_link_dais 0
[ 1233.666056] JJJ2 0 0
[ 1233.666194] magician-audio magician-audio: ASoC: probe Magician dai link 0 late 1
[ 1233.666215] JJJ1 soc_probe_link_dais 0
[ 1233.666363] JJJ2 0 0
[ 1233.666650] magician-audio magician-audio: ASoC: probe Magician dai link 1 late 1
[ 1233.666674] JJJ1 soc_probe_link_dais 0
[ 1233.666834] JJJ2 0 0
[ 1233.666936] magician-audio magician-audio: ASoC: probe Magician dai link 0 late 2
[ 1233.666949] JJJ1 soc_probe_link_dais 0
[ 1233.667072] JJJ2 0 0
[ 1233.671051] JJJ4 0
[ 1233.671335] !!!HHH1 soc_new_pcm 1 0
[ 1233.777422] magician-audio magician-audio: ASoC: registered pcm #0 UDA1380 Playback uda1380-hifi-playback-0
[ 1233.777795] !!!HHH2
[ 1233.778026] C1 pxa2xx_soc_pcm_new
[ 1233.778159] C2 from dma_coerce_mask_and_coherent 0
[ 1233.804002] C3play from pxa2xx_pcm_preallocate_dma_buffer 0
[ 1233.804347] !!!HHH3 0
[ 1233.804726] !!!HHH2
[ 1233.804823] C1 pxa2xx_soc_pcm_new
[ 1233.808244] C2 from dma_coerce_mask_and_coherent 0
[ 1233.890316] C3play from pxa2xx_pcm_preallocate_dma_buffer 0
[ 1233.935667] !!!HHH3 0
[ 1233.939808] magician-audio magician-audio: uda1380-hifi-playback <-> pxa-ssp-dai.0 mapping ok
[ 1233.948848] JJJ7 from soc_new_pcm 0
[ 1233.960808] JJJ8 from soc_link_dai_pcm_new 0
[ 1233.976827] magician-audio magician-audio: ASoC: probe Magician dai link 1 late 2
[ 1233.976876] JJJ1 soc_probe_link_dais 0
[ 1233.991121] JJJ2 0 0
[ 1234.025446] JJJ4 0
[ 1234.042327] !!!HHH1 soc_new_pcm 0 1
[ 1234.097295] magician-audio magician-audio: ASoC: registered pcm #1 UDA1380 Capture uda1380-hifi-capture-1
[ 1234.097362] !!!HHH2
[ 1234.116768] C1 pxa2xx_soc_pcm_new
[ 1234.134276] C2 from dma_coerce_mask_and_coherent 0
[ 1234.149297] C4capt from pxa2xx_pcm_preallocate_dma_buffer 0
[ 1234.183391] !!!HHH3 0
[ 1234.194771] !!!HHH2
[ 1234.210842] C1 pxa2xx_soc_pcm_new
[ 1234.224151] C2 from dma_coerce_mask_and_coherent 0
[ 1234.245172] C4capt from pxa2xx_pcm_preallocate_dma_buffer 0
[ 1234.271813] !!!HHH3 0
[ 1234.289025] magician-audio magician-audio: uda1380-hifi-capture <-> pxa2xx-i2s mapping ok
[ 1234.322781] JJJ7 from soc_new_pcm 0
[ 1234.326307] JJJ8 from soc_link_dai_pcm_new 0
[ 1234.331769] uda1380-codec 0-0018: Playback -> DAC
[ 1234.331861] uda1380-codec 0-0018: Left ADC -> Capture
[ 1234.331892] uda1380-codec 0-0018: Right ADC -> Capture
[ 1234.438108] uda1380-codec 0-0018: ASoC: mux Capture Mux has no paths
[ 1234.582733] D1 uda1380_sync_cache
[ 1234.626753] D2 fin
[ 1234.865116] magician_audio_probe devm_snd_soc_register_card ret=0
[ 1234.897584] magician_audio_probe ALL OK
[ 1237.759360] K1 magician_set_hp
[ 1237.775295] L1 magician_set_spk 1
[ 1237.804672] M1 magician_set_input
========
cat /dev/urandom | aplay -
========
[ 1288.126302] W1 pxa_ssp_startup
[ 1288.137893] W2
[ 1288.157093] W3
[ 1288.174632] W4 fin 0
[ 1288.195780] pxa2xx_pcm_open B1
[ 1288.220112] pxa2xx_pcm_open B2
[ 1288.238129] B3
[ 1288.255617] B4
[ 1288.269827] B5 fin?
[ 1288.286974] pxa2xx_pcm_open B1
[ 1288.301613] pxa2xx_pcm_open B2
[ 1288.345629] B3
[ 1288.357587] B4
[ 1288.366630] B5 fin?
[ 1288.378694] I1 magician_ext_control
[ 1288.390580] I2
[ 1288.399882] I3
[ 1288.411624] I4
[ 1288.421187] I5
[ 1288.433005] I6 fin
[ 1288.484899] ASoC: uda1380-hifi-playback <-> pxa-ssp-dai.0 info:
[ 1288.484954] ASoC: rate mask 0xde
[ 1288.484972] ASoC: min ch 1 max ch 2
[ 1288.484993] ASoC: min rate 8000 max rate 48000
[ 1288.616436] !!pxa UDC queue 1d7a7c2b
[ 1288.782892] !!pxa UDC queue 37d3a997
[ 1288.792200] J1 magician_playback_hw_params
[ 1288.808617] F1 uda1380_set_dai_fmt_playback
[ 1288.821822] F2
[ 1288.839847] F3
[ 1288.854608] F4
[ 1288.871863] F5 fin
[ 1288.881625] J2
[ 1288.896620] !!!!! pxa_ssp_set_dai_fmt 16900
[ 1288.908846] J3
[ 1288.923687] ZZZ1 pxa_ssp_set_dai_tdm_slot
[ 1288.967240] ZZZ2 00000000
[ 1288.981680] ZZZ3 00000000
[ 1288.995804] ZZZ4 0000000f
[ 1289.008651] ZZZ5 0000000f
[ 1289.025359] J4
[ 1289.042626] Y1 pxa_ssp_set_dai_sysclk
[ 1289.063637] Y2 sscr0=0000000f
[ 1289.077765] pxa2xx-ssp pxa27x-ssp.0: pxa_ssp_set_dai_sysclk id: 0, clk_id 3, freq 0
[ 1289.077813] X1 pxa_ssp_set_scr
[ 1289.092615] X2 fin
[ 1289.110028] Y3
[ 1289.150879] !!pxa UDC queue 07059cbc
[ 1289.160669] Y4 fin
[ 1289.168613] J5 fin
[ 1289.182914] H1 uda1380_pcm_hw_params
[ 1289.198760] H2
[ 1289.207622] H3
[ 1289.225398] H4 fin
[ 1289.232837] AA1 pxa_ssp_hw_params
[ 1289.248580] AA2
[ 1289.260817] V1 pxa_ssp_set_dma_params
[ 1289.270816] V2 fin
[ 1289.282628] AA3
[ 1289.298130] AA4
[ 1289.432647] !!XXX1a 4000000f
[ 1289.445771] !!XXX1b c000003f
[ 1289.455950] pxa2xx-ssp pxa27x-ssp.0: SSCR0 0xc000003f SSCR1 0x00c01d80 SSTO 0x00000000
[ 1289.456006] pxa2xx-ssp pxa27x-ssp.0: SSPSP 0x02000000 SSSR 0x0000f004 SSACD 0x00000000
[ 1289.456026] AA5
[ 1289.479644] AA6 0xc0000030
[ 1289.489192] AA7
[ 1289.501020] AA8 16000
[ 1289.516616] Z1 pxa_ssp_set_pll
[ 1289.527612] Z2
[ 1289.538644] Z3!!!!!!!!!! 16000
[ 1289.552122] AA8b -22
[ 1289.565645] AA8b rate=8000 ?= 8000
[ 1289.576081] Z1 pxa_ssp_set_pll
[ 1289.591041] Z2
[ 1289.600946] Z3!!!!!!!!!! 32842000
[ 1289.612002] Z4
[ 1289.627072] Z5 fin
[ 1289.640613] AA9
[ 1289.651643] AA10 ttsa=00000000
[ 1289.664734] pxa2xx-ssp pxa27x-ssp.0: No TDM timeslot configured
[ 1289.684614] AA11
[ 1289.694794] pxa2xx-ssp pxa27x-ssp.0: SSCR0 0xc000003f SSCR1 0x00c01d80 SSTO 0x00000000
[ 1289.694850] pxa2xx-ssp pxa27x-ssp.0: SSPSP 0x02000000 SSSR 0x0000f004 SSACD 0x00000045
[ 1289.694870] AA12 fin
[ 1289.715872] pxa2xx_pcm_hw_params A1
[ 1289.730777] pxa2xx_pcm_hw_params A2
[ 1289.746964] pxa2xx_pcm_hw_params A3
[ 1289.764105] pxa2xx_pcm_hw_params A4
[ 1289.787621] pxa2xx_pcm_hw_params A5
[ 1289.808937] pxa2xx_pcm_hw_params A6 fin
[ 1289.821969] pxa2xx_pcm_hw_params A1
[ 1289.834624] pxa2xx_pcm_hw_params A2
[ 1289.847102] pxa2xx_pcm_hw_params A3
[ 1289.861847] pxa2xx_pcm_hw_params A4
[ 1289.873620] pxa2xx_pcm_hw_params A5
[ 1289.884612] pxa2xx_pcm_hw_params A6 fin
[ 1289.913674] N1 magician_spk_power
[ 1289.921084] N2 fin
[ 1289.951169] G1 uda1380_trigger
[ 1289.953698] G2 fin
[ 1289.956020] AC1 pxa_ssp_trigger
[ 1289.958138] AB1 pxa_ssp_set_running_bit
[ 1289.960201] AB2
[ 1289.962205] AB3
[ 1289.964196] AB4
[ 1289.966155] AB5 fin
[ 1289.968095] AC2
[ 1289.970099] pxa2xx-ssp pxa27x-ssp.0: SSCR0 0xc00000bf SSCR1 0x00e01d80 SSTO 0x00000000
[ 1289.970134] pxa2xx-ssp pxa27x-ssp.0: SSPSP 0x02000000 SSSR 0x0000f804 SSACD 0x00000045
[ 1289.970151] AC3 fin 0
======
pressed ctrl+c
======
[ 1322.707977] G1 uda1380_trigger
[ 1322.710466] G2 fin
[ 1322.712555] AC1 pxa_ssp_trigger
[ 1322.714568] AB1 pxa_ssp_set_running_bit
[ 1322.716539] AB2
[ 1322.718491] AB3
[ 1322.720441] AB4
[ 1322.722369] AB5 fin
[ 1322.724301] AC2
[ 1322.726274] pxa2xx-ssp pxa27x-ssp.0: SSCR0 0xc00000bf SSCR1 0x00c01d80 SSTO 0x00000000
[ 1322.726304] pxa2xx-ssp pxa27x-ssp.0: SSPSP 0x02000000 SSSR 0x0000f804 SSACD 0x00000045
[ 1322.726316] AC3 fin 0
[ 1322.835896] CCC1 snd_pcm_release
[ 1322.848577] CCC2
[ 1322.862690] CCC3
[ 1322.872937] DDD1 snd_pcm_release_substream 1
[ 1322.925967] DDD2
[ 1322.935932] DDD3
[ 1322.950893] EEE1 soc_pcm_close
[ 1322.966994] EEE2
[ 1322.979679] EEE3
[ 1322.987889] EEE4
[ 1322.995830] EEE5
[ 1323.003925] WWW1 pxa_ssp_shutdown
[ 1323.013163] WWW2
[ 1323.022023] WWW3
[ 1323.030961] WWW4
[ 1323.041123] WWW5
[ 1323.055619] WWW6
[ 1323.066615] EEE6
[ 1323.084429] EEE7
[ 1323.090085] FFF1 soc_pcm_components_close
[ 1323.105632] FFF2 subdevice #0
[ 1323.115104] GGG1 1
[ 1323.126622] GGG2
[ 1323.140709] GGG3
[ 1323.151642] GGG4
[ 1323.162626] FFF3
[ 1323.173631] FFF2 subdevice #0
[ 1323.184653] GGG1 0
[ 1323.193024] GGG2
[ 1323.206027] ------------[ cut here ]------------
[ 1323.217886] WARNING: CPU: 0 PID: 892 at drivers/dma/dmaengine.c:788 dma_release_channel+0x44/0xa0
[ 1323.239818] chan reference count 0 != 1
[ 1323.261919] Modules linked in: snd_soc_magician snd_soc_uda1380 snd_soc_pxa2xx_i2s ppp_async ppp_generic slhc ircomm_tty(C) ircomm(C) ds2760_battery ds1wm wire usb_f_eem g_ether usb_f_rndis u_ether libcomposite btintel bluetooth drbg ecdh_generic firmware_class ads7846 ov9640 max1586 8250_pxa pxaficp_ir(C) 8250 8250_base fixed irda(C) serial_core spi_pxa2xx_platform ohci_pxa27x pxa_camera snd_soc_pxa2xx snd_soc_pxa_ssp videobuf2_dma_sg ohci_hcd snd_pxa2xx_lib v4l2_common pxa27x_udc snd_pcm_dmaengine videobuf2_memops i2c_pxa udc_core snd_soc_core videobuf2_v4l2 backlight usbcore videodev snd_pcm usb_common pwm_pxa videobuf2_common snd_timer i2c_core rtc_sa1100 snd ssp soundcore pda_power htc_pasic3 leds_gpio mfd_core led_class configfs [last unloaded: pwm_bl]
[ 1323.381942] CPU: 0 PID: 892 Comm: aplay Tainted: G         C        4.18.0-rc6-next-20180726-magician+ #16
[ 1323.402847] Hardware name: HTC Magician
[ 1323.420046] [<c0107d90>] (unwind_backtrace) from [<c010594c>] (show_stack+0x10/0x14)
[ 1323.444245] [<c010594c>] (show_stack) from [<c0111680>] (__warn+0xd4/0xec)
[ 1323.469874] [<c0111680>] (__warn) from [<c01112d0>] (warn_slowpath_fmt+0x44/0x6c)
[ 1323.495267] [<c01112d0>] (warn_slowpath_fmt) from [<c034908c>] (dma_release_channel+0x44/0xa0)
[ 1323.526012] [<c034908c>] (dma_release_channel) from [<bf330528>] (snd_dmaengine_pcm_close_release_chan+0x44/0xb1c [snd_pcm_dmaengine])
[ 1323.583125] [<bf330528>] (snd_dmaengine_pcm_close_release_chan [snd_pcm_dmaengine]) from [<bf26c29c>] (soc_pcm_components_close+0x8c/0xac [snd_soc_core])
[ 1323.630458] [<bf26c29c>] (soc_pcm_components_close [snd_soc_core]) from [<bf26c3a0>] (soc_pcm_close+0xe4/0xd44 [snd_soc_core])
[ 1323.682178] [<bf26c3a0>] (soc_pcm_close [snd_soc_core]) from [<bf167254>] (snd_pcm_release_substream+0x88/0x108 [snd_pcm])
[ 1323.729372] [<bf167254>] (snd_pcm_release_substream [snd_pcm]) from [<bf167330>] (snd_pcm_release+0x5c/0xd2c [snd_pcm])
[ 1323.778573] [<bf167330>] (snd_pcm_release [snd_pcm]) from [<c01c39e4>] (__fput+0xdc/0x1e8)
[ 1323.820098] [<c01c39e4>] (__fput) from [<c0129e7c>] (task_work_run+0xc4/0xd4)
[ 1323.868014] [<c0129e7c>] (task_work_run) from [<c01053ac>] (do_work_pending+0xc0/0xc8)
[ 1323.903237] [<c01053ac>] (do_work_pending) from [<c0101068>] (slow_work_pending+0xc/0x20)
[ 1323.939366] Exception stack(0xc2fdffb0 to 0xc2fdfff8)
[ 1323.957051] ffa0:                                     00000000 0154d1a0 01542a3c 00000000
[ 1323.992950] ffc0: 0154d150 00000000 0009283c 00000006 000003f0 0154d4c8 00000000 0154d4c8
[ 1324.028886] ffe0: b6ee7d70 bef13960 b6e547b8 b6cfe018 60000010 00000004
[ 1324.063896] ---[ end trace 547338f9f5eb52a2 ]---
[ 1324.083619] GGG3
[ 1324.109639] GGG4
[ 1324.135071] FFF3
[ 1324.163890] EEE8
[ 1324.183879] EEE9
[ 1324.201846] EEE10
[ 1324.221827] EEE11
[ 1324.248090] DDD4
[ 1324.261591] DDD5
[ 1324.281652] DDD6
[ 1324.304036] CCC4
[ 1324.320046] CCC5
[ 1324.339609] CCC6
[ 1324.359638] CCC7
[ 1324.374692] CCC8
[ 1324.391962] CCC9
Segmentation fault
[ 1324.881218] BUG: Bad rss-counter state mm:b111e1cc idx:0 val:1
[ 1324.899571] BUG: Bad rss-counter state mm:b111e1cc idx:1 val:2
[ 1325.098335] BUG: Bad page state in process sh  pfn:a2eaa
[ 1325.102496] page:c3fd7540 count:1 mapcount:0 mapping:00000000 index:0x0
[ 1325.109756] flags: 0x1100(slab|private)
[ 1325.113407] raw: 00001100 00000100 00000200 00000000 00000000 00000000 ffffc5aa 00000001
[ 1325.120606] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
[ 1325.127777] bad because of flags: 0x1100(slab|private)
[ 1325.131451] Modules linked in: snd_soc_magician snd_soc_uda1380 snd_soc_pxa2xx_i2s ppp_async ppp_generic slhc ircomm_tty(C) ircomm(C) ds2760_battery ds1wm wire usb_f_eem g_ether usb_f_rndis u_ether libcomposite btintel bluetooth drbg ecdh_generic firmware_class ads7846 ov9640 max1586 8250_pxa pxaficp_ir(C) 8250 8250_base fixed irda(C) serial_core spi_pxa2xx_platform ohci_pxa27x pxa_camera snd_soc_pxa2xx snd_soc_pxa_ssp videobuf2_dma_sg ohci_hcd snd_pxa2xx_lib v4l2_common pxa27x_udc snd_pcm_dmaengine videobuf2_memops i2c_pxa udc_core snd_soc_core videobuf2_v4l2 backlight usbcore videodev snd_pcm usb_common pwm_pxa videobuf2_common snd_timer i2c_core rtc_sa1100 snd ssp soundcore pda_power htc_pasic3 leds_gpio mfd_core led_class configfs [last unloaded: pwm_bl]
[ 1325.179640] CPU: 0 PID: 271 Comm: sh Tainted: G        WC        4.18.0-rc6-next-20180726-magician+ #16
[ 1325.186932] Hardware name: HTC Magician
[ 1325.190695] [<c0107d90>] (unwind_backtrace) from [<c010594c>] (show_stack+0x10/0x14)
[ 1325.198061] [<c010594c>] (show_stack) from [<c017f76c>] (bad_page+0xfc/0x134)
[ 1325.205439] [<c017f76c>] (bad_page) from [<c0182204>] (get_page_from_freelist+0x9bc/0xb2c)
[ 1325.212812] [<c0182204>] (get_page_from_freelist) from [<c0182928>] (__alloc_pages_nodemask+0xc0/0x9a4)
[ 1325.220225] [<c0182928>] (__alloc_pages_nodemask) from [<c010ef88>] (copy_process.part.3+0xe4/0x1514)
[ 1325.227857] [<c010ef88>] (copy_process.part.3) from [<c0110510>] (_do_fork+0xb8/0x368)
[ 1325.235679] [<c0110510>] (_do_fork) from [<c0110880>] (sys_clone+0x1c/0x24)
[ 1325.243748] [<c0110880>] (sys_clone) from [<c0101000>] (ret_fast_syscall+0x0/0x50)
[ 1325.252081] Exception stack(0xc3beffa8 to 0xc3befff0)
[ 1325.256407] ffa0:                   b6f77208 bec2b9c0 01200011 00000000 00000000 00000000
[ 1325.265144] ffc0: b6f77208 bec2b9c0 00000000 00000078 b6f77660 00000000 b6ee2000 bec2b9ec
[ 1325.274152] ffe0: b6f771a0 bec2b9c0 b6e3b3b4 b6e3b460
[ 1325.278804] Disabling lock debugging due to kernel taint
[ 1329.399835]  uda1380_playback: ASoC: pop wq checking: Playback status: inactive waiting: yes
[ 1329.405064] N1 magician_spk_power
[ 1329.424527] N2 fin

--------------EC21B88B4B49456C2F8EAA39
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--------------EC21B88B4B49456C2F8EAA39--
