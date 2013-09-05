From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] ASoC: kirkwood: change the compatible string
	of the kirkwood-i2s driver
Date: Thu,  5 Sep 2013 14:56:31 +0200
Message-ID: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A95D261A09
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2013 14:56:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>
Cc: Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The compatible string of the kirkwood-i2s driver was chosen as
"marvell,mvebu-audio". Using such a compatible string is not a good
idea, since "mvebu" is the name of a large family of SOCs, in which
new, unknown SOCs will be coming in the future. It is therefore
impossible to know what will be evolutions of this hardware block in
the next generations of the SOCs. For this reason, the recommandation
for compatible strings of on-SOCs devices has always been to use the
name of the oldest SOC that has the hardware block. New SOCs that have
an exactly compatible hardware block can reference it using the same
compatible string. See [1], [2] and [3] for various cases were this
suggestion was made, including from Rob Herring, a Device Tree binding
maintainer.

As an example, there are already small differences between current
generations:

 * On Kirkwood, only one interrupt is used for audio.
 * On Dove, two interrupts are used, one for audio data and one for
   error reporting.

In the near future, I'll be adding audio support to Armada 370, which
allows has the same hardware block (but maybe with minor variants).

Therefore, this patch changes the driver to accept
"marvell,kirkwood-audio" and "marvell,dove-audio" as compatible
strings instead of the too-generic "marvell,mvebu-audio". The reason
for the two different compatible strings is the difference in the
number of interrupts used by the two SOCs for audio.

This Device Tree binding has never been part of a Linux kernel stable
release so far, so it can be changed now without breaking backward
compatibility.

[1] http://lists.infradead.org/pipermail/linux-mtd/2012-March/040417.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161065.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087702.html

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/sound/mvebu-audio.txt | 12 ++++++++----
 sound/soc/kirkwood/kirkwood-i2s.c                       |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
index 7e5fd37..f0062c5 100644
--- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -2,13 +2,17 @@
 
 Required properties:
 
-- compatible: "marvell,mvebu-audio"
+- compatible:
+  "marvell,kirkwood-audio" for Kirkwood platforms
+  "marvell,dove-audio" for Dove platforms
 
 - reg: physical base address of the controller and length of memory mapped
   region.
 
-- interrupts: list of two irq numbers.
-  The first irq is used for data flow and the second one is used for errors.
+- interrupts:
+  with "marvell,kirkwood-audio", the audio interrupt
+  with "marvell,dove-audio", a list of two interrupts, the first for
+  the data flow, and the second for errors.
 
 - clocks: one or two phandles.
   The first one is mandatory and defines the internal clock.
@@ -21,7 +25,7 @@ Required properties:
 Example:
 
 i2s1: audio-controller@b4000 {
-	compatible = "marvell,mvebu-audio";
+	compatible = "marvell,dove-audio";
 	reg = <0xb4000 0x2210>;
 	interrupts = <21>, <22>;
 	clocks = <&gate_clk 13>;
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 7fce340..0f3d73d 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -559,7 +559,8 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static struct of_device_id mvebu_audio_of_match[] = {
-	{ .compatible = "marvell,mvebu-audio" },
+	{ .compatible = "marvell,kirkwood-audio" },
+	{ .compatible = "marvell,dove-audio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mvebu_audio_of_match);
-- 
1.8.1.2
