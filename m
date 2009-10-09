From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/3] ascenario: Convert last sprintf() to
	snprintf()
Date: Fri,  9 Oct 2009 17:53:30 +0200
Message-ID: <1255103612-11134-3-git-send-email-stefan@datenfreihafen.org>
References: <1255103612-11134-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 441F1103B30
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 17:53:43 +0200 (CEST)
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

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index d2a9519..49845dc 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -554,11 +554,11 @@ static int read_sequence_file(snd_scenario_t *scn, int position)
 	struct scenario_info *info = &scn->scenario[scn->current_scenario];
 
 	if (position == PRE_SEQ) {
-		sprintf(filename, "%s/%s/%s", ALSA_SCN_DIR, scn->card_name,
+		snprintf(filename, MAX_FILE, "%s/%s/%s", ALSA_SCN_DIR, scn->card_name,
 			info->pre_sequence_file);
 	}
 	else {
-		sprintf(filename, "%s/%s/%s", ALSA_SCN_DIR, scn->card_name,
+		snprintf(filename, MAX_FILE, "%s/%s/%s", ALSA_SCN_DIR, scn->card_name,
 			info->post_sequence_file);
 	}
 
@@ -777,7 +777,7 @@ static int import_master_config(snd_scenario_t *scn)
 	FILE *f;
 	char filename[MAX_FILE];
 
-	sprintf(filename, "%s/%s.conf", ALSA_SCN_DIR, scn->card_name);
+	snprintf(filename, MAX_FILE, "%s/%s.conf", ALSA_SCN_DIR, scn->card_name);
 
 	fd = open(filename, O_RDONLY | O_NOATIME);
 	if (fd < 0) {
-- 
1.6.4.3
