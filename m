From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 2/2] ASoC: dapm: harden use of lookup tables
Date: Mon,  4 Feb 2019 14:27:10 -0600
Message-ID: <20190204202710.14547-2-pierre-louis.bossart@linux.intel.com>
References: <20190204202710.14547-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 105F526745C
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 21:27:24 +0100 (CET)
In-Reply-To: <20190204202710.14547-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add warnings when
a) the table size isn't aligned with the enum list
b) the values are not initialized. This requires an increase by one of all
values to avoid the default 0.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dapm.h |   3 +
 sound/soc/soc-dapm.c     | 163 +++++++++++++++++++++------------------
 2 files changed, 90 insertions(+), 76 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 79b4ddfb8e9e..82de75b4de87 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -523,6 +523,9 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_asrc,		/* DSP/CODEC ASRC component */
 	snd_soc_dapm_encoder,		/* FW/SW audio encoder component */
 	snd_soc_dapm_decoder,		/* FW/SW audio decoder component */
+
+	/* Don't forget to change the following: */
+	SND_SOC_DAPM_TYPE_LAST = snd_soc_dapm_decoder
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2bf5bab579de..50ca1c7cac34 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -64,85 +64,85 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
-	[snd_soc_dapm_pre] = 0,
-	[snd_soc_dapm_regulator_supply] = 1,
-	[snd_soc_dapm_pinctrl] = 1,
-	[snd_soc_dapm_clock_supply] = 1,
-	[snd_soc_dapm_supply] = 2,
-	[snd_soc_dapm_micbias] = 3,
-	[snd_soc_dapm_vmid] = 3,
-	[snd_soc_dapm_dai_link] = 2,
-	[snd_soc_dapm_dai_in] = 4,
-	[snd_soc_dapm_dai_out] = 4,
-	[snd_soc_dapm_aif_in] = 4,
-	[snd_soc_dapm_aif_out] = 4,
-	[snd_soc_dapm_mic] = 5,
-	[snd_soc_dapm_siggen] = 5,
-	[snd_soc_dapm_input] = 5,
-	[snd_soc_dapm_output] = 5,
-	[snd_soc_dapm_mux] = 6,
-	[snd_soc_dapm_demux] = 6,
-	[snd_soc_dapm_dac] = 7,
-	[snd_soc_dapm_switch] = 8,
-	[snd_soc_dapm_mixer] = 8,
-	[snd_soc_dapm_mixer_named_ctl] = 8,
-	[snd_soc_dapm_pga] = 9,
-	[snd_soc_dapm_buffer] = 9,
-	[snd_soc_dapm_scheduler] = 9,
-	[snd_soc_dapm_effect] = 9,
-	[snd_soc_dapm_src] = 9,
-	[snd_soc_dapm_asrc] = 9,
-	[snd_soc_dapm_encoder] = 9,
-	[snd_soc_dapm_decoder] = 9,
-	[snd_soc_dapm_adc] = 10,
-	[snd_soc_dapm_out_drv] = 11,
-	[snd_soc_dapm_hp] = 11,
-	[snd_soc_dapm_spk] = 11,
-	[snd_soc_dapm_line] = 11,
-	[snd_soc_dapm_sink] = 11,
-	[snd_soc_dapm_kcontrol] = 12,
-	[snd_soc_dapm_post] = 13,
+	[snd_soc_dapm_pre] = 1,
+	[snd_soc_dapm_regulator_supply] = 2,
+	[snd_soc_dapm_pinctrl] = 2,
+	[snd_soc_dapm_clock_supply] = 2,
+	[snd_soc_dapm_supply] = 3,
+	[snd_soc_dapm_micbias] = 4,
+	[snd_soc_dapm_vmid] = 4,
+	[snd_soc_dapm_dai_link] = 3,
+	[snd_soc_dapm_dai_in] = 5,
+	[snd_soc_dapm_dai_out] = 5,
+	[snd_soc_dapm_aif_in] = 5,
+	[snd_soc_dapm_aif_out] = 5,
+	[snd_soc_dapm_mic] = 6,
+	[snd_soc_dapm_siggen] = 6,
+	[snd_soc_dapm_input] = 6,
+	[snd_soc_dapm_output] = 6,
+	[snd_soc_dapm_mux] = 7,
+	[snd_soc_dapm_demux] = 7,
+	[snd_soc_dapm_dac] = 8,
+	[snd_soc_dapm_switch] = 9,
+	[snd_soc_dapm_mixer] = 9,
+	[snd_soc_dapm_mixer_named_ctl] = 9,
+	[snd_soc_dapm_pga] = 10,
+	[snd_soc_dapm_buffer] = 10,
+	[snd_soc_dapm_scheduler] = 10,
+	[snd_soc_dapm_effect] = 10,
+	[snd_soc_dapm_src] = 10,
+	[snd_soc_dapm_asrc] = 10,
+	[snd_soc_dapm_encoder] = 10,
+	[snd_soc_dapm_decoder] = 10,
+	[snd_soc_dapm_adc] = 11,
+	[snd_soc_dapm_out_drv] = 12,
+	[snd_soc_dapm_hp] = 12,
+	[snd_soc_dapm_spk] = 12,
+	[snd_soc_dapm_line] = 12,
+	[snd_soc_dapm_sink] = 12,
+	[snd_soc_dapm_kcontrol] = 13,
+	[snd_soc_dapm_post] = 14,
 };
 
 static int dapm_down_seq[] = {
-	[snd_soc_dapm_pre] = 0,
-	[snd_soc_dapm_kcontrol] = 1,
-	[snd_soc_dapm_adc] = 2,
-	[snd_soc_dapm_hp] = 3,
-	[snd_soc_dapm_spk] = 3,
-	[snd_soc_dapm_line] = 3,
-	[snd_soc_dapm_out_drv] = 3,
-	[snd_soc_dapm_sink] = 3,
-	[snd_soc_dapm_pga] = 4,
-	[snd_soc_dapm_buffer] = 4,
-	[snd_soc_dapm_scheduler] = 4,
-	[snd_soc_dapm_effect] = 4,
-	[snd_soc_dapm_src] = 4,
-	[snd_soc_dapm_asrc] = 4,
-	[snd_soc_dapm_encoder] = 4,
-	[snd_soc_dapm_decoder] = 4,
-	[snd_soc_dapm_switch] = 5,
-	[snd_soc_dapm_mixer_named_ctl] = 5,
-	[snd_soc_dapm_mixer] = 5,
-	[snd_soc_dapm_dac] = 6,
-	[snd_soc_dapm_mic] = 7,
-	[snd_soc_dapm_siggen] = 7,
-	[snd_soc_dapm_input] = 7,
-	[snd_soc_dapm_output] = 7,
-	[snd_soc_dapm_micbias] = 8,
-	[snd_soc_dapm_vmid] = 8,
-	[snd_soc_dapm_mux] = 9,
-	[snd_soc_dapm_demux] = 9,
-	[snd_soc_dapm_aif_in] = 10,
-	[snd_soc_dapm_aif_out] = 10,
-	[snd_soc_dapm_dai_in] = 10,
-	[snd_soc_dapm_dai_out] = 10,
-	[snd_soc_dapm_dai_link] = 11,
-	[snd_soc_dapm_supply] = 12,
-	[snd_soc_dapm_clock_supply] = 13,
-	[snd_soc_dapm_pinctrl] = 13,
-	[snd_soc_dapm_regulator_supply] = 13,
-	[snd_soc_dapm_post] = 14,
+	[snd_soc_dapm_pre] = 1,
+	[snd_soc_dapm_kcontrol] = 2,
+	[snd_soc_dapm_adc] = 3,
+	[snd_soc_dapm_hp] = 4,
+	[snd_soc_dapm_spk] = 4,
+	[snd_soc_dapm_line] = 4,
+	[snd_soc_dapm_out_drv] = 4,
+	[snd_soc_dapm_sink] = 4,
+	[snd_soc_dapm_pga] = 5,
+	[snd_soc_dapm_buffer] = 5,
+	[snd_soc_dapm_scheduler] = 5,
+	[snd_soc_dapm_effect] = 5,
+	[snd_soc_dapm_src] = 5,
+	[snd_soc_dapm_asrc] = 5,
+	[snd_soc_dapm_encoder] = 5,
+	[snd_soc_dapm_decoder] = 5,
+	[snd_soc_dapm_switch] = 6,
+	[snd_soc_dapm_mixer_named_ctl] = 6,
+	[snd_soc_dapm_mixer] = 6,
+	[snd_soc_dapm_dac] = 7,
+	[snd_soc_dapm_mic] = 8,
+	[snd_soc_dapm_siggen] = 8,
+	[snd_soc_dapm_input] = 8,
+	[snd_soc_dapm_output] = 8,
+	[snd_soc_dapm_micbias] = 9,
+	[snd_soc_dapm_vmid] = 9,
+	[snd_soc_dapm_mux] = 10,
+	[snd_soc_dapm_demux] = 10,
+	[snd_soc_dapm_aif_in] = 11,
+	[snd_soc_dapm_aif_out] = 11,
+	[snd_soc_dapm_dai_in] = 11,
+	[snd_soc_dapm_dai_out] = 11,
+	[snd_soc_dapm_dai_link] = 12,
+	[snd_soc_dapm_supply] = 13,
+	[snd_soc_dapm_clock_supply] = 14,
+	[snd_soc_dapm_pinctrl] = 14,
+	[snd_soc_dapm_regulator_supply] = 14,
+	[snd_soc_dapm_post] = 15,
 };
 
 static void dapm_assert_locked(struct snd_soc_dapm_context *dapm)
@@ -1425,11 +1425,22 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 {
 	int *sort;
 
+	WARN_ONCE(ARRAY_SIZE(dapm_up_seq) != SND_SOC_DAPM_TYPE_LAST,
+		  "bad size for dapm_up_seq, expected %d\n",
+		  SND_SOC_DAPM_TYPE_LAST);
+
+	WARN_ONCE(ARRAY_SIZE(dapm_down_seq) != SND_SOC_DAPM_TYPE_LAST,
+		  "bad size for dapm_down_seq, expected %d\n",
+		  SND_SOC_DAPM_TYPE_LAST);
+
 	if (power_up)
 		sort = dapm_up_seq;
 	else
 		sort = dapm_down_seq;
 
+	WARN_ONCE(sort[a->id] == 0, "offset a->id %d not initialized\n", a->id);
+	WARN_ONCE(sort[b->id] == 0, "offset b->id %d not initialized\n", b->id);
+
 	if (sort[a->id] != sort[b->id])
 		return sort[a->id] - sort[b->id];
 	if (a->subseq != b->subseq) {
-- 
2.17.1
