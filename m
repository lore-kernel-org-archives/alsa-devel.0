From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: Re: Aureal Vortex PATCH [Fwd: via workaround error]
Date: Mon, 12 Jan 2004 19:08:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4002E295.3050001@gmx.at>
References: <1073703888.4419.2.camel@localhost> <s5hbrp9gtc8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000006070303050604050509"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrp9gtc8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000006070303050604050509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Fri, 09 Jan 2004 23:04:49 -0400,
> Manuel Jander wrote:
> 
>>Please apply to CVS. Thanks
>>
>>-----Forwarded Message-----
>>From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
>>To: openvortex-dev@nongnu.org, manuel.jander@mat.utfsm.cl
>>Subject: via workaround error
>>Date: Fri, 09 Jan 2004 20:16:01 +0100
>>
>>i made a stupid error when i wrote the via workaround patch. the pci 
>>latency for the vortex was still set to 0xff when using autodetection 
>>and no via chipset was found. i discovered this after i exchanged my 
>>motherboard from a via kt133 to a sis 735. the fix is attached. the bug 
>>should not have caused any troubles but it is just not right...
> 
> 
> i didn't receive the VIA workaround patch itself yet.
> could you send the whole patch?

here we go...

--------------000006070303050604050509
Content-Type: text/plain;
 name="alsa-0.9.7c-aureal-via-quirks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-0.9.7c-aureal-via-quirks.patch"

--- alsa-driver-0.9.7c/pci/au88x0/au88x0.c	2003-10-06 16:01:04.000000000 +0200
+++ alsa-driver-0.9.7c-ww/pci/au88x0/au88x0.c	2003-10-25 22:31:09.000000000 +0200
@@ -26,6 +26,7 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+static int pcifix[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 255 };
 
 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
@@ -36,6 +37,9 @@ MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
+MODULE_PARM(pcifix, "1-255i");
+MODULE_PARM_DESC(pcifix, "Enable VIA-workaround for " CARD_NAME " soundcard.");
+MODULE_PARM_SYNTAX(pcifix, SNDRV_ENABLED ",allows:{{0,Disabled},{1,Latency},{2,Bridge},{3,Both},{255,Auto}},default:4,dialog:check");
 
 MODULE_DESCRIPTION("Aureal vortex");
 MODULE_CLASSES("{sound}");
@@ -61,6 +65,56 @@ __setup("snd-au88x0=", alsa_card_vortex_
 
 MODULE_DEVICE_TABLE(pci, snd_vortex_ids);
 
+static void __devinit snd_vortex_workaround(struct pci_dev *vortex, int fix) {
+	struct pci_dev *via=NULL;
+		/* autodetect if workarounds are required */
+	while( (via = pci_find_device(PCI_VENDOR_ID_VIA,
+				PCI_DEVICE_ID_VIA_8365_1, via)) ) {
+		if(fix == 255) {
+			printk(KERN_INFO CARD_NAME
+				": detected VIA KT133/KM133. activating workaround...\n");
+			fix = 3; // do latency and via bridge workaround
+		}
+		break;
+	}
+	
+	int rc;
+
+		/* fix vortex latency */
+	if(fix & 0x01) {
+		if( !(rc = pci_write_config_byte(vortex, 0x40, 0xff)) ) {
+			printk(KERN_INFO CARD_NAME
+					": vortex latency is 0xff\n");
+		}
+		else {
+			printk(KERN_WARNING CARD_NAME ": could not set vortex latency: pci error 0x%x\n", rc);
+		}
+	}
+
+		/* fix via agp bridge */
+	if(via && (fix & 0x02)) {
+		u8 value;
+
+			/*
+			 * only set the bit (Extend PCI#2 Internal Master for
+			 * Efficient Handling of Dummy Requests) if the can
+			 * read the config and it is not already set
+			 */
+
+		if( !(rc = pci_read_config_byte(via, 0x42, &value)) && (
+			(value & 0x10) ||
+			!(rc=pci_write_config_byte(via, 0x42, value|0x10)) ) ) {
+
+			printk(KERN_INFO CARD_NAME
+					": bridge config is 0x%x\n",
+					value|0x10);
+		}
+		else {
+			printk(KERN_WARNING CARD_NAME ": could not set vortex latency: pci error 0x%x\n", rc);
+		}
+	}
+}
+
 
 // component-destructor
 // (see "Management of Cards and Components")
@@ -198,6 +252,7 @@ snd_vortex_probe(struct pci_dev *pci, co
         snd_card_free(card);
         return err;
     }
+    snd_vortex_workaround(pci, pcifix[dev]);
     // (4) Alloc components.
     // ADB pcm.
     if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {

--------------000006070303050604050509--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
