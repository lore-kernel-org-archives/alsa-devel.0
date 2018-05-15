From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 2/6] control: use position offset
	macro of TLV data
Date: Tue, 15 May 2018 21:36:35 +0900
Message-ID: <20180515123639.18255-3-o-takashi@sakamocchi.jp>
References: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 532E9266EDF
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:17 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id w19-v6so6744301plq.4
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:17 -0700 (PDT)
In-Reply-To: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c       | 12 ++++----
 src/control/control_hw.c    |  6 ++--
 src/control/control_local.h |  1 +
 src/control/tlv.c           | 72 ++++++++++++++++++++++++---------------------
 4 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 11f7815a..82cd1a05 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -938,10 +938,10 @@ int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	 * and compare the returned value after ioctl for checking
 	 * the validity of TLV.
 	 */
-	tlv[0] = -1;
-	tlv[1] = 0;
+	tlv[SNDRV_CTL_TLVO_TYPE] = -1;
+	tlv[SNDRV_CTL_TLVO_LEN] = 0;
 	err = snd_ctl_tlv_do(ctl, 0, id, tlv, tlv_size);
-	if (err >= 0 && tlv[0] == (unsigned int)-1)
+	if (err >= 0 && tlv[SNDRV_CTL_TLVO_TYPE] == (unsigned int)-1)
 		err = -ENXIO;
 	return err;
 }
@@ -967,7 +967,8 @@ int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			   const unsigned int *tlv)
 {
 	assert(ctl && id && (id->name[0] || id->numid) && tlv);
-	return snd_ctl_tlv_do(ctl, 1, id, (unsigned int *)tlv, tlv[1] + 2 * sizeof(unsigned int));
+	return snd_ctl_tlv_do(ctl, 1, id, (unsigned int *)tlv,
+			tlv[SNDRV_CTL_TLVO_LEN] + 2 * sizeof(unsigned int));
 }
 
 /**
@@ -991,7 +992,8 @@ int snd_ctl_elem_tlv_command(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     const unsigned int *tlv)
 {
 	assert(ctl && id && (id->name[0] || id->numid) && tlv);
-	return snd_ctl_tlv_do(ctl, -1, id, (unsigned int *)tlv, tlv[1] + 2 * sizeof(unsigned int));
+	return snd_ctl_tlv_do(ctl, -1, id, (unsigned int *)tlv,
+			tlv[SNDRV_CTL_TLVO_LEN] + 2 * sizeof(unsigned int));
 }
 
 /**
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index 4cbd306f..68eca522 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -240,11 +240,13 @@ static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
 		return -errno;
 	}
 	if (op_flag == 0) {
-		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size) {
+		unsigned int size;
+		size = xtlv->tlv[SNDRV_CTL_TLVO_LEN] + 2 * sizeof(unsigned int);
+		if (size > tlv_size) {
 			free(xtlv);
 			return -EFAULT;
 		}
-		memcpy(tlv, xtlv->tlv, xtlv->tlv[1] + 2 * sizeof(unsigned int));
+		memcpy(tlv, xtlv->tlv, size);
 	}
 	free(xtlv);
 	return 0;
diff --git a/src/control/control_local.h b/src/control/control_local.h
index 30218c6c..9568968e 100644
--- a/src/control/control_local.h
+++ b/src/control/control_local.h
@@ -20,6 +20,7 @@
  */
 
 #include "local.h"
+#include <sound/tlv.h>
 
 typedef struct _snd_ctl_ops {
 	int (*close)(snd_ctl_t *handle);
diff --git a/src/control/tlv.c b/src/control/tlv.c
index 467023b3..d6944b52 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -65,8 +65,8 @@ int snd_tlv_parse_dB_info(unsigned int *tlv,
 	int err;
 
 	*db_tlvp = NULL;
-	type = tlv[0];
-	size = tlv[1];
+	type = tlv[SNDRV_CTL_TLVO_TYPE];
+	size = tlv[SNDRV_CTL_TLVO_LEN];
 	tlv_size -= 2 * sizeof(int);
 	if (size > tlv_size) {
 		SNDERR("TLV size error");
@@ -83,7 +83,7 @@ int snd_tlv_parse_dB_info(unsigned int *tlv,
 				return err; /* error */
 			if (err > 0)
 				return err; /* found */
-			len = int_index(tlv[1]) + 2;
+			len = int_index(tlv[SNDRV_CTL_TLVO_LEN]) + 2;
 			size -= len * sizeof(int);
 			tlv += len;
 		}
@@ -131,10 +131,10 @@ int snd_tlv_get_dB_range(unsigned int *tlv, long rangemin, long rangemax,
 {
 	int err;
 
-	switch (tlv[0]) {
+	switch (tlv[SNDRV_CTL_TLVO_TYPE]) {
 	case SND_CTL_TLVT_DB_RANGE: {
 		unsigned int pos, len;
-		len = int_index(tlv[1]);
+		len = int_index(tlv[SNDRV_CTL_TLVO_LEN]);
 		if (len > MAX_TLV_RANGE_SIZE)
 			return -EINVAL;
 		pos = 2;
@@ -167,22 +167,23 @@ int snd_tlv_get_dB_range(unsigned int *tlv, long rangemin, long rangemax,
 	}
 	case SND_CTL_TLVT_DB_SCALE: {
 		int step;
-		if (tlv[3] & 0x10000)
+		if (tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] & 0x10000)
 			*min = SND_CTL_TLV_DB_GAIN_MUTE;
 		else
-			*min = (int)tlv[2];
-		step = (tlv[3] & 0xffff);
-		*max = (int)tlv[2] + step * (rangemax - rangemin);
+			*min = (int)tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN];
+		step = (tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] & 0xffff);
+		*max = (int)tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN] +
+						step * (rangemax - rangemin);
 		return 0;
 	}
 	case SND_CTL_TLVT_DB_MINMAX:
 	case SND_CTL_TLVT_DB_LINEAR:
-		*min = (int)tlv[2];
-		*max = (int)tlv[3];
+		*min = (int)tlv[SNDRV_CTL_TLVO_DB_LINEAR_MIN];
+		*max = (int)tlv[SNDRV_CTL_TLVO_DB_LINEAR_MAX];
 		return 0;
 	case SND_CTL_TLVT_DB_MINMAX_MUTE:
 		*min = SND_CTL_TLV_DB_GAIN_MUTE;
-		*max = (int)tlv[3];
+		*max = (int)tlv[SNDRV_CTL_TLVO_DB_MINMAX_MAX];
 		return 0;
 	}
 	return -EINVAL;
@@ -200,10 +201,12 @@ int snd_tlv_get_dB_range(unsigned int *tlv, long rangemin, long rangemax,
 int snd_tlv_convert_to_dB(unsigned int *tlv, long rangemin, long rangemax,
 			  long volume, long *db_gain)
 {
-	switch (tlv[0]) {
+	unsigned int type = tlv[SNDRV_CTL_TLVO_TYPE];
+
+	switch (type) {
 	case SND_CTL_TLVT_DB_RANGE: {
 		unsigned int pos, len;
-		len = int_index(tlv[1]);
+		len = int_index(tlv[SNDRV_CTL_TLVO_LEN]);
 		if (len > MAX_TLV_RANGE_SIZE)
 			return -EINVAL;
 		pos = 2;
@@ -220,9 +223,9 @@ int snd_tlv_convert_to_dB(unsigned int *tlv, long rangemin, long rangemax,
 	}
 	case SND_CTL_TLVT_DB_SCALE: {
 		int min, step, mute;
-		min = tlv[2];
-		step = (tlv[3] & 0xffff);
-		mute = (tlv[3] >> 16) & 1;
+		min = tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN];
+		step = (tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] & 0xffff);
+		mute = (tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] >> 16) & 1;
 		if (mute && volume <= rangemin)
 			*db_gain = SND_CTL_TLV_DB_GAIN_MUTE;
 		else
@@ -232,10 +235,10 @@ int snd_tlv_convert_to_dB(unsigned int *tlv, long rangemin, long rangemax,
 	case SND_CTL_TLVT_DB_MINMAX:
 	case SND_CTL_TLVT_DB_MINMAX_MUTE: {
 		int mindb, maxdb;
-		mindb = tlv[2];
-		maxdb = tlv[3];
+		mindb = tlv[SNDRV_CTL_TLVO_DB_MINMAX_MIN];
+		maxdb = tlv[SNDRV_CTL_TLVO_DB_MINMAX_MAX];
 		if (volume <= rangemin || rangemax <= rangemin) {
-			if (tlv[0] == SND_CTL_TLVT_DB_MINMAX_MUTE)
+			if (type == SND_CTL_TLVT_DB_MINMAX_MUTE)
 				*db_gain = SND_CTL_TLV_DB_GAIN_MUTE;
 			else
 				*db_gain = mindb;
@@ -248,8 +251,8 @@ int snd_tlv_convert_to_dB(unsigned int *tlv, long rangemin, long rangemax,
 	}
 #ifndef HAVE_SOFT_FLOAT
 	case SND_CTL_TLVT_DB_LINEAR: {
-		int mindb = tlv[2];
-		int maxdb = tlv[3];
+		int mindb = tlv[SNDRV_CTL_TLVO_DB_LINEAR_MIN];
+		int maxdb = tlv[SNDRV_CTL_TLVO_DB_LINEAR_MAX];
 		if (volume <= rangemin || rangemax <= rangemin)
 			*db_gain = mindb;
 		else if (volume >= rangemax)
@@ -289,11 +292,13 @@ int snd_tlv_convert_to_dB(unsigned int *tlv, long rangemin, long rangemax,
 int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 			    long db_gain, long *value, int xdir)
 {
-	switch (tlv[0]) {
+	unsigned int type = tlv[SNDRV_CTL_TLVO_TYPE];
+
+	switch (type) {
 	case SND_CTL_TLVT_DB_RANGE: {
 		long dbmin, dbmax, prev_submax;
 		unsigned int pos, len;
-		len = int_index(tlv[1]);
+		len = int_index(tlv[SNDRV_CTL_TLVO_LEN]);
 		if (len < 6 || len > MAX_TLV_RANGE_SIZE)
 			return -EINVAL;
 		pos = 2;
@@ -324,13 +329,14 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 		return 0;
 	}
 	case SND_CTL_TLVT_DB_SCALE: {
-		int min, step, max;
-		min = tlv[2];
-		step = (tlv[3] & 0xffff);
+		int min, step, max, mute;
+		min = tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN];
+		step = tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] & 0xffff;
+		mute = tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] & 0x10000;
 		max = min + (int)(step * (rangemax - rangemin));
 		if (db_gain <= min)
 			if (db_gain > SND_CTL_TLV_DB_GAIN_MUTE && xdir > 0 &&
-			    (tlv[3] & 0x10000))
+			    mute)
 				*value = rangemin + 1;
 			else
 				*value = rangemin;
@@ -348,11 +354,11 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 	case SND_CTL_TLVT_DB_MINMAX:
 	case SND_CTL_TLVT_DB_MINMAX_MUTE: {
 		int min, max;
-		min = tlv[2];
-		max = tlv[3];
+		min = tlv[SNDRV_CTL_TLVO_DB_MINMAX_MIN];
+		max = tlv[SNDRV_CTL_TLVO_DB_MINMAX_MAX];
 		if (db_gain <= min)
 			if (db_gain > SND_CTL_TLV_DB_GAIN_MUTE && xdir > 0 &&
-			    tlv[0] == SND_CTL_TLVT_DB_MINMAX_MUTE)
+			    type == SND_CTL_TLVT_DB_MINMAX_MUTE)
 				*value = rangemin + 1;
 			else
 				*value = rangemin;
@@ -370,8 +376,8 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 #ifndef HAVE_SOFT_FLOAT
 	case SND_CTL_TLVT_DB_LINEAR: {
 		int min, max;
-		min = tlv[2];
-		max = tlv[3];
+		min = tlv[SNDRV_CTL_TLVO_DB_LINEAR_MIN];
+		max = tlv[SNDRV_CTL_TLVO_DB_LINEAR_MAX];
 		if (db_gain <= min)
 			*value = rangemin;
 		else if (db_gain >= max)
-- 
2.14.1
