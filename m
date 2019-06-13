From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ucm: Dell WD15 set lineout controls
Date: Thu, 13 Jun 2019 16:53:09 -0700
Message-ID: <20190613235309.30984-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 234CDF80791
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 01:53:30 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id p184so222499pfp.7
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 16:53:30 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Curtis Malainey <cujomalainey@chromium.org>, Crag Wang <crag.wang@dell.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The lineout playback switch should be enabled and disabled when enabling
and disabling the device.

This commit needs to be tested by dell.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Cc: Dylan Reid <dgreid@chromium.org>
Cc: Crag Wang <crag.wang@dell.com>
---
 src/conf/ucm/Dell-WD15-Dock/HiFi.conf | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
index 1b6bd212..cab13c5d 100644
--- a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
+++ b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
@@ -1,3 +1,11 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:Dock"
+	]
+	DisableSequence [
+	]
+}
+
 SectionDevice."Headphone" {
 	Comment "Headphone"
 
@@ -14,6 +22,14 @@ SectionDevice."LineOut" {
 		PlaybackChannels "2"
 		PlaybackPCM "hw:Dock,1"
 	}
+	EnableSequence [
+		cdev "hw:Dock"
+		cset "name='Line Playback Switch' on"
+	]
+	DisableSequence [
+		cdev "hw:Dock"
+		cset "name='Line Playback Switch' off"
+	]
 }
 
 SectionDevice."Mic" {
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
