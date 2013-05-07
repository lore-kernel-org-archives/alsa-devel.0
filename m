From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: sgtl5000: Mark CHIP_ANA_POWER as volatile
Date: Tue, 7 May 2013 17:20:12 -0300
Message-ID: <1367958018-4827-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id AEAD926510C
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 22:20:43 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Register CHIP_ANA_POWER (address: 0x0030) contains all of the power down 
controls for the analog blocks.

Mark it as a volatile register, so that sgtl5000 can be functional after a
reset.

Without this patch the following error happens after a audio playback followed
by a reset:

sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
sgtl5000 0-000a: ASoC: failed to probe CODEC -19
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 327b443..8b704ff 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -965,6 +965,7 @@ static bool sgtl5000_volatile(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case SGTL5000_CHIP_ID:
 	case SGTL5000_CHIP_ADCDAC_CTRL:
+	case SGTL5000_CHIP_ANA_POWER:
 	case SGTL5000_CHIP_ANA_STATUS:
 		return true;
 	}
-- 
1.7.9.5
