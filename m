From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH - alsa-lib 1/3] tlv: Check out of range dB with
	SND_CTL_TLVT_DB_RANGE
Date: Mon, 19 Jul 2010 10:14:04 +0300
Message-ID: <1279523646-4987-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id BD0B210385B
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 09:14:36 +0200 (CEST)
In-Reply-To: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When converting from dB value to raw value, the control's
full range was not checked in case of SND_CTL_TLVT_DB_RANGE.

Check out of range dB values, and return apropriate raw
value for the caller.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 src/control/tlv.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/control/tlv.c b/src/control/tlv.c
index 0ff052e..d09766a 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -285,13 +285,20 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 {
 	switch (tlv[0]) {
 	case SND_CTL_TLVT_DB_RANGE: {
+		long dbmin, dbmax;
 		unsigned int pos, len;
 		len = int_index(tlv[1]);
 		if (len > MAX_TLV_RANGE_SIZE)
 			return -EINVAL;
+		if (snd_tlv_get_dB_range(tlv, rangemin, rangemax,
+					 &dbmin, &dbmax))
+			return -EINVAL;
+		if (db_gain <= dbmin || db_gain >= dbmax) {
+			*value = db_gain <= dbmin ? rangemin : rangemax;
+			return 0;
+		}
 		pos = 2;
 		while (pos + 4 <= len) {
-			long dbmin, dbmax;
 			rangemin = (int)tlv[pos];
 			rangemax = (int)tlv[pos + 1];
 			if (!snd_tlv_get_dB_range(tlv + pos + 2,
-- 
1.7.1.1
