From: arun@accosted.net
Subject: [PATCH] control: Allow cset'ing specific values in the
	multi-value case
Date: Tue,  9 Jun 2015 16:25:07 +0530
Message-ID: <1433847307-26125-1-git-send-email-arun@accosted.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A20265173
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 12:55:42 +0200 (CEST)
Received: by pdjn11 with SMTP id n11so12562565pdj.0
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 03:55:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Arun Raghavan <git@arunraghavan.net>
List-Id: alsa-devel@alsa-project.org

From: Arun Raghavan <git@arunraghavan.net>

This works with syntax like ...

  amixer cset 'IIR1 Band1'  ,,200

... to set the third value of the control to 200.
---
 src/control/ctlparse.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
index 8d6c385..64c6480 100644
--- a/src/control/ctlparse.c
+++ b/src/control/ctlparse.c
@@ -48,9 +48,9 @@ static inline long int convert_prange1(long val, long min, long max)
 #define check_range(val, min, max) \
 	((val < min) ? (min) : ((val > max) ? (max) : (val)))
 
-static long get_integer(const char **ptr, long min, long max)
+static long get_integer(const char **ptr, long def, long min, long max)
 {
-	long val = min;
+	long val = def;
 	char *p = (char *)*ptr, *s;
 
 	if (*p == ':')
@@ -351,6 +351,8 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER:
 			tmp = get_integer(&ptr,
+					  snd_ctl_elem_value_get_integer(dst,
+									 idx),
 					  snd_ctl_elem_info_get_min(info),
 					  snd_ctl_elem_info_get_max(info));
 			snd_ctl_elem_value_set_integer(dst, idx, tmp);
@@ -364,12 +366,12 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
 		case SND_CTL_ELEM_TYPE_ENUMERATED:
 			tmp = get_ctl_enum_item_index(handle, info, &ptr);
 			if (tmp < 0)
-				tmp = get_integer(&ptr, 0,
+				tmp = get_integer(&ptr, 0, 0,
 					snd_ctl_elem_info_get_items(info) - 1);
 			snd_ctl_elem_value_set_enumerated(dst, idx, tmp);
 			break;
 		case SND_CTL_ELEM_TYPE_BYTES:
-			tmp = get_integer(&ptr, 0, 255);
+			tmp = get_integer(&ptr, 0, 0, 255);
 			snd_ctl_elem_value_set_byte(dst, idx, tmp);
 			break;
 		default:
-- 
2.4.2
