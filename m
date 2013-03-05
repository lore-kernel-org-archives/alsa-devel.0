From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH] ASoC: cs42l73: If Internal MCLK is >= 6.4MHz,
	then set SCLK to 64*Fs.
Date: Tue, 5 Mar 2013 13:12:56 -0600
Message-ID: <1362510776-14408-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 510C12652C3
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 20:48:37 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, brian.austin@cirrus.com, broonie@opensource.wolfsonmicro.com, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 6361dab..3b20c86 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1180,7 +1180,11 @@ static int cs42l73_pcm_hw_params(struct snd_pcm_substream *substream,
 		priv->config[id].mmcc &= 0xC0;
 		priv->config[id].mmcc |= cs42l73_mclk_coeffs[mclk_coeff].mmcc;
 		priv->config[id].spc &= 0xFC;
-		priv->config[id].spc |= MCK_SCLK_MCLK;
+		/* Use SCLK=64*Fs if internal MCLK >= 6.4MHz */
+		if (priv->mclk >= 6400000)
+			priv->config[id].spc |= MCK_SCLK_64FS;
+		else
+			priv->config[id].spc |= MCK_SCLK_MCLK;
 	} else {
 		/* CS42L73 Slave */
 		priv->config[id].spc &= 0xFC;
-- 
1.7.0.4
