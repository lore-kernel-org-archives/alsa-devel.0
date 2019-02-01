From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] ASoC: dapm: fix out-of-bounds accesses to
	DAPM lookup tables
Date: Fri,  1 Feb 2019 11:05:11 -0600
Message-ID: <20190201170513.13905-2-pierre-louis.bossart@linux.intel.com>
References: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 71D8C267470
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 18:05:22 +0100 (CET)
In-Reply-To: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
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
lookup tables. The value of 10 was chosen since these widgets are not
too critical for pop/click removals.

Also the sequences for the following widgets were not defined
 snd_soc_dapm_input
 snd_soc_dapm_output
 snd_soc_dapm_mic
 snd_soc_dapm_vmid
 snd_soc_dapm_siggen
 snd_soc_dapm_sink

Since their values defaulted to zero, use a more reasonable mid-level
value of 10.

Fixes: 8a70b4544ef4 ('ASoC: dapm: Add new widget type for constructing DAPM graphs on DSPs.').
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dapm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c4c13419539..f0d3d2d1a6bc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -84,6 +84,19 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_mixer_named_ctl] = 8,
 	[snd_soc_dapm_pga] = 9,
 	[snd_soc_dapm_adc] = 10,
+	[snd_soc_dapm_input] = 10,
+	[snd_soc_dapm_output] = 10,
+	[snd_soc_dapm_mic] = 10,
+	[snd_soc_dapm_vmid] = 10,
+	[snd_soc_dapm_siggen] = 10,
+	[snd_soc_dapm_sink] = 10,
+	[snd_soc_dapm_buffer] = 10,
+	[snd_soc_dapm_scheduler] = 10,
+	[snd_soc_dapm_effect] = 10,
+	[snd_soc_dapm_src] = 10,
+	[snd_soc_dapm_asrc] = 10,
+	[snd_soc_dapm_encoder] = 10,
+	[snd_soc_dapm_decoder] = 10,
 	[snd_soc_dapm_out_drv] = 11,
 	[snd_soc_dapm_hp] = 11,
 	[snd_soc_dapm_spk] = 11,
@@ -113,6 +126,19 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai_in] = 10,
 	[snd_soc_dapm_dai_out] = 10,
+	[snd_soc_dapm_input] = 10,
+	[snd_soc_dapm_output] = 10,
+	[snd_soc_dapm_mic] = 10,
+	[snd_soc_dapm_vmid] = 10,
+	[snd_soc_dapm_siggen] = 10,
+	[snd_soc_dapm_sink] = 10,
+	[snd_soc_dapm_buffer] = 10,
+	[snd_soc_dapm_scheduler] = 10,
+	[snd_soc_dapm_effect] = 10,
+	[snd_soc_dapm_src] = 10,
+	[snd_soc_dapm_asrc] = 10,
+	[snd_soc_dapm_encoder] = 10,
+	[snd_soc_dapm_decoder] = 10,
 	[snd_soc_dapm_dai_link] = 11,
 	[snd_soc_dapm_supply] = 12,
 	[snd_soc_dapm_clock_supply] = 13,
-- 
2.17.1
