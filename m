From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with Avermedia 771
Date: Wed, 20 Oct 2004 17:02:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410201649590.9471-100000@studcom.urz.uni-halle.de>
References: <s5hy8i1h6k8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hy8i1h6k8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Jaroslav Kysela <perex@suse.cz>, Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> > > So we'll have to build a whitelist from scratch from user feedback, and
> > > maybe add a insmod option so you can ask the driver to grab the device
> > > even if not whitelisted for easy use.
>
> The experimental patch for this is below.

Below is the same patch with entries for WinTV cards (the old default
entries were intended to handle those).

I don't know of any other cards with working audio function (all
feedback I got for other cards was negative).

I'm going to write some documention, too.


Clemens

-- 
Index: alsa-kernel/pci/bt87x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/bt87x.c,v
retrieving revision 1.14
diff -u -r1.14 bt87x.c
--- alsa-kernel/pci/bt87x.c	29 Sep 2004 13:33:18 -0000	1.14
+++ alsa-kernel/pci/bt87x.c	20 Oct 2004 14:43:12 -0000
@@ -45,6 +45,7 @@
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static int digital_rate[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* digital input rate */
+static int load_all;	/* allow to load the non-whitelisted cards */
 static int boot_devs;

 module_param_array(index, int, boot_devs, 0444);
@@ -55,6 +56,8 @@
 MODULE_PARM_DESC(enable, "Enable Bt87x soundcard");
 module_param_array(digital_rate, int, boot_devs, 0444);
 MODULE_PARM_DESC(digital_rate, "Digital input rate for Bt87x soundcard");
+module_param(load_all, bool, 0444);
+MODULE_PARM_DESC(load_all, "Allow to load the non-whitelisted cards");


 #ifndef PCI_VENDOR_ID_BROOKTREE
@@ -148,6 +151,9 @@
 #endif
 #define CLOCK_DIV_MAX 15

+#define DRIVER_DEFAULT_ENTRY	(1<<24)
+#define DRIVER_RATE_MASK	((1<<24)-1)
+
 #define ERROR_INTERRUPTS (INT_FBUS | INT_FTRGT | INT_PPERR | \
 			  INT_RIPERR | INT_PABORT | INT_OCERR)
 #define MY_INTERRUPTS (INT_RISCI | ERROR_INTERRUPTS)
@@ -746,6 +752,11 @@
 	bt87x_t *chip;
 	int err;

+	if (pci_id->driver_data & DRIVER_DEFAULT_ENTRY) {
+		if (! load_all)
+			return -ENODEV;
+	}
+
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
@@ -764,7 +775,7 @@
 	if (digital_rate[dev] > 0)
 		chip->dig_rate = digital_rate[dev];
 	else
-		chip->dig_rate = (int)pci_id->driver_data;
+		chip->dig_rate = (int)(pci_id->driver_data & DRIVER_RATE_MASK);

 	err = snd_bt87x_pcm(chip, DEVICE_DIGITAL, "Bt87x Digital");
 	if (err < 0)
@@ -816,11 +827,13 @@

 /* driver_data is the default digital_rate value for that device */
 static struct pci_device_id snd_bt87x_ids[] = {
-	BT_DEVICE(878, 0x0070, 0xff01, 44100), /* Osprey 200 */
-
-	/* default entries for 32kHz and generic Bt87x cards */
-	BT_DEVICE(878, PCI_ANY_ID, PCI_ANY_ID, 32000),
-	BT_DEVICE(879, PCI_ANY_ID, PCI_ANY_ID, 32000),
+	BT_DEVICE(878, 0x0070, 0x13eb, 32000), /* Hauppauge WinTV series */
+	BT_DEVICE(879, 0x0070, 0x13eb, 32000), /* Hauppauge WinTV series */
+	BT_DEVICE(878, 0x0070, 0xff01, 44100), /* Viewcast Osprey 200 */
+
+	/* default entries for unknown Bt87x cards */
+	BT_DEVICE(878, PCI_ANY_ID, PCI_ANY_ID, 32000 | DRIVER_DEFAULT_ENTRY),
+	BT_DEVICE(879, PCI_ANY_ID, PCI_ANY_ID, 32000 | DRIVER_DEFAULT_ENTRY),
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, snd_bt87x_ids);





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
