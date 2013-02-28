From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hdajackretask: Fix "advanced override" bug
Date: Thu, 28 Feb 2013 22:01:08 +0100
Message-ID: <1362085268-31957-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CB66264F8B
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 22:01:06 +0100 (CET)
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

The values were not correctly retreived from the comboboxes.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hdajackretask/main-gtk.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hdajackretask/main-gtk.c b/hdajackretask/main-gtk.c
index 65d0f3a..4227669 100644
--- a/hdajackretask/main-gtk.c
+++ b/hdajackretask/main-gtk.c
@@ -183,14 +183,14 @@ static void update_user_pin_config(ui_data_t* ui)
             continue;
 
         if (ui->free_overrides) {
-            int i;
+            int j;
             int index;
             unsigned long val = 0;
-            for (i = 0; i < FREE_OVERRIDES_COUNT; i++) {
-                index = gtk_combo_box_get_active(GTK_COMBO_BOX(pin_ui->jacktype));
-                if (index < 0) 
+            for (j = 0; j < FREE_OVERRIDES_COUNT; j++) {
+                index = gtk_combo_box_get_active(GTK_COMBO_BOX(pin_ui->free_override_cb[j]));
+                if (index < 0)
                     break;
-                val += get_free_override_list(i)[index].value;
+                val += get_free_override_list(j)[index].value;
             }
             if (index < 0)
                 continue;
-- 
1.7.9.5
