From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 12:33:40 +0800
Message-ID: <432A4B24.1040209@netvigator.com>
References: <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050915204345.GC27700@sashak.softier1.local>
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
Cc: Sasha Khapyorsky <sashak@smlink.com>, openvortex-dev@nongnu.org, pmhahn@titan.lahn.de, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sasha Khapyorsky wrote:
> On 17:35 Thu 15 Sep     , Sasha Khapyorsky wrote:
> 
>>I will send cleaned codec access patch separately and will look what is
>>next.
> 
> 
> Pilipp, no real patches yet, let's investigate few things:
> 
> 1. Actual "secondary codec" bit in CODEC_EN register - just silly print
> (apply with -p1):
> 
> 
> --- au88x0_prev/au88x0_core.c	2005-09-14 20:51:03.000000000 +0300
> +++ au88x0/au88x0_core.c	2005-09-15 22:59:05.000000000 +0300
> @@ -2516,6 +2516,8 @@ static void vortex_codec_init(vortex_t *
>  	msleep(2);
>  	if (hwread(vortex->mmio, VORTEX_CODEC_EN)&(EN_CODEC1|EN_MODEM))
>  		vortex->num_of_codecs = 2;
> +	printk("vortex_codec_init: VORTEX_CODEC_EN = %08x\n",
> +		hwread(vortex->mmio, VORTEX_CODEC_EN));
>  }
>  
>  static void
> 
> 

VORTEX_CODEC_EN = 00000000 on au8830 (STAC9708) after cold reset of AC-Link.


static int vortex_core_init(vortex_t * vortex)
{

	printk(KERN_INFO "Vortex: init.... ");
	/* Hardware Init. */
	hwwrite(vortex->mmio, VORTEX_CTRL, 0xffffffff);
	msleep(5);
+	printk(KERN_INFO "VORTEX_CTRL : %.8x\n",hwread(vortex->mmio, 
VORTEX_CTRL));

VORTEX_CTRL : 00303260 after cold reset on au8830 Optical SPDIF ( 
Subsystem: 12eb:0088 )


There is a TAD connector on the au8820/au8830 sound cards.
I guess it is used for the ISA Modem Interface.

Does TAD work with external modem ?

There are P4 motherboards which has ISA slots and PCI slots.

http://www.prnewswire.co.uk/cgi/news/release?id=50053

Modem and Telephony Support on PCI Bus:

Besides sound controllers, modems are the only other PC component that 
are still ISA-based. The AU8820 includes an interface to existing, 
standard ISA modem chip sets, such as the latest 56k modems from US 
Robotics and Rockwell. This unique feature offers two key advantages to 
OEMs: the ability to build PCI based audio-telephony combo cards, and 
the design of a PC without an ISA bus.



diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8810.c 
modem/alsa-driver/alsa-kernel/pci/au88x0/au8810.c
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8810.c	2005-09-15 
19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au8810.c	2005-09-16 
08:56:39.000000000 +0800
@@ -6,6 +6,7 @@
  	{0,}
  };

+#include "au88x0_modem.c"
  #include "au88x0_core.c"
  #include "au88x0_pcm.c"
  #include "au88x0_mixer.c"
diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8820.h 
modem/alsa-driver/alsa-kernel/pci/au88x0/au8820.h
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8820.h	2005-09-15 
19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au8820.h	2005-09-15 
19:37:17.000000000 +0800
@@ -158,7 +158,7 @@
  /* CODEC */
  #define VORTEX_CODEC_CTRL 0x11984
  #define VORTEX_CODEC_EN 0x11990
-#define		EN_CODEC	0x00000300
+#define		EN_AUDIO0	0x00000300
  #define		EN_SPORT	0x00030000
  #define		EN_SPDIF	0x000c0000
  #define VORTEX_CODEC_CHN 0x11880
diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8830.h 
modem/alsa-driver/alsa-kernel/pci/au88x0/au8830.h
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8830.h	2005-09-15 
19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au8830.h	2005-09-15 
19:37:46.000000000 +0800
@@ -208,7 +208,6 @@
  #define		EN_AUDIO1		0x00003000
  #define		EN_SPORT		0x00030000
  #define		EN_SPDIF		0x000c0000
-#define		EN_CODEC		(EN_AUDIO1 | EN_AUDIO0)

  #define VORTEX_SPDIF_SMPRATE	0x29194

diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0.c 
modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0.c
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0.c	2005-09-15 
19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0.c	2005-09-16 
11:13:44.000000000 +0800
@@ -27,6 +27,9 @@
  static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
  static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
  static int pcifix[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 255 };
+#ifdef CHIP_AU8810
+static int pcimodem[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0 };
+#endif

  module_param_array(index, int, NULL, 0444);
  MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
@@ -36,6 +39,10 @@
  MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
  module_param_array(pcifix, int, NULL, 0444);
  MODULE_PARM_DESC(pcifix, "Enable VIA-workaround for " CARD_NAME " 
soundcard.");
+#ifdef CHIP_AU8810
+module_param_array(pcimodem, int, NULL, 0444);
+MODULE_PARM_DESC(pcimodem, "Enable PCI Modem " CARD_NAME " soundcard.");
+#endif

  MODULE_DESCRIPTION("Aureal vortex");
  MODULE_LICENSE("GPL");
@@ -256,6 +263,11 @@
  	}
  	snd_vortex_workaround(pci, pcifix[dev]);
  	// (4) Alloc components.
+	// snd_ac97_mixer
+	if ((err = snd_vortex_mixer(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
  	// ADB pcm.
  	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
  		snd_card_free(card);
@@ -287,11 +299,25 @@
  		return err;
  	}
  #endif
-	// snd_ac97_mixer and Vortex mixer.
-	if ((err = snd_vortex_mixer(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+#ifdef CHIP_AU8810
+	// MODEM
+	if ( pcimodem[dev] ) {
+		if ((err = pci_read_config_word(pci, PCI_DEVICE_ID,
+						  &(chip->device))) < 0) {
+			snd_card_free(card);
+			return err;
+		};
+		if ((err = snd_vortex_modem_mixer(chip,
+			(( chip->device == PCI_DEVICE_ID_AUREAL_ADVANTAGE) ? 1 : 0 ))) < 0) {
+			snd_card_free(card);
+			return err;
+		};
+		if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_MODEM, 1)) < 0) {
+			snd_card_free(card);
+			return err;
+		};
+	};
+#endif
  	if ((err = snd_vortex_midi(chip)) < 0) {
  		snd_card_free(card);
  		return err;
diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_core.c 
modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_core.c
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_core.c 
2005-09-15 19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_core.c	2005-09-16 
09:00:14.000000000 +0800
@@ -2510,7 +2505,7 @@
  	msleep(1);
  	/* Enable codec channels 0 and 1. */
  	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
-		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC);
+		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_AUDIO0);
  }
diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0.h 
modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0.h
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0.h	2005-09-15 
19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0.h	2005-09-16 
08:52:10.000000000 +0800
@@ -93,8 +93,9 @@
  #define VORTEX_PCM_SPDIF	1
  #define VORTEX_PCM_A3D		2
  #define VORTEX_PCM_WT		3
-#define VORTEX_PCM_I2S		4
-#define VORTEX_PCM_LAST		5
+#define VORTEX_PCM_MODEM        4
+#define VORTEX_PCM_I2S		5
+#define VORTEX_PCM_LAST		6

  #define MIX_CAPT(x) (vortex->mixcapt[x])
  #define MIX_PLAYB(x) (vortex->mixplayb[x])
@@ -136,6 +137,9 @@

  	snd_rawmidi_t *rmidi;	/* Legacy Midi interface. */
  	ac97_t *codec;
+#ifdef CHIP_AU8810
+	ac97_t *mc97;	
+#endif

  	/* Stream structs. */
  	stream_t dma_adb[NR_ADB];
diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_mixer.c 
modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_mixer.c 
2005-09-15 19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c	2005-09-15 
20:04:09.000000000 +0800
@@ -28,6 +28,12 @@
  	ac97.private_data = vortex;
  	ac97.scaps = AC97_SCAP_NO_SPDIF;
  	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
-	vortex->isquad = ((vortex->codec == NULL) ?  0 : 
(vortex->codec->ext_id&0x80));
+	vortex->isquad = ((vortex->codec == NULL) ?  0 : 
(vortex->codec->ext_id & AC97_EI_SDAC));
+#ifndef CHIP_AU8820
+	/* Enable rear channels of audio codec. */
+	if ( vortex->isquad )
+		hwwrite(vortex->mmio, VORTEX_CODEC_EN,
+			hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_AUDIO1);
+#endif
  	return err;
  }
diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_modem.c 
modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_modem.c
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_modem.c 
1970-01-01 08:00:00.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_modem.c	2005-09-16 
09:12:15.000000000 +0800
@@ -0,0 +1,96 @@
+/*
+ * Vortex Modem support.
+ *
+ */
+
+#include <sound/driver.h>
+#include <linux/time.h>
+#include <linux/init.h>
+#include <sound/core.h>
+#include "au88x0.h"
+#define MODEM_POLL_COUNT 1000
+
+
+static void
+vortex_modem_codec_write(ac97_t * codec, unsigned short addr, unsigned 
short data)
+{
+
+	vortex_t *card = (vortex_t *) codec->private_data;
+	unsigned int lifeboat = 0;
+
+	/* wait for transactions to clear */
+	while (!(hwread(card->mmio, VORTEX_CODEC_CTRL) & 0x100)) {
+		udelay(100);
+		if (lifeboat++ > MODEM_POLL_COUNT) {
+			printk(KERN_ERR "vortex: mc97 codec stuck busy\n");
+			return;
+		}
+	}
+	/* write register */
+	hwwrite(card->mmio, VORTEX_CODEC_IO,
+		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
+		VORTEX_CODEC_WRITE |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) );
+
+	/* Flush Caches. */
+	hwread(card->mmio, VORTEX_CODEC_IO);
+}
+
+static unsigned short
+vortex_modem_codec_read(ac97_t * codec, unsigned short addr)
+{
+
+	vortex_t *card = (vortex_t *) codec->private_data;
+	u32 read_addr, data;
+	unsigned lifeboat = 0;
+
+	/* wait for transactions to clear */
+	while (!(hwread(card->mmio, VORTEX_CODEC_CTRL) & 0x100)) {
+		udelay(100);
+		if (lifeboat++ > MODEM_POLL_COUNT) {
+			printk(KERN_ERR "vortex: mc97 codec stuck busy\n");
+			return 0xffff;
+		}
+	}
+	/* set up read address */
+	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) ;
+
+	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
+
+	/* wait for address */
+	do {
+		udelay(100);
+		data = hwread(card->mmio, VORTEX_CODEC_IO);
+		if (lifeboat++ > MODEM_POLL_COUNT) {
+			printk(KERN_ERR "vortex: mc97 address never arrived\n");
+			return 0xffff;
+		}
+	} while ((data & VORTEX_CODEC_ADDMASK) !=
+		 (addr << VORTEX_CODEC_ADDSHIFT));
+
+	/* return data. */
+	return (u16) (data & VORTEX_CODEC_DATMASK);
+}
+
+static int __devinit snd_vortex_modem_mixer(vortex_t * vortex, int num)
+{
+	ac97_bus_t *pbus;
+	ac97_template_t mc97;
+	int err;
+	static ac97_bus_ops_t ops = {
+		.write = vortex_modem_codec_write,
+		.read = vortex_modem_codec_read,
+	};
+
+	if ((err = snd_ac97_bus(vortex->card, 0, &ops, NULL, &pbus)) < 0)
+		return err;
+	memset(&mc97, 0, sizeof(mc97));
+	// Intialize MC97 codec stuff.
+	mc97.private_data = vortex;
+	mc97.scaps = AC97_SCAP_SKIP_AUDIO;
+	mc97.num = num;
+	if (err = snd_ac97_mixer(pbus, &mc97, &vortex->mc97)) == 0 ) {
+ 	        hwwrite(vortex->mmio, VORTEX_CODEC_EN,
+		      hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_AC98);
+       };
+	return err;
+}




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
