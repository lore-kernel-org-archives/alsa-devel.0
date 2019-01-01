From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] conf/ucm: bytcr-rt5651: Document mono speaker
	wiring
Date: Tue,  1 Jan 2019 12:32:46 +0100
Message-ID: <20190101113246.18595-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 51987267783
 for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2019 12:32:50 +0100 (CET)
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

During my recent work on the bytcht-es8316 UCM profile I realized that the
bytcr-rt5651 devices with a single speaker use a differential setup just
like the es8316 does. The tell-tale here is the speaker going quiet when
playing the exact same sound on both channels when things are configured
for stereo speakers.

I've run some tests and the rt5651 does have a special mono balanced out
mode for its line-out but using this results in the same sound (and the
same loudness / volume of the sound) as our current solution, so adding
support for this to the kernel buys us nothing.

This commit makes no changes, it just documents my findings in a big
comment for future reference.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/codecs/rt5651/MonoSpeaker.conf | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/conf/ucm/codecs/rt5651/MonoSpeaker.conf b/src/conf/ucm/codecs/rt5651/MonoSpeaker.conf
index 0c3492fb..f4181d10 100644
--- a/src/conf/ucm/codecs/rt5651/MonoSpeaker.conf
+++ b/src/conf/ucm/codecs/rt5651/MonoSpeaker.conf
@@ -9,7 +9,21 @@ SectionDevice."MonoSpeaker" {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
 
-		# Map left and right input on left
+		# On most (all?) devices with a single / mono speaker an
+		# amplifier with a differential input connected between LOUT
+		# right and left is used. We deal with this by silencing the
+		# right output and mixing left + right to the left output.
+		#
+		# An alternative approach for devices using the differential
+		# setup would be to set bit 15 of register 5 in the codec,
+		# which turns the stereo unbalanced line out into a mono
+		# balanced line out.
+		#
+		# This possibility was discovered after we already shipped the
+		# current solution and the current solution has the advantage
+		# of also working on devices which only use LOUT left in
+		# unbalanced mode. The net result is the same for devices using
+		# the differential setup, so we just stick with what we have.
 		cset "name='Stereo DAC MIXR DAC R1 Switch' off"
 		cset "name='Stereo DAC MIXL DAC R1 Switch' on"
 
-- 
2.20.1
