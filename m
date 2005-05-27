From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [PATCH 1/2] MC97 modem mixer in pci/ac97/
Date: Sat, 28 May 2005 02:51:36 +0300
Message-ID: <20050527235136.GC22222@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Simple MC97 modem mixer with two common controls: Off-hook and CID,
and Si3056 MC specific control: Modem Speaker.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.185
diff -u -b -B -r1.185 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	25 Apr 2005 10:22:20 -0000	1.185
+++ alsa-kernel/pci/ac97/ac97_codec.c	27 May 2005 01:21:29 -0000
@@ -150,7 +150,7 @@
 { 0x4e534331, 0xffffffff, "LM4549",		NULL,		NULL },
 { 0x4e534350, 0xffffffff, "LM4550",		NULL,		NULL },
 { 0x50534304, 0xffffffff, "UCB1400",		NULL,		NULL },
-{ 0x53494c20, 0xffffffe0, "Si3036,8",		NULL,		mpatch_si3036 },
+{ 0x53494c20, 0xffffffe0, "Si3036,8",		mpatch_si3036,	mpatch_si3036, AC97_MODEM_PATCH },
 { 0x54524102, 0xffffffff, "TR28022",		NULL,		NULL },
 { 0x54524106, 0xffffffff, "TR28026",		NULL,		NULL },
 { 0x54524108, 0xffffffff, "TR28028",		patch_tritech_tr28028,	NULL }, // added by xin jin [07/09/99]
@@ -666,6 +666,11 @@
 static const snd_kcontrol_new_t snd_ac97_control_eapd =
 AC97_SINGLE("External Amplifier", AC97_POWERDOWN, 15, 1, 1);
 
+static const snd_kcontrol_new_t snd_ac97_controls_modem_switches[2] = {
+AC97_SINGLE("Off-hook Switch", AC97_GPIO_STATUS, 0, 1, 0),
+AC97_SINGLE("Caller ID Switch", AC97_GPIO_STATUS, 2, 1, 0)
+};
+
 /* change the existing EAPD control as inverted */
 static void set_inv_eapd(ac97_t *ac97, snd_kcontrol_t *kctl)
 {
@@ -1526,13 +1531,25 @@
 
 static int snd_ac97_modem_build(snd_card_t * card, ac97_t * ac97)
 {
-	/* TODO */
+	int err, idx;
+
 	//printk("AC97_GPIO_CFG = %x\n",snd_ac97_read(ac97,AC97_GPIO_CFG));
 	snd_ac97_write(ac97, AC97_GPIO_CFG, 0xffff & ~(AC97_GPIO_LINE1_OH));
 	snd_ac97_write(ac97, AC97_GPIO_POLARITY, 0xffff & ~(AC97_GPIO_LINE1_OH));
 	snd_ac97_write(ac97, AC97_GPIO_STICKY, 0xffff);
 	snd_ac97_write(ac97, AC97_GPIO_WAKEUP, 0x0);
 	snd_ac97_write(ac97, AC97_MISC_AFE, 0x0);
+
+	/* build modem switches */
+	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_modem_switches); idx++)
+		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_modem_switches[idx], ac97))) < 0)
+			return err;
+
+	/* build chip specific controls */
+	if (ac97->build_ops->build_specific)
+		if ((err = ac97->build_ops->build_specific(ac97)) < 0)
+			return err;
+
 	return 0;
 }
 
Index: alsa-kernel/pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.84
diff -u -b -B -r1.84 ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c	17 May 2005 16:17:57 -0000	1.84
+++ alsa-kernel/pci/ac97/ac97_patch.c	27 May 2005 01:21:36 -0000
@@ -2459,12 +2459,29 @@
 	return 0;
 }
 
-/* Si3036/8 specific registers */
+/*
+ * Si3036 codec
+ */
+
 #define AC97_SI3036_CHIP_ID     0x5a
+#define AC97_SI3036_LINE_CFG    0x5c
+
+static const snd_kcontrol_new_t snd_ac97_controls_si3036[] = {
+AC97_DOUBLE("Modem Speaker Volume", 0x5c, 14, 12, 3, 1)
+};
+
+static int patch_si3036_specific(ac97_t * ac97)
+{
+	return patch_build_controls(ac97, snd_ac97_controls_si3036, ARRAY_SIZE(snd_ac97_controls_si3036));
+}
+
+static struct snd_ac97_build_ops patch_si3036_ops = {
+	.build_specific	= patch_si3036_specific,
+};
 
 int mpatch_si3036(ac97_t * ac97)
 {
-	//printk("mpatch_si3036: chip id = %x\n", snd_ac97_read(ac97, 0x5a));
+	ac97->build_ops = &patch_si3036_ops;
 	snd_ac97_write_cache(ac97, 0x5c, 0xf210 );
 	snd_ac97_write_cache(ac97, 0x68, 0);
 	return 0;


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
