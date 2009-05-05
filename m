From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/18] ASoC: Display S3C IISv2 mode and MS
	errors by default
Date: Tue,  5 May 2009 11:02:21 +0100
Message-ID: <1241517751-2634-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D58402451F
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index ad690b2..bc4e504 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -295,7 +295,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod |= IISMOD_MASTER;
 		break;
 	default:
-		pr_debug("unknwon master/slave format\n");
+		pr_err("unknwon master/slave format\n");
 		return -EINVAL;
 	}
 
@@ -312,7 +312,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod |= S3C2412_IISMOD_SDF_IIS;
 		break;
 	default:
-		pr_debug("Unknown data format\n");
+		pr_err("Unknown data format\n");
 		return -EINVAL;
 	}
 
-- 
1.6.2.4
