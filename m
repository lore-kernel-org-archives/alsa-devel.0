From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 3/6] ASoC: dapm: Expose snd_soc_dapm_new_control_unlocked properly
Date: Tue, 27 Aug 2019 16:17:09 +0200
Message-ID: <20190827141712.21015-4-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

We use snd_soc_dapm_new_control_unlocked for topology and have local
declaration, instead declare it properly in header like already declared
snd_soc_dapm_new_control.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
---
 include/sound/soc-dapm.h | 3 +++
 sound/soc/soc-topology.c | 6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2aa73d6dd7be..30d8d0410952 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -404,6 +404,9 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 struct snd_soc_dapm_widget *snd_soc_dapm_new_control(
 		struct snd_soc_dapm_context *dapm,
 		const struct snd_soc_dapm_widget *widget);
+struct snd_soc_dapm_widget *snd_soc_dapm_new_control_unlocked(
+		struct snd_soc_dapm_context *dapm,
+		const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b8690715abb5..aa9a1fca46fa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -80,12 +80,6 @@ struct soc_tplg {
 
 static int soc_tplg_process_headers(struct soc_tplg *tplg);
 static void soc_tplg_complete(struct soc_tplg *tplg);
-struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
-			 const struct snd_soc_dapm_widget *widget);
-struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-			 const struct snd_soc_dapm_widget *widget);
 static void soc_tplg_denum_remove_texts(struct soc_enum *se);
 static void soc_tplg_denum_remove_values(struct soc_enum *se);
 
-- 
2.17.1
