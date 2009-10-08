From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/2] ascenario: Reduce SND_SCN_* defines to the
	basics.
Date: Thu,  8 Oct 2009 17:29:18 +0200
Message-ID: <1255015758-4269-3-git-send-email-stefan@datenfreihafen.org>
References: <1255015758-4269-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 169EB103A46
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 17:29:28 +0200 (CEST)
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

Also fix two minor qhitespace issues while being at it.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 include/ascenario.h |   25 ++-----------------------
 1 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/ascenario.h b/include/ascenario.h
index 6119f49..bc1543a 100644
--- a/include/ascenario.h
+++ b/include/ascenario.h
@@ -48,7 +48,7 @@ extern "C" {
  *  See \ref ascenario page for more details.
  *  \{
  */
-     
+
 /**
  * Scenario IDs
  *
@@ -61,12 +61,8 @@ extern "C" {
 #define SND_SCN_PLAYBACK_HEADPHONES     "playback headphone"
 /** use headset for playback */
 #define SND_SCN_PLAYBACK_HEADSET        "playback headset"
-/** use bluetooth interface for playback */
-#define SND_SCN_PLAYBACK_BLUETOOTH      "playback bluetooth"
 /** use handset interface for playback */
 #define SND_SCN_PLAYBACK_HANDSET        "playback handset"
-/** use gsm interface for playback */
-#define SND_SCN_PLAYBACK_GSM            "playback gsm"
 /** use line interface for playback */
 #define SND_SCN_PLAYBACK_LINE           "playback line"
 
@@ -78,23 +74,6 @@ extern "C" {
 #define SND_SCN_CAPTURE_HEADSET         "capture headset"
 /** use handset input for capture */
 #define SND_SCN_CAPTURE_HANDSET         "capture handset"
-/** use bluetooth input for capture */
-#define SND_SCN_CAPTURE_BLUETOOTH       "capture bluetooth"
-/** use gsm input for capture */
-#define SND_SCN_CAPTURE_GSM             "capture gsm"
-
-/** phone call through gsm handset */
-#define SND_SCN_PHONECALL_GSM_HANDSET   "phonecall gsm handset"
-/** phone call through bluetooth handset */
-#define SND_SCN_PHONECALL_BT_HANDSET    "phonecall bt handset"
-/** phone call through ip handset */
-#define SND_SCN_PHONECALL_IP_HANDSET    "phonecall ip handset"
-/** phone call through gsm headset */
-#define SND_SCN_PHONECALL_GSM_HEADSET   "phonecall gsm headset"
-/** phone call through bluetooth headset */
-#define SND_SCN_PHONECALL_BT_HEADSET    "phonecall bt headset"
-/** phone call through ip headset */
-#define SND_SCN_PHONECALL_IP_HEADSET    "phonecall ip headset"
 
 /**
  * QOS
@@ -224,4 +203,4 @@ int snd_scenario_dump(snd_output_t *output, const char *card_name);
 }
 #endif
 
-#endif /* __ALSA_ASCENARIO_H */  
+#endif /* __ALSA_ASCENARIO_H */
-- 
1.6.4.3
