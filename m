From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Don't mark the outputs of supplies
	as dirty on state changes
Date: Tue,  4 Oct 2011 23:01:24 +0100
Message-ID: <1317765685-8683-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317765685-8683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C5171038B7
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 00:01:30 +0200 (CEST)
In-Reply-To: <1317765685-8683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The whole point of supply widgets is that they aren't inputs to their
sinks so a state change in a supply should never affect the state of the
widget being supplied and we don't need to mark them as dirty.

           Power    Path   Neighbour
Before:    69       727    905
After:     63       607    731

This is particularly useful where supplies affect large portions of the
chip (eg, a bandgap supplying the analogue sections).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c39146d..cbca1dd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1260,11 +1260,18 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 						   path->connect);
 		}
 	}
-	list_for_each_entry(path, &w->sinks, list_source) {
-		if (path->sink) {
-			dapm_widget_set_peer_power(path->sink, power,
-						   path->connect);
+	switch (w->id) {
+	case snd_soc_dapm_supply:
+		/* Supplies can't affect their outputs, only their inputs */
+		break;
+	default:
+		list_for_each_entry(path, &w->sinks, list_source) {
+			if (path->sink) {
+				dapm_widget_set_peer_power(path->sink, power,
+							   path->connect);
+			}
 		}
+		break;
 	}
 
 	if (power)
-- 
1.7.6.3
