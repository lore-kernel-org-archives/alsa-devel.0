From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Splitting CONFIG_SND_POWERMAC
Date: Sun, 14 Mar 2004 23:59:51 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403141654340.10348@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_VG9vM2cyyuwmSIYfp6GYFQ)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_VG9vM2cyyuwmSIYfp6GYFQ)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hello!

I was compiling Linux 2.6.x for PowerPC and got compile errors:

sound/built-in.o(.text+0x28828): In function `daca_init_client':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x28840): In function `daca_init_client':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x2885c): In function `daca_init_client':
: undefined reference to `i2c_smbus_write_block_data'

and so on.  It turns out CONFIG_SND_POWERMAC should not be enabled without
CONFIG_I2C.  My first idea was to add a dependency.

However, the kernel finds Burgundy sound chip on my PowerPC.  The code for
Burgundy doesn't use I2C.  I have to enable CONFIG_I2C (without any
drivers) just to satisfy the linker.

I think ideally the driver should be split into the base powermac driver
and 3 specific drivers - AWACS, Burgundy and Keywest, the later being
dependent on I2C.

The attached patch implements an interim solution - there is still one
module, but the user can select what hardware the module supports.  Only
Keywest devices require I2C.

The patch is against Linux 2.6.4.

-- 
Regards,
Pavel Roskin

--Boundary_(ID_VG9vM2cyyuwmSIYfp6GYFQ)
Content-id: <Pine.LNX.4.58.0403142359510.19545@portland.hansa.lan>
Content-type: TEXT/plain; charset=US-ASCII; name=pmac_sound.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=pmac_sound.diff
Content-description: 

--- linux.orig/sound/ppc/Kconfig
+++ linux/sound/ppc/Kconfig
@@ -4,8 +4,30 @@
 	depends on SND!=n && PPC
 
 config SND_POWERMAC
-	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
+	tristate "PowerMac sound support"
 	depends on SND
+	---help---
+	  Answer Y or M to include support for intergrated sound devices on
+	  PowerMac.  You also need to select one of the drivers below.
+
+config SND_AWACS
+	bool "AWACS, Screamer sound support"
+	depends on SND_POWERMAC
+	---help---
+	  Answer Y to include support for AWACS and Screamer sound on PowerMac.
+
+config SND_BURGUNDY
+	bool "Burgundy sound support"
+	depends on SND_POWERMAC
+	---help---
+	  Answer Y to include support for Burgundy sound on PowerMac.
+
+config SND_KEYWEST
+	bool "Keywest (DACA, Tumbler, Snapper) sound support"
+	depends on SND_POWERMAC && I2C
+	---help---
+	  Answer Y to include support for PowerMac Keywest sound devices, such
+	  as DACA, Tumbler and Snapper.
 
 endmenu
 
--- linux.orig/sound/ppc/Makefile
+++ linux/sound/ppc/Makefile
@@ -3,7 +3,16 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-snd-powermac-objs := powermac.o pmac.o awacs.o burgundy.o daca.o tumbler.o keywest.o
+snd-powermac-objs := powermac.o pmac.o
+ifeq ($(CONFIG_SND_AWACS),y)
+snd-powermac-objs += awacs.o
+endif
+ifeq ($(CONFIG_SND_BURGUNDY),y)
+snd-powermac-objs += burgundy.o
+endif
+ifeq ($(CONFIG_SND_KEYWEST),y)
+snd-powermac-objs += daca.o tumbler.o keywest.o
+endif
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_POWERMAC) += snd-powermac.o
--- linux.orig/sound/ppc/powermac.c
+++ linux/sound/ppc/powermac.c
@@ -70,7 +70,6 @@ static int __init snd_pmac_probe(void)
 {
 	snd_card_t *card;
 	pmac_t *chip;
-	char *name_ext;
 	int err;
 
 	card = snd_card_new(index, id, THIS_MODULE, 0);
@@ -81,6 +80,7 @@ static int __init snd_pmac_probe(void)
 		goto __error;
 
 	switch (chip->model) {
+#ifdef CONFIG_SND_BURGUNDY
 	case PMAC_BURGUNDY:
 		strcpy(card->driver, "PMac Burgundy");
 		strcpy(card->shortname, "PowerMac Burgundy");
@@ -89,6 +89,8 @@ static int __init snd_pmac_probe(void)
 		if ((err = snd_pmac_burgundy_init(chip)) < 0)
 			goto __error;
 		break;
+#endif
+#ifdef CONFIG_SND_KEYWEST
 	case PMAC_DACA:
 		strcpy(card->driver, "PMac DACA");
 		strcpy(card->shortname, "PowerMac DACA");
@@ -98,8 +100,8 @@ static int __init snd_pmac_probe(void)
 			goto __error;
 		break;
 	case PMAC_TUMBLER:
-	case PMAC_SNAPPER:
-		name_ext = chip->model == PMAC_TUMBLER ? "Tumbler" : "Snapper";
+	case PMAC_SNAPPER: {
+		char *name_ext = (chip->model == PMAC_TUMBLER) ? "Tumbler" : "Snapper";
 		sprintf(card->driver, "PMac %s", name_ext);
 		sprintf(card->shortname, "PowerMac %s", name_ext);
 		sprintf(card->longname, "%s (Dev %d) Sub-frame %d",
@@ -107,9 +109,12 @@ static int __init snd_pmac_probe(void)
 		if ((err = snd_pmac_tumbler_init(chip)) < 0)
 			goto __error;
 		break;
+	}
+#endif
+#ifdef CONFIG_SND_AWACS
 	case PMAC_AWACS:
-	case PMAC_SCREAMER:
-		name_ext = chip->model == PMAC_SCREAMER ? "Screamer" : "AWACS";
+	case PMAC_SCREAMER: {
+		char *name_ext = (chip->model == PMAC_SCREAMER) ? "Screamer" : "AWACS";
 		sprintf(card->driver, "PMac %s", name_ext);
 		sprintf(card->shortname, "PowerMac %s", name_ext);
 		if (chip->is_pbook_3400)
@@ -123,6 +128,8 @@ static int __init snd_pmac_probe(void)
 		if ((err = snd_pmac_awacs_init(chip)) < 0)
 			goto __error;
 		break;
+	}
+#endif
 	default:
 		snd_printk("unsupported hardware %d\n", chip->model);
 		err = -EINVAL;

--Boundary_(ID_VG9vM2cyyuwmSIYfp6GYFQ)--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
