From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v3] ASoC: docs: add clocking examples for DAI formats
Date: Tue, 19 Apr 2016 12:11:28 +0200
Message-ID: <1461060688-19410-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, peda@lysator.liu.se
List-Id: alsa-devel@alsa-project.org

Provide *our* view of what the rules are for the different DAI formats,
so that we do not have to trust external interpretations for this
crucial bit of interoperability.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/sound/alsa/soc/clocking.txt | 146 +++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

Changed PCM mode A to start left word one BCLK after positive LRC edge.
Added link to I2S spec as indicated by Mark Brown.

Cheers,
Peter

diff --git a/Documentation/sound/alsa/soc/clocking.txt b/Documentation/sound/alsa/soc/clocking.txt
index b1300162e01c..7eb02f0758e7 100644
--- a/Documentation/sound/alsa/soc/clocking.txt
+++ b/Documentation/sound/alsa/soc/clocking.txt
@@ -47,5 +47,147 @@ rate, number of channels and word size) to save on power.
 It is also desirable to use the codec (if possible) to drive (or master) the
 audio clocks as it usually gives more accurate sample rates than the CPU.
 
-
-
+The below diagrams all have BCLK as the first signal, LRC as the second signal
+and DATA as the third. Below that is an indication about which DATA bits belong
+in what channel.
+
+A "..." marking as DATA indicates that there may be more bits that are not
+shown. Also, all DATA bits marked X may or may not be present. DAI
+transmitters must add them should LRC not match the word size exactly and DAI
+receivers must be prepared to ignore them. DAI transmitters must insert zeros
+for I2S and Left Justified modes, and preferably not drive DATA for the DSP
+modes for these extra X bits.
+
+
+I2S
+
+LRC should have its flanks synchronized with a negative flank of BCLK.
+The left channel word starts one BCLK cycle after a negative flank of LRC, and
+the right channel word starts one BCLK cycle after a positive flank of LRC. The
+words start with the MSB. Receivers must truncate words if more bits per word
+are transmitted than they can use, and transmitters must pad words with zeros
+if LRC is not matching the word size. Also, see
+https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+---.                               .-------------------------------.
+   '-------------------------------'                               '-----
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |   |MSB|   |...|   |LSB| X |...| X |MSB|   |...|   |LSB| X |...| X |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+       | Left channel                  | Right channel                 |
+
+
+Left Justified (aka MSB)
+
+LRC should have its flanks synchronized with a negative flank of BCLK.
+The left channel word starts directly after a positive flank of LRC, and the
+right channel word starts directly after a negative flank of LRC. The words
+start with the MSB. Receivers must truncate words if more bits per word are
+transmitted than they can use, and transmitters must pad words with zeros if
+LRC is not matching the word size.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+   .-------------------------------.                               .-----
+---'                               '-------------------------------'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |MSB|   |...|   |LSB| X |...| X |MSB|   |...|   |LSB| X |...| X |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+   | Left channel                  | Right channel                 |
+
+
+Right Justified (aka LSB)
+
+LRC should have its flanks synchronized with a negative flank of BCLK.
+The left channel word end right before a negative flank of LRC, and the right
+channel word ends right before a positive flank of LRC. The words end with LSB.
+Transmitters must pad words if LRC is not matching the word size and the
+transmitter and the receiver have to agree on the word leghth.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+   .-------------------------------.                               .-----
+---'                               '-------------------------------'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   | X |...| X |MSB|   |...|   |LSB| X |...| X |MSB|   |...|   |LSB|   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+   | Left channel                  | Right channel                 |
+
+
+DSP mode A
+
+LRC should have positive flanks synchronized with a negative flank of BCLK.
+The left channel word starts one BCLK after a positive flank of LRC, and the
+right channel word starts directly after the left channel word. The words
+start with MSB.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+   .-                                                          .-
+  -'                                                          -'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |   |MSB|   |...|   |LSB|MSB|   |...|   |LSB| X |   |...|   | X |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+       | Left channel      | Right channel     |                   |
+
+LRC examples for DSP mode A
+   .---.                                                       .---.
+---'   '-------------------------------------------------------'   '-----
+   .-.                                                         .-.
+---' '---------------------------------------------------------' '-------
+-. .---------------------------------------------------------. .---------
+ '-'                                                         '-'
+
+
+DSP mode B
+
+LRC should have positive flanks synchronized with a negative flank of BCLK.
+The left channel word starts directly after a positive flank of LRC, and the
+right channel word starts directly after the left channel word. The words
+start with MSB.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+   .-                                                          .-
+  -'                                                          -'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |MSB|   |...|   |LSB|MSB|   |...|   |LSB| X |   |...|   | X |   |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+   | Left channel      | Right channel     |                   |
+
+LRC examples for DSP mode B
+   .---.                                                       .---.
+---'   '-------------------------------------------------------'   '-----
+-. .---------------------------------------------------------. .---------
+ '-'                                                         '-'
+
+
+The above diagrams show normal BCLK and LRC clocking where DAI transmitters
+change DATA on the falling edge of BCLK and DAI receivers read DATA on the
+rising edge. For inverted BCLK it is naturally the other way around. Inverted
+LRC is just that. Note that DSP mode A is compatible with DSP mode B with
+inverted LRC, and vice versa.
+
+
+Left Justified, inverted BCLK
+-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-
+ '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-'
+   .-------------------------------.                               .-----
+---'                               '-------------------------------'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |MSB|   |...|   |LSB| X |...| X |MSB|   |...|   |LSB| X |...| X |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+   | Left channel                  | Right channel                 |
+
+
+Left Justified, inverted LRC
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+---.                               .-------------------------------.
+   '-------------------------------'                               '-----
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |MSB|   |...|   |LSB| X |...| X |MSB|   |...|   |LSB| X |...| X |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+   | Left channel                  | Right channel                 |
-- 
2.1.4

