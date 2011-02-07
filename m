From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/2] hdspmixer: Style and purity fixes for name
	arrays.
Date: Mon,  7 Feb 2011 18:55:26 +0100
Message-ID: <1297101326-10509-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1297101326-10509-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1297101326-10509-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Contribution by Fredrik Lingvall <fredrik.lingvall@gmail.com>

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 hdspmixer/src/HDSPMixerSelector.cxx |  124 ++++++++++++++++++-----------------
 1 files changed, 65 insertions(+), 59 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index 23cb744..bc18f60 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -36,15 +36,14 @@ static char *destinations_madi_ds[16] = {
   "1+2", "3+4", "5+6", "7+8",
   "9+10", "11+12", "13+14", "15+16",
   "17+18", "19+20", "21+22", "23+24",
-  "25+26", "27+28", "29+30", "31+32",
+  "25+26", "27+28", "29+30", "31+32"
 };
 
 static char *destinations_madi_qs[8] = {
   "1+2", "3+4", "5+6", "7+8",
-  "9+10", "11+12", "13+14", "15+16",
+  "9+10", "11+12", "13+14", "15+16"
 };
 
-
 static char *destinations_aes[8] = {
   "AES 1+2", "AES 3+4", "AES 5+6", "AES 7+8",
   "AES 9+10", "AES 11+12", "AES 13+14", "AES 15+16",
@@ -82,73 +81,80 @@ static char *destinations_raydat_qs[6] = {
 static char *destinations_aio_ss[8] = {
   "AN 1+2",
   "AES",
-  "SPDIF", 
+  "SPDIF",
   "A 1+2", "A 3+4", "A 5+6", "A 7+8",
-  "Phones",
+  "Phones"
 };
 
 static char *destinations_aio_ds[6] = {
   "AN 1+2", 
   "AES",
-  "SPDIF", 
-  "A 1+2", "A 3+4"
-  "Phones",
+  "SPDIF",
+  "A 1+2", "A 3+4",
+  "Phones"
 };
 
 static char *destinations_aio_qs[5] = {
   "AN 1+2",
   "AES",
-  "SPDIF", 
-  "A 1+2"
-  "Phones",
+  "SPDIF",
+  "A 1+2",
+  "Phones"
+};
+
+static char *destinations_mf_ss[10] = {
+  "AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
+  "A 1+2", "A 3+4", "A 5+6", "A 7+8",
+  "SPDIF", "Analog"
+};
+
+static char *destinations_mf_ds[8] = {
+  "AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
+  "A 1+2", "A 3+4",
+  "SPDIF", "Analog"
+};
+
+static char *destinations_df_ss[14] = {
+  "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
+  "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
+  "A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
+  "SPDIF", "Analog"
 };
 
-    static char *destinations_mf_ss[10] = {
-	"AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
-	"A 1+2", "A 3+4", "A 5+6", "A 7+8",
-	"SPDIF", "Analog"
-    };
-    static char *destinations_mf_ds[8] = {
-	"AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
-	"A 1+2", "A 3+4",
-        "SPDIF", "Analog"
-    };
-    static char *destinations_df_ss[14] = {
-	"A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
-	"A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
-	"A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
-	"SPDIF", "Analog"
-    };
-    static char *destinations_df_ds[8] = {
-	"A1 1+2", "A1 3+4",
-	"A2 1+2", "A2 3+4",
-	"A3 1+2", "A3 3+4",
-	"SPDIF", "Analog"
-    };
-    static char *destinations_h9652_ss[13] = {
-	"A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
-	"A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
-	"A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
-	"SPDIF"
-    };
+static char *destinations_df_ds[8] = {
+  "A1 1+2", "A1 3+4",
+  "A2 1+2", "A2 3+4",
+  "A3 1+2", "A3 3+4",
+  "SPDIF", "Analog"
+};
 
-    static char *destinations_h9652_ds[7] = {
-	"A1 1+2", "A1 3+4",
-	"A2 1+2", "A2 3+4",
-	"A3 1+2", "A3 3+4",
-	"SPDIF"
-    };
-    static char *destinations_h9632_ss[8] = {
-	"A 1+2", "A 3+4", "A 5+6", "A 7+8",
-	"SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"
-    };
-    static char *destinations_h9632_ds[6] = {
-	"A 1+2", "A 3+4",
-	"SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
-    };
-    static char *destinations_h9632_qs[4] = {
-	"SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
-    };
+static char *destinations_h9652_ss[13] = {
+  "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
+  "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
+  "A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
+  "SPDIF"
+};
+
+static char *destinations_h9652_ds[7] = {
+  "A1 1+2", "A1 3+4",
+  "A2 1+2", "A2 3+4",
+  "A3 1+2", "A3 3+4",
+  "SPDIF"
+};
+
+static char *destinations_h9632_ss[8] = {
+  "A 1+2", "A 3+4", "A 5+6", "A 7+8",
+  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"
+};
+
+static char *destinations_h9632_ds[6] = {
+  "A 1+2", "A 3+4",
+  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
+};
+
+static char *destinations_h9632_qs[4] = {
+  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
+};
 
 HDSPMixerSelector::HDSPMixerSelector(int x, int y, int w, int h):Fl_Menu_(x, y, w, h)
 {
-- 
1.7.2.3
