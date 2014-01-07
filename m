From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Docs: Update the Overview document
Date: Tue,  7 Jan 2014 17:51:41 +0000
Message-ID: <1389117102-6488-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A9DE265087
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:52:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the ASoC overview to bring it up to date with the current code base
and include multi-component.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Documentation/sound/alsa/soc/overview.txt | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/sound/alsa/soc/overview.txt b/Documentation/sound/alsa/soc/overview.txt
index 138ac88..ff88f52 100644
--- a/Documentation/sound/alsa/soc/overview.txt
+++ b/Documentation/sound/alsa/soc/overview.txt
@@ -49,18 +49,23 @@ features :-
   * Machine specific controls: Allow machines to add controls to the sound card
     (e.g. volume control for speaker amplifier).
 
-To achieve all this, ASoC basically splits an embedded audio system into 3
-components :-
+To achieve all this, ASoC basically splits an embedded audio system into
+multiple re-usable component drivers :-
 
-  * Codec driver: The codec driver is platform independent and contains audio
-    controls, audio interface capabilities, codec DAPM definition and codec IO
-    functions.
+  * Codec class drivers: The codec class driver is platform independent and
+    contains audio controls, audio interface capabilities, codec DAPM
+    definition and codec IO functions. This class extends to BT, FM and MODEM
+    ICs if required. Codec class drivers should be generic code that can run
+    on any architecture and machine.
 
-  * Platform driver: The platform driver contains the audio DMA engine and audio
-    interface drivers (e.g. I2S, AC97, PCM) for that platform.
+  * Platform class drivers: The platform class driver includes the audio DMA
+    engine driver, digital audio interface (DAI) drivers (e.g. I2S, AC97, PCM)
+    and any audio DSP drivers for that platform.
 
-  * Machine driver: The machine driver handles any machine specific controls and
-    audio events (e.g. turning on an amp at start of playback).
+  * Machine class driver: The machine driver class acts as the glue that
+    decribes and binds the other component drivers together to form an ALSA
+    "sound card device". It handles any machine specific controls and
+    machine level audio events (e.g. turning on an amp at start of playback).
 
 
 Documentation
@@ -84,3 +89,7 @@ machine.txt: Machine driver internals.
 pop_clicks.txt: How to minimise audio artifacts.
 
 clocking.txt: ASoC clocking for best power performance.
+
+jack.txt: ASoC jack detection.
+
+DPCM.txt: Dynamic PCM - Describes DPCM with DSP examples.
-- 
1.8.3.2
