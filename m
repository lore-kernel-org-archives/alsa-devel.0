From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8810: change the target of MIC
	BIAS supply
Date: Thu, 3 May 2018 10:46:42 +0800
Message-ID: <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D58D266C1C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 04:46:50 +0200 (CEST)
In-Reply-To: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The MICBAIS will not supply if there is only one path from MICP to
input boost stage. The driver fixes the issue by changing the supply
target to input boost stage mixer.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index bfd74b8..988bd18 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -468,9 +468,9 @@ static const struct snd_soc_dapm_route nau8810_dapm_routes[] = {
 	{"ADC", NULL, "PLL", check_mclk_select_pll},
 	{"Input Boost Stage", "PGA Mute Switch", "Input PGA"},
 	{"Input Boost Stage", "PMIC PGA Switch", "MICP"},
+	{"Input Boost Stage", NULL, "Mic Bias"},
 
 	/* Input PGA */
-	{"Input PGA", NULL, "Mic Bias"},
 	{"Input PGA", "MicN Switch", "MICN"},
 	{"Input PGA", "MicP Switch", "MICP"},
 
-- 
2.6.4
