From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] conf: Add basic infrastructure for 2.1
	surround sound
Date: Tue, 18 Feb 2014 16:41:48 +0100
Message-ID: <1392738109-9956-2-git-send-email-david.henningsson@canonical.com>
References: <1392738109-9956-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B6B92265602
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 16:41:52 +0100 (CET)
In-Reply-To: <1392738109-9956-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

For now, we do 2.1 over 5.1, because that's what ALSA allows per default.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/alsa.conf           |  3 +++
 src/conf/pcm/Makefile.am     |  2 +-
 src/conf/pcm/surround21.conf | 62 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/pcm/surround21.conf

diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index bc91df3..5c928e8 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -90,6 +90,8 @@ defaults.pcm.center_lfe.card defaults.pcm.card
 defaults.pcm.center_lfe.device defaults.pcm.device
 defaults.pcm.side.card defaults.pcm.card
 defaults.pcm.side.device defaults.pcm.device
+defaults.pcm.surround21.card defaults.pcm.card
+defaults.pcm.surround21.device defaults.pcm.device
 defaults.pcm.surround40.card defaults.pcm.card
 defaults.pcm.surround40.device defaults.pcm.device
 defaults.pcm.surround41.card defaults.pcm.card
@@ -131,6 +133,7 @@ pcm.front cards.pcm.front
 pcm.rear cards.pcm.rear
 pcm.center_lfe cards.pcm.center_lfe
 pcm.side cards.pcm.side
+pcm.surround21 cards.pcm.surround21
 pcm.surround40 cards.pcm.surround40
 pcm.surround41 cards.pcm.surround41
 pcm.surround50 cards.pcm.surround50
diff --git a/src/conf/pcm/Makefile.am b/src/conf/pcm/Makefile.am
index cc3286e..c548660 100644
--- a/src/conf/pcm/Makefile.am
+++ b/src/conf/pcm/Makefile.am
@@ -1,5 +1,5 @@
 cfg_files = default.conf front.conf rear.conf center_lfe.conf side.conf\
-	    surround40.conf surround41.conf \
+	    surround21.conf surround40.conf surround41.conf \
 	    surround50.conf surround51.conf \
 	    surround71.conf iec958.conf hdmi.conf modem.conf \
 	    dmix.conf dsnoop.conf \
diff --git a/src/conf/pcm/surround21.conf b/src/conf/pcm/surround21.conf
new file mode 100644
index 0000000..be29020
--- /dev/null
+++ b/src/conf/pcm/surround21.conf
@@ -0,0 +1,62 @@
+#
+#  Hardware output from 2.1 speakers.
+#  Samples must be positioned:
+#    chn0 - front left
+#    chn1 - front right
+#    chn2 - LFE
+#
+
+pcm.!surround21 {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_SURROUND21_CARD
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround21.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_SURROUND21_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround21.device
+			}
+		}
+	}
+	type route
+	slave.pcm {
+		@func refer
+		name {
+			@func concat
+			strings [
+				"cards."
+				{
+					@func card_driver
+					card $CARD
+				}
+				".pcm.surround51." $DEV ":CARD=" $CARD
+			]
+		}
+	}
+	slave.channels 6
+	ttable.0.0 1
+	ttable.1.1 1
+	ttable.2.5 1
+	hint {
+		description "2.1 Surround output to Front and Subwoofer speakers"
+		device $DEV
+	}
+}
-- 
1.9.rc1
