From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 3/3] maestro3: HP OmniBook HW volume button magic
Date: Thu, 21 Apr 2005 22:08:54 +0300 (EEST)
Message-ID: <20050421190854.7ED467B@kuori.saunalahti.fi>
Content-Type: text
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some HP OmniBook laptops (500 and 6000 at least) require some GPIO magic
before the HW volume buttons work. This patch makes them work mostly.
Something is still missing to make them work perfectly. However I have been
unable to figure out what exactly.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 maestro3.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -urN linux/sound/pci/maestro3.c linux/sound/pci/maestro3.c
--- linux/sound/pci/maestro3.c	2005-04-21 21:43:56.000000000 +0300
+++ linux/sound/pci/maestro3.c	2005-04-21 21:44:06.000000000 +0300
@@ -2392,6 +2392,18 @@
 	       DISABLE_LEGACY);
 	pci_write_config_word(pcidev, PCI_LEGACY_AUDIO_CTRL, w);
 
+	/*
+	 * Volume buttons on some HP OmniBook laptops (500 and 6000 at least)
+	 * don't work correctly. This makes them work for the most part.
+	 * Volume up and down buttons on the laptop side work perfectly.
+	 * Fn+cursor_up (volme up) works, Fn+cursor_down (volume down) doesn't,
+	 * Fn+F8 (mute) works acts as volume up.
+	 */
+	outw(~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_MASK);
+	outw(inw(io + GPIO_DIRECTION) & ~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DIRECTION);
+	outw((GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DATA);
+	outw(0xffff, io + GPIO_MASK);
+
 	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
 	n &= ~HV_BUTTON_FROM_GD;
 	n |= HV_CTRL_ENABLE | REDUCED_DEBOUNCE;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
