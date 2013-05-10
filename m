From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH 5/5] tegraalc5632: add UCM config from Ubuntu
Date: Fri, 10 May 2013 14:51:10 +0200
Message-ID: <1368190270-29647-6-git-send-email-marcin@juszkiewicz.com.pl>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tygrysek.juszkiewicz.com.pl (tygrysek.juszkiewicz.com.pl
 [178.33.81.99]) by alsa0.perex.cz (Postfix) with ESMTP id DC557261609
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 14:51:24 +0200 (CEST)
In-Reply-To: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
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
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 tegraalc5632/tegraalc5632.conf | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tegraalc5632/tegraalc5632.conf

diff --git a/tegraalc5632/tegraalc5632.conf b/tegraalc5632/tegraalc5632.conf
new file mode 100644
index 0000000..958fade
--- /dev/null
+++ b/tegraalc5632/tegraalc5632.conf
@@ -0,0 +1,30 @@
+# UCM configuration for tegra-alc5632
+
+ValueDefaults {
+  PlaybackCTL "hw:0"
+  CaptureCTL "hw:0"
+}
+
+SectionDefaults [
+		exec "echo Im setting defaults for tegra-alc5632"
+		cdev "hw:tegraalc5632"
+		cset "name='Master Playback Switch' on"
+		cset "name='Master Playback Volume' 44,44"
+		cset "name='Headphone Playback Switch' on"
+		cset "name='Headphone Playback Volume' 21,21"
+		cset "name='Speaker Playback Switch' on"
+		cset "name='Speaker Playback Volume' 21,21"
+		cset "name='Speaker Mix DAC2SPK Playback Switch' on"
+		cset "name='SpeakerOut Mux' 2"
+		cset "name='SpeakerOut N Mux' LN/-R"
+		cset "name='AB-D Amp Mux' 0"
+		cset "name='HPL Mix DACL2HP Playback Switch' on"
+		cset "name='HPR Mix DACR2HP Playback Switch' on"
+		cset "name='Int Spk Switch' on"
+		cset "name='Left Headphone Mux' 1"
+		cset "name='Right Headphone Mux' 1"
+                cset "name='DMIC En Capture Switch' on"
+                cset "name='DMIC PreFilter Capture Switch' on"
+                cset "name='DMIC Boost Capture Volume' 4"
+                cset "name='Rec Capture Volume' 24"
+]
-- 
1.8.1.2
