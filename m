From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/14] conf/ucm: bytcr-rt5651: Start with all
	outputs and inputs disabled
Date: Fri, 20 Jul 2018 09:27:32 +0200
Message-ID: <20180720072741.4632-6-hdegoede@redhat.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E9A0326772E
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 09:27:49 +0200 (CEST)
In-Reply-To: <20180720072741.4632-1-hdegoede@redhat.com>
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

Start with all switches disabled, so that e.g. the
LOUT L/R Playback Switches are not left enabled when starting with
headphones plugged in.

This fixes the platform clock being kept on by these in some cases.

While at also move the IN? Boost and IF1 ASRC Switch lines around
a bit to match the order from https://github.com/plbossart/UCM so
the profiles can be more easily compared.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index d6e8e48d..4bcc6a6c 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -123,14 +123,13 @@ SectionDefaults [
 	cset "name='HPO R Playback Switch' off"
 	cset "name='HPOVOL L Switch' on"
 	cset "name='HPOVOL R Switch' on"
-	cset "name='IF1 ASRC Switch' on"
-	cset "name='IN2 Boost' 1"
-	cset "name='IN1 Boost' 1"
-	cset "name='LOUT L Playback Switch' on"
 	cset "name='LOUT MIX DAC L1 Switch' on"
 	cset "name='LOUT MIX DAC R1 Switch' on"
-	cset "name='LOUT R Playback Switch' on"
-	cset "name='OUT Playback Volume' 33"
+	cset "name='IN1 Boost' 1"
+	cset "name='IN2 Boost' 1"
+	cset "name='IF1 ASRC Switch' on"
+	cset "name='LOUT L Playback Switch' off"
+	cset "name='LOUT R Playback Switch' off"
 	cset "name='Stereo DAC MIXL DAC L1 Switch' on"
 	cset "name='Stereo DAC MIXR DAC R1 Switch' on"
 	cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
@@ -160,4 +159,7 @@ SectionDefaults [
 	cset "name='RECMIXR BST3 Switch' off"
 	cset "name='RECMIXL BST2 Switch' off"
 	cset "name='RECMIXR BST2 Switch' off"
+	cset "name='Headset Mic Switch' off"
+	cset "name='Internal Mic Switch' off"
+	cset "name='Line In Switch' off"
 ]
-- 
2.17.1
