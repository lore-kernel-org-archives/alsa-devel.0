From: Richard Zhao <linuxzsc@gmail.com>
Subject: [PATCH 1/1] ALSA: ASoC: Fix wrong param when call
	snd_soc_test_bits
Date: Fri, 26 Sep 2008 22:28:52 +0800
Message-ID: <1222439332-21375-1-git-send-email-linuxzsc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 222052436B
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:28:57 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so375145tid.8
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 07:28:56 -0700 (PDT)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Richard Zhao <linuxzsc@gmail.com>, "Richard Zhao (none)" <richard@richard-laptop.alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Richard Zhao <richard@richard-laptop.(none)>

Fix wrong param when call snd_soc_test_bits in function dapm_mux_update_power.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c016426..9ca9c08 100644
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
1.5.4.3
