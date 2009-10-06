From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 3/3] ascenario: Catchup with function
	declaration changes.
Date: Tue,  6 Oct 2009 17:54:31 +0200
Message-ID: <1254844471-12987-4-git-send-email-stefan@datenfreihafen.org>
References: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EE03243F4
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:54:49 +0200 (CEST)
In-Reply-To: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
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

This is just enough to compile ascenario.c with last changes to the
declarations.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index 157207a..ce0a795 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -1034,9 +1034,10 @@ int snd_scenario_reload(snd_scenario_t *scn)
 	return 0;
 }
 
-void snd_scenario_close(snd_scenario_t *scn)
+int snd_scenario_close(snd_scenario_t *scn)
 {
 	free_scn(scn);
+	return 0;
 }
 
 static int set_control(snd_ctl_t *handle, snd_ctl_elem_id_t *id,
@@ -1241,7 +1242,7 @@ close:
 	return ret;
 }
 
-int snd_scenario_dump(const char *card_name)
+int snd_scenario_dump(snd_output_t *output, const char *card_name)
 {
 	snd_ctl_t *handle;
 	snd_ctl_card_info_t *info;
@@ -1321,6 +1322,8 @@ const char *snd_scenario_get_scn(snd_scenario_t *scn)
 
 int snd_scenario_set_integer(snd_scenario_t *scn, int type, int value)
 {
+	int qos;
+
 	switch (type) {
 	case SND_SCN_INT_QOS:
 		scn->scenario[scn->current_scenario].qos = qos;
-- 
1.6.4.3
