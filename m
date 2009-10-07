From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 3/3] ascenario: Implement
	snd_scenario_get_control_id()
Date: Wed,  7 Oct 2009 15:55:58 +0200
Message-ID: <1254923758-14598-4-git-send-email-stefan@datenfreihafen.org>
References: <1254923758-14598-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id A02C21038DE
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 15:56:08 +0200 (CEST)
In-Reply-To: <1254923758-14598-1-git-send-email-stefan@datenfreihafen.org>
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

This new function is used to get the control ids for our aliased control. It
replaces the different functions for {playback, capture}_{volume, switch}.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index f90192c..d753de0 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -1347,8 +1347,84 @@ int snd_scenario_get_integer(snd_scenario_t *scn, int type, int *value)
 int snd_scenario_get_control_id(snd_scenario_t *scn, int type,
 				snd_ctl_elem_id_t *id)
 {
-	/* not yet implemented */
-	return -EINVAL;
+	int numid, ret, i, count, tmp;
+	snd_ctl_t *handle;
+	snd_ctl_card_info_t *info;
+	snd_ctl_elem_list_t *list;
+
+	snd_ctl_card_info_alloca(&info);
+	snd_ctl_elem_list_alloca(&list);
+
+	switch (type) {
+	case SND_SCN_KCTL_MASTER_PLAYBACK_VOLUME:
+		numid = scn->scenario[scn->current_scenario].playback_volume_id;
+		break;
+	case SND_SCN_KCTL_MASTER_PLAYBACK_SWITCH:
+		numid = scn->scenario[scn->current_scenario].playback_switch_id;
+		 break;
+	case SND_SCN_KCTL_MASTER_CAPTURE_VOLUME:
+		numid = scn->scenario[scn->current_scenario].capture_volume_id;
+		break;
+	case SND_SCN_KCTL_MASTER_CAPTURE_SWITCH:
+		numid = scn->scenario[scn->current_scenario].capture_switch_id;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Where is id lookup from numid if you need it?
+	 * Get a list of all controls to step through */
+	ret = snd_ctl_open(&handle, scn->card_name, SND_CTL_READONLY);
+	if (ret < 0) {
+		scn_error("%s: control %s open retor: %s\n", __func__,
+			scn->card_name, snd_strerror(ret));
+		return ret;
+	}
+
+	ret = snd_ctl_card_info(handle, info);
+	if (ret < 0) {
+		scn_error("%s :control %s local retor: %s\n", __func__,
+			scn->card_name, snd_strerror(ret));
+		goto close;
+	}
+
+	ret = snd_ctl_elem_list(handle, list);
+	if (ret < 0) {
+		scn_error("%s: cannot determine controls: %s\n", __func__,
+			snd_strerror(ret));
+		goto close;
+	}
+
+	count = snd_ctl_elem_list_get_count(list);
+	if (count < 0) {
+		ret = 0;
+		goto close;
+	}
+
+	snd_ctl_elem_list_set_offset(list, 0);
+	if (snd_ctl_elem_list_alloc_space(list, count) < 0) {
+		scn_error("%s: not enough memory...\n", __func__);
+		ret =  -ENOMEM;
+		goto close;
+	}
+	if ((ret = snd_ctl_elem_list(handle, list)) < 0) {
+		scn_error("%s: cannot determine controls: %s\n", __func__,
+			snd_strerror(ret));
+		goto free;
+	}
+
+	/* Iterate through list and check for the right numid to find our id */
+	for (i = 0; i < count; ++i) {
+		snd_ctl_elem_list_get_id(list, i, id);
+		tmp = snd_ctl_elem_id_get_numid(id);
+		if (numid == tmp)
+			break;
+	}
+free:
+	snd_ctl_elem_list_free_space(list);
+close:
+	snd_ctl_close(handle);
+	return ret;
 }
 
 int snd_scenario_list(snd_scenario_t *scn, const char **list[])
-- 
1.6.4.3
