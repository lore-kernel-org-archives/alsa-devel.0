From: Timur Tabi <timur@freescale.com>
Subject: [ALSA] fix private data pointer calculation in CS4270
	driver
Date: Tue, 13 Nov 2007 17:23:36 -0600
Message-ID: <11949962161100-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 0139E2467B
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 00:25:35 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lADNNdeT028096
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 16:25:32 -0700 (MST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Fix the calculation of the private_data pointer in the CS4270 driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 5d601ad..abac628 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -725,7 +725,8 @@ static int cs4270_probe(struct platform_device *pdev)
 	codec->owner = THIS_MODULE;
 	codec->dai = &cs4270_dai;
 	codec->num_dai = 1;
-	codec->private_data = codec + ALIGN(sizeof(struct snd_soc_codec), 4);
+	codec->private_data = (void *) codec +
+		ALIGN(sizeof(struct snd_soc_codec), 4);
 
 	socdev->codec = codec;
 
-- 
1.5.2.4
