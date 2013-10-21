From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [03/29] ALSA: dice: allow all sample rates
Date: Mon, 21 Oct 2013 21:22:36 +0200
Message-ID: <52657EFC.6080706@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Instead of forcing a constant 44.1 kHz, read the current sample rate
from the device when opening the PCM device.

Actually changing the sample rate requires some separate controller
application.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   55 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index b081021..d3f3eb7 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -75,6 +75,7 @@
 #define  CLOCK_RATE_ANY_MID		0x00000800
 #define  CLOCK_RATE_ANY_HIGH		0x00000900
 #define  CLOCK_RATE_NONE		0x00000a00
+#define  CLOCK_RATE_SHIFT		8
 #define GLOBAL_ENABLE			0x050
 #define  ENABLE				0x00000001
 #define GLOBAL_STATUS			0x054
@@ -248,6 +249,16 @@ MODULE_DESCRIPTION("DICE driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");

+static const unsigned int dice_rates[] = {
+	[0] =  32000,
+	[1] =  44100,
+	[2] =  48000,
+	[3] =  88200,
+	[4] =  96000,
+	[5] = 176400,
+	[6] = 192000,
+};
+
 static inline u64 global_address(struct dice *dice, unsigned int offset)
 {
 	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
@@ -508,9 +519,6 @@ static int dice_open(struct snd_pcm_substream *substream)
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_BLOCK_TRANSFER,
 		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
-		.rates = SNDRV_PCM_RATE_44100,
-		.rate_min = 44100,
-		.rate_max = 44100,
 		.buffer_bytes_max = 16 * 1024 * 1024,
 		.period_bytes_min = 1,
 		.period_bytes_max = UINT_MAX,
@@ -519,10 +527,21 @@ static int dice_open(struct snd_pcm_substream *substream)
 	};
 	struct dice *dice = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	__be32 number_audio, number_midi;
+	__be32 clock_sel, number_audio, number_midi;
+	unsigned int rate;
 	int err;

 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
+				 global_address(dice, GLOBAL_CLOCK_SELECT),
+				 &clock_sel, 4);
+	if (err < 0)
+		return err;
+	rate = (be32_to_cpu(clock_sel) & CLOCK_RATE_MASK) >> CLOCK_RATE_SHIFT;
+	if (rate >= ARRAY_SIZE(dice_rates))
+		return -ENXIO;
+	rate = dice_rates[rate];
+
+	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 rx_address(dice, RX_NUMBER_AUDIO),
 				 &number_audio, 4);
 	if (err < 0)
@@ -534,10 +553,14 @@ static int dice_open(struct snd_pcm_substream *substream)
 		return err;

 	runtime->hw = hardware;
+
+	runtime->hw.rates = snd_pcm_rate_to_rate_bit(rate);
+	snd_pcm_limit_hw_rates(runtime);
+
 	runtime->hw.channels_min = be32_to_cpu(number_audio);
 	runtime->hw.channels_max = be32_to_cpu(number_audio);

-	amdtp_out_stream_set_rate(&dice->stream, 44100);
+	amdtp_out_stream_set_rate(&dice->stream, rate);
 	amdtp_out_stream_set_pcm(&dice->stream, be32_to_cpu(number_audio));
 	amdtp_out_stream_set_midi(&dice->stream, be32_to_cpu(number_midi));

@@ -746,17 +769,9 @@ static int dice_create_pcm(struct dice *dice)
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
-	__be32 clock;
 	struct snd_pcm *pcm;
 	int err;

-	clock = cpu_to_be32(CLOCK_SOURCE_ARX1 | CLOCK_RATE_44100);
-	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock, 4);
-	if (err < 0)
-		return err;
-
 	err = snd_pcm_new(dice->card, "DICE", 0, 1, 0, &pcm);
 	if (err < 0)
 		return err;
@@ -897,6 +912,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 {
 	struct snd_card *card;
 	struct dice *dice;
+	__be32 clock_sel;
 	int err;

 	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*dice), &card);
@@ -938,6 +954,19 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)

 	dice_card_strings(dice);

+	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
+				 global_address(dice, GLOBAL_CLOCK_SELECT),
+				 &clock_sel, 4);
+	if (err < 0)
+		goto error;
+	clock_sel &= cpu_to_be32(~CLOCK_SOURCE_MASK);
+	clock_sel |= cpu_to_be32(CLOCK_SOURCE_ARX1);
+	err = snd_fw_transaction(unit, TCODE_WRITE_QUADLET_REQUEST,
+				 global_address(dice, GLOBAL_CLOCK_SELECT),
+				 &clock_sel, 4);
+	if (err < 0)
+		goto error;
+
 	err = dice_create_pcm(dice);
 	if (err < 0)
 		goto error;

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
