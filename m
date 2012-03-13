From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 04/16] ASoC: core: Add info accessor for mreg
	control
Date: Tue, 13 Mar 2012 16:11:31 +0100
Message-ID: <1331651503-16917-5-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id A7C6A104336
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:18 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
List-Id: alsa-devel@alsa-project.org

From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>

Added info accessor for mreg controls that includes support for signed values.

snd_soc_info_xr_sx

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 66953a6..0437c12 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -432,6 +432,8 @@ int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_xr8_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_xr8_sx(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bacc465..16d071e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2641,6 +2641,30 @@ int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
 
 /**
+ * snd_soc_info_xr_sx - signed multi register info callback
+ * @kcontrol: mreg control
+ * @uinfo: control element information
+ *
+ * Callback to provide information about a control
+ * that supports multiple signed values.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = mc->count;
+	uinfo->value.integer.min = mc->min;
+	uinfo->value.integer.max = mc->max;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_xr_sx);
+
+/**
  * snd_soc_get_xr8_sx - signed multi register get callback
  * @kcontrol: mreg control
  * @ucontrol: control element information
-- 
1.7.8.3
