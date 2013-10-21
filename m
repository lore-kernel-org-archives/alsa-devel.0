From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [13/29] ALSA: dice: optimize reading of consecutive registers
Date: Mon, 21 Oct 2013 21:27:59 +0200
Message-ID: <5265803F.9000105@ladisch.de>
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

Instead of reading two consecutive register with two quadlet requests,
use one block read request.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 8804e42..e1d8dff 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -374,8 +374,8 @@ static int dice_open(struct snd_pcm_substream *substream)
 	};
 	struct dice *dice = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	__be32 clock_sel, number_audio, number_midi;
-	unsigned int rate_index, rate;
+	__be32 clock_sel, data[2];
+	unsigned int rate_index, number_audio, number_midi;
 	int err;

 	err = dice_try_lock(dice);
@@ -393,30 +393,25 @@ static int dice_open(struct snd_pcm_substream *substream)
 		err = -ENXIO;
 		goto err_lock;
 	}
-	rate = dice_rates[rate_index];

-	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
+	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
 				 rx_address(dice, RX_NUMBER_AUDIO),
-				 &number_audio, 4);
-	if (err < 0)
-		goto err_lock;
-	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
-				 rx_address(dice, RX_NUMBER_MIDI),
-				 &number_midi, 4);
+				 data, 2 * 4);
 	if (err < 0)
 		goto err_lock;
+	number_audio = be32_to_cpu(data[0]);
+	number_midi = be32_to_cpu(data[1]);

 	runtime->hw = hardware;

-	runtime->hw.rates = snd_pcm_rate_to_rate_bit(rate);
+	runtime->hw.rates = snd_pcm_rate_to_rate_bit(dice_rates[rate_index]);
 	snd_pcm_limit_hw_rates(runtime);

-	runtime->hw.channels_min = be32_to_cpu(number_audio);
-	runtime->hw.channels_max = be32_to_cpu(number_audio);
+	runtime->hw.channels_min = number_audio;
+	runtime->hw.channels_max = number_audio;

-	amdtp_out_stream_set_parameters(&dice->stream, rate,
-					be32_to_cpu(number_audio),
-					be32_to_cpu(number_midi));
+	amdtp_out_stream_set_parameters(&dice->stream, dice_rates[rate_index],
+					number_audio, number_midi);

 	err = snd_pcm_hw_constraint_step(runtime, 0,
 					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE,

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
