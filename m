From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ASoC: Fix TLV320AIC3X PLL divider table
	for 64 kHz rate
Date: Wed, 20 Feb 2008 15:23:44 +0200
Message-ID: <1203513825-17158-2-git-send-email-jarkko.nikula@nokia.com>
References: <1203513825-17158-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 014B72434B
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 14:24:00 +0100 (CET)
In-Reply-To: <1203513825-17158-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Vladimir Barinov <vbarinov@ru.mvista.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 710e028..569ecac 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -681,8 +681,8 @@ static const struct aic3x_rate_divs aic3x_divs[] = {
 	{22579200, 48000, 48000, 0x0, 8, 7075},
 	{33868800, 48000, 48000, 0x0, 5, 8049},
 	/* 64k */
-	{22579200, 96000, 96000, 0x1, 8, 7075},
-	{33868800, 96000, 96000, 0x1, 5, 8049},
+	{22579200, 64000, 96000, 0x1, 8, 7075},
+	{33868800, 64000, 96000, 0x1, 5, 8049},
 	/* 88.2k */
 	{22579200, 88200, 88200, 0x0, 8, 0},
 	{33868800, 88200, 88200, 0x0, 5, 3333},
-- 
1.5.3.8
