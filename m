From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/2] UCM: Fix deadlock following failed get
	_verb
Date: Thu,  2 Jun 2011 16:44:39 -0600
Message-ID: <1307054679-32175-2-git-send-email-swarren@nvidia.com>
References: <1307054679-32175-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 381382438B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 00:44:52 +0200 (CEST)
In-Reply-To: <1307054679-32175-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

When querying the current verb without a verb set, snd_use_case_get bails
out early without unlocking uc_mgr->mutex. This causes subsequent API calls
to hang. Instead, s/return/goto __end/.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/ucm/main.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index f8ceeeb..fb4aa91 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1132,8 +1132,10 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                 }
                 err = 0;
         } else if (strcmp(identifier, "_verb") == 0) {
-                if (uc_mgr->active_verb == NULL)
-                        return -ENOENT;
+                if (uc_mgr->active_verb == NULL) {
+                        err = -ENOENT;
+			goto __end;
+		}
                 *value = strdup(uc_mgr->active_verb->name);
                 if (*value == NULL) {
                         err = -ENOMEM;
-- 
1.7.0.4
