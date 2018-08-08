From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 03/13] conf/ucm: bytcr-rt5651: Configure all
	volumes at 0dB
Date: Wed,  8 Aug 2018 11:05:33 +0200
Message-ID: <20180808090543.15181-3-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 290DC2678CC
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:48 +0200 (CEST)
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

The volumes are taken from this commit:
https://github.com/plbossart/UCM/commit/753e2430cd0e6cafbf10c6b29b689dbd32ac5250

That commit also adds line-in support, so it has not been
taken in its entirety.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index 3bf7f69a..27a7b5c6 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -98,16 +98,13 @@ SectionDefaults [
 	cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
 
 	# default state
-	cset "name='ADC Capture Volume' 126"
 	cset "name='HPO MIX DAC1 Switch' on"
 	cset "name='HPO MIX HPVOL Switch' off"
-	cset "name='HP Playback Volume' 0"
 	cset "name='HPO L Playback Switch' off"
 	cset "name='HPO R Playback Switch' off"
 	cset "name='HPOVOL L Switch' on"
 	cset "name='HPOVOL R Switch' on"
 	cset "name='IF1 ASRC Switch' on"
-	cset "name='IN Capture Volume' 27"
 	cset "name='IN2 Boost' 1"
 	cset "name='IN1 Boost' 1"
 	cset "name='LOUT L Playback Switch' on"
@@ -126,6 +123,13 @@ SectionDefaults [
 	cset "name='Headphone Switch' off"
 	cset "name='Speaker Switch' off"
 
+	# volumes for 0dB
+	cset "name='OUT Playback Volume' 31"
+	cset "name='HP Playback Volume' 31"
+	cset "name='IN Capture Volume' 23"
+	cset "name='ADC Capture Volume' 47"
+	cset "name='DAC1 Playback Volume' 175"
+
 	# input
 	cset "name='Stereo1 ADC L1 Mux' ADC"
 	cset "name='Stereo1 ADC R1 Mux' ADC"
-- 
2.18.0
