From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add keycode* to input_dev
Date: Mon, 11 Jan 2016 09:01:48 +0100
Message-ID: <1452499308-5239-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 978A9260522
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 09:01:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/linux/input.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/input.h b/include/linux/input.h
index 213c12b..c710fe4 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -26,6 +26,11 @@ struct input_dev {
 	unsigned long keybit[0x300 / (sizeof(long) * 8)];
 	/* ... */
 
+        unsigned int keycodemax;
+        unsigned int keycodesize;
+        void *keycode;
+	/* ... */
+
 	int (*open)(struct input_dev *dev);
 	void (*close)(struct input_dev *dev);
 	int (*flush)(struct input_dev *dev, struct file *file);
-- 
1.9.1
