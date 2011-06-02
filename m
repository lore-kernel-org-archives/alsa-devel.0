From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/2] alsaucm: Add list1 command for non-tuple
	lists
Date: Thu,  2 Jun 2011 16:45:12 -0600
Message-ID: <1307054713-32228-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B588D1037F2
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 00:45:19 +0200 (CEST)
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

snd_use_case_get_list returns lists of strings that are either:
a) A sequence of single strings
b) A sequence of pairs of strings all flattened into a single list

The current list command assumes layout (b) above, and hence prints
nothing when printing a single-entry list that's actually in layout (a).
Add a new command "list1" to dump lists in layout (a).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 alsaucm/usecase.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
index 83781d0..f24e63e 100644
--- a/alsaucm/usecase.c
+++ b/alsaucm/usecase.c
@@ -63,7 +63,8 @@ enum uc_cmd {
 	OM_RESET,
 	OM_RELOAD,
 	OM_LISTCARDS,
-	OM_LIST,
+	OM_LIST2,
+	OM_LIST1,
 
 	/* set/get */
 	OM_SET,
@@ -87,7 +88,8 @@ static struct cmd cmds[] = {
 	{ OM_RESET, 0, 1, "reset" },
 	{ OM_RELOAD, 0, 1, "reload" },
 	{ OM_LISTCARDS, 0, 0, "listcards" },
-	{ OM_LIST, 1, 1, "list" },
+	{ OM_LIST1, 1, 1, "list1" },
+	{ OM_LIST2, 1, 1, "list" },
 	{ OM_SET, 2, 1, "set" },
 	{ OM_GET, 1, 1, "get" },
 	{ OM_GETI, 1, 1, "geti" },
@@ -172,7 +174,7 @@ static int do_one(struct context *context, struct cmd *cmd, char **argv)
 {
 	const char **list, *str;
 	long lval;
-	int err, i;
+	int err, i, j, entries;
 
 	if (cmd->opencard && context->uc_mgr == NULL) {
 		fprintf(stderr, "%s: command '%s' requires an open card\n",
@@ -233,7 +235,17 @@ static int do_one(struct context *context, struct cmd *cmd, char **argv)
 		}
 		snd_use_case_free_list(list, err);
 		break;
-	case OM_LIST:
+	case OM_LIST1:
+	case OM_LIST2:
+		switch (cmd->code) {
+		case OM_LIST1:
+		    entries = 1;
+		    break;
+		case OM_LIST2:
+		    entries = 2;
+		    break;
+		}
+
 		err = snd_use_case_get_list(context->uc_mgr,
 					    argv[0],
 					    &list);
@@ -246,10 +258,11 @@ static int do_one(struct context *context, struct cmd *cmd, char **argv)
 		}
 		if (err == 0)
 			printf("  list is empty\n");
-		for (i = 0; i < err / 2; i++) {
-			printf("  %i: %s\n", i, list[i*2]);
-			if (list[i*2+1])
-				printf("    %s\n", list[i*2+1]);
+		for (i = 0; i < err / entries; i++) {
+			printf("  %i: %s\n", i, list[i*entries]);
+			for (j = 0; j < entries - 1; j++)
+				if (list[i*entries+j+1])
+					printf("    %s\n", list[i*entries+j+1]);
 		}
 		snd_use_case_free_list(list, err);
 		break;
-- 
1.7.0.4
