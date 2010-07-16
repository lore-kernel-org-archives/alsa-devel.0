From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/3] ASoC: TWL4030: Fix DB_RANGE tlv mapping
	for digital loopback
Date: Fri, 16 Jul 2010 13:17:09 +0300
Message-ID: <1279275431-26922-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FEF010396A
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 12:17:39 +0200 (CEST)
In-Reply-To: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
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

The TLV_DB_SCALE_ITEMs within the DB_RANGE has to cover the
whole range without holes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 6fd6d0b..7686457 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -544,8 +544,8 @@ static const struct snd_kcontrol_new twl4030_dapm_abypassv_control =
 static const unsigned int twl4030_dapm_dbypass_tlv[] = {
 	TLV_DB_RANGE_HEAD(3),
 	0, 1, TLV_DB_SCALE_ITEM(-3000, 600, 1),
-	2, 3, TLV_DB_SCALE_ITEM(-2400, 0, 0),
-	4, 7, TLV_DB_SCALE_ITEM(-1800, 600, 0),
+	1, 3, TLV_DB_SCALE_ITEM(-2400, 0, 0),
+	3, 7, TLV_DB_SCALE_ITEM(-2400, 600, 0),
 };
 
 /* Digital bypass left (TX1L -> RX2L) */
-- 
1.7.1.1
