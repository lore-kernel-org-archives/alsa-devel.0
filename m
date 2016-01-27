From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH] ASoC: pxa: pxa-ssp.c: indent with TABs,
	not spaces
Date: Wed, 27 Jan 2016 13:31:37 +0100
Message-ID: <1453897897-27018-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 9947826044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 13:31:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Antonio Ospite <ao2@ao2.it>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index da03fad..3caace4 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -586,7 +586,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-	       sspsp = pxa_ssp_read_reg(ssp, SSPSP);
+		sspsp = pxa_ssp_read_reg(ssp, SSPSP);
 
 		if ((pxa_ssp_get_scr(ssp) == 4) && (width == 16)) {
 			/* This is a special case where the bitclk is 64fs
-- 
2.7.0
