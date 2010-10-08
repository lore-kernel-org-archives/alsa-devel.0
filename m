From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ucm: Don't crash on attempts to set missing
	verbs
Date: Fri,  8 Oct 2010 14:16:06 -0700
Message-ID: <1286572566-13672-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0BDA0103803
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 23:15:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mostly for the benefit of alsaucm which passes the specified verb (if
any) straight through, but the robustness fix seems better here.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 src/use-case.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/use-case.c b/src/use-case.c
index b45fe1f..ee44275 100644
--- a/src/use-case.c
+++ b/src/use-case.c
@@ -2786,6 +2786,9 @@ int snd_use_case_set_verb(snd_use_case_mgr_t *uc_mgr,
 {
 	int i = 0, ret = -EINVAL, inactive = 0;
 
+	if (!verb_name)
+		return -EINVAL;
+
 	pthread_mutex_lock(&uc_mgr->mutex);
 
 	uc_dbg("uc_mgr %p, verb_name %s", uc_mgr, verb_name);
-- 
1.7.1
