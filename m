From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rcar: fix 'const static' variables
Date: Mon, 13 Jun 2016 17:39:46 +0200
Message-ID: <1465832422-2998958-5-git-send-email-arnd@arndb.de>
References: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When building with 'make W=1', we get a harmless warning about
slightly incorrect prototypes in the rcar audio driver:

sound/soc/sh/rcar/gen.c: In function 'rsnd_gen2_probe':
sound/soc/sh/rcar/gen.c:209:2: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]

This changes the 'const static' to 'static const' as it should be.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sh/rcar/gen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 46c0ba7b6414..7d2fdf8dd188 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -206,7 +206,7 @@ static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
  */
 static int rsnd_gen2_probe(struct rsnd_priv *priv)
 {
-	const static struct rsnd_regmap_field_conf conf_ssiu[] = {
+	static const struct rsnd_regmap_field_conf conf_ssiu[] = {
 		RSND_GEN_S_REG(SSI_MODE0,	0x800),
 		RSND_GEN_S_REG(SSI_MODE1,	0x804),
 		RSND_GEN_S_REG(SSI_MODE2,	0x808),
@@ -221,7 +221,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_INT_ENABLE,	0x18,	0x80),
 	};
 
-	const static struct rsnd_regmap_field_conf conf_scu[] = {
+	static const struct rsnd_regmap_field_conf conf_scu[] = {
 		RSND_GEN_M_REG(SRC_I_BUSIF_MODE,0x0,	0x20),
 		RSND_GEN_M_REG(SRC_O_BUSIF_MODE,0x4,	0x20),
 		RSND_GEN_M_REG(SRC_BUSIF_DALIGN,0x8,	0x20),
@@ -308,7 +308,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(DVC_VOL7R,	0xe44,	0x100),
 		RSND_GEN_M_REG(DVC_DVUER,	0xe48,	0x100),
 	};
-	const static struct rsnd_regmap_field_conf conf_adg[] = {
+	static const struct rsnd_regmap_field_conf conf_adg[] = {
 		RSND_GEN_S_REG(BRRA,		0x00),
 		RSND_GEN_S_REG(BRRB,		0x04),
 		RSND_GEN_S_REG(SSICKR,		0x08),
@@ -328,7 +328,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_S_REG(SRCOUT_TIMSEL4,	0x58),
 		RSND_GEN_S_REG(CMDOUT_TIMSEL,	0x5c),
 	};
-	const static struct rsnd_regmap_field_conf conf_ssi[] = {
+	static const struct rsnd_regmap_field_conf conf_ssi[] = {
 		RSND_GEN_M_REG(SSICR,		0x00,	0x40),
 		RSND_GEN_M_REG(SSISR,		0x04,	0x40),
 		RSND_GEN_M_REG(SSITDR,		0x08,	0x40),
@@ -359,14 +359,14 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 
 static int rsnd_gen1_probe(struct rsnd_priv *priv)
 {
-	const static struct rsnd_regmap_field_conf conf_adg[] = {
+	static const struct rsnd_regmap_field_conf conf_adg[] = {
 		RSND_GEN_S_REG(BRRA,		0x00),
 		RSND_GEN_S_REG(BRRB,		0x04),
 		RSND_GEN_S_REG(SSICKR,		0x08),
 		RSND_GEN_S_REG(AUDIO_CLK_SEL0,	0x0c),
 		RSND_GEN_S_REG(AUDIO_CLK_SEL1,	0x10),
 	};
-	const static struct rsnd_regmap_field_conf conf_ssi[] = {
+	static const struct rsnd_regmap_field_conf conf_ssi[] = {
 		RSND_GEN_M_REG(SSICR,		0x00,	0x40),
 		RSND_GEN_M_REG(SSISR,		0x04,	0x40),
 		RSND_GEN_M_REG(SSITDR,		0x08,	0x40),
-- 
2.7.0
