From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/6] ASoC: TWL4030: Enable all audio paths
Date: Mon,  6 Apr 2009 15:19:29 +0300
Message-ID: <1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id EB2311038C4
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:19:51 +0200 (CEST)
In-Reply-To: <1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Enable all TX and RX paths on the TWL codec.
This is not so nice, but doing it runtime brings quite a bit
of challenge, since for example the Digital loopback also needs
the RX and TX paths to be enabled.

In power consumption there is no difference keeping these
enabled or disabled, but this issue worth to be revisited at
some point.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index bfda7a8..8b44a88 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -43,7 +43,7 @@
 static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* this register not used		*/
 	0x91, /* REG_CODEC_MODE		(0x1)	*/
-	0xc3, /* REG_OPTION		(0x2)	*/
+	0xff, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
 	0x20, /* REG_ANAMICL		(0x5)	*/
-- 
1.6.2.2
