From: Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] ASoC: dapm: don't skip evaluate the power of
	widget with force set
Date: Sun, 13 Apr 2014 16:37:20 +0800
Message-ID: <1397378240-20821-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mxmail.xiaomi.com (mx1.mxmail.xiaomi.com [58.68.235.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 8279F2616C9
 for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2014 10:37:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, bardliao@realtek.com
Cc: alsa-devel@alsa-project.org, xiaoxiang@xiaomi.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c8a780d..14af77e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1673,7 +1673,7 @@ static void dapm_widget_set_peer_power(struct snd_soc_dapm_widget *peer,
 
 	/* If the peer is already in the state we're moving to then we
 	 * won't have an impact on it. */
-	if (power != peer->power)
+	if (peer->force || power != peer->power)
 		dapm_mark_dirty(peer, "peer state change");
 }
 
@@ -1683,7 +1683,7 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 {
 	struct snd_soc_dapm_path *path;
 
-	if (w->power == power)
+	if (!w->force && w->power == power)
 		return;
 
 	trace_snd_soc_dapm_widget_power(w, power);
-- 
1.8.1.2
