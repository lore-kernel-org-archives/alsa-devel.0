From: Rolf Anderegg <rolf.anderegg@weiss.ch>
Subject: ALSA firewire kernel branch: snd_dice enhancements
Date: Wed, 2 Nov 2011 19:52:36 +0100
Message-ID: <4EB19174.5030107@weiss.ch>
References: <FC670913-F529-4E9B-8BB8-151227FA463E@weiss.ch>
Reply-To: rolf.anderegg@weiss.ch
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020204010905080806070105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail11.bluewin.ch (mail11.bluewin.ch [195.186.18.61])
	by alsa0.perex.cz (Postfix) with ESMTP id 8387224406
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 19:52:48 +0100 (CET)
In-Reply-To: <FC670913-F529-4E9B-8BB8-151227FA463E@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Uli Franke <uli.franke@weiss.ch>, Brian Karr <briank@tctechnologies.tc>, alsa-devel <alsa-devel@alsa-project.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, ffado-devel <ffado-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--------------020204010905080806070105
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit


Hi Clemens, hi Stefan,

I recently stumbled upon your alsa-kernel branch (firewire-kernel-streaming:
http://git.alsa-project.org/?p=alsa-kprivate.git;a=shortlog;h=firewire-kernel-streaming)
and have finally found the time to play around with it. First of all I was
impressed to see that it easily worked in conjunction with our DICE-based
devices, even in high samplerate mode (>96kHz), provided that the clockselection
of the DICE had been done beforehand via TCAT's drivers. To get samplerate
switching working via ALSA's driver API I have made a few changes, especially
within the dice_hw_params callback method. Plus, I enhanced the rate constraints
for the pcm settings. You can find these changes in the attached patch
(applicable to
http://git.alsa-project.org/?p=alsa-kprivate.git;a=commit;h=f29bf150b7ba0624142496c84bb48ddba561c0e2).
I hope that some of these enhancements will make it to your alsa-kernel branch,
if not even to the 3.x kernel tree (is this being considered for the near future?).

I am happy to say that this solution will fit our needs for the time being,
while we still have not given up on FFADO as a longterm alternative, provided it
is stable at all rates. I noticed that amdtp_out_stream offers support for
"dualwire" streaming at high rates, which is applied for dice's stream. Has this
already been considered in FFADO? I wasn't able to pinpoint the appropriate
entities within the FFADO sources yet.

In order for snd_dice to make it upstream for generic DICE support there appear
to remain a few minor issues:

1.) wait for NOTIFY_CLOCK_ACCEPTED notification bit after writing
GLOBAL_CLOCK_SELECT within dice_hw_params. For the time being I introduced a
"childish" msleep(500) in order for DICE to potentially switch its ratemode
before starting the stream. I didn't quite figure out how to wait/poll for a
particular notification. Do you have a hint how this would be done (using hwdep)?
2.) support DICE capture streams
3.) DICE clock source (CLOCK_SOURCE_*) selectable via ALSA driver API; how could
this be done? I have changed the default clock source to INTERNAL, since I was
experiencing "slips" with ARX1; as far as I know ARX1/2 is reasonably applicable
only if there is another clock sync master on the Firewire bus.

Thanks again for this cool branch and let us know whether we can be of further
assistance.

Cheers,

Rolf Anderegg,
Weiss Engineering Ltd.

--------------020204010905080806070105
Content-Type: text/plain; name="weiss_dice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="weiss_dice.patch"

diff --git a/sound/firewire/dice-interface.h b/sound/firewire/dice-interface.h
index af916b9..d1e5086 100644
--- a/sound/firewire/dice-interface.h
+++ b/sound/firewire/dice-interface.h
@@ -94,12 +94,13 @@
 #define  CLOCK_SOURCE_AES4		0x00000003
 #define  CLOCK_SOURCE_AES_ANY		0x00000004
 #define  CLOCK_SOURCE_ADAT		0x00000005
-#define  CLOCK_SOURCE_TDIF		0x00000006
+#define  CLOCK_SOURCE_TDIF		0x00000006	//only on DICE II
+#define  CLOCK_SOURCE_ADATAUX		0x00000006	//only on DICE JR/Mini
 #define  CLOCK_SOURCE_WC		0x00000007
 #define  CLOCK_SOURCE_ARX1		0x00000008
 #define  CLOCK_SOURCE_ARX2		0x00000009
-#define  CLOCK_SOURCE_ARX3		0x0000000a
-#define  CLOCK_SOURCE_ARX4		0x0000000b
+#define  CLOCK_SOURCE_ARX3		0x0000000a	//only on DICE II
+#define  CLOCK_SOURCE_ARX4		0x0000000b	//only on DICE II
 #define  CLOCK_SOURCE_INTERNAL		0x0000000c
 #define  CLOCK_RATE_MASK		0x0000ff00
 #define  CLOCK_RATE_32000		0x00000000
@@ -198,12 +199,13 @@
 #define  CLOCK_CAP_SOURCE_AES4		0x00080000
 #define  CLOCK_CAP_SOURCE_AES_ANY	0x00100000
 #define  CLOCK_CAP_SOURCE_ADAT		0x00200000
-#define  CLOCK_CAP_SOURCE_TDIF		0x00400000
+#define  CLOCK_CAP_SOURCE_TDIF		0x00400000	//only on DICE II
+#define  CLOCK_CAP_SOURCE_ADATAUX	0x00400000	//only on DICE JR/Mini
 #define  CLOCK_CAP_SOURCE_WC		0x00800000
 #define  CLOCK_CAP_SOURCE_ARX1		0x01000000
 #define  CLOCK_CAP_SOURCE_ARX2		0x02000000
-#define  CLOCK_CAP_SOURCE_ARX3		0x04000000
-#define  CLOCK_CAP_SOURCE_ARX4		0x08000000
+#define  CLOCK_CAP_SOURCE_ARX3		0x04000000	//only on DICE II
+#define  CLOCK_CAP_SOURCE_ARX4		0x08000000	//only on DICE II
 #define  CLOCK_CAP_SOURCE_INTERNAL	0x10000000
 
 /*
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 7a37587..0c7b17b 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -35,6 +35,7 @@ struct dice {
 	spinlock_t lock;
 	struct mutex mutex;
 	unsigned int global_offset;
+	unsigned int tx_offset;
 	unsigned int rx_offset;
 	struct fw_address_handler notification_handler;
 	int owner_generation;
@@ -107,6 +108,11 @@ static inline u64 global_address(struct dice *dice, unsigned int offset)
 	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
 }
 
+static inline u64 tx_address(struct dice *dice, unsigned int offset)
+{
+	return DICE_PRIVATE_SPACE + dice->tx_offset + offset;
+}
+
 // TODO: rx index
 static inline u64 rx_address(struct dice *dice, unsigned int offset)
 {
@@ -277,9 +283,35 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 	dice->notification_bits |= be32_to_cpup(data);
 	spin_unlock_irqrestore(&dice->lock, flags);
 	fw_send_response(card, request, RCODE_COMPLETE);
+	//snd_printk(KERN_INFO "dice_notification: bits: %#x\n", dice->notification_bits);
 	wake_up(&dice->hwdep_wait);
 }
 
+static unsigned int dice_caps_to_rate_constraints(__be32 const* const caps)
+{
+	unsigned int i;
+	unsigned int rate_constraints = 0;
+	for (i=CLOCK_CAP_RATE_32000; i<=CLOCK_CAP_RATE_192000; i<<=1) {
+		switch(i & be32_to_cpu(*caps)) {
+		case CLOCK_CAP_RATE_32000:
+			rate_constraints|=SNDRV_PCM_RATE_32000; break;
+		case CLOCK_CAP_RATE_44100:
+			rate_constraints|=SNDRV_PCM_RATE_44100; break;
+		case CLOCK_CAP_RATE_48000:
+			rate_constraints|=SNDRV_PCM_RATE_48000; break;
+		case CLOCK_CAP_RATE_88200:
+			rate_constraints|=SNDRV_PCM_RATE_88200; break;
+		case CLOCK_CAP_RATE_96000:
+			rate_constraints|=SNDRV_PCM_RATE_96000; break;
+		case CLOCK_CAP_RATE_176400:
+			rate_constraints|=SNDRV_PCM_RATE_176400; break;
+		case CLOCK_CAP_RATE_192000:
+			rate_constraints|=SNDRV_PCM_RATE_192000; break;
+		}
+	}
+	return rate_constraints;
+}
+
 static int dice_open(struct snd_pcm_substream *substream)
 {
 	static const struct snd_pcm_hardware hardware = {
@@ -298,7 +330,9 @@ static int dice_open(struct snd_pcm_substream *substream)
 	struct dice *dice = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	__be32 clock_sel, data[2];
+	__be32 clock_caps;
 	unsigned int rate_index, number_audio, number_midi;
+	unsigned int rate_constraints;
 	int err;
 
 	err = dice_try_lock(dice);
@@ -306,6 +340,13 @@ static int dice_open(struct snd_pcm_substream *substream)
 		goto error;
 
 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
+					 global_address(dice, GLOBAL_CLOCK_CAPABILITIES),
+					 &clock_caps, 4, 0);
+	if (err < 0)
+		goto err_lock;
+	rate_constraints = dice_caps_to_rate_constraints(&clock_caps);
+
+	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 global_address(dice, GLOBAL_CLOCK_SELECT),
 				 &clock_sel, 4, 0);
 	if (err < 0)
@@ -327,25 +368,14 @@ static int dice_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = hardware;
 
-	runtime->hw.rates = snd_pcm_rate_to_rate_bit(dice_rates[rate_index]);
+	runtime->hw.rates = rate_constraints;
 	snd_pcm_limit_hw_rates(runtime);
 
 	runtime->hw.channels_min = number_audio;
 	runtime->hw.channels_max = number_audio;
 
-	amdtp_out_stream_set_parameters(&dice->stream, dice_rates[rate_index],
-					number_audio, number_midi);
-
-	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-					 amdtp_syt_intervals[rate_index]);
-	if (err < 0)
-		goto err_lock;
-	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-					 amdtp_syt_intervals[rate_index]);
-	if (err < 0)
-		goto err_lock;
+	/*snd_printk(KERN_INFO "dice_open: clk_caps: %#x -> rate constraints: %#x\n",
+					be32_to_cpu(clock_caps),rate_constraints);*/
 
 	err = snd_pcm_hw_constraint_minmax(runtime,
 					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
@@ -365,6 +395,94 @@ error:
 	return err;
 }
 
+static int dice_set_rate(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params, unsigned int clk_src)
+{
+	struct dice *dice = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	__be32 clock_sel, data[2];
+	int err;
+	unsigned int rate_index;
+	unsigned int number_audio = params_channels(hw_params);
+	unsigned int number_midi;
+
+	for (rate_index = 0; rate_index < ARRAY_SIZE(dice_rates); rate_index++)
+		if (params_rate(hw_params) == dice_rates[rate_index])
+			break;
+	if (rate_index >= ARRAY_SIZE(dice_rates)) {
+		err = -ENXIO;
+		goto error;
+	}
+
+	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
+					 rx_address(dice, RX_NUMBER_AUDIO),
+					 data, 2 * 4, 0);
+	if (err < 0)
+		goto error;
+	number_midi = be32_to_cpu(data[1]);
+
+	/*snd_printk(KERN_INFO "dice_set_rate: rate: %i Hz (idx: %i), source: %#x, "\
+			"channels: %i, midi ports: %i\n",
+			params_rate(hw_params),rate_index,clk_src,
+			number_audio,number_midi);*/
+
+	// set rate (DICE clock select & AMDTP & PCM):
+	clock_sel = cpu_to_be32((rate_index << CLOCK_RATE_SHIFT) | clk_src);
+	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 global_address(dice, GLOBAL_CLOCK_SELECT),
+				 &clock_sel, 4, 0);
+
+	// TODO: wait for NOTIFY_CLOCK_ACCEPTED
+#	if 0
+	while(1) {
+		if (hwdep_rd_cnt-- <= 0) {
+			snd_printk(KERN_INFO "dice_set_rate: error: too many hwdep reads.\n");
+			break;
+		}
+		if (dice_hwdep_read(dice->hwdep, (char*)&fw_event, sizeof(fw_event), NULL) <= 0)
+			continue;
+		switch(fw_event.common.type) {
+		case SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION:
+			snd_printk(KERN_INFO "dice_set_rate: DICE notif event (%i): %#x\n",
+					fw_event.dice_notification.type,fw_event.dice_notification.notification);
+			break;
+		case SNDRV_FIREWIRE_EVENT_LOCK_STATUS:
+			snd_printk(KERN_INFO "dice_set_rate: lock status event (%i): %#x\n",
+					fw_event.lock_status.type,fw_event.lock_status.status);
+			break;
+		default:
+			snd_printk(KERN_INFO "dice_set_rate: unknown event (%i)\n",
+					fw_event.common.type);
+			break;
+		}
+		if (fw_event.common.type == SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION &&
+			(fw_event.dice_notification.notification & NOTIFY_CLOCK_ACCEPTED))
+			break;
+	}
+#	else
+	msleep(500);
+#	endif
+
+	amdtp_out_stream_set_parameters(&dice->stream, dice_rates[rate_index],
+						number_audio, number_midi);
+
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					 amdtp_syt_intervals[rate_index]);
+	if (err < 0)
+		goto error;
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					 amdtp_syt_intervals[rate_index]);
+	if (err < 0)
+		goto error;
+
+	return 0;
+
+error:
+	return err;
+}
+
 static int dice_close(struct snd_pcm_substream *substream)
 {
 	struct dice *dice = substream->private_data;
@@ -466,11 +584,17 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	dice_stream_stop(dice);
 	mutex_unlock(&dice->mutex);
 
+	/*snd_printk(KERN_INFO "dice_hw_params: dice stream rate idx: %i, hw_params rate: %i, channels: %i\n",
+			dice->stream.sfc,params_rate(hw_params), params_channels(hw_params));*/
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
 	if (err < 0)
 		goto error;
 
+	err = dice_set_rate(substream, hw_params, CLOCK_SOURCE_INTERNAL);
+	if (err < 0)
+		return err;
+
 	amdtp_out_stream_set_pcm_format(&dice->stream,
 					params_format(hw_params));
 
@@ -845,6 +969,7 @@ static int __devinit dice_init_offsets(struct dice *dice)
 		return err;
 
 	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
+	dice->tx_offset = be32_to_cpu(pointers[2]) * 4;
 	dice->rx_offset = be32_to_cpu(pointers[4]) * 4;
 
 	return 0;
@@ -947,12 +1072,13 @@ static int __devinit dice_probe(struct device *unit_dev)
 	if (err < 0)
 		goto error;
 	clock_sel &= cpu_to_be32(~CLOCK_SOURCE_MASK);
-	clock_sel |= cpu_to_be32(CLOCK_SOURCE_ARX1);
+	clock_sel |= cpu_to_be32(CLOCK_SOURCE_INTERNAL);
 	err = snd_fw_transaction(unit, TCODE_WRITE_QUADLET_REQUEST,
 				 global_address(dice, GLOBAL_CLOCK_SELECT),
 				 &clock_sel, 4, 0);
 	if (err < 0)
 		goto error;
+	//snd_printk(KERN_INFO "dice_probe: curr. clock_sel: %#x\n",be32_to_cpu(clock_sel));
 
 	err = dice_create_pcm(dice);
 	if (err < 0)

--------------020204010905080806070105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020204010905080806070105--
