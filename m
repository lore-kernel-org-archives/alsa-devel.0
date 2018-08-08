From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 13/13] conf/ucm: bytcr-rt5640: Improve human
	readable input/output names
Date: Wed,  8 Aug 2018 11:05:43 +0200
Message-ID: <20180808090543.15181-13-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B2502678D4
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:57 +0200 (CEST)
In-Reply-To: <20180808090543.15181-1-hdegoede@redhat.com>
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

The Comment field is displayed tot the end user in various UIs as such
names like MonoSpeaker and DigitalMics without any spaces are no good.

Also the names themselves as well as how they get displayed in the
typical UI (in separate input / output tabs) makes the adding of
playback and capture to the comment superfluous and this looks weird
in the UI, so drop it.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/rt5640/DigitalMics.conf     | 2 +-
 src/conf/ucm/rt5640/HeadPhones.conf      | 2 +-
 src/conf/ucm/rt5640/HeadsetMic.conf      | 2 +-
 src/conf/ucm/rt5640/IN1-InternalMic.conf | 2 +-
 src/conf/ucm/rt5640/IN3-InternalMic.conf | 2 +-
 src/conf/ucm/rt5640/MonoSpeaker.conf     | 2 +-
 src/conf/ucm/rt5640/Speaker.conf         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/conf/ucm/rt5640/DigitalMics.conf b/src/conf/ucm/rt5640/DigitalMics.conf
index c7d54099..06b42f16 100644
--- a/src/conf/ucm/rt5640/DigitalMics.conf
+++ b/src/conf/ucm/rt5640/DigitalMics.conf
@@ -1,5 +1,5 @@
 SectionDevice."DigitalMics" {
-	Comment "DigitalMics capture"
+	Comment "Internal Digital Microphones"
 
 	ConflictingDevice [
 		"IN1-InternalMics"
diff --git a/src/conf/ucm/rt5640/HeadPhones.conf b/src/conf/ucm/rt5640/HeadPhones.conf
index 0e7149e5..38f37a6f 100644
--- a/src/conf/ucm/rt5640/HeadPhones.conf
+++ b/src/conf/ucm/rt5640/HeadPhones.conf
@@ -1,5 +1,5 @@
 SectionDevice."Headphones" {
-	Comment "Headphones playback"
+	Comment "Headphones"
 
 	ConflictingDevice [
 		"Speaker"
diff --git a/src/conf/ucm/rt5640/HeadsetMic.conf b/src/conf/ucm/rt5640/HeadsetMic.conf
index 4d54eed0..567d4122 100644
--- a/src/conf/ucm/rt5640/HeadsetMic.conf
+++ b/src/conf/ucm/rt5640/HeadsetMic.conf
@@ -1,5 +1,5 @@
 SectionDevice."HeadsetMic" {
-	Comment "Headset Mic capture"
+	Comment "Headset Microphone"
 
 	ConflictingDevice [
 		"IN1-InternalMics"
diff --git a/src/conf/ucm/rt5640/IN1-InternalMic.conf b/src/conf/ucm/rt5640/IN1-InternalMic.conf
index d18c21db..3bf31e64 100644
--- a/src/conf/ucm/rt5640/IN1-InternalMic.conf
+++ b/src/conf/ucm/rt5640/IN1-InternalMic.conf
@@ -1,5 +1,5 @@
 SectionDevice."IN1-InternalMics" {
-	Comment "Internal IN1 analog Mic capture"
+	Comment "Internal Microphone on IN1"
 
 	ConflictingDevice [
 		"DigitalMics"
diff --git a/src/conf/ucm/rt5640/IN3-InternalMic.conf b/src/conf/ucm/rt5640/IN3-InternalMic.conf
index 17d85229..e1a6c49b 100644
--- a/src/conf/ucm/rt5640/IN3-InternalMic.conf
+++ b/src/conf/ucm/rt5640/IN3-InternalMic.conf
@@ -1,5 +1,5 @@
 SectionDevice."IN3-InternalMics" {
-	Comment "Internal IN3 analog Mic capture"
+	Comment "Internal Microphone on IN3"
 
 	ConflictingDevice [
 		"DigitalMics"
diff --git a/src/conf/ucm/rt5640/MonoSpeaker.conf b/src/conf/ucm/rt5640/MonoSpeaker.conf
index 0fb54030..58ab7807 100644
--- a/src/conf/ucm/rt5640/MonoSpeaker.conf
+++ b/src/conf/ucm/rt5640/MonoSpeaker.conf
@@ -1,5 +1,5 @@
 SectionDevice."MonoSpeaker" {
-	Comment "MonoSpeaker playback"
+	Comment "Mono Speaker"
 
 	ConflictingDevice [
 		"Headphones"
diff --git a/src/conf/ucm/rt5640/Speaker.conf b/src/conf/ucm/rt5640/Speaker.conf
index b745ed06..a7df9fbf 100644
--- a/src/conf/ucm/rt5640/Speaker.conf
+++ b/src/conf/ucm/rt5640/Speaker.conf
@@ -1,5 +1,5 @@
 SectionDevice."Speaker" {
-	Comment "Speaker playback"
+	Comment "Speakers"
 
 	ConflictingDevice [
 		"Headphones"
-- 
2.18.0
