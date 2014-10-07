From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ASoC: eukrea-tlv320: Fix of_node_put()
	call with uninitialized object
Date: Tue,  7 Oct 2014 18:19:52 +0200
Message-ID: <1412698794-25536-3-git-send-email-tiwai@suse.de>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA88260594
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 18:20:15 +0200 (CEST)
In-Reply-To: <1412698794-25536-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The of_node_put() call in eukrea_tlv320_probe() may take an
uninitialized pointer, as compiler spotted out:
  sound/soc/codecs/mc13783.c:787:13: warning: 'np' may be used uninitialized in this function [-Wuninitialized]

This patch adds the proper NULL initialization as a fix.

Fixes: 66f232908de2 ('ASoC: eukrea-tlv320: Add DT support')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/fsl/eukrea-tlv320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index eb093d5b85c4..d53b002595b6 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -105,7 +105,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 	int ret;
 	int int_port = 0, ext_port;
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *ssi_np, *codec_np;
+	struct device_node *ssi_np = NULL, *codec_np;
 
 	eukrea_tlv320.dev = &pdev->dev;
 	if (np) {
-- 
2.1.2
