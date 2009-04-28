From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/17] ASoC: Use our registration function for
	S3C64xx
Date: Tue, 28 Apr 2009 16:23:33 +0100
Message-ID: <1240932222-3718-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1FF210388D
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:45 +0200 (CEST)
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

Make sure we get the DAI operations initialised.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   18 ++++++------------
 sound/soc/s3c24xx/s3c64xx-i2s.c |    2 +-
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index aeea49c..ab680aa 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -105,9 +105,7 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "TXEN: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
-			break;
+			dev_err(i2s->dev, "TXEN: Invalid MODE in IISMOD\n");
 		}
 
 		writel(con, regs + S3C2412_IISCON);
@@ -134,9 +132,7 @@ void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "TXDIS: Invalid MODE %xin IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
-			break;
+			dev_err(i2s->dev, "TXDIS: Invalid MODE in IISMOD\n");
 		}
 
 		writel(mod, regs + S3C2412_IISMOD);
@@ -179,8 +175,7 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
+			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
 		}
 
 		writel(mod, regs + S3C2412_IISMOD);
@@ -204,8 +199,7 @@ void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
 			break;
 
 		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
+			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
 		}
 
 		writel(con, regs + S3C2412_IISCON);
@@ -287,7 +281,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod |= IISMOD_MASTER;
 		break;
 	default:
-		pr_err("unknwon master/slave format\n");
+		pr_debug("unknwon master/slave format\n");
 		return -EINVAL;
 	}
 
@@ -304,7 +298,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod |= S3C2412_IISMOD_SDF_IIS;
 		break;
 	default:
-		pr_err("Unknown data format\n");
+		pr_debug("Unknown data format\n");
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index c335248..1345fbd 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -225,7 +225,7 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	ret = snd_soc_register_dai(dai);
+	ret = s3c_i2sv2_register_dai(dai);
 	if (ret != 0)
 		goto err_i2sv2;
 
-- 
1.6.2.4
