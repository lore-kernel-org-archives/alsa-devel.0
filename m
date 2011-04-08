From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow DAPM pin operations to match any
	context
Date: Fri,  8 Apr 2011 09:46:00 +0900
Message-ID: <1302223560-27371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B48F24362
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 02:45:53 +0200 (CEST)
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
index 14dbba7..5fe750c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1477,6 +1477,19 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
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
@@ -2332,6 +2345,17 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
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
