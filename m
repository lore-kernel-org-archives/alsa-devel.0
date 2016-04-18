From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: docs: add clocking examples for DAI
	formats
Date: Mon, 18 Apr 2016 11:39:50 +0200
Message-ID: <1460972390-30149-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0121.outbound.protection.outlook.com [157.56.112.121])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5942650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 11:40:19 +0200 (CEST)
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
 Documentation/sound/alsa/soc/clocking.txt | 110 +++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

Now, the reason for me writing this is that I once again had to go hunting
the internet to find the rules for these things. And like last time, I
found no definitive source and sometimes strange things as well. So, I don't
know if the above is 100% good, but it is my understanding of the subject.

Please enlighten me on any errors.

Cheers,
Peter

diff --git a/Documentation/sound/alsa/soc/clocking.txt b/Documentation/sound/alsa/soc/clocking.txt
index b1300162e01c..8b498d610e10 100644
--- a/Documentation/sound/alsa/soc/clocking.txt
+++ b/Documentation/sound/alsa/soc/clocking.txt
@@ -47,5 +47,111 @@ rate, number of channels and word size) to save on power.
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
+receivers must be prepared to ignore them. DAI transmitters must insert
+zeros for I2S, Left and Right Justified modes, and preferably not drive DATA
+for the DSP modes for these extra X bits.
+
+
+I2S
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
