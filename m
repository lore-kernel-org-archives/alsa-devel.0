From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH] ucm: fix switch device & modifier when no
	transition is found
Date: Tue, 11 Jan 2011 17:56:30 +0000
Message-ID: <1294768590-17028-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f193.google.com (mail-wy0-f193.google.com
	[74.125.82.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 80DAD10386B
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:56:43 +0100 (CET)
Received: by wyb42 with SMTP id 42so6927196wyb.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 09:56:43 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Fix some logic bugs in switch device and switch modifier when
transition sequences are not found. Also fix check for new device.

Reported-by: w0806.kim@samsung.com
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/ucm/main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 7305042..030c9b1 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1305,7 +1305,7 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
         if (xold == NULL)
                 return -ENOENT;
         xnew = find_device(uc_mgr->active_verb, new_device);
-        if (xold == NULL)
+        if (xnew == NULL)
                 return -ENOENT;
         err = 0;
         list_for_each(pos, &xold->transition_list) {
@@ -1327,7 +1327,7 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
                 err = set_device(uc_mgr, xold, 0);
                 if (err < 0)
                         return err;
-                err = set_device(uc_mgr, xnew, 0);
+                err = set_device(uc_mgr, xnew, 1);
                 if (err < 0)
                         return err;
         }
@@ -1379,7 +1379,7 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
                 err = set_modifier(uc_mgr, xold, 0);
                 if (err < 0)
                         return err;
-                err = set_modifier(uc_mgr, xnew, 0);
+                err = set_modifier(uc_mgr, xnew, 1);
                 if (err < 0)
                         return err;
         }
-- 
1.7.1
