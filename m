From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] conf/ucm: DAISY-I2S: Set default filter mode
	for HiFi.
Date: Tue, 14 May 2013 09:47:58 -0700
Message-ID: <1368550078-11562-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f201.google.com (mail-vc0-f201.google.com
 [209.85.220.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 67EDE26510D
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 18:48:03 +0200 (CEST)
Received: by mail-vc0-f201.google.com with SMTP id hz10so76803vcb.4
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 09:48:02 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Default to music mode filter for the HiFi use case on the Samsung ARM
Chromebook.  This mode is better at 44.1k and 48k audio than the
"Voice" setting.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 src/conf/ucm/DAISY-I2S/HiFi.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/ucm/DAISY-I2S/HiFi.conf b/src/conf/ucm/DAISY-I2S/HiFi.conf
index 66b0afa..d8c06ad 100644
--- a/src/conf/ucm/DAISY-I2S/HiFi.conf
+++ b/src/conf/ucm/DAISY-I2S/HiFi.conf
@@ -11,6 +11,7 @@ SectionVerb {
 		cset "name='Left ADC Mixer MIC2 Switch' on"
 		cset "name='Right ADC Mixer MIC2 Switch' on"
 		cset "name='EQ1 Mode' Default"
+		cset "name='DAI1 Filter Mode' Music"
 	]
 	DisableSequence [
 	]
-- 
1.8.1.3.605.g02339dd
