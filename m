From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] conf/ucm: bytcr-rt5640: Add default
	DisableSequence
Date: Thu, 31 May 2018 17:10:24 +0200
Message-ID: <20180531151026.29521-4-hdegoede@redhat.com>
References: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5FD26792D
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:10:32 +0200 (CEST)
In-Reply-To: <20180531151026.29521-1-hdegoede@redhat.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add a disable sequence powering off the SST mixer elements, loosely
based on the default DisableSequence from:
https://github.com/plbossart/UCM/blob/master/chtnau8824/HiFi.conf

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf |  2 ++
 .../bytcr-rt5640-mono-spk-in1-mic/HiFi.conf   |  2 ++
 .../bytcr-rt5640-mono-spk-in3-mic/HiFi.conf   |  2 ++
 .../HiFi.conf                                 |  2 ++
 .../bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf |  2 ++
 .../bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf |  2 ++
 src/conf/ucm/bytcr-rt5640/HiFi.conf           |  2 ++
 src/conf/ucm/bytcr/Makefile.am                |  2 +-
 src/conf/ucm/bytcr/PlatformDisableSeq.conf    | 20 +++++++++++++++++++
 9 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/ucm/bytcr/PlatformDisableSeq.conf

diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
index 47ca04f0..938b3592 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
index e280843d..f36b245e 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
index 511b7c98..1a08eded 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
index 8cf5cb7c..4587b2e1 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
index a617ba19..decd3960 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
index 83b31795..d243bf82 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5640/HiFi.conf b/src/conf/ucm/bytcr-rt5640/HiFi.conf
index 130671ca..c833fe74 100644
--- a/src/conf/ucm/bytcr-rt5640/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640/HiFi.conf
@@ -11,6 +11,8 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr/Makefile.am b/src/conf/ucm/bytcr/Makefile.am
index a0e5545e..f7a54cbd 100644
--- a/src/conf/ucm/bytcr/Makefile.am
+++ b/src/conf/ucm/bytcr/Makefile.am
@@ -1,4 +1,4 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/bytcr
-ucm_DATA = PlatformEnableSeq.conf
+ucm_DATA = PlatformEnableSeq.conf PlatformDisableSeq.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr/PlatformDisableSeq.conf b/src/conf/ucm/bytcr/PlatformDisableSeq.conf
new file mode 100644
index 00000000..9bb018bc
--- /dev/null
+++ b/src/conf/ucm/bytcr/PlatformDisableSeq.conf
@@ -0,0 +1,20 @@
+# disable audio output path
+cset "name='codec_out0 mix 0 pcm0_in Switch' off"
+cset "name='modem_out mix 0 pcm0_in Switch' off"
+
+cset "name='media0_out mix 0 media0_in Switch' off"
+cset "name='media0_out mix 0 media1_in Switch' off"
+cset "name='media0_out mix 0 media3_in Switch' off"
+
+cset "name='media0_in Gain 0 Switch' off"
+cset "name='media1_in Gain 0 Switch' off"
+cset "name='media3_in Gain 0 Switch' off"
+
+cset "name='pcm0_in Gain 0 Switch' off"
+cset "name='codec_out0 Gain 0 Switch' off"
+cset "name='modem_out Gain 0 Switch' off"
+
+# disable audio input path
+cset "name='pcm1_out Gain 0 Switch' off"
+cset "name='codec_in0 Gain 0 Switch' off"
+cset "name='modem_in Gain 0 Switch' off"
-- 
2.17.0
