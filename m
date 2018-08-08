From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/13] conf/ucm: bytcr-rt5651: Change
	Speaker/Headphone en/disable sequences to fix switching
Date: Wed,  8 Aug 2018 11:05:35 +0200
Message-ID: <20180808090543.15181-5-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 076A126786A
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:50 +0200 (CEST)
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

pulseaudio will run the DisableSequence of the current playback device
before running the EnableSequence of the new playback device.

This causes the Platform Clock and BIAS to temporarily get turned off which
on the rt5651 breaks audio-streams which are playing when switching.

This commit moves the disabling to the EnableSequence of the other device
fixing this.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index bc604276..42fa2c9a 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -30,14 +30,19 @@ SectionDevice."Headphones" {
 		cset "name='Headphone Switch' on"
 		cset "name='HPO L Playback Switch' on"
 		cset "name='HPO R Playback Switch' on"
+		# Done after turning the HP on to keep the bias and clk on
+		cset "name='Speaker Switch' off"
+		cset "name='LOUT L Playback Switch' off"
+		cset "name='LOUT R Playback Switch' off"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
 		exec "echo Headphones playback disable sequence"
-		cset "name='Headphone Switch' off"
-		cset "name='HPO L Playback Switch' off"
-		cset "name='HPO R Playback Switch' off"
+		# This is done by the Speaker EnableSequence, so that the
+		# Platform Clock and BIAS do not temporarily get turned off
+		# as that breaks audio-streams which are playing when
+		# switching between Speaker/Headphone
 	]
 
 	Value {
@@ -57,12 +62,21 @@ SectionDevice."Speaker" {
 		cdev "hw:bytcrrt5651"
 		exec "echo Speaker enable sequence"
 		cset "name='Speaker Switch' on"
+		cset "name='LOUT L Playback Switch' on"
+		cset "name='LOUT R Playback Switch' on"
+		# Done after turning the speaker on to keep the bias and clk on
+		cset "name='Headphone Switch' off"
+		cset "name='HPO L Playback Switch' off"
+		cset "name='HPO R Playback Switch' off"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
 		exec "echo Speaker disable sequence"
-		cset "name='Speaker Switch' off"
+		# This is done by the Headphones EnableSequence, so that the
+		# Platform Clock and BIAS do not temporarily get turned off
+		# as that breaks audio-streams which are playing when
+		# switching between Speaker/Headphone
 	]
 
 	Value {
-- 
2.18.0
