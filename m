From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] es968: fix wrong PnP dma index
Date: Sun, 25 Apr 2010 13:12:45 +0200
Message-ID: <20100425131245.a2a98727.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpo.poczta.interia.pl (smtpo.poczta.interia.pl
	[217.74.65.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FB041037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Apr 2010 13:12:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

There is only one dma for the ESS ES968 based board.
Its index is 0 and not 1.

This make the es968 card working.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/sb/es968.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/isa/sb/es968.c b/sound/isa/sb/es968.c
index cafc3a7..ff18286 100644
--- a/sound/isa/sb/es968.c
+++ b/sound/isa/sb/es968.c
@@ -93,7 +93,7 @@ static int __devinit snd_card_es968_pnp(int dev, struct snd_card_es968 *acard,
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
-	dma8[dev] = pnp_dma(pdev, 1);
+	dma8[dev] = pnp_dma(pdev, 0);
 	irq[dev] = pnp_irq(pdev, 0);
 
 	return 0;
-- 
1.6.4
