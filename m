From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 1/2] ASoC: dapm: fix out-of-bounds accesses
	to DAPM lookup tables
Date: Tue,  5 Feb 2019 10:22:27 -0600
Message-ID: <20190205162228.23252-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 262342666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:22:32 +0100 (CET)
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

KASAN reports and additional traces point to out-of-bounds accesses to
the dapm_up_seq and dapm_down_seq lookup tables. The indices used are
larger than the array definition.

Fix by adding missing entries for the new widget types in these two
lookup tables, and align them with PGA values.

Also the sequences for the following widgets were not defined. Since
their values defaulted to zero, assign them explicitly

 snd_soc_dapm_input
 snd_soc_dapm_output
 snd_soc_dapm_vmid
 snd_soc_dapm_siggen
 snd_soc_dapm_sink

Fixes: 8a70b4544ef4 ('ASoC: dapm: Add new widget type for constructing DAPM graphs on DSPs.').
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dapm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5b74dffc9c11..2bf5bab579de 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -70,12 +70,16 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_clock_supply] = 1,
 	[snd_soc_dapm_supply] = 2,
 	[snd_soc_dapm_micbias] = 3,
+	[snd_soc_dapm_vmid] = 3,
 	[snd_soc_dapm_dai_link] = 2,
 	[snd_soc_dapm_dai_in] = 4,
 	[snd_soc_dapm_dai_out] = 4,
 	[snd_soc_dapm_aif_in] = 4,
 	[snd_soc_dapm_aif_out] = 4,
 	[snd_soc_dapm_mic] = 5,
+	[snd_soc_dapm_siggen] = 5,
+	[snd_soc_dapm_input] = 5,
+	[snd_soc_dapm_output] = 5,
 	[snd_soc_dapm_mux] = 6,
 	[snd_soc_dapm_demux] = 6,
 	[snd_soc_dapm_dac] = 7,
@@ -83,11 +87,19 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_mixer] = 8,
 	[snd_soc_dapm_mixer_named_ctl] = 8,
 	[snd_soc_dapm_pga] = 9,
+	[snd_soc_dapm_buffer] = 9,
+	[snd_soc_dapm_scheduler] = 9,
+	[snd_soc_dapm_effect] = 9,
+	[snd_soc_dapm_src] = 9,
+	[snd_soc_dapm_asrc] = 9,
+	[snd_soc_dapm_encoder] = 9,
+	[snd_soc_dapm_decoder] = 9,
 	[snd_soc_dapm_adc] = 10,
 	[snd_soc_dapm_out_drv] = 11,
 	[snd_soc_dapm_hp] = 11,
 	[snd_soc_dapm_spk] = 11,
 	[snd_soc_dapm_line] = 11,
+	[snd_soc_dapm_sink] = 11,
 	[snd_soc_dapm_kcontrol] = 12,
 	[snd_soc_dapm_post] = 13,
 };
@@ -100,13 +112,25 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_spk] = 3,
 	[snd_soc_dapm_line] = 3,
 	[snd_soc_dapm_out_drv] = 3,
+	[snd_soc_dapm_sink] = 3,
 	[snd_soc_dapm_pga] = 4,
+	[snd_soc_dapm_buffer] = 4,
+	[snd_soc_dapm_scheduler] = 4,
+	[snd_soc_dapm_effect] = 4,
+	[snd_soc_dapm_src] = 4,
+	[snd_soc_dapm_asrc] = 4,
+	[snd_soc_dapm_encoder] = 4,
+	[snd_soc_dapm_decoder] = 4,
 	[snd_soc_dapm_switch] = 5,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
 	[snd_soc_dapm_mixer] = 5,
 	[snd_soc_dapm_dac] = 6,
 	[snd_soc_dapm_mic] = 7,
+	[snd_soc_dapm_siggen] = 7,
+	[snd_soc_dapm_input] = 7,
+	[snd_soc_dapm_output] = 7,
 	[snd_soc_dapm_micbias] = 8,
+	[snd_soc_dapm_vmid] = 8,
 	[snd_soc_dapm_mux] = 9,
 	[snd_soc_dapm_demux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
-- 
2.17.1
