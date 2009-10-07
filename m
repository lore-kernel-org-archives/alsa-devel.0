From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/3] ascenario: Fix
	snd_scenario_get_control_id() declaration to match implementation
Date: Wed,  7 Oct 2009 15:55:57 +0200
Message-ID: <1254923758-14598-3-git-send-email-stefan@datenfreihafen.org>
References: <1254923758-14598-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id D51DD1038A0
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 15:56:06 +0200 (CEST)
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

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 include/ascenario.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ascenario.h b/include/ascenario.h
index 3055cfa..6119f49 100644
--- a/include/ascenario.h
+++ b/include/ascenario.h
@@ -166,8 +166,8 @@ const char *snd_scenario_get_scn(snd_scenario_t *scn);
  *
  * Get the control id for the current scenario.
  */
-int snd_scenario_get_kcontrol(snd_scenario_t *scn,
-                              int kctl_type, snd_ctl_elem_id_t *id);
+int snd_scenario_get_control_id(snd_scenario_t *scn,
+                                int kctl_type, snd_ctl_elem_id_t *id);
 
 /**
  * \brief set integer value
-- 
1.6.4.3
