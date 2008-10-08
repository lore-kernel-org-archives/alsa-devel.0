From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ALSA: ASoC: add new param mux to
	dapm_mux_update_power
Date: Wed,  8 Oct 2008 10:37:56 +0100
Message-ID: <1223458680-9506-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
	<1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC1C6244C7
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:15 +0200 (CEST)
In-Reply-To: <1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Zhao <linuxzsc@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Richard Zhao <linuxzsc@gmail.com>

Function dapm_mux_update_power needs enum index mux and register mask value val
as parameters, but it only has a parameter val, and uses it as both val and mux.
snd_soc_test_bits(widget->codec, e->reg, mask, val) val is register mask here,
e->texts[val] but val should be enum index mux here.

This patch adds a new param mux to fix it.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 05ffba2..83fa9c4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -693,7 +693,7 @@ static void dbg_dump_dapm(struct snd_soc_codec* codec, const char *action)
 /* test and update the power status of a mux widget */
 static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 				 struct snd_kcontrol *kcontrol, int mask,
-				 int val, struct soc_enum* e)
+				 int mux, int val, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
@@ -709,12 +709,12 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		if (path->kcontrol != kcontrol)
 			continue;
 
-		if (!path->name || ! e->texts[val])
+		if (!path->name || !e->texts[mux])
 			continue;
 
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[val])))
+		if (!(strcmp(path->name, e->texts[mux])))
 			path->connect = 1; /* new connection */
 		else
 			path->connect = 0; /* old connection must be powered down */
@@ -1291,7 +1291,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
-	dapm_mux_update_power(widget, kcontrol, mask, mux, e);
+	dapm_mux_update_power(widget, kcontrol, mask, mux, val, e);
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
 			ret = widget->event(widget,
-- 
1.5.6.5
