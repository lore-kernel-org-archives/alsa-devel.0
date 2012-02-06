From: Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH] Add default config for tegra-alc5632 (as found
	on paz00)
Date: Tue,  7 Feb 2012 00:51:38 +0400
Message-ID: <1328561498-19337-1-git-send-email-fercerpav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Paul Fertser <fercerpav@gmail.com>, alsa-devel@alsa-project.org, Oliver Grawert <ogra@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

This makes paz00 (aka Toshiba ac100, a popular arm-based netbook) use
dmix/dsnoop by default since it doesn't support hw mixing.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
Hi,

I haven't seen any other ASoC configs here so probably i'm missing
something obvious. My reasoning is that when a person uses a regular
notebook with HDA he gets DMix by default so it should be the case for this
less common netbook too.

Rate is set to 44100 because it's unlikely a person will listen to Hi-Fi
music and hence it avoids resampling for the most common usecase. Feel free
to drop if that's inappropriate, the device works fine with 48000 too.

 src/conf/cards/Makefile.am        |    1 +
 src/conf/cards/tegra-alc5632.conf |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 src/conf/cards/tegra-alc5632.conf

diff --git a/src/conf/cards/Makefile.am b/src/conf/cards/Makefile.am
index b7190e7..efed590 100644
--- a/src/conf/cards/Makefile.am
+++ b/src/conf/cards/Makefile.am
@@ -44,6 +44,7 @@ cfg_files = aliases.conf \
 	RME9652.conf \
 	SI7018.conf \
 	SB-XFi.conf \
+	tegra-alc5632.conf \
 	TRID4DWAVENX.conf \
 	USB-Audio.conf \
 	YMF744.conf \
diff --git a/src/conf/cards/tegra-alc5632.conf b/src/conf/cards/tegra-alc5632.conf
new file mode 100644
index 0000000..371fe2a
--- /dev/null
+++ b/src/conf/cards/tegra-alc5632.conf
@@ -0,0 +1,23 @@
+# default with dmix/dsnoop
+tegra-alc5632.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type asym
+	playback.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dmix:CARD=" $CARD ",RATE=44100" ]
+		}
+	}
+	capture.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dsnoop:CARD=" $CARD ",RATE=44100" ]
+		}
+	}
+}
+
-- 
1.7.3.4
