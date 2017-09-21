From: Stuart Henderson <stuarth@opensource.cirrus.com>
Subject: [PATCH] ASoC: dapm: Make snd_soc_dapm_add/del_routes
	use runtime mutex subclass
Date: Thu, 21 Sep 2017 11:02:12 +0100
Message-ID: <1505988132-9511-1-git-send-email-stuarth@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 631602675AC
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 12:02:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

Make snd_soc_dapm_add_routes and snd_soc_dapm_del_routes use the
SND_SOC_DAPM_CLASS_RUNTIME dapm subclass to allow dynamic dapm route
updates.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a..e6b6011 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2884,7 +2884,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 {
 	int i, r, ret = 0;
 
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	for (i = 0; i < num; i++) {
 		r = snd_soc_dapm_add_route(dapm, route);
 		if (r < 0) {
@@ -2915,7 +2915,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 {
 	int i;
 
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	for (i = 0; i < num; i++) {
 		snd_soc_dapm_del_route(dapm, route);
 		route++;
-- 
2.1.4
