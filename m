From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/8] ALSA: control: rename to appropriate macro
	name
Date: Wed, 11 Feb 2015 19:37:31 +0900
Message-ID: <1423651052-19593-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 447FC2605F9
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:37:41 +0100 (CET)
In-Reply-To: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MAX_CONTROL_COUNT is used for the maximum number of values included in
a control, therefore should be rename to mean it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index c18ac04..04534f3 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -30,9 +30,11 @@
 #include <sound/info.h>
 #include <sound/control.h>
 
+/* The maximum number of values which one control has. */
+#define MAX_VALUES_COUNT	1028
+
 /* max number of user-defined controls */
 #define MAX_USER_CONTROLS	32
-#define MAX_CONTROL_COUNT	1028
 
 struct snd_kctl_ioctl {
 	struct list_head list;		/* list of all ioctls */
@@ -211,7 +213,7 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
 	if (snd_BUG_ON(!control || !control->count))
 		return NULL;
 
-	if (control->count > MAX_CONTROL_COUNT)
+	if (control->count > MAX_VALUES_COUNT)
 		return NULL;
 
 	size  = sizeof(*kctl);
-- 
2.1.0
