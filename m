From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 5/5] UCM: snd_use_case_get: Don't segfault when
	no current verb
Date: Fri,  3 Jun 2011 14:56:34 -0600
Message-ID: <1307134594-32176-5-git-send-email-swarren@nvidia.com>
References: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F471103975
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 22:56:48 +0200 (CEST)
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

get_value, called by snd_use_case_get, uses uc_mgr->active_verb without
checking there is one, and hence can segfault. Fix this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/ucm/main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index db71f03..13ea1ed 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1180,6 +1180,9 @@ static int get_value(snd_use_case_mgr_t *uc_mgr,
 	struct use_case_device *dev;
 	int err;
 
+	if (!uc_mgr->active_verb)
+		return -ENOENT;
+
 	if (item != NULL) {
 		mod = find_modifier(uc_mgr, uc_mgr->active_verb, item, 0);
 		if (mod != NULL) {
-- 
1.7.0.4
