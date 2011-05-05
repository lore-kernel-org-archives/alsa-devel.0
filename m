From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/12] ASoC: SSM2602: Fix reg_cache_size
Date: Thu,  5 May 2011 16:59:14 +0200
Message-ID: <1304607560-15083-6-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id C2E99103A0A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:45 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

reg_cache_size is supposed to be the number of elements in the register cache,
not the size in bytes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 6444d34..40d3474 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -545,7 +545,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.suspend =	ssm2602_suspend,
 	.resume =	ssm2602_resume,
 	.set_bias_level = ssm2602_set_bias_level,
-	.reg_cache_size = sizeof(ssm2602_reg),
+	.reg_cache_size = ARRAY_SIZE(ssm2602_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = ssm2602_reg,
 };
-- 
1.7.2.5
