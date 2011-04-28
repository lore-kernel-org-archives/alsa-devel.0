From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/4] ASoC: Add w->kcontrols, and populate it
Date: Thu, 28 Apr 2011 17:37:59 -0600
Message-ID: <1304033881-1160-3-git-send-email-swarren@nvidia.com>
References: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 0768F1039E1
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 01:38:13 +0200 (CEST)
In-Reply-To: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Future changes will need reference to the kcontrol created for a given
kcontrol_new. Store the created kcontrol values now.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-dapm.c     |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3733e4d..8c4b90b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -473,6 +473,7 @@ struct snd_soc_dapm_widget {
 	/* kcontrols that relate to this widget */
 	int num_kcontrols;
 	const struct snd_kcontrol_new *kcontrol_news;
+	struct snd_kcontrol **kcontrols;
 
 	/* widget input and outputs */
 	struct list_head sources;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 401bb0f..24d19a0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -400,6 +400,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 				path->long_name = NULL;
 				return ret;
 			}
+			w->kcontrols[i] = path->kcontrol;
 		}
 	}
 	return ret;
@@ -442,6 +443,8 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	if (ret < 0)
 		goto err;
 
+	w->kcontrols[0] = kcontrol;
+
 	list_for_each_entry(path, &w->sources, list_sink)
 		path->kcontrol = kcontrol;
 
@@ -1455,6 +1458,7 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 			kfree(p->long_name);
 			kfree(p);
 		}
+		kfree(w->kcontrols);
 		kfree(w->name);
 		kfree(w);
 	}
@@ -1705,6 +1709,14 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		if (w->new)
 			continue;
 
+		if (w->num_kcontrols) {
+			w->kcontrols = kzalloc(w->num_kcontrols *
+						sizeof(struct snd_kcontrol *),
+						GFP_KERNEL);
+			if (!w->kcontrols)
+				return -ENOMEM;
+		}
+
 		switch(w->id) {
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
-- 
1.7.0.4
