From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/2] ASoC: AD1980/AD73311: make sure to set dev
	member
Date: Tue,  6 Oct 2009 01:51:50 -0400
Message-ID: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 54389245A5
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 07:52:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The codec driver should initialize snd_soc_codec's dev member to the
appropriate device when setting up the device, but these codecs weren't.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1980.c  |    1 +
 sound/soc/codecs/ad73311.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index d7440a9..0477a91 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -203,6 +203,7 @@ static int ad1980_soc_probe(struct platform_device *pdev)
 	codec->reg_cache_size = sizeof(u16) * ARRAY_SIZE(ad1980_reg);
 	codec->reg_cache_step = 2;
 	codec->name = "AD1980";
+	codec->dev = &pdev->dev;
 	codec->owner = THIS_MODULE;
 	codec->dai = &ad1980_dai;
 	codec->num_dai = 1;
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index e61dac5..6e18149 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -50,6 +50,7 @@ static int ad73311_soc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	mutex_init(&codec->mutex);
 	codec->name = "AD73311";
+	codec->dev = &pdev->dev;
 	codec->owner = THIS_MODULE;
 	codec->dai = &ad73311_dai;
 	codec->num_dai = 1;
-- 
1.6.5.rc2
