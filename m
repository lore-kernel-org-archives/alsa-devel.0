From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/2] alsa-lib: add LaCie Firewire
 Speakers/Griffin FireWave Surround driver
Date: Mon, 07 Feb 2011 10:14:49 +0100
Message-ID: <4D4FB809.80304@ladisch.de>
References: <4D46933D.5050609@ladisch.de> <4D4FB7C8.7090501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8CF60246C3
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 10:14:49 +0100 (CET)
In-Reply-To: <4D4FB7C8.7090501@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, Jay Fenlason <fenlason@redhat.com>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Add configuration files for the "default"/"front"/"surround40"/
"surround51" devices for the snd-firewire-speakers driver.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 src/conf/cards/Makefile.am     |    2 +
 src/conf/cards/FWSpeakers.conf |   26 ++++++++++++++
 src/conf/cards/FireWave.conf   |   61 +++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

--- alsa-lib/src/conf/cards/Makefile.am
+++ alsa-lib/src/conf/cards/Makefile.am
@@ -25,6 +25,8 @@ cfg_files = aliases.conf \
 	ENS1371.conf \
 	ES1968.conf \
 	FM801.conf \
+	FWSpeakers.conf \
+	FireWave.conf \
 	GUS.conf \
 	HDA-Intel.conf \
 	ICE1712.conf \
--- /dev/null
+++ alsa-lib/src/conf/cards/FWSpeakers.conf
@@ -0,0 +1,26 @@
+#
+# Configuration for the LaCie Firewire speakers
+#
+
+FWSpeakers.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type plug
+	slave.pcm {
+		@func concat
+		strings [ "dmix:" $CARD ",FORMAT=S32" ]
+	}
+}
+
+<confdir:pcm/front.conf>
+
+FWSpeakers.pcm.front.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+}
--- /dev/null
+++ alsa-lib/src/conf/cards/FireWave.conf
@@ -0,0 +1,61 @@
+#
+# Configuration for the Griffin FireWave Surround
+#
+
+FireWave.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type plug
+	slave.pcm {
+		@func concat
+		strings [ "dmix:" $CARD ",FORMAT=S32" ]
+	}
+}
+
+<confdir:pcm/front.conf>
+
+FireWave.pcm.front.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+}
+
+<confdir:pcm/surround40.conf>
+
+FireWave.pcm.surround40.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+}
+
+<confdir:pcm/surround41.conf>
+<confdir:pcm/surround50.conf>
+<confdir:pcm/surround51.conf>
+
+FireWave.pcm.surround51.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type route
+	ttable [
+		[ 1 0 0 0 0 0 ]
+		[ 0 1 0 0 0 0 ]
+		[ 0 0 0 0 1 0 ]
+		[ 0 0 0 0 0 1 ]
+		[ 0 0 1 0 0 0 ]
+		[ 0 0 0 1 0 0 ]
+	]
+	slave.pcm {
+		type hw
+		card $CARD
+	}
+}
