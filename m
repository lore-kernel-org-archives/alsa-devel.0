From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 08/11] ucm: check the correct return value for
	modifier
Date: Tue, 21 Dec 2010 22:11:57 +0000
Message-ID: <1292969520-18047-9-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9590B103A57
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:24 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4322500wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:24 -0800 (PST)
In-Reply-To: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
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

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/ucm/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 3a61679..4c13547 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1323,7 +1323,7 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
         if (xold == NULL)
                 return -ENOENT;
         xnew = find_modifier(uc_mgr->active_verb, new_modifier);
-        if (xold == NULL)
+        if (xnew == NULL)
                 return -ENOENT;
         err = 0;
         list_for_each(pos, &xold->transition_list) {
-- 
1.7.1
