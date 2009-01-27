From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/6] ASoC: TWL4030: Syncronize the reg_cache
	for ANAMICL after the offset cancelation
Date: Tue, 27 Jan 2009 11:29:39 +0200
Message-ID: <1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AF381037EC
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:30:00 +0100 (CET)
In-Reply-To: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

The offset cancelation bit in ANAMICL register is self cleanig.
Make sure that the reg_cache holds the same value as the HW
register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f530c1e..df72a21 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -913,6 +913,9 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 		 ((byte & TWL4030_CNCL_OFFSET_START) ==
 		  TWL4030_CNCL_OFFSET_START));
 
+	/* Make sure that the reg_cache has the same value as the HW */
+	twl4030_write_reg_cache(codec, TWL4030_REG_ANAMICL, byte);
+
 	/* anti-pop when changing analog gain */
 	regmisc1 = twl4030_read_reg_cache(codec, TWL4030_REG_MISC_SET_1);
 	twl4030_write(codec, TWL4030_REG_MISC_SET_1,
-- 
1.6.1
