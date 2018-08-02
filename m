From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/4] ALSA: galaxy: Mark expected switch fall-throughs
Date: Thu, 2 Aug 2018 15:40:37 -0500
Message-ID: <a7d1e7067504056852483ee5d91f8788322d3c10.1533242152.git.gustavo@embeddedor.com>
References: <cover.1533242152.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533242152.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1468367 ("Missing break in switch")
Addresses-Coverity-ID: 115037 ("Missing break in switch")
Addresses-Coverity-ID: 115038 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/galaxy/galaxy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index b9994cc..af9eea4 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -260,6 +260,7 @@ static int snd_galaxy_match(struct device *dev, unsigned int n)
 		break;
 	case 2:
 		irq[n] = 9;
+		/* Fall through */
 	case 9:
 		wss_config[n] |= WSS_CONFIG_IRQ_9;
 		break;
@@ -304,6 +305,7 @@ static int snd_galaxy_match(struct device *dev, unsigned int n)
 	case 1:
 		if (dma1[n] == 0)
 			break;
+		/* Fall through */
 	default:
 		dev_err(dev, "invalid capture DMA %d\n", dma2[n]);
 		return 0;
@@ -333,6 +335,7 @@ static int snd_galaxy_match(struct device *dev, unsigned int n)
 		break;
 	case 2:
 		mpu_irq[n] = 9;
+		/* Fall through */
 	case 9:
 		config[n] |= GALAXY_CONFIG_MPUIRQ_2;
 		break;
-- 
2.7.4
