From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3] ASoC: dapm: Add new widget type
	snd_soc_dapm_dsp_component
Date: Thu, 15 Jun 2017 20:46:04 +0100
Message-ID: <1497555964-4862-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 434A4266A65
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 21:46:24 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Add a new widget type to represent internal DSP components and allow DSP
drivers and firmware to define topologies using this widget type.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

---

Takashi, I'll send a subsequent patch for alsa-lib if Mark is happy with this
version.

Changes V2.
   o No need for multiple types since core does not care.
Changes v1.
   o Added some documentation.
   o Split codec widget into encoder and decoder to avoid confusion with HW
     CODECS.

 Documentation/sound/soc/dapm.rst | 4 ++++
 include/sound/soc-dapm.h         | 1 +
 include/uapi/sound/asoc.h        | 3 ++-
 sound/soc/soc-topology.c         | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index a27f42befa4d..540a86012e29 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -105,6 +105,10 @@ Pre
 	Special PRE widget (exec before all others)
 Post
 	Special POST widget (exec after all others)
+DSP Component
+	Internal DSP component not used by the ASoC core but may be used
+	by DSP driver and DSP firmware.
+
 
 (Widgets are defined in include/sound/soc-dapm.h)
 
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a466f4bdc835..87133c974991 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,6 +510,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
 	snd_soc_dapm_kcontrol,		/* Auto-disabled kcontrol */
+	snd_soc_dapm_dsp_component,	/* DSP internal component */
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 6702533c8bd8..e805ef651538 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -73,7 +73,8 @@
 #define SND_SOC_TPLG_DAPM_DAI_IN	13
 #define SND_SOC_TPLG_DAPM_DAI_OUT	14
 #define SND_SOC_TPLG_DAPM_DAI_LINK	15
-#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DAI_LINK
+#define SND_SOC_TPLG_DAPM_DSP_COMPONENT	16
+#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DSP_COMPONENT
 
 /* Header magic number and string sizes */
 #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 12e189701924..17751736957f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -242,6 +242,7 @@ static const struct soc_tplg_map dapm_map[] = {
 	{SND_SOC_TPLG_DAPM_DAI_IN, snd_soc_dapm_dai_in},
 	{SND_SOC_TPLG_DAPM_DAI_OUT, snd_soc_dapm_dai_out},
 	{SND_SOC_TPLG_DAPM_DAI_LINK, snd_soc_dapm_dai_link},
+	{SND_SOC_TPLG_DAPM_DSP_COMPONENT, snd_soc_dapm_dsp_component},
 };
 
 static int tplc_chan_get_reg(struct soc_tplg *tplg,
-- 
2.11.0
