From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/3] ascenario: Fix typedef for snd_scenario_t
Date: Tue,  6 Oct 2009 17:54:29 +0200
Message-ID: <1254844471-12987-2-git-send-email-stefan@datenfreihafen.org>
References: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id D75AC243C4
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:54:47 +0200 (CEST)
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

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 include/ascenario.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/ascenario.h b/include/ascenario.h
index 003eabe..0c5acb9 100644
--- a/include/ascenario.h
+++ b/include/ascenario.h
@@ -128,7 +128,7 @@ extern "C" {
 #define SND_SCN_INT_QOS				1
 
 /** Scenario container */
-typedef snd_scenario_t snd_scenario_t;
+typedef struct _snd_scenario_t snd_scenario_t;
 
 /* TODO: add notification */
 
-- 
1.6.4.3
