From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/17] ASoC: s3c-i2s-v2 diagnostic improvements
Date: Tue, 28 Apr 2009 16:23:32 +0100
Message-ID: <1240932222-3718-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EB1F103895
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:46 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
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

Say what invalid values we're seeing when we see an invalid value and
ensure that errors are displayed by default.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index ab680aa..aeea49c 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -105,7 +105,9 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "TXEN: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "TXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+			break;
 		}
 
 		writel(con, regs + S3C2412_IISCON);
@@ -132,7 +134,9 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "TXDIS: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "TXDIS: Invalid MODE %xin IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+			break;
 		}
 
 		writel(mod, regs + S3C2412_IISMOD);
@@ -175,7 +179,8 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
 		}
 
 		writel(mod, regs + S3C2412_IISMOD);
@@ -199,7 +204,8 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
+			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
 		}
 
 		writel(con, regs + S3C2412_IISCON);
@@ -281,7 +287,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod |= IISMOD_MASTER;
 		break;
 	default:
-		pr_debug("unknwon master/slave format\n");
+		pr_err("unknwon master/slave format\n");
 		return -EINVAL;
 	}
 
@@ -298,7 +304,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod |= S3C2412_IISMOD_SDF_IIS;
 		break;
 	default:
-		pr_debug("Unknown data format\n");
+		pr_err("Unknown data format\n");
 		return -EINVAL;
 	}
 
-- 
1.6.2.4
