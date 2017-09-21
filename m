From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 6/7] uapi: sound: Avoid using timespec for struct snd_ctl_elem_value
Date: Thu, 21 Sep 2017 14:18:08 +0800
Message-ID: <f47f86aa2bc1b96fbe47737f795ea1aee642caa0.1505973912.git.baolin.wang@linaro.org>
References: <cover.1505973912.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505973912.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1505973912.git.baolin.wang@linaro.org>
References: <cover.1505973912.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, mingo@kernel.org, o-takashi@sakamocchi.jp, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, arnd@arndb.de, broonie@kernel.org, deepa.kernel@gmail.com, baolin.wang@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The struct snd_ctl_elem_value will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since there are no drivers will implemented the tstamp member of the
struct snd_ctl_elem_value, and also the stucture size will not be changed
if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.

Thus we can simply change timespec to s64 for tstamp member to avoid
using the type which is not year 2038 safe on 32bits system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/uapi/sound/asound.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1949923..71bce52 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -943,8 +943,8 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	struct { s64 tv_sec; s64 tv_nsec; } tstamp;
+	unsigned char reserved[128-sizeof(struct { s64 tv_sec; s64 tv_nsec; })];
 };
 
 struct snd_ctl_tlv {
-- 
1.7.9.5
