From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with Avermedia 771
Date: Thu, 21 Oct 2004 09:22:18 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410210908100.7031-100000@studcom.urz.uni-halle.de>
References: <s5hwtxlh0wg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hwtxlh0wg.wl@alsa2.suse.de>
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
> > > > > So we'll have to build a whitelist from scratch from user feedback, and
> > > > > maybe add a insmod option so you can ask the driver to grab the device
> > > > > even if not whitelisted for easy use.
>
> Should the driver put some kernel info when the device is probed but
> disabled?

New patch for this below, including a doc file which has quite an
amount of "literal, line-by-line copying" :) from btaudio.txt.

> One concern is again hotplug.  This might be annoying although it's
> harmless.

Well, so we now have a blacklist for cards we ignore silently.

A centralized card list looks more advantageous now ...


I'm going to commit it to ALSA if nobody objects.


Clemens


-- 
Index: alsa-kernel/pci/Kconfig
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/Kconfig,v
retrieving revision 1.35
diff -u -r1.35 Kconfig
--- alsa-kernel/pci/Kconfig	29 Sep 2004 13:33:18 -0000	1.35
+++ alsa-kernel/pci/Kconfig	21 Oct 2004 06:50:51 -0000
@@ -106,8 +106,9 @@
         depends on SND
 	select SND_PCM
         help
-	  Say Y here to include support for recording audio from TV
-	  cards based on Brooktree Bt878/Bt879 chips.
+	  If you want to record audio from TV cards based on
+	  Brooktree Bt878/Bt879 chips, say Y here and read
+	  <file:Documentation/sound/alsa/Bt87x.txt>.

 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-bt87x.
Index: alsa-kernel/pci/bt87x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/bt87x.c,v
retrieving revision 1.14
diff -u -r1.14 bt87x.c
--- alsa-kernel/pci/bt87x.c	29 Sep 2004 13:33:18 -0000	1.14
+++ alsa-kernel/pci/bt87x.c	21 Oct 2004 06:50:51 -0000
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
@@ -738,14 +741,77 @@
 	return 0;
 }

+/* cards known to have audio */
+static struct card_entry {
+	unsigned short subvendor, subdevice;
+	int digital_rate;
+	const char *name;
+} whitelist[] __devinitdata = {
+	{0x0070, 0x13eb, 32000, "WinTV series"},
+	{0x0070, 0xff01, 44100, "Osprey 200"},
+};
+
+/* cards known not to have audio
+ * (DVB cards use the audio function to transfer MPEG data) */
+static struct {
+	unsigned short subvendor, subdevice;
+} blacklist[] __devinitdata = {
+	{0x0071, 0x0101}, /* Nebula Electronics DigiTV */
+	{0x11bd, 0x0026}, /* Pinnacle PCTV SAT CI */
+	{0x1461, 0x0761}, /* AVermedia AverTV DVB-T */
+	{0x1461, 0x0771}, /* AVermedia DVB-T 771 */
+	{0x1822, 0x0001}, /* Twinhan VisionPlus DVB-T */
+	{0x270f, 0xfc00}, /* Chaintech Digitop DST-1000 DVB-S */
+};
+
+static struct card_entry *
+__devinit snd_bt87x_detect_card(struct pci_dev *pci)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(whitelist); ++i)
+		if (whitelist[i].subvendor == pci->subsystem_vendor &&
+		    whitelist[i].subdevice == pci->subsystem_device) {
+			snd_printk(KERN_INFO "detected audio for %s (%d Hz)\n",
+				   whitelist[i].name, whitelist[i].digital_rate);
+			return &whitelist[i];
+		}
+	for (i = 0; i < ARRAY_SIZE(blacklist); ++i)
+		if (blacklist[i].subvendor == pci->subsystem_vendor &&
+		    blacklist[i].subdevice == pci->subsystem_device) {
+			snd_printdd(KERN_INFO "card %#04x:%#04x has no audio\n",
+				    pci->subsystem_vendor, pci->subsystem_device);
+			return NULL;
+		}
+	if (load_all) {
+		static struct card_entry unknown_card __devinitdata = {
+			PCI_ANY_ID, PCI_ANY_ID, 32000, NULL
+		};
+		snd_printk(KERN_INFO "unknown card %#04x:%#04x\n",
+			   pci->subsystem_vendor, pci->subsystem_device);
+		snd_printk(KERN_DEBUG "please mail id, board name, and, "
+			   "if it works, the correct digital_rate option to "
+			   "<alsa-devel@lists.sf.net>\n");
+		return &unknown_card;
+	}
+	snd_printk(KERN_INFO "Unknown TV card found, the audio driver will not load.\n");
+	snd_printk(KERN_INFO "To try to capture audio from this card, use the load_all=1 option.\n");
+	return NULL;
+}
+
 static int __devinit snd_bt87x_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	static int dev;
+	struct card_entry *card_entry;
 	snd_card_t *card;
 	bt87x_t *chip;
 	int err;

+	card_entry = snd_bt87x_detect_card(pci);
+	if (!card_entry)
+		return -ENODEV;
+
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
@@ -764,7 +830,7 @@
 	if (digital_rate[dev] > 0)
 		chip->dig_rate = digital_rate[dev];
 	else
-		chip->dig_rate = (int)pci_id->driver_data;
+		chip->dig_rate = card_entry->digital_rate;

 	err = snd_bt87x_pcm(chip, DEVICE_DIGITAL, "Bt87x Digital");
 	if (err < 0)
@@ -808,19 +874,17 @@
 	pci_set_drvdata(pci, NULL);
 }

-#define BT_DEVICE(chip, subvend, subdev, rate) \
-	{ .vendor = PCI_VENDOR_ID_BROOKTREE, \
-	  .device = PCI_DEVICE_ID_BROOKTREE_##chip, \
-	  .subvendor = subvend, .subdevice = subdev, \
-	  .driver_data = rate }
-
-/* driver_data is the default digital_rate value for that device */
 static struct pci_device_id snd_bt87x_ids[] = {
-	BT_DEVICE(878, 0x0070, 0xff01, 44100), /* Osprey 200 */
-
-	/* default entries for 32kHz and generic Bt87x cards */
-	BT_DEVICE(878, PCI_ANY_ID, PCI_ANY_ID, 32000),
-	BT_DEVICE(879, PCI_ANY_ID, PCI_ANY_ID, 32000),
+	{
+		.vendor = PCI_VENDOR_ID_BROOKTREE,
+		.device = PCI_DEVICE_ID_BROOKTREE_878,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	},
+	{
+		.vendor = PCI_VENDOR_ID_BROOKTREE,
+		.device = PCI_DEVICE_ID_BROOKTREE_879,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, snd_bt87x_ids);
Index: alsa-kernel/Documentation/ALSA-Configuration.txt
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/ALSA-Configuration.txt,v
retrieving revision 1.53
diff -u -r1.53 ALSA-Configuration.txt
--- alsa-kernel/Documentation/ALSA-Configuration.txt	28 Sep 2004 16:44:02 -0000	1.53
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	21 Oct 2004 06:50:52 -0000
@@ -252,6 +252,7 @@
     Module for video cards based on Bt87x chips.

     digital_rate - Override the default digital rate (Hz)
+    load_all	- Load the driver even if the card model isn't known

     Module supports up to 8 cards.

--- alsa-kernel/Documentation/Bt87x.txt.org	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/Documentation/Bt87x.txt	2004-10-21 08:50:16.740436000 +0200
@@ -0,0 +1,78 @@
+Intro
+=====
+
+You might have noticed that the bt878 grabber cards have actually
+_two_ PCI functions:
+
+$ lspci
+[ ... ]
+00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
+00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
+[ ... ]
+
+The first does video, it is backward compatible to the bt848.  The second
+does audio.  snd-bt87x is a driver for the second function.  It's a sound
+driver which can be used for recording sound (and _only_ recording, no
+playback).  As most TV cards come with a short cable which can be plugged
+into your sound card's line-in you probably don't need this driver if all
+you want to do is just watching TV...
+
+Some cards do not bother to connect anything to the audio input pins of
+the chip, and some other cards use the audio function to transport MPEG
+video data, so it's quite possible that audio recording may not work
+with your card.
+
+
+Driver Status
+=============
+
+The driver is now stable.  However, it doesn't know about many TV cards,
+and it refuses to load for cards it doesn't know.
+
+If the driver complains ("Unknown TV card found, the audio driver will
+not load"), you can specify the load_all=1 option to force the driver to
+try to use the audio capture function of your card.  If the frequency of
+recorded data is not right, try to specify the digital_rate option with
+other values than the default 32000 (often it's 44100 or 64000).
+
+If you have an unknown card, please mail the ID and board name to
+<alsa-devel@lists.sf.net>, regardless of whether audio capture works or
+not, so that future versions of this driver know about your card.
+
+
+Audio modes
+===========
+
+The chip knows two different modes (digital/analog).  snd-bt87x
+registers two PCM devices, one for each mode.  They cannot be used at
+the same time.
+
+
+Digital audio mode
+==================
+
+The first device (hw:X,0) gives you 16 bit stereo sound.  The sample
+rate depends on the external source which feeds the Bt87x with digital
+sound via I2S interface.
+
+
+Analog audio mode (A/D)
+=======================
+
+The second device (hw:X,1) gives you 8 or 16 bit mono sound.  Supported
+sample rates are between 119466 and 448000 Hz (yes, these numbers are
+that high).  If you've set the CONFIG_SND_BT87X_OVERCLOCK option, the
+maximum sample rate is 1792000 Hz, but audio data becomes unusable
+beyond 896000 Hz on my card.
+
+The chip has three analog inputs.  Consequently you'll get a mixer
+device to control these.
+
+
+Have fun,
+
+  Clemens
+
+
+Written by Clemens Ladisch <clemens@ladisch.de>
+big parts copied from btaudio.txt by Gerd Knorr <kraxel@bytesex.org>



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
