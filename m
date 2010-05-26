From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 6/8] ASoC: TWL4030: Correct the
	ARXR2_APGA_CTL chip default
Date: Wed, 26 May 2010 11:38:19 +0300
Message-ID: <1274863101-18514-7-git-send-email-peter.ujfalusi@nokia.com>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B1C5E103945
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:39:36 +0200 (CEST)
In-Reply-To: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

It seams at least on twl5031 that the ARXR2_APGA_CTL register
does not have the same default value as it is written in
the TRM.
Since the codec part of the PM chip has not been actually
changed according to TI, assuming, that all version has
the same problem, so writing there the TRM value.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index cd913ef..92f65de 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -289,6 +289,9 @@ static void twl4030_init_chip(struct platform_device *pdev)
 		TWL4030_ATXL1_EN | TWL4030_ATXR1_EN |
 		TWL4030_ARXL2_EN | TWL4030_ARXR2_EN);

+	/* REG_ARXR2_APGA_CTL reset according to the TRM: 0dB, DA_EN */
+	twl4030_write(codec, TWL4030_REG_ARXR2_APGA_CTL, 0x32);
+
 	/* Machine dependent setup */
 	if (!setup)
 		return;
--
1.7.1
