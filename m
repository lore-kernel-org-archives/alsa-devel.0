From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] ALSA: Avoid using timespec for struct
	snd_ctl_elem_value
Date: Thu, 26 Apr 2018 14:44:20 +0200
Message-ID: <20180426124422.2921744-3-arnd@arndb.de>
References: <20180426124422.2921744-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CFEE2677F6
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 14:45:19 +0200 (CEST)
In-Reply-To: <20180426124422.2921744-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com, lgirdwood@gmail.com, o-takashi@sakamocchi.jp, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Baolin Wang <baolin.wang@linaro.org>

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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ed0a120d4f08..1231f0a943f1 100644
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
2.9.0
