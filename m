From: sgiurgiu11@gmail.com
Subject: [PATCH - ALSA: snd-virtuoso 1/1] Xonar DSX support
Date: Sun,  9 Sep 2012 05:14:15 -0400
Message-ID: <504c9632.8697320a.1336.4b37@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Sergiu Giurgiu <sgiurgiu11@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Sergiu Giurgiu <sgiurgiu11@gmail.com>

This patch adds support for ASUS - Xonar DSX sound cards. Tested on openSUSE 12.2 with kernel:
Linux 3.4.6-2.10-desktop #1 SMP PREEMPT Thu Jul 26 09:36:26 UTC 2012 (641c197) x86_64 x86_64 x86_64 GNU/Linux
Works:
 - play sounds
 - adjust volume on master channel.
 - mute .

Since Xonar DS uses the same chip, everything that works for DS should work for DSX as well.

Thank you,
Sergiu Giurgiu.

Signed-off-by: Sergiu Giurgiu <sgiurgiu11@gmail.com>

diff --git a/mirror/sound/pci/oxygen/virtuoso.c b/mirror/sound/pci/oxygen/virtuoso.c
index 3d71423..8104eab 100644
--- a/mirror/sound/pci/oxygen/virtuoso.c
+++ b/mirror/sound/pci/oxygen/virtuoso.c
@@ -52,6 +52,7 @@ static DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835d) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835e) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x838e) },
+	{ OXYGEN_PCI_SUBID(0x1043, 0x8522) },
 	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
 	{ }
 };
diff --git a/mirror/sound/pci/oxygen/xonar_wm87x6.c b/mirror/sound/pci/oxygen/xonar_wm87x6.c
index 63cff90..b555b62 100644
--- a/mirror/sound/pci/oxygen/xonar_wm87x6.c
+++ b/mirror/sound/pci/oxygen/xonar_wm87x6.c
@@ -1255,7 +1255,6 @@ static void dump_wm87x6_registers(struct oxygen *chip,
 }
 
 static const struct oxygen_model model_xonar_ds = {
-	.shortname = "Xonar DS",
 	.longname = "Asus Virtuoso 66",
 	.chip = "AV200",
 	.init = xonar_ds_init,
@@ -1327,6 +1326,11 @@ int __devinit get_xonar_wm87x6_model(struct oxygen *chip,
 	switch (id->subdevice) {
 	case 0x838e:
 		chip->model = model_xonar_ds;
+		chip->model.shortname = "Xonar DS";
+		break;
+	case 0x8522:
+		chip->model = model_xonar_ds;
+		chip->model.shortname = "Xonar DSX";
 		break;
 	case 0x835e:
 		chip->model = model_xonar_hdav_slim;
-- 
1.7.10.4
