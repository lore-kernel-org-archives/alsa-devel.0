From: Eduard Hasenleithner <ehasenle@spamcop.net>
Subject: Terratec DMX 6fire audio input
Date: 22 Jun 2003 22:52:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056315154.4468.11.camel@boundary.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ELbyGmGH5rxyN7duCAIb"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-ELbyGmGH5rxyN7duCAIb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello developers.

Here is a patch which enables to do audio input on this particular card
even when not doing a soft reboot from windows. The problem with the
current driver is that the PCA9554 is set to input mode for all IO pins
after a cold reset. In order to set the pins to output mode register 3
of this chip has to be set.

As I don't know if there are any pins used as input I have set register
3 to 0x80, so the MSB is input. Hopefully my patch won't do any damage!
Maybe someone can check the content of this register after a warm reboot
from windows. I have a linux only machine.

Keep on the good work.

bye,
Eduard.

PS: Sorry if this email arrives twice, it didn't seem to come through
the first time.

--=-ELbyGmGH5rxyN7duCAIb
Content-Disposition: attachment; filename=adrv-0.9.4-6fire.patch
Content-Type: text/plain; name=adrv-0.9.4-6fire.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa/alsa-driver-0.9.4/sound/pci/ice1712/ews.c	2003-04-30 13:43:01.000000000 +0200
+++ alsa-driver-0.9.4/sound/pci/ice1712/ews.c	2003-06-22 13:13:55.000000000 +0200
@@ -389,6 +389,12 @@
  * initialize the chip
  */
 
+#define PCF9554_REG_INPUT	0
+#define PCF9554_REG_OUTPUT	1
+#define PCF9554_REG_POLARITY	2
+#define PCF9554_REG_CONFIG	3
+static int snd_ice1712_6fire_write_pca(ice1712_t *ice, unsigned char reg, unsigned char data);
+
 static int __devinit snd_ice1712_ews_init(ice1712_t *ice)
 {
 	int err;
@@ -425,6 +431,7 @@
 			snd_printk("PCF9554 initialization failed\n");
 			return err;
 		}
+		snd_ice1712_6fire_write_pca(ice, PCF9554_REG_CONFIG, 0x80);
 		break;
 	case ICE1712_SUBDEVICE_EWS88MT:
 	case ICE1712_SUBDEVICE_EWS88MT_NEW:
@@ -750,11 +757,6 @@
  * DMX 6Fire specific controls
  */
 
-#define PCF9554_REG_INPUT	0
-#define PCF9554_REG_OUTPUT	1
-#define PCF9554_REG_POLARITY	2
-#define PCF9554_REG_CONFIG	3
-
 static int snd_ice1712_6fire_read_pca(ice1712_t *ice, unsigned char reg)
 {
 	unsigned char byte;

--=-ELbyGmGH5rxyN7duCAIb--



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
