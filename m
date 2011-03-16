From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2 v3] ASoC: soc-core: Add helper function to
	handle dynamic update of controls
Date: Wed, 16 Mar 2011 10:58:55 +0000
Message-ID: <1300273135-17101-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300273135-17101-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49189103873
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 11:59:03 +0100 (CET)
In-Reply-To: <1300273135-17101-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This function can be used to update or add controls at runtime.  It will
always try to add a given control if it does not already exist.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bfa4836..509c1ea 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -344,6 +344,8 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 				  const char *prefix);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
+int snd_soc_update_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 17efacd..7ce2a07 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2420,6 +2420,39 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_add_controls);
 
 /**
+ * snd_soc_update_controls - update an array of controls
+ * Convienience function to update a list of controls.
+ *
+ * @codec: codec to update controls of
+ * @controls: array of controls to update
+ * @num_controls: number of elements in the array
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_update_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	struct snd_card *card = codec->card->snd_card;
+	int err, i;
+
+	for (i = 0; i < num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+		/* always add on update if not already added */
+		err = snd_ctl_update(card, snd_soc_cnew(control, codec,
+							control->name,
+							codec->name_prefix), true);
+		if (err < 0) {
+			dev_err(codec->dev, "%s: Failed to update %s: %d\n",
+				codec->name, control->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_update_controls);
+
+/**
  * snd_soc_info_enum_double - enumerated double mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.7.4.1
