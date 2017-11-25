From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/24] ALSA: ctl: allocation of elem_info data
	for ELEM_INFO request
Date: Sat, 25 Nov 2017 18:19:54 +0900
Message-ID: <20171125092006.24408-13-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 19CBD266FA1
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In current implementation, for I/O request of ELEM_INFO, kernel stack
is used to copy 'struct snd_ctl_elem_info' data. However, the size of
this structure is a bit big and usage of kernel stack is not preferable.

This commit allocates a memory object on kernel space, instead.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 8d158a49467d..4cb950e310bf 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -875,20 +875,23 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 	return result;
 }
 
-static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl,
-				  struct snd_ctl_elem_info __user *_info)
+static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl, void __user *arg)
 {
-	struct snd_ctl_elem_info info;
-	int result;
+	struct snd_ctl_elem_info *info;
+	int err;
 
-	if (copy_from_user(&info, _info, sizeof(info)))
-		return -EFAULT;
-	result = snd_ctl_elem_info(ctl, &info);
-	if (result < 0)
-		return result;
-	if (copy_to_user(_info, &info, sizeof(info)))
-		return -EFAULT;
-	return result;
+	info = memdup_user(arg, sizeof(*info));
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	err = snd_ctl_elem_info(ctl, info);
+	if (err >= 0) {
+		if (copy_to_user(arg, info, sizeof(*info)))
+			return -EFAULT;
+	}
+
+	kfree(info);
+	return err;
 }
 
 static int snd_ctl_elem_read(struct snd_card *card,
-- 
2.14.1
