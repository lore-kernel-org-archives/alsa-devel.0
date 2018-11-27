From: Hui Wang <hui.wang@canonical.com>
Subject: [alsa-lib][PATCH 1/2] conf/ucm: Add a UCM profile for
	Dell WD19 Dock USB-audio
Date: Tue, 27 Nov 2018 09:36:28 +0800
Message-ID: <20181127013629.7620-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 629BE26784E
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 02:36:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

USB-audio device on Dell WD19 docking station provides two individual
output PCM streams, one for headphone Jack and another for speaker out
Jack. A UCM profile gives the proper roles for these.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 .../ucm/Dell-WD19-Dock/Dell-WD19-Dock.conf    |  5 ++++
 src/conf/ucm/Dell-WD19-Dock/HiFi.conf         | 26 +++++++++++++++++++
 src/conf/ucm/Dell-WD19-Dock/Makefile.am       |  4 +++
 3 files changed, 35 insertions(+)
 create mode 100644 src/conf/ucm/Dell-WD19-Dock/Dell-WD19-Dock.conf
 create mode 100644 src/conf/ucm/Dell-WD19-Dock/HiFi.conf
 create mode 100644 src/conf/ucm/Dell-WD19-Dock/Makefile.am

diff --git a/src/conf/ucm/Dell-WD19-Dock/Dell-WD19-Dock.conf b/src/conf/ucm/Dell-WD19-Dock/Dell-WD19-Dock.conf
new file mode 100644
index 00000000..465ff550
--- /dev/null
+++ b/src/conf/ucm/Dell-WD19-Dock/Dell-WD19-Dock.conf
@@ -0,0 +1,5 @@
+Comment "USB-audio on Dell WD19 docking station"
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Default"
+}
diff --git a/src/conf/ucm/Dell-WD19-Dock/HiFi.conf b/src/conf/ucm/Dell-WD19-Dock/HiFi.conf
new file mode 100644
index 00000000..e1427a79
--- /dev/null
+++ b/src/conf/ucm/Dell-WD19-Dock/HiFi.conf
@@ -0,0 +1,26 @@
+SectionDevice."Headphone" {
+	Comment "Headphone"
+
+	Value {
+		PlaybackChannels "2"
+		PlaybackPCM "hw:Dock,0"
+	}
+}
+
+SectionDevice."Speaker" {
+	Comment "Speaker"
+
+	Value {
+		PlaybackChannels "2"
+		PlaybackPCM "hw:Dock,1"
+	}
+}
+
+SectionDevice."Mic" {
+	Comment "Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePCM "hw:Dock,0"
+	}
+}
diff --git a/src/conf/ucm/Dell-WD19-Dock/Makefile.am b/src/conf/ucm/Dell-WD19-Dock/Makefile.am
new file mode 100644
index 00000000..6549ae1b
--- /dev/null
+++ b/src/conf/ucm/Dell-WD19-Dock/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/Dell-WD19-Dock
+ucm_DATA = Dell-WD19-Dock.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
-- 
2.17.1
