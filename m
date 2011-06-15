From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/5] ASoC: AD1836: fix codec name
Date: Wed, 15 Jun 2011 15:29:21 -0400
Message-ID: <1308166163-22355-4-git-send-email-vapier@gentoo.org>
References: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id EC1F510382F
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 21:29:00 +0200 (CEST)
In-Reply-To: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The codec name should not have a "-codec" suffix since this is not part of
a MFD.  This was incorrectly changed during the multi-component updated.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 7d6aae8..fc14668 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -384,7 +384,7 @@ MODULE_DEVICE_TABLE(spi, ad1836_ids);
 
 static struct spi_driver ad1836_spi_driver = {
 	.driver = {
-		.name	= "ad1836-codec",
+		.name	= "ad1836",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad1836_spi_probe,
-- 
1.7.5.3
