From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 3/3] ascenario: Make sequences unique for every
	scenario.
Date: Fri,  9 Oct 2009 17:53:31 +0200
Message-ID: <1255103612-11134-4-git-send-email-stefan@datenfreihafen.org>
References: <1255103612-11134-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E83A103B26
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 17:53:42 +0200 (CEST)
In-Reply-To: <1255103612-11134-1-git-send-email-stefan@datenfreihafen.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

I could have sworn that worked before. Anyway, pre and post sequences are now
unique per scenario as they always should have been.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index 49845dc..945b776 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -71,6 +71,8 @@ struct scenario_info {
 	char *file;
 	char *pre_sequence_file;
 	char *post_sequence_file;
+	struct sequence_element *pre_seq_list; /* Linked list for pre sequence */
+	struct sequence_element *post_seq_list; /* Linked list for post sequence */
 	short playback_volume_id;
 	short playback_switch_id;
 	short capture_volume_id;
@@ -85,8 +87,6 @@ struct snd_scenario {
 	int current_scenario;
 	int num_scenarios; /* number of supported scenarios */
 	int num_kcontrols;  /* number of kcontrols */
-	struct sequence_element *pre_seq_list; /* Linked list for pre sequence */
-	struct sequence_element *post_seq_list; /* Linked list for post sequence */
 	const char **list;
 	struct scenario_info *scenario; /* var len array of scenario info */
 	struct control_settings *control; /* var len array of controls */
@@ -414,11 +414,11 @@ static void seq_list_append(snd_scenario_t *scn,
 	struct sequence_element *last, *tmp;
 
 	if (position) {
-		if (!scn->post_seq_list)
-			scn->post_seq_list = curr;
+		if (!scn->scenario[scn->current_scenario].post_seq_list)
+			scn->scenario[scn->current_scenario].post_seq_list = curr;
 
 		else {
-			tmp = scn->post_seq_list;
+			tmp = scn->scenario[scn->current_scenario].post_seq_list;
 			while (tmp) {
 				last = tmp;
 				tmp = tmp->next;
@@ -427,11 +427,11 @@ static void seq_list_append(snd_scenario_t *scn,
 		}
 	}
 	else {
-		if (!scn->pre_seq_list) {
-			scn->pre_seq_list = curr;
+		if (!scn->scenario[scn->current_scenario].pre_seq_list) {
+			scn->scenario[scn->current_scenario].pre_seq_list = curr;
 		}
 		else {
-			tmp = scn->pre_seq_list;
+			tmp = scn->scenario[scn->current_scenario].pre_seq_list;
 			while (tmp) {
 				last = tmp;
 				tmp = tmp->next;
@@ -595,10 +595,12 @@ static int parse_scenario(snd_scenario_t *scn, FILE *f, int line_)
 	bzero(scn->scenario + offset, len);
 	info = scn->scenario + scn->num_scenarios;
 
-	/* Set sequence filename to NULL as it is optional and we want to check
-	 * for  NULL to avoid segfaults */
+	/* Set to NULL as it is optional and we want to check for  NULL to
+	 * avoid segfaults */
 	info->pre_sequence_file = NULL;
 	info->post_sequence_file = NULL;
+	info->pre_seq_list = NULL;
+	info->post_seq_list = NULL;
 
 	while(fgets(buf, MAX_BUF, f) != NULL) {
 
@@ -953,10 +955,6 @@ static void free_scn(snd_scenario_t *scn)
 		free(scn->list);
 	if (scn->card_name)
 		free(scn->card_name);
-	if (scn->pre_seq_list)
-		free(scn->pre_seq_list);
-	if (scn->post_seq_list)
-		free(scn->post_seq_list);
 
 	if (scn->scenario) {
 		for (i = 0; i < scn->num_scenarios; i++) {
@@ -970,6 +968,10 @@ static void free_scn(snd_scenario_t *scn)
 				free(info->pre_sequence_file);
 			if (info->post_sequence_file)
 				free(info->post_sequence_file);
+			if (info->pre_seq_list)
+				free(info->pre_seq_list);
+			if (info->post_seq_list)
+				free(info->post_seq_list);
 		}
 		free(scn->scenario);
 	}
@@ -1216,8 +1218,9 @@ found:
 
 	/* If we have a sequence list that should be executed before the new
 	 * scenario is set do it now */
-	if (scn->pre_seq_list)
-		exec_sequence(scn->pre_seq_list, scn, list, handle);
+	if (scn->scenario[scn->current_scenario].pre_seq_list)
+		exec_sequence(scn->scenario[scn->current_scenario].pre_seq_list,
+			      scn, list, handle);
 
 	/* iterate through each kcontrol and add to db */
 	for (i = 0; i < count; ++i) {
@@ -1234,8 +1237,9 @@ found:
 
 	/* If we have a sequence list that should be executed after the new
 	 * scenario is set do it now */
-	if (scn->post_seq_list)
-		exec_sequence(scn->post_seq_list, scn, list, handle);
+	if (scn->scenario[scn->current_scenario].post_seq_list)
+		exec_sequence(scn->scenario[scn->current_scenario].post_seq_list,
+			      scn, list, handle);
 
 free:
 	snd_ctl_elem_list_free_space(list);
-- 
1.6.4.3
