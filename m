From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/8] ALSA: Avoid using timespec for struct snd_ctl_elem_value
Date: Tue, 24 Apr 2018 20:06:10 +0800
Message-ID: <33f88d93c2330a17c50c51f1d0e7742f4d27c12a.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: baolin.wang@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, o-takashi@sakamocchi.jp, mingo@kernel.org, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com, subhransu.s.prusty@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The struct snd_ctl_elem_value will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since there are no drivers will implemented the tstamp member of the
struct snd_ctl_elem_value, and also the stucture size will not be changed
if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.

>From Takashi's comments, "In the library, applications are not expected
to access to this structure directly. The applications get opaque pointer
to the structure and must use any control APIs to operate it. Actually the
library produce no API to handle 'struct snd_ctl_elem_value.tstamp'. This
means that we can drop this member from alsa-lib without decline of
functionality." Thus we can simply remove the tstamp member to avoid using
the type which is not year 2038 safe on 32bits system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/uapi/sound/asound.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ed0a120..1231f0a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -954,8 +954,7 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	unsigned char reserved[128];
 };
 
 struct snd_ctl_tlv {
-- 
1.7.9.5
