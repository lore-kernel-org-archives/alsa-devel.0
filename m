From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] alsaucm: Report failure to set a device due to
	missing verb setup
Date: Fri,  8 Oct 2010 14:11:54 -0700
Message-ID: <1286572314-8035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A03E9103860
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 23:11:44 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 alsaucm/usecase.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
index 2db26f1..d1420c0 100644
--- a/alsaucm/usecase.c
+++ b/alsaucm/usecase.c
@@ -94,8 +94,10 @@ static int list_verb_device_status(snd_use_case_mgr_t *uc_mgr)
 	int i, enabled, num;
 
 	verb = snd_use_case_get_verb(uc_mgr);
-	if (verb == NULL)
+	if (verb == NULL) {
+		printf(" no verb currently enabled.\n");
 		return -ENODEV;
+	}
 
 	num = snd_use_case_get_device_list(uc_mgr, verb, &device_list);
 	if (num <= 0) {
-- 
1.7.1
