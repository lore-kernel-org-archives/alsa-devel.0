From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] ASoC: rsnd: ssiu: correct shift bit for ssiu9
Date: Mon, 4 Feb 2019 22:41:05 +0900
Message-ID: <20190204134105.15243-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: jiada_wang@mentor.com, twischer@de.adit-jv.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently "0xf << 36" is used to
clear SSIU-9 internal buffer state, which overflows 32-bit value
according to user reference manual, it is always bit4 ~ bit7
of SSI_SYS_STATUS[1,3,5,7] registers indicate
SSIU-9's buffer state, so "0xf << 4" should be used.

This patch fix incorrect shifting issue in SSIU-9 case

Fixes: commit b7169ddea2f2 ("ASoC: rsnd: remove RSND_REG_ from rsnd_reg")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 2f3085a54eba..b11677489a5e 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -79,7 +79,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		break;
 	case 9:
 		for (i = 0; i < 4; i++)
-			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << (id * 4));
+			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << 4);
 		break;
 	}
 
-- 
2.19.2
