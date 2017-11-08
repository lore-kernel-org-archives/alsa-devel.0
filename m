From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] conf/ucm: rt5651: Mute speakers on boot
Date: Wed,  8 Nov 2017 12:33:30 +0000
Message-ID: <20171108123330.12102-2-carlo@caione.org>
References: <20171108123330.12102-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 90CEB266D55
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 13:33:41 +0100 (CET)
Received: by mail-pf0-f195.google.com with SMTP id 17so1610471pfn.12
 for <alsa-devel@alsa-project.org>; Wed, 08 Nov 2017 04:33:41 -0800 (PST)
In-Reply-To: <20171108123330.12102-1-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

The UCM configuration is enabling the speakers in the SectionDefaults.
This is a problem when booting with an headset already connected since
the audio output is routed at the same time both on speakers and
heaphones until the jack is disconnected and reconnected again.

Fix this disabling all the outputs in the default mixer configuration.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index 60798ce7..069427b7 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -99,11 +99,11 @@ SectionDefaults [
 
 	# default state
 	cset "name='ADC Capture Volume' 126"
-	cset "name='HP Playback Volume' 29"
-	cset "name='HPO L Playback Switch' on"
+	cset "name='HP Playback Volume' 0"
+	cset "name='HPO L Playback Switch' off"
 	cset "name='HPO MIX DAC1 Switch' on"
 	cset "name='HPO MIX HPVOL Switch' on"
-	cset "name='HPO R Playback Switch' on"
+	cset "name='HPO R Playback Switch' off"
 	cset "name='HPOVOL L Switch' on"
 	cset "name='HPOVOL R Switch' on"
 	cset "name='IF1 ASRC Switch' on"
@@ -123,6 +123,8 @@ SectionDefaults [
 	cset "name='Stereo2 ADC MIXL ADC2 Switch' on"
 	cset "name='Stereo2 ADC MIXR ADC1 Switch' on"
 	cset "name='Stereo2 ADC MIXR ADC2 Switch' on"
+	cset "name='Headphone Switch' off"
+	cset "name='Speaker Switch' off"
 
 	# input
 	cset "name='Stereo1 ADC L1 Mux' ADC"
-- 
2.14.2
