From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ASoC: doc: ReSTize pops_clicks.txt
Date: Thu, 10 Nov 2016 22:47:19 +0100
Message-ID: <20161110214722.14698-8-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 380F42673DA
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:28 +0100 (CET)
In-Reply-To: <20161110214722.14698-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

A simple conversion from a plain text file.
The file name was changed from "pops_clicks" to "pops-clicks" to align
with others.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/soc/index.rst                         |  1 +
 .../{alsa/soc/pops_clicks.txt => soc/pops-clicks.rst}     | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
 rename Documentation/sound/{alsa/soc/pops_clicks.txt => soc/pops-clicks.rst} (87%)

diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index 4ac3585e7dd1..4dd679927a91 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -13,3 +13,4 @@ The documentation is spilt into the following sections:-
    dapm
    platform
    machine
+   pops-clicks
diff --git a/Documentation/sound/alsa/soc/pops_clicks.txt b/Documentation/sound/soc/pops-clicks.rst
similarity index 87%
rename from Documentation/sound/alsa/soc/pops_clicks.txt
rename to Documentation/sound/soc/pops-clicks.rst
index e1e74daa4497..de7eb2a6604a 100644
--- a/Documentation/sound/alsa/soc/pops_clicks.txt
+++ b/Documentation/sound/soc/pops-clicks.rst
@@ -1,3 +1,4 @@
+=====================
 Audio Pops and Clicks
 =====================
 
@@ -20,10 +21,11 @@ currently, however future audio codec hardware will have better pop and click
 suppression.  Pops can be reduced within playback by powering the audio
 components in a specific order. This order is different for startup and
 shutdown and follows some basic rules:-
+::
 
- Startup Order :- DAC --> Mixers --> Output PGA --> Digital Unmute
-
- Shutdown Order :- Digital Mute --> Output PGA --> Mixers --> DAC
+   Startup Order :- DAC --> Mixers --> Output PGA --> Digital Unmute
+  
+   Shutdown Order :- Digital Mute --> Output PGA --> Mixers --> DAC
 
 This assumes that the codec PCM output path from the DAC is via a mixer and then
 a PGA (programmable gain amplifier) before being output to the speakers.
@@ -36,10 +38,11 @@ Capture artifacts are somewhat easier to get rid as we can delay activating the
 ADC until all the pops have occurred. This follows similar power rules to
 playback in that components are powered in a sequence depending upon stream
 startup or shutdown.
+::
 
- Startup Order - Input PGA --> Mixers --> ADC
-
- Shutdown Order - ADC --> Mixers --> Input PGA
+   Startup Order - Input PGA --> Mixers --> ADC
+  
+   Shutdown Order - ADC --> Mixers --> Input PGA
 
 
 Zipper Noise
-- 
2.10.2
