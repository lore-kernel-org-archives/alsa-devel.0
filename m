From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/3] ascenario: Rename SND_SCN_INT_QOS to
	SND_SCN_INT_QOS_POWER
Date: Wed,  7 Oct 2009 15:55:56 +0200
Message-ID: <1254923758-14598-2-git-send-email-stefan@datenfreihafen.org>
References: <1254923758-14598-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 664751038A0
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 15:56:05 +0200 (CEST)
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

This brings it in line with SND_POWER_QOS_* and emphasis the power consumption
background.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 include/ascenario.h |    2 +-
 src/ascenario.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/ascenario.h b/include/ascenario.h
index b139551..3055cfa 100644
--- a/include/ascenario.h
+++ b/include/ascenario.h
@@ -125,7 +125,7 @@ extern "C" {
  * Integer types
  */
 /** QoS volume */
-#define SND_SCN_INT_QOS				1
+#define SND_SCN_INT_QOS_POWER			1
 
 /** Scenario container */
 typedef struct snd_scenario snd_scenario_t;
diff --git a/src/ascenario.c b/src/ascenario.c
index 19d3856..f90192c 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -1323,7 +1323,7 @@ const char *snd_scenario_get_scn(snd_scenario_t *scn)
 int snd_scenario_set_integer(snd_scenario_t *scn, int type, int value)
 {
 	switch (type) {
-	case SND_SCN_INT_QOS:
+	case SND_SCN_INT_QOS_POWER:
 		scn->scenario[scn->current_scenario].qos = value;
 		return 0;
 	default:
@@ -1336,7 +1336,7 @@ int snd_scenario_get_integer(snd_scenario_t *scn, int type, int *value)
 	if (value == NULL)
 		return -EINVAL;
 	switch (type) {
-	case SND_SCN_INT_QOS:
+	case SND_SCN_INT_QOS_POWER:
 		*value = scn->scenario[scn->current_scenario].qos;
 		return 0;
 	default:
-- 
1.6.4.3
