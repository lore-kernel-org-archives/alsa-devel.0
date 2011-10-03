From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Mark mixer and mux neighbours as dirty
	when changing them
Date: Mon,  3 Oct 2011 22:02:21 +0100
Message-ID: <1317675741-28236-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317673938-11716-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3719103855
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 23:02:24 +0200 (CEST)
In-Reply-To: <1317673938-11716-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 50517d8..06d8cfa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1608,10 +1608,14 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux])))
+		if (!(strcmp(path->name, e->texts[mux]))) {
 			path->connect = 1; /* new connection */
-		else
+			dapm_mark_dirty(path->source);
+		} else {
+			if (path->connect)
+				dapm_mark_dirty(path->source);
 			path->connect = 0; /* old connection must be powered down */
+		}
 	}
 
 	if (found) {
@@ -1642,6 +1646,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		/* found, now check type */
 		found = 1;
 		path->connect = connect;
+		dapm_mark_dirty(path->source);
 	}
 
 	if (found) {
-- 
1.7.6.3
