From: Richard Zhao <linuxzsc@gmail.com>
Subject: [PATCH 1/1] ALSA: ASoC: add new param mux to
	dapm_mux_update_power
Date: Tue,  7 Oct 2008 08:05:20 +0800
Message-ID: <1223337920-8225-1-git-send-email-linuxzsc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 1658C1037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 02:05:38 +0200 (CEST)
Received: by gxk10 with SMTP id 10so6248289gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2008 17:05:25 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk, Richard Zhao <linuxzsc@gmail.com>
List-Id: alsa-devel@alsa-project.org

Function dapm_mux_update_power needs enum index mux and register mask value val
as parameters, but it only has a parameter val, and uses it as both val and mux.
snd_soc_test_bits(widget->codec, e->reg, mask, val) val is register mask here,
e->texts[val] but val should be enum index mux here.

This patch adds a new param mux to fix it.

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
