From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: RME AES32 & MADI
Date: Tue, 20 Feb 2007 18:04:18 +0100
Message-ID: <20070220170418.GA9723@trinnov.com>
References: <20070131121148.GA20540@trinnov.com> <s5h3b5ojtf6.wl%tiwai@suse.de>
	<200702051027.29226.ritsch@iem.at>
	<20070213104406.GA9387@trinnov.com> <s5hr6ssbx8t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr6ssbx8t.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Winfried Ritsch <ritsch@iem.at>
List-Id: alsa-devel@alsa-project.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Here is the new patch. Comments below:

On Wednesday 14 February at 16:00, Takashi Iwai wrote:
> >  
> >  	runtime->hw = snd_hdspm_playback_subinfo;
> > +	runtime->dma_area = hdspm->playback_buffer;
> > +	runtime->dma_bytes = HDSPM_DMA_AREA_BYTES;
> 
> Why this?  They are overwritten anyway in hw_params call.

This is something that remained from my trials to get the things work. In fact,
this is done in the equivalent place in hdsp.c so I imagined it may be
lacking here. I removed that in the attached patch.

> > @@ -4184,7 +4325,8 @@ static int __devinit snd_hdspm_prealloca
> >  	pcm = hdspm->pcm;
> >  
> >  /*	wanted = HDSPM_DMA_AREA_BYTES + 4096;*/	/* dont know why, but it works */
> > -	wanted = HDSPM_DMA_AREA_BYTES;
> > +	/* Two times, for both input and output */
> > +	wanted = 2 * HDSPM_DMA_AREA_BYTES;
> 
> This shouldn't be necessary.  Since the buffer size for each stream is
> fixed, it's not necessarily bigger than that.

Well, my (maybe wrong) guess is that we need a buffer for playback and a
buffer for capture, so the required size is twice the one-way size.

Remy

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=patch-hdspm

diff -r 1ce859e9fd4a pci/rme9652/hdspm.c
--- a/pci/rme9652/hdspm.c	Fri Feb 09 20:52:55 2007 +0100
+++ b/pci/rme9652/hdspm.c	Tue Feb 20 17:50:09 2007 +0100
@@ -91,8 +91,10 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MAD
 #define HDSPM_controlRegister	     64
 #define HDSPM_interruptConfirmation  96
 #define HDSPM_control2Reg	     256  /* not in specs ???????? */
+#define HDSPM_freqReg                256  /* for AES32 */
 #define HDSPM_midiDataOut0  	     352  /* just believe in old code */
 #define HDSPM_midiDataOut1  	     356
+#define HDSPM_eeprom_wr		     384  /* for AES32 */
 
 /* DMA enable for 64 channels, only Bit 0 is relevant */
 #define HDSPM_outputEnableBase       512  /* 512-767  input  DMA */ 
@@ -389,9 +391,8 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MAD
    size is the same regardless of the number of channels, and
    also the latency to use. 
    for one direction !!!
-   => need to mupltiply by 2!!
 */
-#define HDSPM_DMA_AREA_BYTES (2 * HDSPM_MAX_CHANNELS * HDSPM_CHANNEL_BUFFER_BYTES)
+#define HDSPM_DMA_AREA_BYTES (HDSPM_MAX_CHANNELS * HDSPM_CHANNEL_BUFFER_BYTES)
 #define HDSPM_DMA_AREA_KILOBYTES (HDSPM_DMA_AREA_BYTES/1024)
 
 /* revisions >= 230 indicate AES32 card */
@@ -818,6 +819,27 @@ static int hdspm_set_interrupt_interval(
 	return 0;
 }
 
+static void hdspm_set_dds_value(struct hdspm *hdspm, int rate)
+{
+	u64 n;
+	u32 r;
+	
+	if (rate >= 112000)
+		rate /= 4;
+	else if (rate >= 56000)
+		rate /= 2;
+
+	/* RME says n = 104857600000000, but in the windows MADI driver, I see:
+//	return 104857600000000 / rate; // 100 MHz
+	return 110100480000000 / rate; // 105 MHz
+        */	   
+	//n = 104857600000000ULL;  /*  =  2^20 * 10^8 */
+	n = 110100480000000ULL;    /* Value checked for AES32 and MADI */
+	div64_32(&n, rate, &r);
+	/* n should be less than 2^32 for being written to FREQ register */
+	snd_assert((n >> 32) == 0);
+	hdspm_write(hdspm, HDSPM_freqReg, (u32)n);
+}
 
 /* dummy set rate lets see what happens */
 static int hdspm_set_rate(struct hdspm * hdspm, int rate, int called_internally)
@@ -943,12 +965,16 @@ static int hdspm_set_rate(struct hdspm *
 	hdspm->control_register |= rate_bits;
 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
 
-	if (rate > 96000 /* 64000*/)
-		hdspm->channel_map = channel_map_madi_qs;
-	else if (rate > 48000)
-		hdspm->channel_map = channel_map_madi_ds;
-	else 
-		hdspm->channel_map = channel_map_madi_ss;
+	/* For AES32, need to set DDS value in FREQ register
+	   For MADI, also apparently */
+	hdspm_set_dds_value(hdspm, rate);
+	
+	if (hdspm->is_aes32 && rate != current_rate)
+		hdspm_write(hdspm, HDSPM_eeprom_wr, 0);
+	
+	/* For AES32 and for MADI (at least rev 204), channel_map needs to
+	 * always be channel_map_madi_ss, whatever the sample rate */
+	hdspm->channel_map = channel_map_madi_ss;
 
 	hdspm->system_sample_rate = rate;
 
@@ -3184,8 +3210,8 @@ snd_hdspm_proc_read_aes32(struct snd_inf
 		    hdspm_read(hdspm, HDSPM_midiStatusIn0) & 0xFF,
 		    hdspm_read(hdspm, HDSPM_midiStatusIn1) & 0xFF);
 	snd_iprintf(buffer,
-		    "Register: ctrl1=0x%x, ctrl2=0x%x, status1=0x%x, status2=0x%x, timecode=0x%x\n",
-		    hdspm->control_register, hdspm->control2_register,
+		    "Register: ctrl1=0x%x, status1=0x%x, status2=0x%x, timecode=0x%x\n",
+		    hdspm->control_register,
 		    status, status2, timecode);
 
 	snd_iprintf(buffer, "--- Settings ---\n");
@@ -3377,13 +3403,16 @@ static int snd_hdspm_set_defaults(struct
 
 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
 
+        if (!hdspm->is_aes32) {
+		/* No control2 register for AES32 */
 #ifdef SNDRV_BIG_ENDIAN
-	hdspm->control2_register = HDSPM_BIGENDIAN_MODE;
+		hdspm->control2_register = HDSPM_BIGENDIAN_MODE;
 #else
-	hdspm->control2_register = 0;
+		hdspm->control2_register = 0;
 #endif
 
-	hdspm_write(hdspm, HDSPM_control2Reg, hdspm->control2_register);
+		hdspm_write(hdspm, HDSPM_control2Reg, hdspm->control2_register);
+	}
 	hdspm_compute_period_size(hdspm);
 
 	/* silence everything */
@@ -3658,11 +3687,10 @@ static int snd_hdspm_hw_params(struct sn
 
 	/* Memory allocation, takashi's method, dont know if we should spinlock  */
 	/* malloc all buffer even if not enabled to get sure */
-	/* malloc only needed bytes */
+	/* Update for MADI rev 204: we need to allocate for all channels,
+	 * otherwise it doesn't work at 96kHz */
 	err =
-	    snd_pcm_lib_malloc_pages(substream,
-				     HDSPM_CHANNEL_BUFFER_BYTES *
-				     params_channels(params));
+	    snd_pcm_lib_malloc_pages(substream, HDSPM_DMA_AREA_BYTES);
 	if (err < 0)
 		return err;
 
@@ -3698,6 +3726,13 @@ static int snd_hdspm_hw_params(struct sn
 	   "playback" : "capture",
 	   snd_pcm_sgbuf_get_addr(sgbuf, 0));
 	 */
+	/*
+	snd_printdd("set_hwparams: %s %d Hz, %d channels, bs = %d\n",
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			  "playback" : "capture",
+			params_rate(params), params_channels(params),
+			params_buffer_size(params));
+	*/
 	return 0;
 }
 
@@ -3904,6 +3939,61 @@ static int snd_hdspm_hw_rule_channels_ra
 	struct snd_interval *r =
 	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 
+	if (r->min > 48000 && r->max <= 96000) {
+		struct snd_interval t = {
+			.min = hdspm->ds_channels,
+			.max = hdspm->ds_channels,
+			.integer = 1,
+		};
+		return snd_interval_refine(c, &t);
+	} else if (r->max < 64000) {
+		struct snd_interval t = {
+			.min = hdspm->ss_channels,
+			.max = hdspm->ss_channels,
+			.integer = 1,
+		};
+		return snd_interval_refine(c, &t);
+	}
+	return 0;
+}
+
+static int snd_hdspm_hw_rule_rate_channels(struct snd_pcm_hw_params *params,
+					   struct snd_pcm_hw_rule * rule)
+{
+	struct hdspm *hdspm = rule->private;
+	struct snd_interval *c =
+	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r =
+	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+
+	if (c->min >= hdspm->ss_channels) {
+		struct snd_interval t = {
+			.min = 32000,
+			.max = 48000,
+			.integer = 1,
+		};
+		return snd_interval_refine(r, &t);
+	} else if (c->max <= hdspm->ds_channels) {
+		struct snd_interval t = {
+			.min = 64000,
+			.max = 96000,
+			.integer = 1,
+		};
+
+		return snd_interval_refine(r, &t);
+	}
+	return 0;
+}
+
+static int snd_hdspm_hw_rule_channels_rate_aes32(struct snd_pcm_hw_params *params,
+					   struct snd_pcm_hw_rule * rule)
+{
+	struct hdspm *hdspm = rule->private;
+	struct snd_interval *c =
+	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r =
+	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+
 	if (r->min > 48000) {
 		struct snd_interval t = {
 			.min = 1,
@@ -3922,7 +4012,7 @@ static int snd_hdspm_hw_rule_channels_ra
 	return 0;
 }
 
-static int snd_hdspm_hw_rule_rate_channels(struct snd_pcm_hw_params *params,
+static int snd_hdspm_hw_rule_rate_channels_aes32(struct snd_pcm_hw_params *params,
 					   struct snd_pcm_hw_rule * rule)
 {
 	struct hdspm *hdspm = rule->private;
@@ -3931,31 +4021,63 @@ static int snd_hdspm_hw_rule_rate_channe
 	struct snd_interval *r =
 	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 
-	if (c->min <= hdspm->ss_channels) {
+	if (c->min >= hdspm->ss_channels) {
 		struct snd_interval t = {
 			.min = 32000,
 			.max = 48000,
 			.integer = 1,
 		};
 		return snd_interval_refine(r, &t);
-	} else if (c->max > hdspm->ss_channels) {
+	} else if (c->max <= hdspm->qs_channels) {
+		struct snd_interval t = {
+			.min = 128000,
+			.max = 192000,
+			.integer = 1,
+		};
+		return snd_interval_refine(r, &t);
+	} else if (c->max <= hdspm->ds_channels) {
 		struct snd_interval t = {
 			.min = 64000,
 			.max = 96000,
 			.integer = 1,
 		};
-
 		return snd_interval_refine(r, &t);
 	}
 	return 0;
 }
+
+static int snd_hdspm_hw_rule_channels(struct snd_pcm_hw_params *params,
+				      struct snd_pcm_hw_rule *rule)
+{
+	unsigned int list[3];
+	struct hdspm *hdspm = rule->private;
+	struct snd_interval *c = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_CHANNELS);
+	if (hdspm->is_aes32) {
+		list[0] = hdspm->qs_channels;
+		list[1] = hdspm->ds_channels;
+		list[2] = hdspm->ss_channels;
+		return snd_interval_list(c, 3, list, 0);
+	} else {
+		list[0] = hdspm->ds_channels;
+		list[1] = hdspm->ss_channels;
+		return snd_interval_list(c, 2, list, 0);
+	}
+}
+
+
+static unsigned int hdspm_aes32_sample_rates[] = { 32000, 44100, 48000, 64000, 88200, 96000, 128000, 176400, 192000 };
+
+static struct snd_pcm_hw_constraint_list hdspm_hw_constraints_aes32_sample_rates = {
+	.count = ARRAY_SIZE(hdspm_aes32_sample_rates),
+	.list = hdspm_aes32_sample_rates,
+	.mask = 0
+};
 
 static int snd_hdspm_playback_open(struct snd_pcm_substream *substream)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	snd_printdd("Open device substream %d\n", substream->stream);
 
 	spin_lock_irq(&hdspm->lock);
 
@@ -3977,14 +4099,21 @@ static int snd_hdspm_playback_open(struc
 				   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				   &hw_constraints_period_sizes);
 
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			    snd_hdspm_hw_rule_channels_rate, hdspm,
-			    SNDRV_PCM_HW_PARAM_RATE, -1);
-
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-			    snd_hdspm_hw_rule_rate_channels, hdspm,
-			    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-
+	if (hdspm->is_aes32) {
+		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				&hdspm_hw_constraints_aes32_sample_rates);
+	} else {
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				     snd_hdspm_hw_rule_channels, hdspm,
+				     SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    snd_hdspm_hw_rule_channels_rate, hdspm,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    snd_hdspm_hw_rule_rate_channels, hdspm,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	}
 	return 0;
 }
 
@@ -4024,14 +4153,21 @@ static int snd_hdspm_capture_open(struct
 	snd_pcm_hw_constraint_list(runtime, 0,
 				   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				   &hw_constraints_period_sizes);
-
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			    snd_hdspm_hw_rule_channels_rate, hdspm,
-			    SNDRV_PCM_HW_PARAM_RATE, -1);
-
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-			    snd_hdspm_hw_rule_rate_channels, hdspm,
-			    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (hdspm->is_aes32) {
+		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				&hdspm_hw_constraints_aes32_sample_rates);
+	} else {
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				     snd_hdspm_hw_rule_channels, hdspm,
+				     SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    snd_hdspm_hw_rule_channels_rate, hdspm,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    snd_hdspm_hw_rule_rate_channels, hdspm,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	}
 	return 0;
 }
 
@@ -4184,7 +4320,8 @@ static int __devinit snd_hdspm_prealloca
 	pcm = hdspm->pcm;
 
 /*	wanted = HDSPM_DMA_AREA_BYTES + 4096;*/	/* dont know why, but it works */
-	wanted = HDSPM_DMA_AREA_BYTES;
+	/* Two times, for both input and output */
+	wanted = 2 * HDSPM_DMA_AREA_BYTES;
 
 	if ((err =
 	     snd_pcm_lib_preallocate_pages_for_all(pcm,

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--7JfCtLOvnd9MIVvH--
