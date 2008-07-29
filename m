From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/14] ASoC: Staticise keyclick dev_attr in
	tlv320aic26
Date: Tue, 29 Jul 2008 11:42:33 +0100
Message-ID: <1217328155-30158-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-11-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90F9B2483D
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:40 +0200 (CEST)
In-Reply-To: <1217328155-30158-11-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 sound/soc/codecs/tlv320aic26.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 73b7027..bed8a9e 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -418,7 +418,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
+static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 
 /* ---------------------------------------------------------------------
  * SPI device portion of driver: probe and release routines and SPI
-- 
1.5.6.3
