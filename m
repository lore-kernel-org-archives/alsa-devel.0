From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 3/5] UCM: Disallow gets of undefined system
	properties
Date: Fri,  3 Jun 2011 14:56:32 -0600
Message-ID: <1307134594-32176-3-git-send-email-swarren@nvidia.com>
References: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C193510380B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 22:56:45 +0200 (CEST)
In-Reply-To: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

In UCM, there are various system-defined properties whose names start
with "_". Explicitly prevent any gets from falling back to properties
defined in a config file if the property name starts with "_", in order
to reserve the entire "_" namespace for system-defined properties.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/ucm/main.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index e5d06e6..d319160 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1032,6 +1032,8 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
           		err = get_device_list(uc_mgr, list, str);
                 else if (check_identifier(identifier, "_modifiers"))
                         err = get_modifier_list(uc_mgr, list, str);
+		else if (identifier[0] == '_')
+			err = -ENOENT;
                 else
                         err = get_value_list(uc_mgr, identifier, list, str);
         	if (str)
@@ -1159,6 +1161,9 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                         goto __end;
                 }
 	        err = 0;
+	} else if (identifier[0] == '_') {
+		err = -ENOENT;
+		goto __end;
         } else {
                 str1 = strchr(identifier, '/');
                 if (str1) {
@@ -1247,8 +1252,16 @@ int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
 				*value = err;
 				err = 0;
 			}
+#if 0
+		/*
+		 * enable this block if the else clause below is expanded to query
+		 * user-supplied values
+		 */
+		} else if (identifier[0] == '_')
+			err = -ENOENT;
+#endif
 		} else
-                        err = -EINVAL;
+                        err = -ENOENT;
                 if (str)
                         free(str);
         }
-- 
1.7.0.4
