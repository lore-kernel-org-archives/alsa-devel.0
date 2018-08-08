From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 02/13] conf/ucm: bytcr-rt5651: Do not use
	both DAC1 and HPVOL inputs for HP
Date: Wed,  8 Aug 2018 11:05:32 +0200
Message-ID: <20180808090543.15181-2-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4D12678CA
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:47 +0200 (CEST)
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

The headphones can either be driven directly from DAC1, or through
the HP volume mixer chain to allow volume control, both can be enabled
at the same time, but this should not be done.

Mix only DAC1 to the headphones and not the HP volume path, there
are 2 reasons to choice the DAC1 path;
1) It is the power-on-reset default
2) We don't expose the volume control to e.g. pulseaudio anyways so it
   is not useful

While at it also move the "HPO MIX DAC1" and "HPO MIX HPVOL" entries up a
bit so that they are no longer inbetween the "HPO L Playback Switch" and
"HPO R Playback Switch" entries.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf         | 2 --
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index 8ded2d52..bc604276 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -30,7 +30,6 @@ SectionDevice."Headphones" {
 		cset "name='Headphone Switch' on"
 		cset "name='HPO L Playback Switch' on"
 		cset "name='HPO R Playback Switch' on"
-		cset "name='HP Playback Volume' 100"
 	]
 
 	DisableSequence [
@@ -39,7 +38,6 @@ SectionDevice."Headphones" {
 		cset "name='Headphone Switch' off"
 		cset "name='HPO L Playback Switch' off"
 		cset "name='HPO R Playback Switch' off"
-		cset "name='HP Playback Volume' 0"
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index 069427b7..3bf7f69a 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -99,10 +99,10 @@ SectionDefaults [
 
 	# default state
 	cset "name='ADC Capture Volume' 126"
+	cset "name='HPO MIX DAC1 Switch' on"
+	cset "name='HPO MIX HPVOL Switch' off"
 	cset "name='HP Playback Volume' 0"
 	cset "name='HPO L Playback Switch' off"
-	cset "name='HPO MIX DAC1 Switch' on"
-	cset "name='HPO MIX HPVOL Switch' on"
 	cset "name='HPO R Playback Switch' off"
 	cset "name='HPOVOL L Switch' on"
 	cset "name='HPOVOL R Switch' on"
-- 
2.18.0
