From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2] ASoC: docs: add clocking examples for DAI
	formats
Date: Mon, 18 Apr 2016 15:25:09 +0200
Message-ID: <1460985909-31857-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0119.outbound.protection.outlook.com [104.47.0.119])
 by alsa0.perex.cz (Postfix) with ESMTP id B4BA3265112
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 15:25:29 +0200 (CEST)
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
Cc: Jonathan Corbet <corbet@lwn.net>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, peda@lysator.liu.se, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Provide *our* view of what the rules are for the different DAI formats,
so that we do not have to trust external interpretations for this
crucial bit of interoperability.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/sound/alsa/soc/clocking.txt | 145 +++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 2 deletions(-)

Now with some words on each format as well.

Cheers,
Peter

diff --git a/Documentation/sound/alsa/soc/clocking.txt b/Documentation/sound/alsa/soc/clocking.txt
index b1300162e01c..e74e91bbee94 100644
--- a/Documentation/sound/alsa/soc/clocking.txt
+++ b/Documentation/sound/alsa/soc/clocking.txt
@@ -47,5 +47,146 @@ rate, number of channels and word size) to save on power.
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
+if LRC is not matching the word size.
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
+Receivers must truncate words if more bits per word are transmitted than they
+can use, and transmitters must pad words if LRC is not matching the word size.
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
+LRC should have negative flanks synchronized with a negative flank of BCLK.
+The left channel word starts directly after a negative flank of LRC, and the
+right channel word starts directly after the left channel word. The words
+start with MSB.
+
+ .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
+-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
+      -.                                                          -.
+       '-                                                          '-
+---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.---.-
+   |   |MSB|   |...|   |LSB|MSB|   |...|   |LSB| X |   |...|   | X |   |
+---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'---'-
+       | Left channel      | Right channel     |                   |
+
+LRC examples for DSP mode A
+   .---.                                                       .---.
+---'   '-------------------------------------------------------'   '-----
+     .-.                                                         .-.
+-----' '---------------------------------------------------------' '-----
+-------. .---------------------------------------------------------. .---
+       '-'                                                         '-'
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
