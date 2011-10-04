From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Stop checking for supplied widgets
	after we find the first
Date: Tue,  4 Oct 2011 23:01:25 +0100
Message-ID: <1317765685-8683-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317765685-8683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CF841038DD
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

We don't really care how many widgets a supply is supplying, we just care
if the number is non-zero. This didn't actually produce any improvement
in the test cases I've been using but seems obviously sensible enough that
I'm pushing it out anyway.

We could do a similar thing for other widgets but this may be unhelpful
for further refactorings Liam was working on aiming to allow us to
identify connected audio paths.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cbca1dd..82d93bf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -851,7 +851,6 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *path;
-	int power = 0;
 
 	DAPM_UPDATE_STAT(w, power_checks);
 
@@ -869,15 +868,13 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 		if (!path->sink)
 			continue;
 
-		if (dapm_widget_power_check(path->sink)) {
-			power = 1;
-			break;
-		}
+		if (dapm_widget_power_check(path->sink))
+			return 1;
 	}
 
 	dapm_clear_walk(w->dapm);
 
-	return power;
+	return 0;
 }
 
 static int dapm_always_on_check_power(struct snd_soc_dapm_widget *w)
-- 
1.7.6.3
