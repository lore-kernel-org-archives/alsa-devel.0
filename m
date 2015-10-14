From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add info callback for SX_TLV controls
Date: Wed, 14 Oct 2015 13:31:24 +0100
Message-ID: <1444825884-11827-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF762651A5
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 14:50:53 +0200 (CEST)
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
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

SX_TLV controls are intended for situations where the register behind
the control has some non-zero value indicating the minimum gain
and then gains increasing from there and eventually overflowing through
zero.

Currently every CODEC implementing these controls specifies the minimum
as the non-zero value for the minimum and the maximum as the number of
gain settings available.

This means when the info callback subtracts the minimum value from the
maximum value to calculate the number of gain levels available it is
actually under reporting the available levels. This patch fixes this
issue by adding a new snd_soc_info_volsw_sx callback that does not
subtract the minimum value.

Fixes: 1d99f2436d0d ("ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    6 ++++--
 sound/soc/soc-ops.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 98e080b..bd85564 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -86,7 +86,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
 	SNDRV_CTL_ELEM_ACCESS_READWRITE, \
 	.tlv.p  = (tlv_array),\
-	.info = snd_soc_info_volsw, \
+	.info = snd_soc_info_volsw_sx, \
 	.get = snd_soc_get_volsw_sx,\
 	.put = snd_soc_put_volsw_sx, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
@@ -156,7 +156,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
 	SNDRV_CTL_ELEM_ACCESS_READWRITE, \
 	.tlv.p  = (tlv_array), \
-	.info = snd_soc_info_volsw, \
+	.info = snd_soc_info_volsw_sx, \
 	.get = snd_soc_get_volsw_sx, \
 	.put = snd_soc_put_volsw_sx, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
@@ -593,6 +593,8 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
+int snd_soc_info_volsw_sx(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_info *uinfo);
 #define snd_soc_info_bool_ext		snd_ctl_boolean_mono_info
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 100d92b..05977ae 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -207,6 +207,34 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
 
 /**
+ * snd_soc_info_volsw_sx - Mixer info callback for SX TLV controls
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to provide information about a single mixer control, or a double
+ * mixer control that spans 2 registers of the SX TLV type. SX TLV controls
+ * have a range that represents both positive and negative values either side
+ * of zero but without a sign bit.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_volsw_sx(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	snd_soc_info_volsw(kcontrol, uinfo);
+	/* Max represents the number of levels in an SX control not the
+	 * maximum value, so add the minimum value back on
+	 */
+	uinfo->value.integer.max += mc->min;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_volsw_sx);
+
+/**
  * snd_soc_get_volsw - single mixer get callback
  * @kcontrol: mixer control
  * @ucontrol: control element information
-- 
1.7.2.5
