From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/3] ASoC: tpa6130a2: Fix DB_RANGE mapping for
	tpa6130a2 chip
Date: Fri, 16 Jul 2010 13:17:10 +0300
Message-ID: <1279275431-26922-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 209CF10399A
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
While fixing the mapping, also change the ranges covered
by SCALE_ITEM a bit.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 99b70e5..b15fbdb 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -234,17 +234,23 @@ static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
  * down in gain.
  */
 static const unsigned int tpa6130_tlv[] = {
-	TLV_DB_RANGE_HEAD(10),
+	TLV_DB_RANGE_HEAD(16),
 	0, 1, TLV_DB_SCALE_ITEM(-5950, 600, 0),
+	1, 2, TLV_DB_SCALE_ITEM(-5350, 350, 0),
 	2, 3, TLV_DB_SCALE_ITEM(-5000, 250, 0),
+	3, 4, TLV_DB_SCALE_ITEM(-4750, 200, 0),
 	4, 5, TLV_DB_SCALE_ITEM(-4550, 160, 0),
+	5, 6, TLV_DB_SCALE_ITEM(-4390, 250, 0),
 	6, 7, TLV_DB_SCALE_ITEM(-4140, 190, 0),
+	7, 8, TLV_DB_SCALE_ITEM(-3950, 300, 0),
 	8, 9, TLV_DB_SCALE_ITEM(-3650, 120, 0),
-	10, 11, TLV_DB_SCALE_ITEM(-3330, 160, 0),
-	12, 13, TLV_DB_SCALE_ITEM(-3040, 180, 0),
-	14, 20, TLV_DB_SCALE_ITEM(-2710, 110, 0),
-	21, 37, TLV_DB_SCALE_ITEM(-1960, 74, 0),
-	38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0),
+	9, 10, TLV_DB_SCALE_ITEM(-3530, 200, 0),
+	10, 16, TLV_DB_SCALE_ITEM(-3330, 143, 0),
+	16, 21, TLV_DB_SCALE_ITEM(-2470, 102, 0),
+	21, 29, TLV_DB_SCALE_ITEM(-1960, 83, 0),
+	29, 38, TLV_DB_SCALE_ITEM(-1300, 64, 0),
+	38, 45, TLV_DB_SCALE_ITEM(-720, 53, 0),
+	45, 63, TLV_DB_SCALE_ITEM(-350, 42, 0),
 };
 
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
-- 
1.7.1.1
