From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ASoC: Remove DAPM restriction on mixer
	control name lengths
Date: Thu, 30 Oct 2008 15:58:25 +0000
Message-ID: <1225382309-1827-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030155718.GA1418@rakim.wolfsonmicro.main>
	<1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDB4A24490
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:58:31 +0100 (CET)
In-Reply-To: <1225382309-1827-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

As well as ensuring that UI-relevant parts of control names don't get
truncated in the DAPM code this avoids conflicts in long control names
that differ only at the end of a long string.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b51d822..407092c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -289,7 +289,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
-	char name[32];
+	size_t name_len;
 	struct snd_soc_dapm_path *path;
 
 	/* add kcontrol */
@@ -303,11 +303,16 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 				continue;
 
 			/* add dapm control with long name */
-			snprintf(name, 32, "%s %s", w->name, w->kcontrols[i].name);
-			path->long_name = kstrdup (name, GFP_KERNEL);
+			name_len = 2 + strlen(w->name)
+				+ strlen(w->kcontrols[i].name);
+			path->long_name = kmalloc(name_len, GFP_KERNEL);
 			if (path->long_name == NULL)
 				return -ENOMEM;
 
+			snprintf(path->long_name, name_len, "%s %s",
+				 w->name, w->kcontrols[i].name);
+			path->long_name[name_len - 1] = '\0';
+
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
 				path->long_name);
 			ret = snd_ctl_add(codec->card, path->kcontrol);
-- 
1.5.6.5
