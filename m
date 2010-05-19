From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH - alsa-lib] tlv: Check dB range only within the
	control's volume range
Date: Wed, 19 May 2010 09:19:26 +0300
Message-ID: <1274249966-31030-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 460392450B
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 08:19:37 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The DB_RANGE need to be used on some HW, since the gain on
volume control is not continuous, and has to be divided into
several sub DB_SCALE ranges.
ASoC has a feature to override the HW default volume range,
and in this case when the volume range is less than the
HW maximum we do not need to go through the whole DB_RANGE,
but we need to stop where the kcontrol's maximum tell us.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello,

this patch fixes the ASoC related problem, when the volume is limited by the
machine driver on a given control, which happen to have DB_RANGE gain mapping.
The DB_RANGE has to have _only_ DB_SCALE type of mapping, since with LINEAR,
MINMAX, MINMAX_MUTE it is not possible to accurately calculate the maximum dB
limit on the control, when the volume is limited.

Applications like PulseAudio need to know the actual dB range, and not only the
theoretical maximum.

 src/control/tlv.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/control/tlv.c b/src/control/tlv.c
index cfd9b97..0ff052e 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -140,10 +140,13 @@ int snd_tlv_get_dB_range(unsigned int *tlv, long rangemin, long rangemax,
 		pos = 2;
 		while (pos + 4 <= len) {
 			long rmin, rmax;
-			rangemin = (int)tlv[pos];
-			rangemax = (int)tlv[pos + 1];
+			long submin, submax;
+			submin = (int)tlv[pos];
+			submax = (int)tlv[pos + 1];
+			if (rangemax < submax)
+				submax = rangemax;
 			err = snd_tlv_get_dB_range(tlv + pos + 2,
-						   rangemin, rangemax,
+						   submin, submax,
 						   &rmin, &rmax);
 			if (err < 0)
 				return err;
@@ -156,6 +159,8 @@ int snd_tlv_get_dB_range(unsigned int *tlv, long rangemin, long rangemax,
 				*min = rmin;
 				*max = rmax;
 			}
+			if (rangemax == submax)
+				return 0;
 			pos += int_index(tlv[pos + 3]) + 4;
 		}
 		return 0;
--
1.7.1
