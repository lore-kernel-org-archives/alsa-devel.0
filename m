From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/3] ascenario: Add check for set scenario in
	snd_scenario_get_control_id()
Date: Fri,  9 Oct 2009 17:53:29 +0200
Message-ID: <1255103612-11134-2-git-send-email-stefan@datenfreihafen.org>
References: <1255103612-11134-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id C7DC7103A50
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 17:53:39 +0200 (CEST)
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

Without this check we may have the situation that scn->current_scenario ==
scn->num_scenarios and then we get our values from a wrong memory area. Could
happen if you use the function directly after snd_scenario_list()

Also use short instead of int for the numids.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index 11912ab..d2a9519 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -1349,7 +1349,8 @@ int snd_scenario_get_integer(snd_scenario_t *scn, int type, int *value)
 int snd_scenario_get_control_id(snd_scenario_t *scn, int type,
 				snd_ctl_elem_id_t *id)
 {
-	int numid, ret, i, count, tmp;
+	short numid, tmp;
+	int ret, i, count;
 	snd_ctl_t *handle;
 	snd_ctl_card_info_t *info;
 	snd_ctl_elem_list_t *list;
@@ -1357,6 +1358,11 @@ int snd_scenario_get_control_id(snd_scenario_t *scn, int type,
 	snd_ctl_card_info_alloca(&info);
 	snd_ctl_elem_list_alloca(&list);
 
+	if (scn->current_scenario >= scn->num_scenarios) {
+		scn_error("%s: No scenario set.\n", __func__);
+                return -EINVAL;
+	}
+
 	switch (type) {
 	case SND_SCN_KCTL_MASTER_PLAYBACK_VOLUME:
 		numid = scn->scenario[scn->current_scenario].playback_volume_id;
-- 
1.6.4.3
