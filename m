From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 05/13] ASoC: kirkwood: provide KIRKWOOD_PLAYCTL_ENABLE_MASK
Date: Sun, 04 Aug 2013 20:26:03 +0100
Message-ID: <E1V63wJ-0004lV-FZ@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Provide a helper macro which includes the sum of all enable bits in
the playback control register.  This simplifies the code a little.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   10 ++++------
 sound/soc/kirkwood/kirkwood.h     |    5 ++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index ee27981..f39e57c 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -199,8 +199,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 			ctl_play |= KIRKWOOD_PLAYCTL_MONO_OFF;
 
 		priv->ctl_play &= ~(KIRKWOOD_PLAYCTL_MONO_MASK |
-				    KIRKWOOD_PLAYCTL_I2S_EN |
-				    KIRKWOOD_PLAYCTL_SPDIF_EN |
+				    KIRKWOOD_PLAYCTL_ENABLE_MASK |
 				    KIRKWOOD_PLAYCTL_SIZE_MASK);
 		priv->ctl_play |= ctl_play;
 	} else {
@@ -244,8 +243,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
 		ctl = priv->ctl_play;
-		value = ctl & ~(KIRKWOOD_PLAYCTL_I2S_EN |
-				KIRKWOOD_PLAYCTL_SPDIF_EN);
+		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
 		/* enable interrupts */
@@ -267,7 +265,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
 		/* disable all playbacks */
-		ctl &= ~(KIRKWOOD_PLAYCTL_I2S_EN | KIRKWOOD_PLAYCTL_SPDIF_EN);
+		ctl &= ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
@@ -387,7 +385,7 @@ static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 
 	/* disable playback/record */
 	value = readl(priv->io + KIRKWOOD_PLAYCTL);
-	value &= ~(KIRKWOOD_PLAYCTL_I2S_EN|KIRKWOOD_PLAYCTL_SPDIF_EN);
+	value &= ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 	writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
 	value = readl(priv->io + KIRKWOOD_RECCTL);
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 10a3aaa..9a50607 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -54,7 +54,7 @@
 #define KIRKWOOD_PLAYCTL_MONO_OFF		(0<<5)
 #define KIRKWOOD_PLAYCTL_I2S_MUTE		(1<<7)
 #define KIRKWOOD_PLAYCTL_SPDIF_EN		(1<<4)
-#define KIRKWOOD_PLAYCTL_I2S_EN		(1<<3)
+#define KIRKWOOD_PLAYCTL_I2S_EN			(1<<3)
 #define KIRKWOOD_PLAYCTL_SIZE_MASK		(7<<0)
 #define KIRKWOOD_PLAYCTL_SIZE_16		(7<<0)
 #define KIRKWOOD_PLAYCTL_SIZE_16_C		(3<<0)
@@ -62,6 +62,9 @@
 #define KIRKWOOD_PLAYCTL_SIZE_24		(1<<0)
 #define KIRKWOOD_PLAYCTL_SIZE_32		(0<<0)
 
+#define KIRKWOOD_PLAYCTL_ENABLE_MASK		(KIRKWOOD_PLAYCTL_SPDIF_EN | \
+						 KIRKWOOD_PLAYCTL_I2S_EN)
+
 #define KIRKWOOD_PLAY_BUF_ADDR			0x1104
 #define KIRKWOOD_PLAY_BUF_SIZE			0x1108
 #define KIRKWOOD_PLAY_BYTE_COUNT		0x110C
-- 
1.7.4.4
