From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-tools)] hdajackretask: Fix killing
	PulseAudio on newer PulseAudio versions
Date: Thu, 13 Jun 2013 16:26:43 +0200
Message-ID: <1371133603-14702-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 519C52651D5
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 16:26:44 +0200 (CEST)
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

The standard configuration directory for PulseAudio has changed,
I think since 3.0. Adjust the directory lookup mechanism to match.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hdajackretask/apply-changes.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hdajackretask/apply-changes.c b/hdajackretask/apply-changes.c
index eda404e..77563f7 100644
--- a/hdajackretask/apply-changes.c
+++ b/hdajackretask/apply-changes.c
@@ -97,7 +97,20 @@ gboolean run_sudo_script(const gchar* script_name, GError** err)
 
 static gchar* get_pulseaudio_client_conf()
 {
-    return g_strdup_printf("%s/.pulse/client.conf", g_get_home_dir());
+    /* Reference: See src/pulsecore/core-util.c in pulseaudio */
+    gchar* fname;
+    gchar* dir = g_strdup_printf("%s/.pulse", g_get_home_dir());
+    if (access(dir, F_OK) < 0) {
+        const gchar* xch = g_getenv("XDG_CONFIG_HOME");
+        g_free(dir);
+        if (xch)
+            dir = g_strdup_printf("%s/pulse", xch);
+        else
+            dir = g_strdup_printf("%s/.config/pulse", g_get_home_dir());
+    }
+    fname = g_strdup_printf("%s/client.conf", dir);
+    g_free(dir);
+    return fname;
 }
 
 static gboolean kill_pulseaudio(gboolean* was_killed, int card, GError** err)
-- 
1.7.9.5
