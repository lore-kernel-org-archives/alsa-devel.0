From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: ad73311: fix codec name
Date: Sun, 27 Mar 2011 00:44:11 -0400
Message-ID: <1301201053-3841-2-git-send-email-vapier@gentoo.org>
References: <1301201053-3841-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 180691038A6
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 06:43:42 +0200 (CEST)
In-Reply-To: <1301201053-3841-1-git-send-email-vapier@gentoo.org>
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
Cc: device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The codec name should not have a "-codec" suffix since this is not part of
a MFD.  This was incorrectly changed during the multi-component updated.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad73311.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index de799cd..8d793e9 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -55,7 +55,7 @@ static int __devexit ad73311_remove(struct platform_device *pdev)
 
 static struct platform_driver ad73311_codec_driver = {
 	.driver = {
-			.name = "ad73311-codec",
+			.name = "ad73311",
 			.owner = THIS_MODULE,
 	},
 
-- 
1.7.4.1
