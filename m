From: han.lu@intel.com
Subject: [PATCH 2/2] conf/ucm: broadwell-rt286: add ucm config
Date: Wed,  4 Mar 2015 10:35:49 +0800
Message-ID: <1425436549-8188-2-git-send-email-han.lu@intel.com>
References: <1425436549-8188-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1425436549-8188-1-git-send-email-han.lu@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, "Lu, Han" <han.lu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

The configure should apply to all Broadwell-rt286 boards from Intel,
like Wilson Beach SDS Ultrabook.

Signed-off-by: Lu, Han <han.lu@intel.com>
Author: Bard Liao <bardliao@realtek.com>

diff --git a/src/conf/ucm/broadwell-rt286/HiFi b/src/conf/ucm/broadwell-rt286/HiFi
new file mode 100644
index 0000000..08f5c50
--- /dev/null
+++ b/src/conf/ucm/broadwell-rt286/HiFi
@@ -0,0 +1,128 @@
+# Use case Configuration for Nexus 7
+# Adapted to Ubuntu Touch by David Henningsson <david.henningsson@canonical.com>
+
+SectionVerb {
+
+	EnableSequence [
+	]
+
+	DisableSequence [
+	]
+
+	# ALSA PCM
+	Value {
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:broadwellrt286"
+		CapturePCM "hw:broadwellrt286"
+	}
+}
+
+SectionDevice."Headphones" {
+	Comment "Headphones playback"
+
+	ConflictingDevice [
+		"Speaker"
+	]
+
+	EnableSequence [
+		cdev "hw:broadwellrt286"
+		cset "name='Master Playback Volume' 30"
+		cset "name='HPO L Switch' on"
+		cset "name='HPO R Switch' on"
+		cset "name='Headphone Jack Switch' on"
+		cset "name='DAC0 Playback Volume' 100"
+	]
+
+	DisableSequence [
+		cdev "hw:broadwellrt286"
+		cset "name='Headphone Jack Switch' off"
+		cset "name='HPO L Switch' off"
+		cset "name='HPO R Switch' off"
+	]
+
+	Value {
+		PlaybackChannels "2"
+		JackDev "rt286-jack"
+		JackControl "Headset Jack"
+		JackHWMute "Speaker"
+	}
+}
+
+SectionDevice."Speaker" {
+	Comment "Speaker playback"
+
+	ConflictingDevice [
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:broadwellrt286"
+		cset "name='Master Playback Volume' 30"
+		cset "name='DAC0 Playback Volume' 127"
+		cset "name='SPO Switch' on"
+		cset "name='Speaker Playback Switch' on"
+		cset "name='Speaker Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:broadwellrt286"
+		cset "name='Speaker Switch' off"
+		cset "name='Speaker Playback Switch' off"
+		cset "name='SPO Switch' 0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
+
+SectionDevice."Handset" {
+	Comment "Handset Microphone"
+
+	ConflictingDevice [
+		"Mainmic"
+	]
+
+	EnableSequence [
+		cdev "hw:broadwellrt286"
+
+		cset "name='ADC 0 Mux' 0"
+		cset "name='ADC0 Capture Switch' on"
+		cset "name='ADC0 Capture Volume' 127"
+		cset "name='AMIC Volume' 1"
+	]
+
+	DisableSequence [
+		cdev "hw:broadwellrt286"
+		cset "name='ADC0 Capture Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
+
+SectionDevice."Mainmic" {
+	Comment "Main Microphone"
+
+	ConflictingDevice [
+		"Handset"
+	]
+
+	EnableSequence [
+		cdev "hw:broadwellrt286"
+
+		cset "name='ADC 0 Mux' 2"
+		cset "name='ADC0 Capture Switch' on"
+		cset "name='ADC0 Capture Volume' 127"
+	]
+
+	DisableSequence [
+		cdev "hw:broadwellrt286"
+		cset "name='ADC0 Capture Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/broadwell-rt286/broadwell-rt286.conf b/src/conf/ucm/broadwell-rt286/broadwell-rt286.conf
new file mode 100644
index 0000000..4a176cd
--- /dev/null
+++ b/src/conf/ucm/broadwell-rt286/broadwell-rt286.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "HiFi"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:broadwellrt286"
+]
-- 
2.1.0
