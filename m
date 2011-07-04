From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/3] ASoC: core - Add API call to register
	platform kcontrols.
Date: Mon, 4 Jul 2011 22:10:51 +0100
Message-ID: <1309813853-7142-2-git-send-email-lrg@ti.com>
References: <1309813853-7142-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 014B6103889
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:10:59 +0200 (CEST)
In-Reply-To: <1309813853-7142-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In preparation for Dynamic PCM (AKA DSP) support.

Allow platform drivers to register kcontrols.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f30f3fe..c421501 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -368,6 +368,8 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 				  const char *prefix);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
+int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
+	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 06c9b14..a69b87a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1951,6 +1951,36 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_add_controls);
 
 /**
+ * snd_soc_add_platform_controls - add an array of controls to a platform.
+ * Convienience function to add a list of controls.
+ *
+ * @platform: platform to add controls to
+ * @controls: array of controls to add
+ * @num_controls: number of elements in the array
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	struct snd_card *card = platform->card->snd_card;
+	int err, i;
+
+	for (i = 0; i < num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+		err = snd_ctl_add(card, snd_soc_cnew(control, platform,
+				control->name, NULL));
+		if (err < 0) {
+			dev_err(platform->dev, "Failed to add %s %d\n",control->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_platform_controls);
+
+/**
  * snd_soc_info_enum_double - enumerated double mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.7.4.1
