From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: dapm: Avoid duplicating immutable
	strings
Date: Tue, 21 Jul 2015 18:11:08 +0200
Message-ID: <1437495068-4104-2-git-send-email-lars@metafoo.de>
References: <1437495068-4104-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-101.synserver.de
 [212.40.185.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 48EAE260575
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 18:11:12 +0200 (CEST)
In-Reply-To: <1437495068-4104-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

When creating a new widget from a template the name string of the template
is duplicated for the newly created widget. This is necessary because in
some cases the string might be stored on the stack or other volatile
memory locations.

But most of the time the string is static const data, which means it is
possible to use it directly without having to worry that it might get freed
or changed.

Use kstrdup_const() to handle duplicating the string. This function is
capable of detecting whether a string is immutable and if it is returns the
input without duplicating it. This will slightly reduce the runtime memory
footprint of DAPM and also speed up initialization.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7a57b01..7f834a0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2332,7 +2332,7 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 		dapm_free_path(p);
 
 	kfree(w->kcontrols);
-	kfree(w->name);
+	kfree_const(w->name);
 	kfree(w);
 }
 
@@ -3353,7 +3353,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	if (prefix)
 		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
 	else
-		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
+		w->name = kstrdup_const(widget->name, GFP_KERNEL);
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
-- 
2.1.4
