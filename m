From: Zhiwei Jiang <qq282012236@gmail.com>
Subject: [PATCH] ASoC: dapm: Add warnings for widget overwrite when adding route
Date: Thu, 31 Jan 2019 19:30:05 +0800
Message-ID: <20190131113005.13380-1-qq282012236@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: qq282012236@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently, in some complex cases, more than one widgets have same
name and registed from differnt dapm context, and route add from
another context too. When snd_soc_dapm_add_route, the previous
registered widget will overwritten by the latest same name widget,
will cause unexpect error. For Asoc framework we cant avoid this
situation and we cant decide which widget that wanted with route.
At least we can give users a notice.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
---
 sound/soc/soc-dapm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..af45ffcf712d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2741,6 +2741,8 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	char prefixed_sink[80];
 	char prefixed_source[80];
 	const char *prefix;
+	unsigned int sink_ref = 0;
+	unsigned int source_ref = 0;
 	int ret;
 
 	prefix = soc_dapm_prefix(dapm);
@@ -2774,6 +2776,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsource)
 					break;
 			}
+			sink_ref++;
+			if (sink_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: sink widget %s overwritten\n",
+					w->name);
 			continue;
 		}
 		if (!wsource && !(strcmp(w->name, source))) {
@@ -2783,6 +2790,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsink)
 					break;
 			}
+			source_ref++;
+			if (source_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: source widget %s overwritten\n",
+					w->name);
 		}
 	}
 	/* use widget from another DAPM context if not found from this */
-- 
2.19.0
