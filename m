From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add workqueue_set_max_active function
Date: Fri, 29 Nov 2013 14:59:18 +0800
Message-ID: <1385708358-5943-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C436261738
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 07:59:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/linux/workqueue.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1a8834e..ca49b4c 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -53,4 +53,7 @@ static inline struct delayed_work *to_delayed_work(struct work_struct *work)
 	return container_of(work, struct delayed_work, work);
 }
 
+static inline void workqueue_set_max_active(struct workqueue_struct *wq,
+					    int max_active) { }
+
 #endif /* __LINUX_WORKQUEUE_H */
-- 
1.7.9.5
