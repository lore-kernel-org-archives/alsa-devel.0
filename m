From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 07/13] conf/ucm: bytcr-rt5651: Fix ADC and
	Mic capture volumes
Date: Wed,  8 Aug 2018 11:05:37 +0200
Message-ID: <20180808090543.15181-7-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0952678D2
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:51 +0200 (CEST)
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

Fix ADC and Mic capture volumes, so that the microphone inputs actually
work.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/rt5651/EnableSeq.conf | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/conf/ucm/rt5651/EnableSeq.conf b/src/conf/ucm/rt5651/EnableSeq.conf
index 3ef9afc0..37bffecb 100644
--- a/src/conf/ucm/rt5651/EnableSeq.conf
+++ b/src/conf/ucm/rt5651/EnableSeq.conf
@@ -7,8 +7,6 @@ cset "name='HPOVOL L Switch' on"
 cset "name='HPOVOL R Switch' on"
 cset "name='LOUT MIX DAC L1 Switch' on"
 cset "name='LOUT MIX DAC R1 Switch' on"
-cset "name='IN1 Boost' 1"
-cset "name='IN2 Boost' 1"
 cset "name='IF1 ASRC Switch' on"
 cset "name='LOUT L Playback Switch' off"
 cset "name='LOUT R Playback Switch' off"
@@ -23,12 +21,20 @@ cset "name='Stereo2 ADC MIXR ADC2 Switch' on"
 cset "name='Headphone Switch' off"
 cset "name='Speaker Switch' off"
 
-# volumes for 0dB
+# volumes
 cset "name='OUT Playback Volume' 31"
 cset "name='HP Playback Volume' 31"
-cset "name='IN Capture Volume' 23"
-cset "name='ADC Capture Volume' 47"
 cset "name='DAC1 Playback Volume' 175"
+cset "name='IN Capture Volume' 23"
+# 47=0dB, 0.375 dB/step, set it to 6 dB to help with soft mics
+cset "name='ADC Capture Volume' 63"
+cset "name='ADC Capture Switch' on"
+# Set ADC Boost Gain to 3dB higher vals result in too much noise
+cset "name='ADC Boost Gain' 1"
+# Set IN1, IN2 and IN3 internal mic boost to 1
+cset "name='IN1 Boost' 1"
+cset "name='IN2 Boost' 1"
+cset "name='IN3 Boost' 1"
 
 # input
 cset "name='Stereo1 ADC L1 Mux' ADC"
-- 
2.18.0
