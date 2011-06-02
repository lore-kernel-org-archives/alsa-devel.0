From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/2] alsaucm: Don't double-free empty lists
Date: Thu,  2 Jun 2011 16:45:13 -0600
Message-ID: <1307054713-32228-2-git-send-email-swarren@nvidia.com>
References: <1307054713-32228-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C57A71037F2
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 00:45:20 +0200 (CEST)
In-Reply-To: <1307054713-32228-1-git-send-email-swarren@nvidia.com>
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

When snd_use_case_get_list (and hence also snd_use_case_card_list) returns
an empty list, alsaucm still attempts to free it. This ends up double-
freeing the returned list, or worse, freeing an invalid pointer, depending
on how snd_use_case_get_list gets implemented. Fix alsaucm to return early
on empty lists to avoid this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 alsaucm/usecase.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
index f24e63e..1c94680 100644
--- a/alsaucm/usecase.c
+++ b/alsaucm/usecase.c
@@ -226,8 +226,10 @@ static int do_one(struct context *context, struct cmd *cmd, char **argv)
 				snd_strerror(err));
 			return err;
 		}
-		if (err == 0)
+		if (err == 0) {
 			printf("  list is empty\n");
+			return 0;
+		}
 		for (i = 0; i < err / 2; i++) {
 			printf("  %i: %s\n", i, list[i*2]);
 			if (list[i*2+1])
@@ -256,8 +258,10 @@ static int do_one(struct context *context, struct cmd *cmd, char **argv)
 				snd_strerror(err));
 			return err;
 		}
-		if (err == 0)
+		if (err == 0) {
 			printf("  list is empty\n");
+			return 0;
+		}
 		for (i = 0; i < err / entries; i++) {
 			printf("  %i: %s\n", i, list[i*entries]);
 			for (j = 0; j < entries - 1; j++)
-- 
1.7.0.4
