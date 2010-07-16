From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: tpa6130a2: Fix DB_RANGE mapping for
	tpa6140a2 chip
Date: Fri, 16 Jul 2010 13:17:11 +0300
Message-ID: <1279275431-26922-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6332410396A
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
 sound/soc/codecs/tpa6130a2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index b15fbdb..5df03f8 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -263,8 +263,8 @@ static const struct snd_kcontrol_new tpa6130a2_controls[] = {
 static const unsigned int tpa6140_tlv[] = {
 	TLV_DB_RANGE_HEAD(3),
 	0, 8, TLV_DB_SCALE_ITEM(-5900, 400, 0),
-	9, 16, TLV_DB_SCALE_ITEM(-2500, 200, 0),
-	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0),
+	8, 16, TLV_DB_SCALE_ITEM(-2700, 200, 0),
+	16, 31, TLV_DB_SCALE_ITEM(-1100, 100, 0),
 };
 
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
-- 
1.7.1.1
