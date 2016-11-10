From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ASoC: doc: ReSTize DAI.txt
Date: Thu, 10 Nov 2016 22:47:15 +0100
Message-ID: <20161110214722.14698-4-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CE7F62673CC
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:26 +0100 (CET)
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

A simple conversion from a plain text file with slight reformatting /
corrections.

The file name was changed to lower letters to align with others.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../sound/{alsa/soc/DAI.txt => soc/dai.rst}        | 28 ++++++++++++++--------
 Documentation/sound/soc/index.rst                  |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)
 rename Documentation/sound/{alsa/soc/DAI.txt => soc/dai.rst} (71%)

diff --git a/Documentation/sound/alsa/soc/DAI.txt b/Documentation/sound/soc/dai.rst
similarity index 71%
rename from Documentation/sound/alsa/soc/DAI.txt
rename to Documentation/sound/soc/dai.rst
index c9679264c559..55820e51708f 100644
--- a/Documentation/sound/alsa/soc/DAI.txt
+++ b/Documentation/sound/soc/dai.rst
@@ -1,3 +1,7 @@
+==================================
+ASoC Digital Audio Interface (DAI)
+==================================
+
 ASoC currently supports the three main Digital Audio Interfaces (DAI) found on
 SoC controllers and portable audio CODECs today, namely AC97, I2S and PCM.
 
@@ -5,21 +9,21 @@ SoC controllers and portable audio CODECs today, namely AC97, I2S and PCM.
 AC97
 ====
 
-  AC97 is a five wire interface commonly found on many PC sound cards. It is
+AC97 is a five wire interface commonly found on many PC sound cards. It is
 now also popular in many portable devices. This DAI has a reset line and time
 multiplexes its data on its SDATA_OUT (playback) and SDATA_IN (capture) lines.
 The bit clock (BCLK) is always driven by the CODEC (usually 12.288MHz) and the
 frame (FRAME) (usually 48kHz) is always driven by the controller. Each AC97
 frame is 21uS long and is divided into 13 time slots.
 
-The AC97 specification can be found at :-
+The AC97 specification can be found at :
 http://www.intel.com/p/en_US/business/design
 
 
 I2S
 ===
 
- I2S is a common 4 wire DAI used in HiFi, STB and portable devices. The Tx and
+I2S is a common 4 wire DAI used in HiFi, STB and portable devices. The Tx and
 Rx lines are used for audio transmission, whilst the bit clock (BCLK) and
 left/right clock (LRC) synchronise the link. I2S is flexible in that either the
 controller or CODEC can drive (master) the BCLK and LRC clock lines. Bit clock
@@ -30,13 +34,15 @@ different sample rates.
 
 I2S has several different operating modes:-
 
- o I2S - MSB is transmitted on the falling edge of the first BCLK after LRC
-         transition.
+I2S
+  MSB is transmitted on the falling edge of the first BCLK after LRC
+  transition.
 
- o Left Justified - MSB is transmitted on transition of LRC.
+Left Justified
+  MSB is transmitted on transition of LRC.
 
- o Right Justified - MSB is transmitted sample size BCLKs before LRC
-                     transition.
+Right Justified
+  MSB is transmitted sample size BCLKs before LRC transition.
 
 PCM
 ===
@@ -51,6 +57,8 @@ is sometimes referred to as network mode).
 
 Common PCM operating modes:-
 
- o Mode A - MSB is transmitted on falling edge of first BCLK after FRAME/SYNC.
+Mode A
+  MSB is transmitted on falling edge of first BCLK after FRAME/SYNC.
 
- o Mode B - MSB is transmitted on rising edge of FRAME/SYNC.
+Mode B
+  MSB is transmitted on rising edge of FRAME/SYNC.
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index a2e023c91df2..aea7ae7e5aad 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -9,3 +9,4 @@ The documentation is spilt into the following sections:-
 
    overview
    codec
+   dai
-- 
2.10.2
