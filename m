From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Don't add prefix to widget stream
	name
Date: Tue, 21 Jul 2015 11:51:35 +0200
Message-ID: <1437472295-5524-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-100.synserver.de (smtp-out-100.synserver.de
 [212.40.185.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DFAFA26047B
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 11:51:39 +0200 (CEST)
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
Cc: Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Commit fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to
prefix") fixed the case where a DAPM route between a DAI widget and a
DAC/ADC/AIF widget with a matching stream name was not created when the
DAPM context was using a prefix.

Unfortunately the patch introduced a few issues on its own like leaking the
dynamically allocated stream name memory and also not checking whether the
allocation succeeded in the first place.

It is also incomplete in that it still does not handle the case where
stream name of the widget is a substring of the stream name of the DAI,
which is explicitly allowed and works fine if no DAPM prefix is used.

Revert the commit and take a slightly different approach to solving the
issue. Instead of comparing the widget's stream name to the name of the DAI
widget compare it to the stream name of the DAI widget. The stream name of
the DAI widget is identical to the name of the DAI widget except that it
wont have the DAPM prefix added. So this approach behaves identical
regardless to whether the DAPM context uses a prefix or not.

We don't have to worry about potentially matching with a widget with the
same stream name, but from a different DAPM context with a different
prefix, since the code already makes sure that both the DAI widget and the
matched widget are from the same DAPM context.

Fixes: fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to prefix")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1628f0c..1992568 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3344,16 +3344,10 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	}
 
 	prefix = soc_dapm_prefix(dapm);
-	if (prefix) {
+	if (prefix)
 		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
-		if (widget->sname)
-			w->sname = kasprintf(GFP_KERNEL, "%s %s", prefix,
-					     widget->sname);
-	} else {
+	else
 		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
-		if (widget->sname)
-			w->sname = kasprintf(GFP_KERNEL, "%s", widget->sname);
-	}
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
@@ -3802,7 +3796,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 				break;
 			}
 
-			if (!w->sname || !strstr(w->sname, dai_w->name))
+			if (!w->sname || !strstr(w->sname, dai_w->sname))
 				continue;
 
 			if (dai_w->id == snd_soc_dapm_dai_in) {
-- 
2.1.4
