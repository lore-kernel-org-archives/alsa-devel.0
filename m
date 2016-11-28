From: <manohar.narkhede@imgtec.com>
Subject: [PATCH - alsa-lib 1/1] conf/cards: add support for
	pistachio-card.
Date: Mon, 28 Nov 2016 15:03:11 +0530
Message-ID: <1480325591-4681-1-git-send-email-manohar.narkhede@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Manohar Narkhede <Manohar.Narkhede@imgtec.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Manohar Narkhede <Manohar.Narkhede@imgtec.com>

Signed-off-by: Manohar Narkhede <Manohar.Narkhede@imgtec.com>

diff --git a/src/conf/cards/Makefile.am b/src/conf/cards/Makefile.am
index 008d399..60b5309 100644
--- a/src/conf/cards/Makefile.am
+++ b/src/conf/cards/Makefile.am
@@ -39,6 +39,7 @@ cfg_files = aliases.conf \
 	Maestro3.conf \
 	NFORCE.conf \
 	PC-Speaker.conf \
+	pistachio-card.conf \
 	PMac.conf \
 	PMacToonie.conf \
 	PS3.conf \
diff --git a/src/conf/cards/aliases.conf b/src/conf/cards/aliases.conf
index 4a92fb2..60f9d26 100644
--- a/src/conf/cards/aliases.conf
+++ b/src/conf/cards/aliases.conf
@@ -55,6 +55,7 @@ AV100 cards.CMI8788
 AV200 cards.CMI8788
 CMI8786 cards.CMI8788
 CMI8787 cards.CMI8788
+pistachio cards.pistachio-card
 
 <confdir:pcm/default.conf>
 <confdir:pcm/dmix.conf>
diff --git a/src/conf/cards/pistachio-card.conf b/src/conf/cards/pistachio-card.conf
new file mode 100644
index 0000000..9c0318d
--- /dev/null
+++ b/src/conf/cards/pistachio-card.conf
@@ -0,0 +1,34 @@
+#
+# Configuration for the pistachio chip
+#
+
+pistachio-card.pcm.default{
+        @args [ CARD ]
+        @args.CARD {
+                type string
+                default "pistachio"
+        }
+        @args.DEVICE {
+                type integer
+                default 2
+        }
+
+        type asym
+        capture.pcm {
+                type multi
+                slaves.a.pcm "hw:0,4"
+                slaves.a.channels 12
+                bindings.0.slave a
+                bindings.0.channel 4
+                bindings.1.slave a
+                bindings.1.channel 5
+        }
+
+        playback.pcm {
+                type hw
+                card $CARD
+                device $DEVICE
+
+        }
+
+}
-- 
2.1.0
