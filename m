From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 3/6] Documentation/DocBook/writing-an-alsa-driver.tmpl: fix some typos
Date: Mon, 28 Jan 2013 23:42:29 +0100
Message-ID: <1359412952-1680-4-git-send-email-ospite@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-doc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Antonio Ospite <ao2@amarulasolutions.com>, Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

s/PAUSE_PUSE/PAUSE_PUSH/
s/happense/happens/

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index da2f443..c0781bb 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -2897,7 +2897,7 @@ struct _snd_pcm_runtime {
 
         <para>
           When the pcm supports the pause operation (given in the info
-        field of the hardware table), the <constant>PAUSE_PUSE</constant>
+        field of the hardware table), the <constant>PAUSE_PUSH</constant>
         and <constant>PAUSE_RELEASE</constant> commands must be
         handled here, too. The former is the command to pause the pcm,
         and the latter to restart the pcm again. 
@@ -3084,7 +3084,7 @@ struct _snd_pcm_runtime {
       <section id="pcm-interface-interrupt-handler-timer">
         <title>High frequency timer interrupts</title>
         <para>
-	This happense when the hardware doesn't generate interrupts
+	This happens when the hardware doesn't generate interrupts
         at the period boundary but issues timer interrupts at a fixed
         timer rate (e.g. es1968 or ymfpci drivers). 
         In this case, you need to check the current hardware
-- 
1.7.10.4

