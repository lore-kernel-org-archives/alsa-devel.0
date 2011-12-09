From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] ASoC: Fix an obvious copy paste error in an error message
Date: Fri,  9 Dec 2011 14:16:29 +0100
Message-ID: <1323436589-28168-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

The message was obviously copied from soc_init_codec_debugfs()

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5d3685..9548881 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -412,7 +412,7 @@ static void soc_init_card_debugfs(struct snd_soc_ca=
rd *card)
 						     snd_soc_debugfs_root);
 	if (!card->debugfs_card_root) {
 		dev_warn(card->dev,
-			 "ASoC: Failed to create codec debugfs directory\n");
+			 "ASoC: Failed to create card debugfs directory\n");
 		return;
 	}
=20
--=20
1.5.6.5
