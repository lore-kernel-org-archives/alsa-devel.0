From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/2] ascenario: Bring back a bugfix and config
	token change from latest ascenario
Date: Thu,  8 Oct 2009 17:29:17 +0200
Message-ID: <1255015758-4269-2-git-send-email-stefan@datenfreihafen.org>
References: <1255015758-4269-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id F19B724368
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 17:29:29 +0200 (CEST)
In-Reply-To: <1255015758-4269-1-git-send-email-stefan@datenfreihafen.org>
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

The initial applied ascenario patch was not the latest one posted. This brings
back a small bugfix and the token name change requested by Mark
(MasterPlaybackVolume -> Master Playback Volume).

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index d753de0..11912ab 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -583,14 +583,16 @@ close:
 static int parse_scenario(snd_scenario_t *scn, FILE *f, int line_)
 {
 	struct scenario_info *info;
-	int line = line_ - 1, id = 0, file = 0;
+	int line = line_ - 1, id = 0, file = 0, len, offset;
 	char buf[MAX_BUF], *tbuf;
 
+	offset = sizeof(scn->scenario);
 	scn->scenario = realloc(scn->scenario,
 		(scn->num_scenarios + 1) * sizeof(struct scenario_info));
+	len = sizeof(scn->scenario) - offset;
 	if (scn->scenario == NULL)
 		return -ENOMEM;
-	bzero(scn->scenario, sizeof(struct scenario_info));
+	bzero(scn->scenario + offset, len);
 	info = scn->scenario + scn->num_scenarios;
 
 	/* Set sequence filename to NULL as it is optional and we want to check
@@ -640,40 +642,40 @@ static int parse_scenario(snd_scenario_t *scn, FILE *f, int line_)
 			continue;
 		}
 
-		if (strncmp(tbuf, "MasterPlaybackVolume", 20) == 0) {
-			info->playback_volume_id = get_int(tbuf + 20);
+		if (strncmp(tbuf, "Master Playback Volume", 22) == 0) {
+			info->playback_volume_id = get_int(tbuf + 22);
 			if (info->playback_volume_id < 0) {
-				scn_error("%s: failed to get MasterPlaybackVolume\n",
+				scn_error("%s: failed to get Master Playback Volume\n",
 					__func__);
 				goto err;
 			}
 			continue;
 		}
 
-		if (strncmp(tbuf, "MasterPlaybackSwitch", 20) == 0) {
-			info->playback_switch_id = get_int(tbuf + 20);
+		if (strncmp(tbuf, "Master Playback Switch", 22) == 0) {
+			info->playback_switch_id = get_int(tbuf + 22);
 			if (info->playback_switch_id < 0) {
-				scn_error("%s: failed to get MasterPlaybackSwitch\n",
+				scn_error("%s: failed to get Master Playback Switch\n",
 					__func__);
 				goto err;
 			}
 			continue;
 		}
 
-		if (strncmp(tbuf, "MasterCaptureVolume", 19) == 0) {
-			info->capture_volume_id = get_int(tbuf + 19);
+		if (strncmp(tbuf, "Master Capture Volume", 21) == 0) {
+			info->capture_volume_id = get_int(tbuf + 21);
 			if (info->capture_volume_id < 0) {
-				scn_error("%s: failed to get MasterCaptureVolume\n",
+				scn_error("%s: failed to get Master Capture Volume\n",
 					__func__);
 				goto err;
 			}
 			continue;
 		}
 
-		if (strncmp(tbuf, "MasterCaptureSwitch", 19) == 0) {
-			info->capture_switch_id = get_int(tbuf + 19);
+		if (strncmp(tbuf, "Master Capture Switch", 21) == 0) {
+			info->capture_switch_id = get_int(tbuf + 21);
 			if (info->capture_switch_id < 0) {
-				scn_error("%s: failed to get MasterCaptureSwitch\n",
+				scn_error("%s: failed to get Master Capture Switch\n",
 					__func__);
 				goto err;
 			}
@@ -1242,7 +1244,7 @@ close:
 	return ret;
 }
 
-int snd_scenario_dump(snd_output_t *output, const char *card_name)
+int snd_scenario_dump(snd_output_t *output ATTRIBUTE_UNUSED, const char *card_name)
 {
 	snd_ctl_t *handle;
 	snd_ctl_card_info_t *info;
-- 
1.6.4.3
