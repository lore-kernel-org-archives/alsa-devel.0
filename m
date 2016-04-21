From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4] ASoC: docs: add clocking examples for DAI formats
Date: Thu, 21 Apr 2016 22:58:55 +0200
Message-ID: <1461272335-12428-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, peda@lysator.liu.se
List-Id: alsa-devel@alsa-project.org

Provide *our* view of what the rules are for the different DAI formats,
so that we do not have to trust external interpretations for this
crucial bit of interoperability.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/sound/alsa/soc/clocking.txt | 195 ++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

Use rising edge and falling edge (instead of flanks). Also differentiate how
transmitters and receivers behave and explain at what edges transmitters change
data and at what edges receivers read data. Don't speak about left and right
channels for the DSP formats where there are just a number of channels.

Cheers,
Peter

diff --git a/Documentation/sound/alsa/soc/clocking.txt b/Documentation/sound/alsa/soc/clocking.txt
index b1300162e01c..7c2bea8124b0 100644
--- a/Documentation/sound/alsa/soc/clocking.txt
+++ b/Documentation/sound/alsa/soc/clocking.txt
@@ -47,5 +47,200 @@ rate, number of channels and word size) to save on power.
 It is also desirable to use the codec (if possible) to drive (or master) the
 audio clocks as it usually gives more accurate sample rates than the CPU.
 
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
+---
+
+The LRC master should put the edges of LRC so that the LRC slaves can reliably
+sample LRC at the rising edges of BCLK, preferably by changing LRC in response
+to falling edges of BCLK.
+
+Transmitters wait for a falling edge of LRC, then skip a rising edge of BCLK,
+and start the left word (output MSB) at the following falling edge of BCLK.
+Transmitters continue with the rest of the word by changing DATA at the falling
+edges to BCLK. Transmitters must pad words with zeros if LRC is not matching
+the word size, so that receivers expecting wider words do not get noise.
+Transmission of the right word works the same, but is initiated by a rising
+edge of LRC instead.
+
+Receivers wait for a falling edge of LRC, then skip a rising edge of BCLK and
+read the MSB of the left word at the following rising edge of BCLK. Receivers
+then continue with the rest of the word at the following rising edges of BCLK.
+Receivers must ignore the tail if more bits per word are transmitted than they
+can use. Reception of the right word works the same, but is initiated by a
+rising edge of LRC instead.
+
+See the official I2S specification
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
+------------------------
+
+The LRC master should synchronize the LRC clock edges with the falling edges of
+BCLK.
+
+Transmitters start the left word (output MSB) at the rising edge of LRC and
+hold MSB over the first rising edge of BCLK. The transmitters then change DATA
+at the falling edges of BCLK. Transmitters must pad words with zeros if LRC is
+not matching the word size, so that receivers expecting wider words do not get
+noise. Transmission of the right word works the same, but is initiated by a
+falling edge of LRC instead.
+
+Receivers wait for a rising edge of LRC and reads the MSB of the left word at
+the first rising edge of BCLK after that. Receivers then continue with the rest
+of the word at the following rising edges of BCLK. Receivers must ignore the
+tail if more bits per word are transmitted than they can use. Reception of the
+right word works the same, but is initiated by a falling edge of LRC instead.
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
+-------------------------
+
+The LRC master should synchronize the LRC clock edges with the falling edges of
+BCLK.
+
+Transmitters wait for a rising edge of LRC, and then skip the correct number of
+rising edges of BCLK. If zero rising edges are skipped, transmitters start the
+left word (output MSB) immediately at the rising edge of LRC. If at least one
+rising edge of BCLK is skipped, they start the left word at the following
+falling edge of BCLK. The correct number of rising edges of BCLK to skip after
+the initial rising edge of LRC is such that the LSB is ending at the following
+edge of LRC. After the MSB, transmitters continue with the rest of the word at
+the falling edges of BCLK. Transmission of the right word works the same, but
+is initiated by a falling edge of LRC instead.
+
+Receivers wait for a rising edge of LRC, and then skip the same number of rising
+edges of BCLK as the transmitters, and read the MSB of the left word on the
+first rising edge of BCLK after that. Receivers then continue with the rest of
+the word at the following rising edges of BCLK. Reception of the right word
+works the same, but is initiated by a falling edge of LRC instead.
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
+----------
 
+Transmitters wait for a rising edge of LRC, then skip one rising edge of BCLK
+and start the first word (output MSB) at the following falling edge of BCLK.
+They then change DATA at the falling edges of BCLK. When the first word is
+finished, transmitters follow up immediately with further words.
+
+Receivers wait for a rising edge of LRC, then skip one rising edge of BCLK and
+read the MSB of the first word at the following rising edge of BCLK. Receivers
+then continue with the rest of the word at the rising edges of BCLK. Further
+words are following immediately.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+   .-                                                          .-
+  -'                                                          -'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |   |MSB|   |...|   |LSB|MSB|   |...|   |LSB| X |   |...|   | X |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+       | 1st channel       | 2nd channel       |                   |
+
+LRC examples for DSP mode A
+   .---.                                                       .---.
+---'   '-------------------------------------------------------'   '-----
+-. .---------------------------------------------------------. .---------
+ '-'                                                         '-'
+
+
+DSP mode B
+----------
 
+Transmitters start the first word (output MSB) at the rising edge of LRC, hold
+MSB over the first rising edge of BCLK, and continue with the rest of the word
+at the following falling edges of BCLK. When the first word is finished,
+transmitters follow up immediately with further words.
+
+Receivers wait for a rising edge of LRC, then read the MSB of the first word at
+the following rising edge of BCLK. Receivers then continue with the rest of the
+word at the rising edges of BCLK. Further words are following immediately.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+   .-                                                          .-
+  -'                                                          -'
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |MSB|   |...|   |LSB|MSB|   |...|   |LSB| X |   |...|   | X |   |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+   | 1st channel       | 2nd channel       |                   |
+
+LRC examples for DSP mode B
+   .---.                                                       .---.
+---'   '-------------------------------------------------------'   '-----
+-. .---------------------------------------------------------. .---------
+ '-'                                                         '-'
+
+
+Inverted Clocks
+---------------
+
+The above diagrams show normal BCLK and LRC clocking where DAI transmitters
+change DATA on the falling edge of BCLK and DAI receivers read DATA on the
+rising edge. For inverted BCLK it is naturally the other way around. Inverted
+LRC is just that.
+
+Left Justified, inverted BCLK
+-----------------------------
+
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
+----------------------------
+
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
