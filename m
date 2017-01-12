From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fixup some small kernel-doc typos
Date: Thu, 12 Jan 2017 11:38:15 +0000
Message-ID: <1484221095-18821-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CED742669BD
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 12:37:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-ac97.c     | 2 +-
 sound/soc/soc-core.c     | 2 +-
 sound/soc/soc-ops.c      | 2 +-
 sound/soc/soc-topology.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 6c8b0b0..36dae41 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -251,7 +251,7 @@ EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
 /**
  * snd_soc_free_ac97_codec - free AC97 codec device
- * @codec: audio codec
+ * @ac97: snd_ac97 device to be freed
  *
  * Frees AC97 codec device resources.
  */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4f6f682..616fee5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -979,7 +979,7 @@ EXPORT_SYMBOL_GPL(snd_soc_find_dai);
  * @card: soc card
  * @id: DAI link ID to match
  * @name: DAI link name to match, optional
- * @stream name: DAI link stream name to match, optional
+ * @stream_name: DAI link stream name to match, optional
  *
  * This function will search all existing DAI links of the soc card to
  * find the link of the same ID. Since DAI links may not have their
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 9fc1a7b..500f98c 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -120,7 +120,7 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
 /**
- * snd_soc_read_signed - Read a codec register and interprete as signed value
+ * snd_soc_read_signed - Read a codec register and interpret as signed value
  * @component: component
  * @reg: Register to read
  * @mask: Mask to use after shifting the register value
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 87757c2a..dc1f041 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1918,7 +1918,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 
 /**
  * set_link_hw_format - Set the HW audio format of the physical DAI link.
- * @tplg: topology context
+ * @link: &snd_soc_dai_link which should be updated
  * @cfg: physical link configs.
  *
  * Topology context contains a list of supported HW formats (configs) and
@@ -1969,7 +1969,7 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 /**
  * link_new_ver - Create a new physical link config from the old
  * version of source.
- * @toplogy: topology context
+ * @tplg: topology context
  * @src: old version of phyical link config as a source
  * @link: latest version of physical link config created from the source
  *
@@ -2211,7 +2211,7 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 /**
  * manifest_new_ver - Create a new version of manifest from the old version
  * of source.
- * @toplogy: topology context
+ * @tplg: topology context
  * @src: old version of manifest as a source
  * @manifest: latest version of manifest created from the source
  *
-- 
2.1.4
