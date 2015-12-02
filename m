From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Make enable/disable_pin work with
	always on widgets
Date: Wed, 2 Dec 2015 10:22:16 +0000
Message-ID: <1449051736-26338-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C24261566
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 11:22:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Always on widgets currently have some odd interactions with DAPM.
Enabling/disabling a widget (snd_soc_dapm_enable_pin) then connecting
it to a path works as expected, ie. when the widget is disabled the
path doesn't power up and it does when the widget is enabled. However
once in a path enabling the widget does not cause anything to power
up, dapm_widget_set_power will return the current power state of the
widget as 1, meaning we never check peer power states.

This patch updates dapm_always_on_check_power to return w->connected
such that it is effected by snd_soc_dapm_enable_pin and the like.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a8156b5..5a2812f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1300,7 +1300,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 
 static int dapm_always_on_check_power(struct snd_soc_dapm_widget *w)
 {
-	return 1;
+	return w->connected;
 }
 
 static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
-- 
2.1.4
