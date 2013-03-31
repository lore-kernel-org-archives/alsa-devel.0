From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Remove redundant clear_walk() for
	supply widgets
Date: Sun, 31 Mar 2013 23:37:47 +0100
Message-ID: <1364769467-17146-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A707E26157F
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 00:37:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ryo Tsutsui <Ryo.Tsutsui@wolfosonmicro.com>, Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>

We already clear the walked state in dapm_widget_power_check(), no need
to do it again.

Signed-off-by: Ryo Tsutsui <Ryo.Tsutsui@wolfosonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1896a70..0a395eb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1179,8 +1179,6 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 			return 1;
 	}
 
-	dapm_clear_walk(w->dapm);
-
 	return 0;
 }
 
-- 
1.7.10.4
