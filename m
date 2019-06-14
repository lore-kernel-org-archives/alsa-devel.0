From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH v2] ucm: Dell WD15 set lineout controls
Date: Thu, 13 Jun 2019 18:15:31 -0700
Message-ID: <20190614011530.33465-1-cujomalainey@chromium.org>
References: <20190613235309.30984-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CD71F8076F
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 03:15:54 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id a93so263253pla.7
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 18:15:54 -0700 (PDT)
In-Reply-To: <20190613235309.30984-1-cujomalainey@chromium.org>
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
 src/conf/ucm/Dell-WD15-Dock/HiFi.conf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
index 1b6bd212..8e8c0140 100644
--- a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
+++ b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
@@ -14,6 +14,14 @@ SectionDevice."LineOut" {
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
