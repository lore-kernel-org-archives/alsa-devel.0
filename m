From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] integrate snd-usb-midi into snd-usb-audio
Date: Mon, 26 Aug 2002 16:09:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6A36A3.E856D6D2@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Index: acore/seq/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/seq/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- acore/seq/Makefile	3 Jul 2002 08:29:29 -0000	1.2
+++ acore/seq/Makefile	26 Aug 2002 13:54:22 -0000
@@ -3,7 +3,9 @@
 include $(TOPDIR)/toplevel.config
 include $(TOPDIR)/Makefile.conf
 
-obj-$(CONFIG_SND_USB_MIDI) += snd-seq-virmidi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
+obj-$(CONFIG_SND_USB_AUDIO) += snd-seq-virmidi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+endif
 
 TOPDIR = $(MAINSRCDIR)
 include $(TOPDIR)/alsa-kernel/core/seq/Makefile




Index: include/sndmagic.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/sndmagic.h,v
retrieving revision 1.10
diff -u -r1.10 sndmagic.h
--- include/sndmagic.h	16 Aug 2002 11:12:45 -0000	1.10
+++ include/sndmagic.h	26 Aug 2002 13:59:02 -0000
@@ -140,9 +140,9 @@
 #define snd_usb_audio_t_magic			0xa15a3e01
 #define usb_mixer_elem_info_t_magic		0xa15a3e02
 #define snd_usb_stream_t_magic			0xa15a3e03
-#define usbmidi_t_magic				0xa15a3f01
-#define usbmidi_out_endpoint_t_magic		0xa15a3f02
-#define usbmidi_in_endpoint_t_magic		0xa15a3f03
+#define snd_usb_midi_t_magic			0xa15a3f01
+#define snd_usb_midi_out_endpoint_t_magic	0xa15a3f02
+#define snd_usb_midi_in_endpoint_t_magic	0xa15a3f03
 
 
 #else
Index: scripts/Modules.dep
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/scripts/Modules.dep,v
retrieving revision 1.16
diff -u -r1.16 Modules.dep
--- scripts/Modules.dep	14 Aug 2002 17:21:36 -0000	1.16
+++ scripts/Modules.dep	26 Aug 2002 13:59:02 -0000
@@ -203,4 +203,4 @@
 
 %dir linux/sound/usb
 |snd-usb-audio snd-pcm
-|snd-usb-midi @if_sequencer snd-seq-device snd-seq-midi-event
+snd-usb-midi @if_sequencer snd-seq-device snd-seq-midi-event
Index: usb/Config.help
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/Config.help,v
retrieving revision 1.1
diff -u -r1.1 Config.help
--- usb/Config.help	14 Aug 2002 17:22:18 -0000	1.1
+++ usb/Config.help	26 Aug 2002 13:59:02 -0000
@@ -1,5 +1,2 @@
 CONFIG_SND_USB_AUDIO
   Say 'Y' or 'M' to include support for USB audio devices.
-
-CONFIG_SND_USB_MIDI
-  Say 'Y' or 'M' to include support for MIDI devices connected via USB.
Index: usb/Config.in
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/Config.in,v
retrieving revision 1.1
diff -u -r1.1 Config.in
--- usb/Config.in	14 Aug 2002 17:22:18 -0000	1.1
+++ usb/Config.in	26 Aug 2002 13:59:02 -0000
@@ -4,6 +4,5 @@
 comment 'ALSA USB devices'
 
 dep_tristate 'USB Audio driver' CONFIG_SND_USB_AUDIO $CONFIG_SND
-dep_tristate 'USB MIDI driver' CONFIG_SND_USB_MIDI $CONFIG_SND $CONFIG_SND_SEQUENCER
 
 endmenu
Index: usb/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- usb/Makefile	14 Aug 2002 17:22:18 -0000	1.1
+++ usb/Makefile	26 Aug 2002 13:59:02 -0000
@@ -3,10 +3,14 @@
 #
 
 snd-usb-audio-objs := usbaudio.o usbmixer.o
+ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
 snd-usb-midi-objs := usbmidi.o
+endif
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o
-obj-$(CONFIG_SND_USB_MIDI) += snd-usb-midi.o
+ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
+obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-midi.o
+endif
 
 include $(TOPDIR)/Rules.make
Index: usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.2
diff -u -r1.2 usbaudio.c
--- usb/usbaudio.c	15 Aug 2002 12:13:10 -0000	1.2
+++ usb/usbaudio.c	26 Aug 2002 13:59:02 -0000
@@ -36,6 +36,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
+#include <sound/seq_device.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
@@ -1234,6 +1235,7 @@
 static void usb_audio_disconnect(struct usb_device *dev, void *ptr);
 
 static struct usb_device_id usb_audio_ids [] = {
+#include "usbquirks.h"
     { .match_flags = (USB_DEVICE_ID_MATCH_INT_CLASS | USB_DEVICE_ID_MATCH_INT_SUBCLASS),
       .bInterfaceClass = USB_CLASS_AUDIO,
       .bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL },
@@ -1716,11 +1718,14 @@
 
 
 /*
- * parse audio control descriptor and create pcm streams
+ * parse audio control descriptor and create pcm/midi streams
  */
 
-static int snd_usb_create_pcm(snd_usb_audio_t *chip, int ctrlif,
-			      unsigned char *buffer, int buflen)
+static int snd_usb_create_midi_interface(snd_usb_audio_t *chip, int ifnum,
+					 const snd_usb_audio_quirk_t *quirk);
+
+static int snd_usb_create_streams(snd_usb_audio_t *chip, int ctrlif,
+				  unsigned char *buffer, int buflen)
 {
 	struct usb_device *dev = chip->dev;
 	struct usb_config_descriptor *config;
@@ -1752,6 +1757,15 @@
 			continue;
 		}
 		iface = &config->interface[j];
+		if (iface->altsetting[0].bInterfaceClass == USB_CLASS_AUDIO &&
+		    iface->altsetting[0].bInterfaceSubClass == USB_SUBCLASS_MIDI_STREAMING) {
+			if (snd_usb_create_midi_interface(chip, j, NULL) < 0) {
+				snd_printk(KERN_ERR "%d:%u:%d: cannot create sequencer device\n", dev->devnum, ctrlif, j);
+				continue;
+			}
+			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1);
+			continue;
+		}
 		if (iface->altsetting[0].bInterfaceClass != USB_CLASS_AUDIO ||
 		    iface->altsetting[0].bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING) {
 			snd_printdd(KERN_ERR "%d:%u:%d: skipping non-supported interface %d\n", dev->devnum, ctrlif, j,
iface->altsetting[0].bInterfaceClass);
@@ -1808,6 +1822,37 @@
 	return 0;
 }
 
+static int snd_usb_create_midi_interface(snd_usb_audio_t *chip, int ifnum,
+					 const snd_usb_audio_quirk_t *quirk)
+{
+#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+	snd_seq_device_t *seq_device;
+	snd_usb_midi_t *umidi;
+	int err;
+
+	err = snd_seq_device_new(chip->card, chip->next_seq_device,
+				 SNDRV_SEQ_DEV_ID_USBMIDI,
+				 sizeof(snd_usb_midi_t), &seq_device);
+	if (err < 0)
+		return err;
+	chip->next_seq_device++;
+	strcpy(seq_device->name, chip->card->shortname);
+	umidi = (snd_usb_midi_t *)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
+	umidi->chip = chip;
+	umidi->ifnum = ifnum;
+	umidi->quirk = quirk;
+	umidi->seq_client = -1;
+#endif
+	return 0;
+}
+
+static inline int snd_usb_create_quirk(snd_usb_audio_t *chip, int ifnum,
+	       			       const snd_usb_audio_quirk_t *quirk)
+{
+	/* in the future, there may be quirks for PCM devices */
+	return snd_usb_create_midi_interface(chip, ifnum, quirk);
+}
+
 
 /*
  * free the chip instance
@@ -1835,7 +1880,9 @@
 /*
  * create a chip instance and set its names.
  */
-static int snd_usb_audio_create(snd_card_t *card, struct usb_device *dev, snd_usb_audio_t **rchip)
+static int snd_usb_audio_create(snd_card_t *card, struct usb_device *dev,
+				const snd_usb_audio_quirk_t *quirk,
+				snd_usb_audio_t **rchip)
 {
 	snd_usb_audio_t *chip;
 	int err, len;
@@ -1858,18 +1905,50 @@
 	}
 
 	strcpy(card->driver, "USB-Audio");
-	strcpy(card->shortname, "USB Audio Driver");
+
+	/* retrieve the device string as shortname */
+	if (dev->descriptor.iProduct)
+		len = usb_string(dev, dev->descriptor.iProduct,
+				 card->shortname, sizeof(card->shortname));
+	else
+		len = 0;
+	if (len <= 0) {
+ 		if (quirk && quirk->product_name) {
+			strncpy(card->shortname, quirk->product_name, sizeof(card->shortname) - 1);
+			card->shortname[sizeof(card->shortname) - 1] = '\0';
+		} else {
+			sprintf(card->shortname, "USB Device %#04x:%#04x",
+				dev->descriptor.idVendor, dev->descriptor.idProduct);
+		}
+	}
 
 	/* retrieve the vendor and device strings as longname */
-	len = usb_string(dev, 1, card->longname, sizeof(card->longname) - 1);
-	if (len <= 0)
+	if (dev->descriptor.iManufacturer)
+		len = usb_string(dev, dev->descriptor.iManufacturer,
+				 card->longname, sizeof(card->longname) - 1);
+	else
 		len = 0;
-	else {
+	if (len <= 0) {
+		if (quirk && quirk->vendor_name) {
+			strncpy(card->longname, quirk->vendor_name, sizeof(card->longname) - 2);
+			card->longname[sizeof(card->longname) - 2] = '\0';
+			len = strlen(card->longname);
+		} else {
+			len = 0;
+		}
+	}
+	if (len > 0) {
 		card->longname[len] = ' ';
 		len++;
 	}
-	card->longname[len] = 0;
-	usb_string(dev, 2, card->longname + len, sizeof(card->longname) - len);
+	card->longname[len] = '\0';
+	if ((!dev->descriptor.iProduct
+	     || usb_string(dev, dev->descriptor.iProduct,
+	    		   card->longname + len, sizeof(card->longname) - len) <= 0)
+	    && quirk && quirk->product_name) {
+		strncpy(card->longname + len, quirk->product_name, sizeof(card->longname) - len - 1);
+		card->longname[sizeof(card->longname) - 1] = '\0';
+	}
 
 	*rchip = chip;
 	return 0;
@@ -1926,12 +2005,16 @@
 			     const struct usb_device_id *id)
 {
 	struct usb_config_descriptor *config = dev->actconfig;	
+	const snd_usb_audio_quirk_t *quirk = (const snd_usb_audio_quirk_t *)id->driver_info;
 	unsigned char *buffer;
 	unsigned int index;
 	int i, buflen;
 	snd_card_t *card;
 	snd_usb_audio_t *chip;
 
+	if (quirk && ifnum != quirk->ifnum)
+		return NULL;
+
 	if (usb_set_configuration(dev, config->bConfigurationValue) < 0) {
 		snd_printk(KERN_ERR "cannot set configuration (value 0x%x)\n", config->bConfigurationValue);
 		return NULL;
@@ -1966,7 +2049,7 @@
 					snd_printk(KERN_ERR "cannot create a card instance %d\n", i);
 					goto __error;
 				}
-				if (snd_usb_audio_create(card, dev, &chip) < 0) {
+				if (snd_usb_audio_create(card, dev, quirk, &chip) < 0) {
 					snd_card_free(card);
 					goto __error;
 				}
@@ -1980,10 +2063,15 @@
 		}
 	}
 
-	if (snd_usb_create_pcm(chip, ifnum, buffer, buflen) < 0)
-		goto __error;
-	if (snd_usb_create_mixer(chip, ifnum, buffer, buflen) < 0)
-		goto __error;
+	if (!quirk) {
+		if (snd_usb_create_streams(chip, ifnum, buffer, buflen) < 0)
+			goto __error;
+		if (snd_usb_create_mixer(chip, ifnum, buffer, buflen) < 0)
+			goto __error;
+	} else {
+		if (snd_usb_create_quirk(chip, ifnum, quirk) < 0)
+			goto __error;
+	}
 
 	/* we are allowed to call snd_card_register() many times */
 	if (snd_card_register(chip->card) < 0) {
Index: usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.1
diff -u -r1.1 usbaudio.h
--- usb/usbaudio.h	14 Aug 2002 17:22:18 -0000	1.1
+++ usb/usbaudio.h	26 Aug 2002 13:59:02 -0000
@@ -27,6 +27,7 @@
 
 #define USB_SUBCLASS_AUDIO_CONTROL	0x01
 #define USB_SUBCLASS_AUDIO_STREAMING	0x02
+#define USB_SUBCLASS_MIDI_STREAMING	0x03
 
 #define USB_DT_CS_DEVICE                0x21
 #define USB_DT_CS_CONFIG                0x22
@@ -56,6 +57,8 @@
 
 #define EP_GENERAL			0x01
 
+#define MS_GENERAL			0x01
+
 /* endpoint attributes */
 #define EP_ATTR_MASK			0x0c
 #define EP_ATTR_ASYNC			0x04
@@ -115,6 +118,11 @@
 #define USB_AUDIO_FORMAT_IEC1937_MPEG2_LAYER23_LS	0x2006
 
 
+/* maximum number of endpoints per interface */
+#define MIDI_MAX_ENDPOINTS 2
+
+#define SNDRV_SEQ_DEV_ID_USBMIDI "usb-midi"
+
 /*
  */
 
@@ -130,7 +138,52 @@
 	struct list_head pcm_list;	/* list of pcm streams */
 	int pcm_devs;
 
+#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+	int next_seq_device;
+#endif
 };  
+
+/*
+ * Information about devices with broken descriptors
+ */
+typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
+typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
+
+struct snd_usb_audio_quirk {
+	const char *vendor_name;
+	const char *product_name;
+	int ifnum;
+
+	/* MIDI specific */
+	struct snd_usb_midi_endpoint_info {
+		int16_t epnum;		/* ep number, -1 autodetect */
+		uint16_t out_cables;	/* bitmask */
+		uint16_t in_cables;	/* bitmask */
+	} endpoints[MIDI_MAX_ENDPOINTS];
+};
+
+/*
+ * USB MIDI sequencer device data
+ */
+typedef struct snd_usb_midi snd_usb_midi_t;
+typedef struct snd_usb_midi_endpoint snd_usb_midi_endpoint_t;
+typedef struct snd_usb_midi_out_endpoint snd_usb_midi_out_endpoint_t;
+typedef struct snd_usb_midi_in_endpoint snd_usb_midi_in_endpoint_t;
+
+struct snd_usb_midi {
+	/* filled by usbaudio.c */
+	snd_usb_audio_t *chip;
+	int ifnum;
+	const snd_usb_audio_quirk_t *quirk;
+
+	/* used internally in usbmidi.c */
+	int seq_client;
+	struct snd_usb_midi_endpoint {
+		snd_usb_midi_out_endpoint_t *out;
+		snd_usb_midi_in_endpoint_t *in;
+		snd_rawmidi_t *rmidi[0x10];
+	} endpoints[MIDI_MAX_ENDPOINTS];
+};
 
 
 /*
Index: usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.3
diff -u -r1.3 usbmidi.c
--- usb/usbmidi.c	19 Aug 2002 16:19:03 -0000	1.3
+++ usb/usbmidi.c	26 Aug 2002 13:59:02 -0000
@@ -40,7 +40,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
-#include <asm/semaphore.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/asequencer.h>
@@ -48,59 +47,13 @@
 #include <sound/seq_kernel.h>
 #include <sound/seq_virmidi.h>
 #include <sound/seq_midi_event.h>
-#define SNDRV_GET_ID
 #include <sound/initval.h>
+#include "usbaudio.h"
 
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("USB MIDI");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_CLASSES("{sound}");
-MODULE_DEVICES("{{Generic,USB MIDI},"
-		"{Roland/EDIROL,PC-300},"
-		"{Roland/EDIROL,SC-8820},"
-		"{Roland/EDIROL,SC-8850},"
-		"{Roland/EDIROL,SC-D70},"
-		"{Roland/EDIROL,SD-20},"
-		"{Roland/EDIROL,SD-80},"
-		"{Roland/EDIROL,SD-90},"
-		"{Roland/EDIROL,SK-500},"
-		"{Roland/EDIROL,U-8},"
-		"{Roland/EDIROL,UA-100(G)},"
-		"{Roland/EDIROL,UA-700},"
-		"{Roland/EDIROL,UM-1(S)},"
-		"{Roland/EDIROL,UM-2(E)},"
-		"{Roland/EDIROL,UM-4},"
-		"{Roland/EDIROL,UM-550},"
-		"{Roland/EDIROL,UM-880},"
-		"{Roland/EDIROL,XV-5050},"
-		"{Yamaha,MU1000},"
-		"{Yamaha,UX256}}");
-
-static int snd_index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
-static char* snd_id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
-static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */
-static int snd_vid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 }; /* Vendor id of this card */
-static int snd_pid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 }; /* Product id of this card */
-static int snd_int_transfer[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* Use interrupt transfers for this card */
-
-MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_index, "Index value for USB MIDI.");
-MODULE_PARM_SYNTAX(snd_index, SNDRV_INDEX_DESC);
-MODULE_PARM(snd_id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
-MODULE_PARM_DESC(snd_id, "ID string for USB MIDI.");
-MODULE_PARM_SYNTAX(snd_id, SNDRV_ID_DESC);
-MODULE_PARM(snd_enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_enable, "Enable USB MIDI.");
-MODULE_PARM_SYNTAX(snd_enable, SNDRV_ENABLE_DESC);
-MODULE_PARM(snd_vid, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_vid, "USB Vendor ID for USB MIDI.");
-MODULE_PARM_SYNTAX(snd_vid, SNDRV_ENABLED ",allows:{{-1,0xffff}},base:16");
-MODULE_PARM(snd_pid, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_pid, "USB Product ID for USB MIDI.");
-MODULE_PARM_SYNTAX(snd_pid, SNDRV_ENABLED ",allows:{{-1,0xffff}},base:16");
-MODULE_PARM(snd_int_transfer, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_int_transfer, "Use interrupt transfers for USB MIDI input.");
-MODULE_PARM_SYNTAX(snd_int_transfer, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC ",skill:advanced");
 
 /* size of the per-endpoint output buffer, must be a multiple of 4 */
 #define OUTPUT_BUFFER_SIZE 0x400
@@ -108,26 +61,6 @@
 /* max. size of incoming sysex messages */
 #define INPUT_BUFFER_SIZE 0x200
 
-#define MAX_ENDPOINTS 2
-
-#define SNDRV_SEQ_DEV_ID_USBMIDI "usb-midi"
-
-#ifndef USB_SUBCLASS_MIDISTREAMING
-#define USB_SUBCLASS_MIDISTREAMING 3
-#endif
-
-#ifndef USB_DT_CS_INTERFACE
-#define USB_DT_CS_INTERFACE (USB_TYPE_CLASS | USB_DT_INTERFACE)
-#define USB_DT_CS_ENDPOINT (USB_TYPE_CLASS | USB_DT_ENDPOINT)
-#endif
-
-#ifndef USB_DST_MS_HEADER
-#define USB_DST_MS_HEADER 0x01
-#define USB_DST_MS_GENERAL 0x01
-#define USB_DST_MS_HEADER_SIZE 7
-#define USB_DST_MS_GENERAL_SIZE 4
-#endif
-
 typedef struct usb_driver usb_driver_t;
 typedef struct usb_device usb_device_t;
 typedef struct usb_device_id usb_device_id_t;
@@ -153,47 +86,11 @@
 	__u8  baAssocJackID[0];
 } __attribute__ ((packed));
 
-typedef struct usbmidi usbmidi_t;
-typedef struct usbmidi_device_info usbmidi_device_info_t;
-typedef struct usbmidi_endpoint_info usbmidi_endpoint_info_t;
-typedef struct usbmidi_endpoint usbmidi_endpoint_t;
-typedef struct usbmidi_out_endpoint usbmidi_out_endpoint_t;
 typedef struct usbmidi_out_port usbmidi_out_port_t;
-typedef struct usbmidi_in_endpoint usbmidi_in_endpoint_t;
 typedef struct usbmidi_in_port usbmidi_in_port_t;
 
-/*
- * Describes the capabilities of a USB MIDI device.
- * This structure is filled after parsing the USB descriptors,
- * or is supplied explicitly for broken devices.
- */
-struct usbmidi_device_info {
-	char vendor[32];		/* vendor name */
-	char product[32];		/* device name */
-	int16_t ifnum;			/* interface number */
-	struct usbmidi_endpoint_info {
-		int16_t epnum;		/* endpoint number,
-					   -1: autodetect (first ep only) */
-		uint16_t out_cables;	/* bitmask */
-		uint16_t in_cables;	/* bitmask */
-	} endpoints[MAX_ENDPOINTS];
-};
-
-struct usbmidi {
-	snd_card_t* card;
-	usb_device_t* usb_device;
-	int dev;
-	int seq_client;
-	usbmidi_device_info_t device_info;
-	struct usbmidi_endpoint {
-		usbmidi_out_endpoint_t* out;
-		usbmidi_in_endpoint_t* in;
-		snd_rawmidi_t* rmidi[0x10];
-	} endpoints[MAX_ENDPOINTS];
-};
-
-struct usbmidi_out_endpoint {
-	usbmidi_t* umidi;
+struct snd_usb_midi_out_endpoint {
+	snd_usb_midi_t* umidi;
 	struct urb* urb;
 	int max_transfer;		/* size of urb buffer */
 	struct tasklet_struct tasklet;
@@ -204,16 +101,16 @@
 	spinlock_t buffer_lock;
 
 	struct usbmidi_out_port {
-		usbmidi_out_endpoint_t* ep;
+		snd_usb_midi_out_endpoint_t* ep;
 		uint8_t cable;		/* cable number << 4 */
 		uint8_t sysex_len;
 		uint8_t sysex[2];
 	} ports[0x10];
 };
 
-struct usbmidi_in_endpoint {
-	usbmidi_t* umidi;
-	usbmidi_endpoint_t* ep;
+struct snd_usb_midi_in_endpoint {
+	snd_usb_midi_t* umidi;
+	snd_usb_midi_endpoint_t* ep;
 	struct urb* urb;
 	struct usbmidi_in_port {
 		int seq_port;
@@ -221,10 +118,7 @@
 	} ports[0x10];
 };
 
-static int snd_usbmidi_card_used[SNDRV_CARDS];
-static DECLARE_MUTEX(snd_usbmidi_open_mutex);
-
-static void snd_usbmidi_do_output(usbmidi_out_endpoint_t* ep);
+static void snd_usbmidi_do_output(snd_usb_midi_out_endpoint_t* ep);
 
 /*
  * Submits the URB, with error handling.
@@ -255,7 +149,7 @@
 /*
  * Converts a USB MIDI packet into an ALSA sequencer event.
  */
-static void snd_usbmidi_input_packet(usbmidi_in_endpoint_t* ep,
+static void snd_usbmidi_input_packet(snd_usb_midi_in_endpoint_t* ep,
 				     uint8_t packet[4])
 {
 	static const uint8_t cin_length[] = {
@@ -285,7 +179,7 @@
  */
 static void snd_usbmidi_in_urb_complete(struct urb* urb)
 {
-	usbmidi_in_endpoint_t* ep = snd_magic_cast(usbmidi_in_endpoint_t, urb->context, return);
+	snd_usb_midi_in_endpoint_t* ep = snd_magic_cast(snd_usb_midi_in_endpoint_t, urb->context, return);
 
 	if (urb->status == 0) {
 		uint8_t* buffer = (uint8_t*)ep->urb->transfer_buffer;
@@ -300,14 +194,14 @@
 	}
 
 	if (!usb_pipeint(urb->pipe)) {
-		urb->dev = ep->umidi->usb_device;
+		urb->dev = ep->umidi->chip->dev;
 		snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
 	}
 }
 
 static void snd_usbmidi_out_urb_complete(struct urb* urb)
 {
-	usbmidi_out_endpoint_t* ep = snd_magic_cast(usbmidi_out_endpoint_t, urb->context, return);
+	snd_usb_midi_out_endpoint_t* ep = snd_magic_cast(snd_usb_midi_out_endpoint_t, urb->context, return);
 	unsigned long flags;
 
 	if (urb->status < 0) {
@@ -324,7 +218,7 @@
  * (after the reception of one or more sequencer events, or after completion
  * of the previous transfer). ep->buffer_lock must be held.
  */
-static void snd_usbmidi_do_output(usbmidi_out_endpoint_t* ep)
+static void snd_usbmidi_do_output(snd_usb_midi_out_endpoint_t* ep)
 {
 	int len;
 	uint8_t* buffer;
@@ -361,14 +255,14 @@
 	}
 
 	if (len > 0) {
-		ep->urb->dev = ep->umidi->usb_device;
+		ep->urb->dev = ep->umidi->chip->dev;
 		snd_usbmidi_submit_urb(ep->urb, GFP_ATOMIC);
 	}
 }
 
 static void snd_usbmidi_out_tasklet(unsigned long data)
 {
-	usbmidi_out_endpoint_t* ep = snd_magic_cast(usbmidi_out_endpoint_t, (void*)data, return);
+	snd_usb_midi_out_endpoint_t* ep = snd_magic_cast(snd_usb_midi_out_endpoint_t, (void*)data, return);
 	unsigned long flags;
 	
 	spin_lock_irqsave(&ep->buffer_lock, flags);
@@ -382,7 +276,7 @@
 static void output_packet(usbmidi_out_port_t* port,
 			  uint8_t p0, uint8_t p1, uint8_t p2, uint8_t p3)
 {
-	usbmidi_out_endpoint_t* ep = port->ep;
+	snd_usb_midi_out_endpoint_t* ep = port->ep;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ep->buffer_lock, flags);
@@ -568,7 +462,7 @@
  * Frees an input endpoint.
  * May be called when ep hasn't been initialized completely.
  */
-static void snd_usbmidi_in_endpoint_delete(usbmidi_in_endpoint_t* ep)
+static void snd_usbmidi_in_endpoint_delete(snd_usb_midi_in_endpoint_t* ep)
 {
 	int i;
 
@@ -586,53 +480,54 @@
 }
 
 /*
- * Searches for an alternate setting in which the endpoint uses interrupt
+ * For Roland devices, use the alternate setting which uses interrupt
  * transfers for input.
  */
-static int snd_usbmidi_get_int_ep(usbmidi_t* umidi, uint8_t epnum,
-				  usb_endpoint_descriptor_t** descriptor)
+static usb_endpoint_descriptor_t* snd_usbmidi_get_int_epd(snd_usb_midi_t* umidi,
+							  uint8_t epnum)
 {
 	usb_interface_t* intf;
-	int i, j;
+	usb_interface_descriptor_t* intfd;
 
-	*descriptor = NULL;
-	intf = usb_ifnum_to_if(umidi->usb_device, umidi->device_info.ifnum);
-	if (!intf)
-		return -ENXIO;
-	for (i = 0; i < intf->num_altsetting; ++i) {
-		usb_interface_descriptor_t* intfd = &intf->altsetting[i];
-		for (j = 0; j < intfd->bNumEndpoints; ++j) {
-			usb_endpoint_descriptor_t* epd = &intfd->endpoint[j];
-			if ((epd->bEndpointAddress & (USB_ENDPOINT_NUMBER_MASK | USB_ENDPOINT_DIR_MASK)) == (epnum | USB_DIR_IN) &&
-			    (epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT) {
-				usb_set_interface(umidi->usb_device,
-						  intfd->bInterfaceNumber,
-						  intfd->bAlternateSetting);
-				*descriptor = &intfd->endpoint[j];
-				return 0;
-			}
-		}
-	}
-	return -ENXIO;
+	if (umidi->chip->dev->descriptor.idVendor != 0x0582)
+		return NULL;
+	intf = usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
+	if (!intf || intf->num_altsetting != 2)
+		return NULL;
+
+	intfd = &intf->altsetting[0];
+	if (intfd->bNumEndpoints != 2 ||
+	    (intfd->endpoint[0].bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
+	    (intfd->endpoint[1].bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK)
+		return NULL;
+
+	intfd = &intf->altsetting[1];
+	if (intfd->bNumEndpoints != 2 ||
+	    (intfd->endpoint[0].bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
+	    (intfd->endpoint[1].bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
+		return NULL;
+
+	usb_set_interface(umidi->chip->dev, intfd->bInterfaceNumber,
+			  intfd->bAlternateSetting);
+	return &intfd->endpoint[1];
 }
 
 /*
  * Creates an input endpoint, and initalizes input ports.
  * ALSA ports are created later.
  */
-static int snd_usbmidi_in_endpoint_create(usbmidi_t* umidi,
-					  usbmidi_endpoint_info_t* ep_info,
-					  usbmidi_endpoint_t* rep)
+static int snd_usbmidi_in_endpoint_create(snd_usb_midi_t* umidi,
+					  snd_usb_midi_endpoint_info_t* ep_info,
+					  snd_usb_midi_endpoint_t* rep)
 {
-	usbmidi_in_endpoint_t* ep;
-	int do_int_transfer;
-	usb_endpoint_descriptor_t* epd;
+	snd_usb_midi_in_endpoint_t* ep;
+	usb_endpoint_descriptor_t* int_epd;
 	void* buffer;
 	unsigned int pipe;
 	int length, i, err;
 
 	rep->in = NULL;
-	ep = snd_magic_kcalloc(usbmidi_in_endpoint_t, 0, GFP_KERNEL);
+	ep = snd_magic_kcalloc(snd_usb_midi_in_endpoint_t, 0, GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -640,34 +535,28 @@
 	for (i = 0; i < 0x10; ++i)
 		ep->ports[i].seq_port = -1;
 
-	do_int_transfer = snd_int_transfer[umidi->dev];
-	if (do_int_transfer) {
-		if (snd_usbmidi_get_int_ep(umidi, ep_info->epnum, &epd) < 0) {
-			printk(KERN_WARNING "snd-usb-midi: interrupt endpoint not found\n");
-			do_int_transfer = 0;
-		}
-	}
+	int_epd = snd_usbmidi_get_int_epd(umidi, ep_info->epnum);
 
 	ep->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!ep->urb) {
 		snd_usbmidi_in_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	if (do_int_transfer)
-		pipe = usb_rcvintpipe(umidi->usb_device, ep_info->epnum);
+	if (int_epd)
+		pipe = usb_rcvintpipe(umidi->chip->dev, ep_info->epnum);
 	else
-		pipe = usb_rcvbulkpipe(umidi->usb_device, ep_info->epnum);
-	length = usb_maxpacket(umidi->usb_device, pipe, 0);
+		pipe = usb_rcvbulkpipe(umidi->chip->dev, ep_info->epnum);
+	length = usb_maxpacket(umidi->chip->dev, pipe, 0);
 	buffer = kmalloc(length, GFP_KERNEL);
 	if (!buffer) {
 		snd_usbmidi_in_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	if (do_int_transfer)
-		FILL_INT_URB(ep->urb, umidi->usb_device, pipe, buffer, length,
-			     snd_usbmidi_in_urb_complete, ep, epd->bInterval);
+	if (int_epd)
+		FILL_INT_URB(ep->urb, umidi->chip->dev, pipe, buffer, length,
+			     snd_usbmidi_in_urb_complete, ep, int_epd->bInterval);
 	else
-		FILL_BULK_URB(ep->urb, umidi->usb_device, pipe, buffer, length,
+		FILL_BULK_URB(ep->urb, umidi->chip->dev, pipe, buffer, length,
 			      snd_usbmidi_in_urb_complete, ep);
 
 	for (i = 0; i < 0x10; ++i)
@@ -697,7 +586,7 @@
  * Frees an output endpoint.
  * May be called when ep hasn't been initialized completely.
  */
-static void snd_usbmidi_out_endpoint_delete(usbmidi_out_endpoint_t* ep)
+static void snd_usbmidi_out_endpoint_delete(snd_usb_midi_out_endpoint_t* ep)
 {
 	if (ep->tasklet.func)
 		tasklet_kill(&ep->tasklet);
@@ -715,17 +604,17 @@
  * Creates an output endpoint, and initializes output ports.
  * ALSA ports are created later.
  */
-static int snd_usbmidi_out_endpoint_create(usbmidi_t* umidi,
-					   usbmidi_endpoint_info_t* ep_info,
-			 		   usbmidi_endpoint_t* rep)
+static int snd_usbmidi_out_endpoint_create(snd_usb_midi_t* umidi,
+					   snd_usb_midi_endpoint_info_t* ep_info,
+			 		   snd_usb_midi_endpoint_t* rep)
 {
-	usbmidi_out_endpoint_t* ep;
+	snd_usb_midi_out_endpoint_t* ep;
 	int i;
 	unsigned int pipe;
 	void* buffer;
 
 	rep->out = NULL;
-	ep = snd_magic_kcalloc(usbmidi_out_endpoint_t, 0, GFP_KERNEL);
+	ep = snd_magic_kcalloc(snd_usb_midi_out_endpoint_t, 0, GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -735,14 +624,14 @@
 		snd_usbmidi_out_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	pipe = usb_sndbulkpipe(umidi->usb_device, ep_info->epnum);
-	ep->max_transfer = usb_maxpacket(umidi->usb_device, pipe, 1) & ~3;
+	pipe = usb_sndbulkpipe(umidi->chip->dev, ep_info->epnum);
+	ep->max_transfer = usb_maxpacket(umidi->chip->dev, pipe, 1) & ~3;
 	buffer = kmalloc(ep->max_transfer, GFP_KERNEL);
 	if (!buffer) {
 		snd_usbmidi_out_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	FILL_BULK_URB(ep->urb, umidi->usb_device, pipe, buffer,
+	FILL_BULK_URB(ep->urb, umidi->chip->dev, pipe, buffer,
 		      ep->max_transfer, snd_usbmidi_out_urb_complete, ep);
 
 	spin_lock_init(&ep->buffer_lock);
@@ -763,17 +652,17 @@
  */
 static int snd_usbmidi_seq_device_delete(snd_seq_device_t* seq_device)
 {
-	usbmidi_t* umidi;
+	snd_usb_midi_t* umidi;
 	int i, j;
 
-	umidi = (usbmidi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
+	umidi = (snd_usb_midi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
 
 	if (umidi->seq_client >= 0) {
 		snd_seq_delete_kernel_client(umidi->seq_client);
 		umidi->seq_client = -1;
 	}
-	for (i = 0; i < MAX_ENDPOINTS; ++i) {
-		usbmidi_endpoint_t* ep = &umidi->endpoints[i];
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
 		if (ep->out) {
 			snd_usbmidi_out_endpoint_delete(ep->out);
 			ep->out = NULL;
@@ -784,7 +673,7 @@
 		}
 		for (j = 0; j < 0x10; ++j)
 			if (ep->rmidi[j]) {
-				snd_device_free(umidi->card, ep->rmidi[j]);
+				snd_device_free(umidi->chip->card, ep->rmidi[j]);
 				ep->rmidi[j] = NULL;
 			}
 	}
@@ -796,10 +685,9 @@
  * the ALSA port for each input/output port pair in the endpoint.
  * *port_idx is the port number, which must be unique over all endpoints.
  */
-static int snd_usbmidi_create_endpoint_ports(usbmidi_t* umidi, int ep,
-					     int* port_idx)
+static int snd_usbmidi_create_endpoint_ports(snd_usb_midi_t* umidi, int ep, int* port_idx,
+					     snd_usb_midi_endpoint_info_t* ep_info)
 {
-	usbmidi_endpoint_info_t* ep_info = &umidi->device_info.endpoints[ep];
 	int c, err;
 	int cap, type, port;
 	int out, in;
@@ -830,8 +718,8 @@
 		/* TODO: read type bits from element descriptor */
 		type = SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC;
 		/* TODO: read port name from jack descriptor */
-		sprintf(port_name, "%s Port %d",
-			umidi->device_info.product, *port_idx);
+		snprintf(port_name, sizeof(port_name), "%s Port %d",
+			 umidi->chip->card->shortname, *port_idx);
 		port = snd_seq_event_port_attach(umidi->seq_client,
 						 &port_callback,
 						 cap, type, port_name);
@@ -845,7 +733,7 @@
 		if (*port_idx < SNDRV_MINOR_RAWMIDIS) {
 			snd_rawmidi_t *rmidi;
 			snd_virmidi_dev_t *rdev;
-			err = snd_virmidi_new(umidi->card, *port_idx, &rmidi);
+			err = snd_virmidi_new(umidi->chip->card, *port_idx, &rmidi);
 			if (err < 0)
 				return err;
 			rdev = snd_magic_cast(snd_virmidi_dev_t, rmidi->private_data, return -ENXIO);
@@ -853,9 +741,9 @@
 			rdev->seq_mode = SNDRV_VIRMIDI_SEQ_ATTACH;
 			rdev->client = umidi->seq_client;
 			rdev->port = port;
-			err = snd_device_register(umidi->card, rmidi);
+			err = snd_device_register(umidi->chip->card, rmidi);
 			if (err < 0) {
-				snd_device_free(umidi->card, rmidi);
+				snd_device_free(umidi->chip->card, rmidi);
 				return err;
 			}
 			umidi->endpoints[ep].rmidi[c] = rmidi;
@@ -866,219 +754,45 @@
 }
 
 /*
- * Create the endpoints and their ports.
+ * Creates the endpoints and their ports.
  */
-static int snd_usbmidi_create_endpoints(usbmidi_t* umidi)
+static int snd_usbmidi_create_endpoints(snd_usb_midi_t* umidi,
+					snd_usb_midi_endpoint_info_t* endpoints)
 {
 	int i, err, port_idx = 0;
 
-	for (i = 0; i < MAX_ENDPOINTS; ++i) {
-		usbmidi_endpoint_info_t* ep_info = &umidi->device_info.endpoints[i];
-
-		if (!ep_info->epnum)
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		if (!endpoints[i].epnum)
 			continue;
-		if (ep_info->out_cables) {
-			err = snd_usbmidi_out_endpoint_create(umidi, ep_info,
+		if (endpoints[i].out_cables) {
+			err = snd_usbmidi_out_endpoint_create(umidi, &endpoints[i],
 							      &umidi->endpoints[i]);
 			if (err < 0)
 				return err;
 		}
-		if (ep_info->in_cables) {
-			err = snd_usbmidi_in_endpoint_create(umidi, ep_info,
+		if (endpoints[i].in_cables) {
+			err = snd_usbmidi_in_endpoint_create(umidi, &endpoints[i],
 							     &umidi->endpoints[i]);
 			if (err < 0)
 				return err;
 		}
-		err = snd_usbmidi_create_endpoint_ports(umidi, i, &port_idx);
+		err = snd_usbmidi_create_endpoint_ports(umidi, i, &port_idx,
+							&endpoints[i]);
 		if (err < 0)
 			return err;
 		printk(KERN_INFO "snd-usb-midi: endpoint %d: created %d output and %d input ports\n",
-		       ep_info->epnum,
-		       snd_usbmidi_count_bits(ep_info->out_cables),
-		       snd_usbmidi_count_bits(ep_info->in_cables));
+		       endpoints[i].epnum,
+		       snd_usbmidi_count_bits(endpoints[i].out_cables),
+		       snd_usbmidi_count_bits(endpoints[i].in_cables));
 	}
 	return 0;
 }
 
 /*
- * Initialize the sequencer device.
- */
-static int snd_usbmidi_seq_device_new(snd_seq_device_t* seq_device)
-{
-	usbmidi_t* umidi;
-	snd_seq_client_callback_t client_callback;
-	snd_seq_client_info_t client_info;
-	int i, err;
-
-	umidi = (usbmidi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
-
-	memset(&client_callback, 0, sizeof(client_callback));
-	client_callback.allow_output = 1;
-	client_callback.allow_input = 1;
-	umidi->seq_client = snd_seq_create_kernel_client(umidi->card, 0,
-							 &client_callback);
-	if (umidi->seq_client < 0)
-		return umidi->seq_client;
-
-	memset(&client_info, 0, sizeof(client_info));
-	client_info.client = umidi->seq_client;
-	client_info.type = KERNEL_CLIENT;
-	sprintf(client_info.name, "%s %s",
-		umidi->device_info.vendor, umidi->device_info.product);
-	snd_seq_kernel_client_ctl(umidi->seq_client,
-				  SNDRV_SEQ_IOCTL_SET_CLIENT_INFO,
-				  &client_info);
-
-	err = snd_usbmidi_create_endpoints(umidi);
-	if (err < 0) {
-		snd_usbmidi_seq_device_delete(seq_device);
-		return err;
-	}
-
-	for (i = 0; i < MAX_ENDPOINTS; ++i)
-		if (umidi->endpoints[i].in)
-			snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,
-					       GFP_KERNEL);
-	return 0;
-}
-
-static int snd_usbmidi_card_create(usb_device_t* usb_device,
-				   usbmidi_device_info_t* device_info,
-				   snd_card_t** rcard)
-{
-	snd_card_t* card;
-	snd_seq_device_t* seq_device;
-	usbmidi_t* umidi;
-	int dev, err;
-
-	if (rcard)
-		*rcard = NULL;
-
-	down(&snd_usbmidi_open_mutex);
-
-	for (dev = 0; dev < SNDRV_CARDS; ++dev) {
-		if (snd_enable[dev] && !snd_usbmidi_card_used[dev] &&
-		    (snd_vid[dev] == -1 || 
-		     snd_vid[dev] == usb_device->descriptor.idVendor) &&
-		    (snd_pid[dev] == -1 ||
-		     snd_pid[dev] == usb_device->descriptor.idProduct))
-			break;
-	}
-	if (dev >= SNDRV_CARDS) {
-		up(&snd_usbmidi_open_mutex);
-		return -ENOENT;
-	}
-
-	card = snd_card_new(snd_index[dev], snd_id[dev], THIS_MODULE, 0);
-	if (!card) {
-		up(&snd_usbmidi_open_mutex);
-		return -ENOMEM;
-	}
-	strcpy(card->driver, "USB MIDI");
-	snprintf(card->shortname, sizeof(card->shortname), "%s %s",
-		 device_info->vendor, device_info->product);
-	snprintf(card->longname, sizeof(card->longname), "%s %s at %03d/%03d if %d",
-		 device_info->vendor, device_info->product,
-		 usb_device->bus->busnum, usb_device->devnum,
-		 device_info->ifnum);
-	card->private_data = (void*)dev;
-
-	err = snd_seq_device_new(card, 0, SNDRV_SEQ_DEV_ID_USBMIDI,
-				 sizeof(usbmidi_t), &seq_device);
-	if (err < 0) {
-		snd_card_free(card);
-		up(&snd_usbmidi_open_mutex);
-		return err;
-	}
-	strcpy(seq_device->name, card->shortname);
-	umidi = (usbmidi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
-	umidi->card = card;
-	umidi->usb_device = usb_device;
-	umidi->dev = dev;
-	umidi->seq_client = -1;
-	umidi->device_info = *device_info;
-
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		up(&snd_usbmidi_open_mutex);
-		return err;
-	}
-	snd_usbmidi_card_used[dev] = 1;
-	up(&snd_usbmidi_open_mutex);
-	if (rcard)
-		*rcard = card;
-	return 0;
-}
-
-/*
- * If the first endpoint isn't specified, use the first endpoint in the
- * first alternate setting of the interface.
- */
-static int snd_usbmidi_detect_endpoint(usb_device_t* usb_device, 
-			       	       usbmidi_device_info_t* device_info)
-{
-	usb_interface_t* intf;
-	usb_interface_descriptor_t* intfd;
-	usb_endpoint_descriptor_t* epd;
-
-	if (device_info->endpoints[0].epnum == -1) {
-		intf = usb_ifnum_to_if(usb_device, device_info->ifnum);
-		if (!intf || intf->num_altsetting < 1)
-			return -ENOENT;
-		intfd = intf->altsetting;
-		if (intfd->bNumEndpoints < 1)
-			return -ENOENT;
-		epd = intfd->endpoint;
-		device_info->endpoints[0].epnum = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	}
-	return 0;
-}
-
-/*
- * Searches for the alternate setting with the greatest number of bulk transfer
- * endpoints.
- */
-static usb_interface_descriptor_t* snd_usbmidi_get_altsetting(usb_device_t* usb_device,
-							      usb_interface_t* intf)
-{
-	int i, best = -1;
-	int best_out = 0, best_in = 0;
-	usb_interface_descriptor_t* intfd;
-
-	if (intf->num_altsetting == 1)
-		return &intf->altsetting[0];
-	for (i = 0; i < intf->num_altsetting; ++i) {
-		int out = 0, in = 0, j;
-		for (j = 0; j < intf->altsetting[i].bNumEndpoints; ++j) {
-			usb_endpoint_descriptor_t* ep = &intf->altsetting[i].endpoint[j];
-			if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_BULK) {
-				if (ep->bEndpointAddress & USB_DIR_IN)
-					++in;
-				else
-					++out;
-			}
-		}
-		if ((out >= best_out && in >= best_in) &&
-		    (out > best_out || in > best_in)) {
-			best_out = out;
-			best_in = in;
-			best = i;
-		}
-	}
-	if (best < 0)
-		return NULL;
-	intfd = &intf->altsetting[best];
-	usb_set_interface(usb_device, intfd->bInterfaceNumber, intfd->bAlternateSetting);
-	return intfd;
-}
-
-/*
- * Returns MIDIStreaming device capabilities in device_info.
+ * Returns MIDIStreaming device capabilities.
  */
-static int snd_usbmidi_get_ms_info(usb_device_t* usb_device,
-				   unsigned int ifnum,
-				   usbmidi_device_info_t* device_info)
+static int snd_usbmidi_get_ms_info(snd_usb_midi_t* umidi,
+			   	   snd_usb_midi_endpoint_info_t* endpoints)
 {
 	usb_interface_t* intf;
 	usb_interface_descriptor_t* intfd;
@@ -1087,34 +801,17 @@
 	usb_ms_endpoint_descriptor_t* ms_ep;
 	int i, epidx;
 
-	memset(device_info, 0, sizeof(*device_info));
+	memset(endpoints, 0, sizeof(*endpoints) * MIDI_MAX_ENDPOINTS);
 
-	if (usb_device->descriptor.iManufacturer == 0 ||
-	    usb_string(usb_device, usb_device->descriptor.iManufacturer,
-		       device_info->vendor, sizeof(device_info->vendor)) < 0)
-		sprintf(device_info->vendor, "Unknown Vendor %x", usb_device->descriptor.idVendor);
-	if (usb_device->descriptor.iProduct == 0 ||
-	    usb_string(usb_device, usb_device->descriptor.iProduct,
-		       device_info->product, sizeof(device_info->product)) < 0)
-		sprintf(device_info->product, "Unknown Device %x", usb_device->descriptor.idProduct);
-
-	intf = usb_ifnum_to_if(usb_device, ifnum);
+	intf = usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
 	if (!intf)
 		return -ENXIO;
-	device_info->ifnum = ifnum;
-	printk(KERN_INFO "snd-usb-midi: using interface %d\n",
-	       intf->altsetting[0].bInterfaceNumber);
-
-	intfd = snd_usbmidi_get_altsetting(usb_device, intf);
-	if (!intfd) {
-		printk(KERN_ERR "snd-usb-midi: could not determine altsetting\n");
-		return -ENXIO;
-	}
+	intfd = &intf->altsetting[0];
 	ms_header = (usb_ms_header_descriptor_t*)intfd->extra;
-	if (intfd->extralen >= USB_DST_MS_HEADER_SIZE &&
-	    ms_header->bLength >= USB_DST_MS_HEADER_SIZE &&
+	if (intfd->extralen >= 7 &&
+	    ms_header->bLength >= 7 &&
 	    ms_header->bDescriptorType == USB_DT_CS_INTERFACE &&
-	    ms_header->bDescriptorSubtype == USB_DST_MS_HEADER)
+	    ms_header->bDescriptorSubtype == HEADER)
 		printk(KERN_INFO "snd-usb-midi: MIDIStreaming version %02x.%02x\n",
 		       ms_header->bcdMSC[1], ms_header->bcdMSC[0]);
 	else
@@ -1126,242 +823,124 @@
 		if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK)
 			continue;
 		ms_ep = (usb_ms_endpoint_descriptor_t*)ep->extra;
-		if (ep->extralen < USB_DST_MS_GENERAL_SIZE ||
-		    ms_ep->bLength < USB_DST_MS_GENERAL_SIZE ||
+		if (ep->extralen < 4 ||
+		    ms_ep->bLength < 4 ||
 		    ms_ep->bDescriptorType != USB_DT_CS_ENDPOINT ||
-		    ms_ep->bDescriptorSubtype != USB_DST_MS_GENERAL)
+		    ms_ep->bDescriptorSubtype != MS_GENERAL)
 			continue;
-		if (device_info->endpoints[epidx].epnum != 0 &&
-		    device_info->endpoints[epidx].epnum != (ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK)) {
+		if (endpoints[epidx].epnum != 0 &&
+		    endpoints[epidx].epnum != (ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK)) {
 			++epidx;
-			if (epidx >= MAX_ENDPOINTS) {
+			if (epidx >= MIDI_MAX_ENDPOINTS) {
 				printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");
 				break;
 			}
 		}
-		device_info->endpoints[epidx].epnum = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+		endpoints[epidx].epnum = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 		if (ep->bEndpointAddress & USB_DIR_IN) {
-			device_info->endpoints[epidx].in_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
+			endpoints[epidx].in_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
 		} else {
-			device_info->endpoints[epidx].out_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
+			endpoints[epidx].out_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
 		}
 		printk(KERN_INFO "snd-usb-midi: detected %d %s jack(s) on endpoint %d\n",
 		       ms_ep->bNumEmbMIDIJack,
 		       ep->bEndpointAddress & USB_DIR_IN ? "input" : "output",
-		       device_info->endpoints[epidx].epnum);
-	}
-	return 0;
-}
-
-/*
- * Returns device capabilities, either explicitly supplied or from the
- * class-specific descriptors.
- */
-static int snd_usbmidi_get_device_info(usb_device_t* usb_device,
-				       unsigned int ifnum,
-				       const usb_device_id_t* usb_device_id,
-				       usbmidi_device_info_t* device_info)
-{
-	if (usb_device_id->driver_info) {
-		usbmidi_device_info_t* id_info = (usbmidi_device_info_t*)usb_device_id->driver_info;
-		if (ifnum != id_info->ifnum)
-			return -ENXIO;
-		*device_info = *id_info;
-		if (snd_usbmidi_detect_endpoint(usb_device, device_info) < 0)
-			return -ENXIO;
-	} else {
-		if (snd_usbmidi_get_ms_info(usb_device, ifnum, device_info) < 0)
-			return -ENXIO;
+		       endpoints[epidx].epnum);
 	}
 	return 0;
 }
 
 /*
- * Probes for a supported device.
+ * If the first endpoint isn't specified, use the first endpoint in the
+ * first alternate setting of the interface.
  */
-static void* snd_usbmidi_usb_probe(usb_device_t* device,
-				   unsigned int ifnum,
-				   const usb_device_id_t* device_id)
+static int snd_usbmidi_detect_endpoint(snd_usb_midi_t* umidi, 
+			       	       snd_usb_midi_endpoint_info_t* endpoint)
 {
-	usbmidi_device_info_t device_info;
-	snd_card_t* card = NULL;
-	int err;
+	usb_interface_t* intf;
+	usb_interface_descriptor_t* intfd;
+	usb_endpoint_descriptor_t* epd;
 
-	if (snd_usbmidi_get_device_info(device, ifnum, device_id,
-					&device_info) == 0) {
-		printk(KERN_INFO "snd-usb-midi: detected %s %s\n",
-		       device_info.vendor, device_info.product);
-		err = snd_usbmidi_card_create(device, &device_info, &card);
-		if (err < 0)
-			snd_printk(KERN_ERR "cannot create card (error code %d)\n", err);
+	if (endpoint->epnum == -1) {
+		intf = usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
+		if (!intf || intf->num_altsetting < 1)
+			return -ENOENT;
+		intfd = intf->altsetting;
+		if (intfd->bNumEndpoints < 1)
+			return -ENOENT;
+		epd = intfd->endpoint;
+		endpoint->epnum = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	}
-	return card;
+	return 0;
 }
 
 /*
- * Frees the device.
+ * Initialize the sequencer device.
  */
-static void snd_usbmidi_usb_disconnect(usb_device_t* usb_device, void* ptr)
+static int snd_usbmidi_seq_device_new(snd_seq_device_t* seq_device)
 {
-	snd_card_t* card = (snd_card_t*)ptr;
-	int dev = (int)card->private_data;
+	snd_usb_midi_t* umidi;
+	usb_device_t* dev;
+	snd_seq_client_callback_t client_callback;
+	snd_seq_client_info_t client_info;
+	snd_usb_midi_endpoint_info_t endpoints[MIDI_MAX_ENDPOINTS];
+	int i, err;
 
-	snd_card_free(card);
-	down(&snd_usbmidi_open_mutex);
-	snd_usbmidi_card_used[dev] = 0;
-	up(&snd_usbmidi_open_mutex);
-}
+	umidi = (snd_usb_midi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
 
-/*
- * Information about devices with broken descriptors.
- */
-
-static usbmidi_device_info_t snd_usbmidi_yamaha_ux256_info = {
-	/* from NetBSD's umidi driver */
-	.vendor = "Yamaha", .product = "UX256",
-	.ifnum = 0,
-	.endpoints = {{ -1, 0xffff, 0x00ff }}
-};
-static usbmidi_device_info_t snd_usbmidi_yamaha_mu1000_info = {
-	/* from Nagano Daisuke's usb-midi driver */
-	.vendor = "Yamaha", .product = "MU1000",
-	.ifnum = 0,
-	.endpoints = {{ 1, 0x000f, 0x0001 }}
-};
-/*
- * There ain't no such thing as a standard-compliant Roland device.
- * Apparently, Roland decided not to risk to have wrong entries in the USB
- * descriptors. The consequence is that class-specific descriptors are
- * conspicuous by their absence.
- *
- * And now you may guess which company was responsible for writing the
- * USB Device Class Definition for MIDI Devices.
- */
-static usbmidi_device_info_t snd_usbmidi_roland_ua100_info = {
-	.vendor = "Roland", .product = "UA-100",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0007, 0x0007 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_um4_info = {
-	.vendor = "EDIROL", .product = "UM-4",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x000f, 0x000f }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_sc8850_info = {
-	.vendor = "Roland", .product = "SC-8850",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x003f, 0x003f }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_u8_info = {
-	.vendor = "Roland", .product = "U-8",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0003, 0x0003 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_um2_info = {
-	.vendor = "EDIROL", .product = "UM-2",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0003, 0x0003 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_sc8820_info = {
-	.vendor = "Roland", .product = "SC-8820",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0013, 0x0013 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_pc300_info = {
-	.vendor = "Roland", .product = "PC-300",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0001, 0x0001 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_um1_info = {
-	.vendor = "EDIROL", .product = "UM-1",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0001, 0x0001 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_sk500_info = {
-	.vendor = "Roland", .product = "SK-500",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0013, 0x0013 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_scd70_info = {
-	.vendor = "Roland", .product = "SC-D70",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x0007, 0x0007 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_xv5050_info = {
-	.vendor = "Roland", .product = "XV-5050",
-	.ifnum = 0,
-	.endpoints = {{ -1, 0x0001, 0x0001 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_um880_info = {
-	.vendor = "EDIROL", .product = "UM-880",
-	.ifnum = 0,
-	.endpoints = {{ -1, 0x01ff, 0x01ff }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_sd90_info = {
-	.vendor = "EDIROL", .product = "SD-90",
-	.ifnum = 2,
-	.endpoints = {{ -1, 0x000f, 0x000f }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_um550_info = {
-	.vendor = "EDIROL", .product = "UM-550",
-	.ifnum = 0,
-	.endpoints = {{ -1, 0x003f, 0x003f }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_sd20_info = {
-	.vendor = "EDIROL", .product = "SD-20",
-	.ifnum = 0,
-	.endpoints = {{ -1, 0x0003, 0x0007 }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_sd80_info = {
-	.vendor = "EDIROL", .product = "SD-80",
-	.ifnum = 0,
-	.endpoints = {{ -1, 0x000f, 0x000f }}
-};
-static usbmidi_device_info_t snd_usbmidi_roland_ua700_info = {
-	.vendor = "EDIROL", .product = "UA-700",
-	.ifnum = 3,
-	.endpoints = {{ -1, 0x0003, 0x0003 }}
-};
+	memset(&client_callback, 0, sizeof(client_callback));
+	client_callback.allow_output = 1;
+	client_callback.allow_input = 1;
+	umidi->seq_client = snd_seq_create_kernel_client(umidi->chip->card, 0,
+							 &client_callback);
+	if (umidi->seq_client < 0)
+		return umidi->seq_client;
 
-#define USBMIDI_NONCOMPLIANT_DEVICE(vid, pid, name) \
-		USB_DEVICE(vid, pid), \
-		driver_info: (unsigned long)&snd_usbmidi_##name##_info
-static usb_device_id_t snd_usbmidi_usb_id_table[] = {
-	{ match_flags: USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	  bInterfaceClass: USB_CLASS_AUDIO,
-	  bInterfaceSubClass: USB_SUBCLASS_MIDISTREAMING },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0499, 0x1000, yamaha_ux256) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0499, 0x1001, yamaha_mu1000) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0000, roland_ua100) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0002, roland_um4) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0003, roland_sc8850) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0004, roland_u8) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0005, roland_um2) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0007, roland_sc8820) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0008, roland_pc300) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0009, roland_um1) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x000b, roland_sk500) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x000c, roland_scd70) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0012, roland_xv5050) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0014, roland_um880) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0016, roland_sd90) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0023, roland_um550) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0027, roland_sd20) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0029, roland_sd80) },
-	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x002b, roland_ua700) },
-	{ /* terminator */ }
-};
+	memset(&client_info, 0, sizeof(client_info));
+	client_info.client = umidi->seq_client;
+	client_info.type = KERNEL_CLIENT;
+	dev = umidi->chip->dev;
+	if (dev->descriptor.iProduct)
+		err = usb_string(dev, dev->descriptor.iProduct,
+				 client_info.name, sizeof(client_info.name));
+	else
+		err = 0;
+	if (err <= 0) {
+		if (umidi->quirk && umidi->quirk->product_name) {
+			strncpy(client_info.name, umidi->quirk->product_name,
+				sizeof(client_info.name) - 1);
+			client_info.name[sizeof(client_info.name) - 1] = '\0';
+		} else {
+			sprintf(client_info.name, "USB Device %#04x:%#04x",
+				dev->descriptor.idVendor, dev->descriptor.idProduct);
+		}
+	}
+	snd_seq_kernel_client_ctl(umidi->seq_client,
+				  SNDRV_SEQ_IOCTL_SET_CLIENT_INFO,
+				  &client_info);
 
-MODULE_DEVICE_TABLE(usb, snd_usbmidi_usb_id_table);
+	if (umidi->quirk) {
+		memcpy(endpoints, umidi->quirk->endpoints, sizeof(endpoints));
+		err = snd_usbmidi_detect_endpoint(umidi, &endpoints[0]);
+	} else {
+		err = snd_usbmidi_get_ms_info(umidi, endpoints);
+	}
+	if (err < 0) {
+		snd_usbmidi_seq_device_delete(seq_device);
+		return err;
+	}
+	err = snd_usbmidi_create_endpoints(umidi, endpoints);
+	if (err < 0) {
+		snd_usbmidi_seq_device_delete(seq_device);
+		return err;
+	}
 
-static usb_driver_t snd_usbmidi_usb_driver = {
-	.name = "snd-usb-midi",
-	.probe = snd_usbmidi_usb_probe,
-	.disconnect = snd_usbmidi_usb_disconnect,
-	.id_table = snd_usbmidi_usb_id_table,
-	.driver_list = LIST_HEAD_INIT(snd_usbmidi_usb_driver.driver_list)
-};
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
+		if (umidi->endpoints[i].in)
+			snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,
+					       GFP_KERNEL);
+	return 0;
+}
 
 static int __init snd_usbmidi_module_init(void)
 {
@@ -1369,51 +948,15 @@
 		snd_usbmidi_seq_device_new,
 		snd_usbmidi_seq_device_delete
 	};
-	int err;
 
-	err = snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_USBMIDI, &ops,
-					     sizeof(usbmidi_t));
-	if (err < 0)
-		return err;
-	err = usb_register(&snd_usbmidi_usb_driver);
-	if (err < 0) {
-		snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_USBMIDI);
-		return err;
-	}
-	return 0;
+	return snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_USBMIDI, &ops,
+	 				      sizeof(snd_usb_midi_t));
 }
 
 static void __exit snd_usbmidi_module_exit(void)
 {
-	usb_deregister(&snd_usbmidi_usb_driver);
 	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_USBMIDI);
 }
 
 module_init(snd_usbmidi_module_init)
 module_exit(snd_usbmidi_module_exit)
-
-#ifndef MODULE
-
-/*
- * format is snd-usb-midi=snd_enable,snd_index,snd_id,
- *                        snd_vid,snd_pid,snd_int_transfer
- */
-static int __init snd_usbmidi_module_setup(char* str)
-{
-	static unsigned __initdata nr_dev = 0;
-
-	if (nr_dev >= SNDRV_CARDS)
-		return 0;
-	(void)(get_option(&str, &snd_enable[nr_dev]) == 2 &&
-	       get_option(&str, &snd_index[nr_dev]) == 2 &&
-	       get_id(&str, &snd_id[nr_dev]) == 2 &&
-	       get_option(&str, &snd_vid[nr_dev]) == 2 &&
-	       get_option(&str, &snd_pid[nr_dev]) == 2 &&
-	       get_option(&str, &snd_int_transfer[nr_dev]) == 2);
-	++nr_dev;
-	return 1;
-}
-
-__setup("snd-usb-midi=", snd_usbmidi_module_setup);
-
-#endif /* !MODULE */
diff -uP /dev/null usb/usbquirks.h
--- /dev/null	Thu Jan  1 01:00:00 1970
+++ usb/usbquirks.h	Mon Aug 26 15:48:15 2002
@@ -0,0 +1,337 @@
+/*
+ * ALSA USB Audio Driver
+ *
+ * Copyright (c) 2002 by Takashi Iwai <tiwai@suse.de>,
+ *                       Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+/*
+ * The contents of this file are part of the driver's id_table.
+ *
+ * In a perfect world, this file would be empty.
+ */
+
+#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+
+{
+	/* from NetBSD's umidi driver */
+	USB_DEVICE(0x0499, 0x1000), /* Yamaha UX256 */
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0xffff,
+				.in_cables  = 0x00ff
+			}
+		}
+	}
+},
+{
+	/* from Nagano Daisuke's usb-midi driver */
+	USB_DEVICE(0x0499, 0x1001), /* Yamaha MU1000 */
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = 1,
+				.out_cables = 0x000f,
+				.in_cables  = 0x0001
+			}
+		}
+	}
+},
+/*
+ * I don't know whether the following Yamaha devices need entries or not:
+ * 0x1002 MU2000   0x1008 UX96
+ * 0x1003 MU500    0x1009 UX16
+ * 0x1004 UW500    0x100e S08
+ * 0x1005 MOTIF6   0x100f CLP-150
+ * 0x1006 MOTIF7   0x1010 CLP-170
+ * 0x1007 MOTIF8
+ */
+
+/*
+ * Once upon a time people thought, "Wouldn't it be nice if there was a
+ * standard for USB MIDI devices, so that device drivers would not be forced
+ * to know about the quirks of specific devices?"  So Roland went ahead and
+ * wrote the USB Device Class Definition for MIDI Devices, and the USB-IF
+ * endorsed it, and now everybody designing USB MIDI devices does so in
+ * agreement with this standard (or at least tries to).
+ *
+ * And if you prefer a happy end, you can imagine that Roland devices set a
+ * good example. Instead of being completely fucked up due to the lack of
+ * class-specific descriptors.
+ */
+{
+	USB_DEVICE(0x0582, 0x0000),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "UA-100",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0007,
+				.in_cables  = 0x0007
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0002),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-4",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x000f,
+				.in_cables  = 0x000f
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0003),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "SC-8850",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x003f,
+				.in_cables  = 0x003f
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0004),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "U-8",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0003,
+				.in_cables  = 0x0003
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0005),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-2",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0003,
+				.in_cables  = 0x0003
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0007),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "SC-8820",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0013,
+				.in_cables  = 0x0013
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0008),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "PC-300",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0001,
+				.in_cables  = 0x0001
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0009),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-1",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0001,
+				.in_cables  = 0x0001
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x000b),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "SK-500",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0013,
+				.in_cables  = 0x0013
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x000c),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "SC-D70",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0007,
+				.in_cables  = 0x0007
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0012),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "XV-5050",
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0001,
+				.in_cables  = 0x0001
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0014),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-880",
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x01ff,
+				.in_cables  = 0x01ff
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0016),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "SD-90",
+		.ifnum = 2,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x000f,
+				.in_cables  = 0x000f
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0023),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-550",
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x003f,
+				.in_cables  = 0x003f
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0027),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "SD-20",
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0003,
+				.in_cables  = 0x0007
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0029),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "SD-80",
+		.ifnum = 0,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x000f,
+				.in_cables  = 0x000f
+			}
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x002b),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UA-700",
+		.ifnum = 3,
+		.endpoints = {
+			{
+				.epnum = -1,
+				.out_cables = 0x0003,
+				.in_cables  = 0x0003
+			}
+		}
+	}
+},
+
+#endif /* CONFIG_SND_SEQUENCER(_MODULE) */


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
