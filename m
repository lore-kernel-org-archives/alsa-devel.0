From: Adrian Bunk <bunk@stusta.de>
Subject: ALSA patches for 2.6.16
Date: Thu, 31 Aug 2006 23:17:56 +0200
Message-ID: <20060831211756.GW18276@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B888A23C
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 23:17:59 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following 8 patches that were included in 2.6.17.7 seem to also make 
sense in 2.6.16:

ALSA: Suppress irq handler mismatch messages in ALSA ISA drivers
ALSA: RME HDSP - fixed proc interface (missing {})
ALSA: hda-intel - Fix race in remove
ALSA: Fix workaround for AD1988A rev2 codec
ALSA: Fix model for HP dc7600
ALSA: Fix missing array terminators in AD1988 codec support
ALSA: Fix a deadlock in snd-rtctimer
ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port

Could someone review whether it's correct to apply these patches 
to 2.6.16?

I've attached the patches for a better review.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-au88x0-fix-64bit-address-of-mpu401-mmio-port.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 11:10:55 2006
Date: Thu, 13 Jul 2006 20:10:13 +0200
Message-ID: <s5hmzbdtlyy.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port

Fix 64bit address of MPU401 MMIO port on au88x0 chip.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/au88x0/au88x0_mpu401.c |    2 +-
 sound/pci/rme9652/hdsp.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/au88x0/au88x0_mpu401.c
+++ linux-2.6.17.6/sound/pci/au88x0/au88x0_mpu401.c
@@ -47,7 +47,7 @@ static int __devinit snd_vortex_midi(vor
 	struct snd_rawmidi *rmidi;
 	int temp, mode;
 	struct snd_mpu401 *mpu;
-	int port;
+	unsigned long port;
 
 #ifdef VORTEX_MPU401_LEGACY
 	/* EnableHardCodedMPU401Port() */

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-fix-a-deadlock-in-snd-rtctimer.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 11:09:05 2006
Date: Thu, 13 Jul 2006 20:08:01 +0200
Message-ID: <s5hpsg9tm2m.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: Fix a deadlock in snd-rtctimer

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix a deadlock in snd-rtctimer

Fix an occasional deadlock occuring with snd-rtctimer driver,
added irqsave to the lock in tasklet (ALSA bug#952).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/core/timer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.17.6.orig/sound/core/timer.c
+++ linux-2.6.17.6/sound/core/timer.c
@@ -628,8 +628,9 @@ static void snd_timer_tasklet(unsigned l
 	struct snd_timer_instance *ti;
 	struct list_head *p;
 	unsigned long resolution, ticks;
+	unsigned long flags;
 
-	spin_lock(&timer->lock);
+	spin_lock_irqsave(&timer->lock, flags);
 	/* now process all callbacks */
 	while (!list_empty(&timer->sack_list_head)) {
 		p = timer->sack_list_head.next;		/* get first item */
@@ -649,7 +650,7 @@ static void snd_timer_tasklet(unsigned l
 		spin_lock(&timer->lock);
 		ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
 	}
-	spin_unlock(&timer->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
 /*

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-fix-missing-array-terminators-in-ad1988-codec-support.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 11:16:41 2006
Date: Thu, 13 Jul 2006 20:15:44 +0200
Message-ID: <s5hhd1ltlpr.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: Fix missing array terminators in AD1988 codec support

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix missing array terminators in AD1988 codec support

Fixed the missing array terminators in AD1988 codec support code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_analog.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_analog.c
+++ linux-2.6.17.6/sound/pci/hda/patch_analog.c
@@ -1579,6 +1579,7 @@ static struct snd_kcontrol_new ad1988_6s
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_6stack_mixers1_rev2[] = {
@@ -1587,6 +1588,7 @@ static struct snd_kcontrol_new ad1988_6s
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0a, 2, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x06, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_6stack_mixers2[] = {
@@ -1625,6 +1627,7 @@ static struct snd_kcontrol_new ad1988_3s
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_3stack_mixers1_rev2[] = {
@@ -1632,6 +1635,7 @@ static struct snd_kcontrol_new ad1988_3s
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x06, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x06, 2, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_3stack_mixers2[] = {

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-fix-model-for-hp-dc7600.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 12:15:26 2006
Date: Thu, 13 Jul 2006 20:27:55 +0200
Message-ID: <s5hac7dtl5g.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: Fix model for HP dc7600

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix model for HP dc7600

Changed the assigned model for HP dc7600 with ALC260 codec
to match better with the actual I/O assignment.
Patch taken from ALSA bug#2157.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_realtek.c
+++ linux-2.6.17.6/sound/pci/hda/patch_realtek.c
@@ -3827,7 +3827,7 @@ static struct hda_board_config alc260_cf
 	{ .modelname = "hp", .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3010, .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3011, .config = ALC260_HP },
-	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3012, .config = ALC260_HP },
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3012, .config = ALC260_HP_3013 },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3013, .config = ALC260_HP_3013 },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3014, .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3015, .config = ALC260_HP },

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-fix-workaround-for-ad1988a-rev2-codec.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 11:17:14 2006
Date: Thu, 13 Jul 2006 20:16:41 +0200
Message-ID: <s5hfyh5tlo6.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: Fix workaround for AD1988A rev2 codec

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix workaround for AD1988A rev2 codec

Fix the workaround for AD1988A rev2 codec not to apply to AD1988B codec
chips.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_analog.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_analog.c
+++ linux-2.6.17.6/sound/pci/hda/patch_analog.c
@@ -1488,6 +1488,9 @@ enum {
 /* reivision id to check workarounds */
 #define AD1988A_REV2		0x100200
 
+#define is_rev2(codec) \
+	((codec)->vendor_id == 0x11d41988 && \
+	 (codec)->revision_id == AD1988A_REV2)
 
 /*
  * mixers
@@ -2142,7 +2145,7 @@ static inline hda_nid_t ad1988_idx_to_da
 		/* A     B     C     D     E     F     G     H */
 		0x04, 0x05, 0x0a, 0x04, 0x06, 0x05, 0x0a, 0x06
 	};
-	if (codec->revision_id == AD1988A_REV2)
+	if (is_rev2(codec))
 		return idx_to_dac_rev2[idx];
 	else
 		return idx_to_dac[idx];
@@ -2511,7 +2514,7 @@ static int patch_ad1988(struct hda_codec
 	mutex_init(&spec->amp_mutex);
 	codec->spec = spec;
 
-	if (codec->revision_id == AD1988A_REV2)
+	if (is_rev2(codec))
 		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
 
 	board_config = snd_hda_check_board_config(codec, ad1988_cfg_tbl);
@@ -2537,13 +2540,13 @@ static int patch_ad1988(struct hda_codec
 	case AD1988_6STACK_DIG:
 		spec->multiout.max_channels = 8;
 		spec->multiout.num_dacs = 4;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->multiout.dac_nids = ad1988_6stack_dac_nids_rev2;
 		else
 			spec->multiout.dac_nids = ad1988_6stack_dac_nids;
 		spec->input_mux = &ad1988_6stack_capture_source;
 		spec->num_mixers = 2;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->mixers[0] = ad1988_6stack_mixers1_rev2;
 		else
 			spec->mixers[0] = ad1988_6stack_mixers1;
@@ -2559,7 +2562,7 @@ static int patch_ad1988(struct hda_codec
 	case AD1988_3STACK_DIG:
 		spec->multiout.max_channels = 6;
 		spec->multiout.num_dacs = 3;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->multiout.dac_nids = ad1988_3stack_dac_nids_rev2;
 		else
 			spec->multiout.dac_nids = ad1988_3stack_dac_nids;
@@ -2567,7 +2570,7 @@ static int patch_ad1988(struct hda_codec
 		spec->channel_mode = ad1988_3stack_modes;
 		spec->num_channel_mode = ARRAY_SIZE(ad1988_3stack_modes);
 		spec->num_mixers = 2;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->mixers[0] = ad1988_3stack_mixers1_rev2;
 		else
 			spec->mixers[0] = ad1988_3stack_mixers1;

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-hda-intel-fix-race-in-remove.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 11:07:37 2006
Date: Thu, 13 Jul 2006 20:06:54 +0200
Message-ID: <s5hr70ptm4h.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: hda-intel - Fix race in remove

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: hda-intel - Fix race in remove

Call iounmap after free_irq to avoid invalid accesses in the
shared irq.  The patch is taken from
	https://bugzilla.novell.com/show_bug.cgi?id=167869

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/hda_intel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/hda/hda_intel.c
+++ linux-2.6.17.6/sound/pci/hda/hda_intel.c
@@ -1393,10 +1393,10 @@ static int azx_free(struct azx *chip)
 		msleep(1);
 	}
 
-	if (chip->remap_addr)
-		iounmap(chip->remap_addr);
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void*)chip);
+	if (chip->remap_addr)
+		iounmap(chip->remap_addr);
 
 	if (chip->bdl.area)
 		snd_dma_free_pages(&chip->bdl);

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-rme-hdsp-fixed-proc-interface.patch"

>From stable-bounces@linux.kernel.org Thu Jul 13 11:13:21 2006
Date: Thu, 13 Jul 2006 20:12:41 +0200
Message-ID: <s5hk66htluu.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Cc: 
Subject: ALSA: RME HDSP - fixed proc interface (missing {})

From: Remy Bruno <remy.bruno@trinnov.com>

[PATCH] ALSA: RME HDSP - fixed proc interface (missing {})

From: Remy Bruno <remy.bruno@trinnov.com>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/rme9652/hdsp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.6.orig/sound/pci/rme9652/hdsp.c
+++ linux-2.6.17.6/sound/pci/rme9652/hdsp.c
@@ -3169,9 +3169,10 @@ snd_hdsp_proc_read(struct snd_info_entry
 	char *clock_source;
 	int x;
 
-	if (hdsp_check_for_iobox (hdsp))
+	if (hdsp_check_for_iobox (hdsp)) {
 		snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upload firmware.\n");
 		return;
+        }
 
 	if (hdsp_check_for_firmware(hdsp, 0)) {
 		if (hdsp->state & HDSP_FirmwareCached) {

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="alsa-suppress-irq-handler-mismatch-messages-in-alsa-isa-drivers.patch"

>From stable-bounces@linux.kernel.org Fri Jul 14 07:41:12 2006
Date: Fri, 14 Jul 2006 16:40:35 +0200
Message-ID: <s5hlkqws10c.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@kernel.org
Subject: ALSA: Suppress irq handler mismatch messages in ALSA ISA drivers

From: Takashi Iwai <tiwai@suse.de>

[PATCH] Suppress irq handler mismatch messages in ALSA ISA drivers

Suppress 'irq handler mismatch' messages at auto-probing of irqs
in ALSA ISA drivers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/sound/initval.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.6.orig/include/sound/initval.h
+++ linux-2.6.17.6/include/sound/initval.h
@@ -62,7 +62,8 @@ static int snd_legacy_find_free_irq(int 
 {
 	while (*irq_table != -1) {
 		if (!request_irq(*irq_table, snd_legacy_empty_irq_handler,
-				 SA_INTERRUPT, "ALSA Test IRQ", (void *) irq_table)) {
+				 SA_INTERRUPT | SA_PROBEIRQ, "ALSA Test IRQ",
+				 (void *) irq_table)) {
 			free_irq(*irq_table, (void *) irq_table);
 			return *irq_table;
 		}

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--DBIVS5p969aUjpLe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--DBIVS5p969aUjpLe--
