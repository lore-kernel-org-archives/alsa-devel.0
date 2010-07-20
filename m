From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 - alsa-lib 2/3] tlv: Handle 'holes' in
	SND_CTL_TLVT_DB_RANGE array
Date: Tue, 20 Jul 2010 10:34:53 +0300
Message-ID: <1279611294-2014-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1279611294-2014-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5747C1038D5
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 09:35:08 +0200 (CEST)
In-Reply-To: <1279611294-2014-1-git-send-email-peter.ujfalusi@nokia.com>
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

When converting from dB to raw value, and DB_RANGE is
used with non overlapping map, dB value in between the
sub ranges will be not found.

For example, if the control has the following:
0: -10dB
1: -5dB
2: 0dB
3: 2dB
4: 4dB

static const unsigned int nonoverlapping_tlv[] = {
        TLV_DB_RANGE_HEAD(2),
        0, 2, TLV_DB_SCALE_ITEM(-1000, 500, 0),
        3, 4, TLV_DB_SCALE_ITEM(200, 200, 0),
};

Range 1: -10 .. 0dB
Range 2: 2 .. 4dB

If user asks for 1dB the snd_tlv_convert_from_dB will not find
the raw value, since the 1dB is not part of either range.

To fix this, we will store the previous non maching range's
maximum raw value. If the dB value is not found in the next range,
we will check, if the requested dB value is in between the current
and the previous range, and if it is than pick the apropriate raw
value based on the xdir (up or down rounding).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 src/control/tlv.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/control/tlv.c b/src/control/tlv.c
index 9f26f35..49f9afe 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -285,7 +285,7 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 {
 	switch (tlv[0]) {
 	case SND_CTL_TLVT_DB_RANGE: {
-		long dbmin, dbmax;
+		long dbmin, dbmax, prev_rangemax;
 		unsigned int pos, len;
 		len = int_index(tlv[1]);
 		if (len > MAX_TLV_RANGE_SIZE)
@@ -301,6 +301,7 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 			return 0;
 		}
 		pos = 2;
+		prev_rangemax = 0;
 		while (pos + 4 <= len) {
 			rangemin = (int)tlv[pos];
 			rangemax = (int)tlv[pos + 1];
@@ -311,6 +312,11 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 				return snd_tlv_convert_from_dB(tlv + pos + 2,
 							       rangemin, rangemax,
 							       db_gain, value, xdir);
+			else if (db_gain < dbmin) {
+				*value = xdir ? rangemin : prev_rangemax;
+				return 0;
+			}
+			prev_rangemax = rangemax;
 			pos += int_index(tlv[pos + 3]) + 4;
 		}
 		return -EINVAL;
-- 
1.7.1.1
