From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [28/29] ALSA: dice: fix detection of Weiss devices
Date: Mon, 21 Oct 2013 21:41:31 +0200
Message-ID: <5265836B.2020107@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

While most DICE devices keep TCAT's default category ID of 0x04, Weiss
devices identify themselves with 0x00.

Reported-by: Rolf Anderegg <rolf.anderegg@weiss.ch>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 5f0f102..49d630b 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1109,7 +1109,10 @@ static void dice_card_free(struct snd_card *card)
 	mutex_destroy(&dice->mutex);
 }

-#define DICE_CATEGORY_ID 0x04
+#define OUI_WEISS		0x001c6a
+
+#define DICE_CATEGORY_ID	0x04
+#define WEISS_CATEGORY_ID	0x00

 static int dice_interface_check(struct fw_unit *unit)
 {
@@ -1123,15 +1126,15 @@ static int dice_interface_check(struct fw_unit *unit)
 	struct fw_device *device = fw_parent_device(unit);
 	struct fw_csr_iterator it;
 	int key, value, vendor = -1, model = -1, err;
-	unsigned int i;
+	unsigned int category, i;
 	__be32 pointers[ARRAY_SIZE(min_values)];
 	__be32 version;

 	/*
 	 * Check that GUID and unit directory are constructed according to DICE
 	 * rules, i.e., that the specifier ID is the GUID's OUI, and that the
-	 * GUID chip ID consists of the 8-bit DICE category ID, the 10-bit
-	 * product ID, and a 22-bit serial number.
+	 * GUID chip ID consists of the 8-bit category ID, the 10-bit product
+	 * ID, and a 22-bit serial number.
 	 */
 	fw_csr_iterator_init(&it, unit->directory);
 	while (fw_csr_iterator_next(&it, &key, &value)) {
@@ -1144,7 +1147,11 @@ static int dice_interface_check(struct fw_unit *unit)
 			break;
 		}
 	}
-	if (device->config_rom[3] != ((vendor << 8) | DICE_CATEGORY_ID) ||
+	if (vendor == OUI_WEISS)
+		category = WEISS_CATEGORY_ID;
+	else
+		category = DICE_CATEGORY_ID;
+	if (device->config_rom[3] != ((vendor << 8) | category) ||
 	    device->config_rom[4] >> 22 != model)
 		return -ENODEV;


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
