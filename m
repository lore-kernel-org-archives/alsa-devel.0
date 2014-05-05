From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ASoC: sta350: fix DT bindings document
Date: Mon,  5 May 2014 11:49:22 +0200
Message-ID: <1399283363-16441-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 76558261ADF
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 11:49:31 +0200 (CEST)
Received: by mail-ee0-f51.google.com with SMTP id e51so501241eek.38
 for <alsa-devel@alsa-project.org>; Mon, 05 May 2014 02:49:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix a misleading property description, and denote the fact that
st,output-conf and st,ch*-output-mapping have to be passed as /bits/ 8.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/st,sta350.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sta350.txt b/Documentation/devicetree/bindings/sound/st,sta350.txt
index 9501888..ecd7a62 100644
--- a/Documentation/devicetree/bindings/sound/st,sta350.txt
+++ b/Documentation/devicetree/bindings/sound/st,sta350.txt
@@ -25,6 +25,7 @@ Optional properties:
 	2: 2 Channel (Full-Bridge) Power, 1 Channel FFX
 	3: 1 Channel Mono-Parallel
 	If parameter is missing, mode 0 will be enabled.
+	This property has to be specified as '/bits/ 8' value.
 
   -  st,ch1-output-mapping: Channel 1 output mapping
   -  st,ch2-output-mapping: Channel 2 output mapping
@@ -33,6 +34,7 @@ Optional properties:
 	1: Channel 2
 	2: Channel 3
 	If parameter is missing, channel 1 is choosen.
+	This properties have to be specified as '/bits/ 8' values.
 
   -  st,thermal-warning-recover:
 	If present, thermal warning recovery is enabled.
@@ -82,7 +84,7 @@ Optional properties:
 	If not present, preset DC coefficient is used.
 
   -  st,invalid-input-detect-mute:
-	If not present, automatic invalid input detect mute is enabled.
+	If present, automatic invalid input detect mute is enabled.
 
 
 
@@ -93,12 +95,12 @@ codec: sta350@38 {
 	reg = <0x1c>;
 	reset-gpios = <&gpio1 19 0>;
 	power-down-gpios = <&gpio1 16 0>;
-	st,output-conf = <0x3>;			// set output to 2-channel
+	st,output-conf = /bits/ 8  <0x3>;	// set output to 2-channel
 						// (full-bridge) power,
 						// 2-channel data-out
-	st,ch1-output-mapping = <0>;		// set channel 1 output ch 1
-	st,ch2-output-mapping = <0>;		// set channel 2 output ch 1
-	st,ch3-output-mapping = <0>;		// set channel 3 output ch 1
+	st,ch1-output-mapping = /bits/ 8 <0>;	// set channel 1 output ch 1
+	st,ch2-output-mapping = /bits/ 8 <0>;	// set channel 2 output ch 1
+	st,ch3-output-mapping = /bits/ 8 <0>;	// set channel 3 output ch 1
 	st,max-power-correction;		// enables power bridge
 						// correction for THD reduction
 						// near maximum power output
-- 
1.9.0
