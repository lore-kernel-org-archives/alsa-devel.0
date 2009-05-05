From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/18] ASoC: Staticise txctrl and rxctrl for
	S3C IISv2
Date: Tue,  5 May 2009 11:02:22 +0100
Message-ID: <1241517751-2634-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF3C024520
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:35 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They aren't used by anything external and aren't prototyped; if any
users appear they can be exported again for them.

Also report what modes we have a problem with when we encounter invalid
mode configurations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index bc4e504..972c276 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -89,7 +89,7 @@ static inline void dbg_showcon(const char *fn, u32 con)
 
 
 /* Turn on or off the transmission path. */
-void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
+static void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 {
 	void __iomem *regs = i2s->regs;
 	u32 fic, con, mod;
@@ -119,7 +119,9 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "TXEN: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "TXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+			break;
 		}
 
 		writel(con, regs + S3C2412_IISCON);
@@ -146,7 +148,9 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "TXDIS: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "TXDIS: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+			break;
 		}
 
 		writel(mod, regs + S3C2412_IISMOD);
@@ -157,9 +161,8 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 	dbg_showcon(__func__, con);
 	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
 }
-EXPORT_SYMBOL_GPL(s3c2412_snd_txctrl);
 
-void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
+static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 {
 	void __iomem *regs = i2s->regs;
 	u32 fic, con, mod;
@@ -189,7 +192,8 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
 		}
 
 		writel(mod, regs + S3C2412_IISMOD);
@@ -213,7 +217,8 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "RXDIS: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
 		}
 
 		writel(con, regs + S3C2412_IISCON);
@@ -223,7 +228,6 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 	fic = readl(regs + S3C2412_IISFIC);
 	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
 }
-EXPORT_SYMBOL_GPL(s3c2412_snd_rxctrl);
 
 /*
  * Wait for the LR signal to allow synchronisation to the L/R clock
-- 
1.6.2.4
