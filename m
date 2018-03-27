From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: usb-audio: fix memory leak on cval
Date: Tue, 27 Mar 2018 15:30:01 +0100
Message-ID: <20180327143001.13870-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FC7267190
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 16:30:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andrew Chant <achant@google.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

With the current exit return path of the ctl_info allocation failure
cval is not being freed resulting in a memory leak. Fix this by kfree'ing
it on the return.

Detected by CoverityScan, CID#1466878 ("Resource Leak")

Fixes: 21e9b3e931f7 ("ALSA: usb-audio: fix uac control query argument")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 04dab6f65535..301ad61ed426 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1365,8 +1365,10 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	cval->cmask = ctl_mask;
 
 	ctl_info = get_feature_control_info(control);
-	if (!ctl_info)
+	if (!ctl_info) {
+		kfree(cval);
 		return;
+	}
 	if (state->mixer->protocol == UAC_VERSION_1)
 		cval->val_type = ctl_info->type;
 	else /* UAC_VERSION_2 */
-- 
2.15.1
