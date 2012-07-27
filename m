From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for
	LINE_IN
Date: Fri, 27 Jul 2012 19:18:42 +0800
Message-ID: <1343387922-25227-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E1B264F2A
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 13:31:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

From: Dong Aisheng <dong.aisheng@linaro.org>

LINE_IN also needs VAG_POWER on or we may hear noise when directly
route LINE_IN to Headphone Mux.
Tested on imx28evk.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5c54b6f..df2f99d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -239,6 +239,7 @@ static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"Headphone Mux", "DAC", "DAC"},	/* dac --> hp_mux */
 	{"LO", NULL, "DAC"},			/* dac --> line_out */
 
+	{"LINE_IN", NULL, "VAG_POWER"},
 	{"Headphone Mux", "LINE_IN", "LINE_IN"},/* line_in --> hp_mux */
 	{"HP", NULL, "Headphone Mux"},		/* hp_mux --> hp */
 
-- 
1.7.0.4
