From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 10/10] Added vendor prefix. Added range
	information
Date: Fri, 3 Mar 2017 23:52:48 +0900
Message-ID: <1488552768-14901-11-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0105.outbound.protection.outlook.com [104.47.32.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 5716E266F92
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:44 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Vendor prefix was added.
Range information of each propery was added.

 .../devicetree/bindings/sound/max98927.txt         | 33 +++++++++++++---------
 sound/soc/codecs/max98927.c                        |  8 ++++--
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98927.txt b/Documentation/devicetree/bindings/sound/max98927.txt
index ddcd332..d610879 100755
--- a/Documentation/devicetree/bindings/sound/max98927.txt
+++ b/Documentation/devicetree/bindings/sound/max98927.txt
@@ -6,19 +6,25 @@ Required properties:
 
   - compatible : "maxim,max98927"
 
-  - vmon-slot-no : slot number used to send voltage information
+  - maxim,vmon-slot-no : slot number used to send voltage information
                    or in inteleave mode this will be used as
                    interleave slot.
-
-  - imon-slot-no : slot number used to send current information
-
-  - interleave-mode : When using two MAX98927 in a system it is
-                      possible to create ADC data that that will
-                      overflow the frame size. Digital Audio Interleave
-                      mode provides a means to output VMON and IMON data
-                      from two devices on a single DOUT line when running
-                      smaller frames sizes such as 32 BCLKS per LRCLK or
-                      48 BCLKS per LRCLK.
+                   This property can be set to values from 0 to 15 for slot 0 to 15.
+                   Default value is 0.
+
+  - maxim,imon-slot-no : slot number used to send current information
+                   This property can be set to values from 0 to 15 for slot 0 to 15.
+                   Default value is 0.
+
+  - maxim,interleave-mode : When using two MAX98927 in a system it is
+                   possible to create ADC data that that will
+                   overflow the frame size. Digital Audio Interleave
+                   mode provides a means to output VMON and IMON data
+                   from two devices on a single DOUT line when running
+                   smaller frames sizes such as 32 BCLKS per LRCLK or
+                   48 BCLKS per LRCLK.
+                   This property can be set to values from 0 to 1 for off and on.
+                   Default value is 0.
 
   - reg : the I2C address of the device for I2C
 
@@ -26,7 +32,8 @@ Example:
 
 codec: max98927@3a {
    compatible = "maxim,max98927";
-   vmon-slot-no = <1>;
-   imon-slot-no = <0>;
+   maxim,vmon-slot-no = <0>;
+   maxim,imon-slot-no = <1>;
+   maxim,interleave-mode = <0>;
    reg = <0x3a>;
 };
diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 0614936..b9b7621 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -926,11 +926,13 @@ static void max98927_slot_config(struct i2c_client *i2c,
 {
 	int value;
 
-	if (!of_property_read_u32(i2c->dev.of_node, "vmon-l-slot", &value))
+	if (!of_property_read_u32(i2c->dev.of_node,
+		"maxim,vmon-slot-no", &value))
 		max98927->v_l_slot = value & 0xF;
 	else
 		max98927->v_l_slot = 0;
-	if (!of_property_read_u32(i2c->dev.of_node, "imon-l-slot", &value))
+	if (!of_property_read_u32(i2c->dev.of_node,
+		"maxim,imon-slot-no", &value))
 		max98927->i_l_slot = value & 0xF;
 	else
 		max98927->i_l_slot = 1;
@@ -954,7 +956,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 
 	/* update interleave mode info */
 	if (!of_property_read_u32(i2c->dev.of_node,
-		"interleave_mode", &value)) {
+		"maxim,interleave_mode", &value)) {
 		if (value > 0)
 			max98927->interleave_mode = 1;
 		else
-- 
2.7.4
