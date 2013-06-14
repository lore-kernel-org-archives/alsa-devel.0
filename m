From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: dapm: Setup private_free callback
	for dapm kcontrols
Date: Fri, 14 Jun 2013 13:16:51 +0200
Message-ID: <1371208614-18697-2-git-send-email-lars@metafoo.de>
References: <1371208614-18697-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-121.synserver.de (smtp-out-121.synserver.de
 [212.40.185.121])
 by alsa0.perex.cz (Postfix) with ESMTP id B4E00261AA0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:16:51 +0200 (CEST)
In-Reply-To: <1371208614-18697-1-git-send-email-lars@metafoo.de>
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

The private data containing the widget list that is a assigned to a DAPM
kcontrol is never freed. Setup the private_free for DAPM kcontrols to take care
of this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 10290c7..f81d942 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -509,6 +509,11 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
 	return 0;
 }
 
+static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
+{
+	kfree(kctl->private_data);
+}
+
 /*
  * Determine if a kcontrol is shared. If it is, look it up. If it isn't,
  * create it. Either way, add the widget into the control's widget list
@@ -615,6 +620,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], wlist, name,
 					prefix);
+		kcontrol->private_free = dapm_kcontrol_free;
 		ret = snd_ctl_add(card, kcontrol);
 		if (ret < 0) {
 			dev_err(dapm->dev,
-- 
1.8.0
