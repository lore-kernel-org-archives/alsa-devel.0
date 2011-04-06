From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow DAPM pin operations to match any
	context
Date: Wed,  6 Apr 2011 11:38:53 +0900
Message-ID: <1302057533-2295-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18EE7103800
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 16:01:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DAPM pin operations currently require that the specific DAPM context
that the pin being operated in is contained in be specified. With multi
component and especially with the addition of a per-card DAPM context
this isn't ideal as it means that things like disabling unused pins on
CODECs require looking up the CODEC DAPM context.

Fix this by falling back to matching a widget in any context if there isn't
a match in the current context. The code isn't ideal currently but will do
the job.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 790ffa9..f651a71 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1478,6 +1478,19 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 		}
 	}
 
+	/* Try again in other contexts */
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (!strcmp(w->name, pin)) {
+			dev_dbg(w->dapm->dev, "dapm: pin %s = %d\n",
+				pin, status);
+			w->connected = status;
+			/* Allow disabling of forced pins */
+			if (status == 0)
+				w->force = 0;
+			return 0;
+		}
+	}
+
 	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
 	return -EINVAL;
 }
@@ -2333,6 +2346,17 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 		}
 	}
 
+	/* Try again with other contexts */
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (!strcmp(w->name, pin)) {
+			dev_dbg(w->dapm->dev,
+				"dapm: force enable pin %s\n", pin);
+			w->connected = 1;
+			w->force = 1;
+			return 0;
+		}
+	}
+
 	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
 	return -EINVAL;
 }
-- 
1.7.4.1
