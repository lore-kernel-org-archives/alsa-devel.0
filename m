From: Kevin Mack <kevmack@accesscomm.ca>
Subject: [PATCH] Gateway M675 notebook, Sigmatel STAC9758
Date: Sun, 14 Mar 2004 02:38:17 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040314083817.GA19872@slack91.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Here's a quick and dirty patch that's given me basic sound from
my Gateway M675 notebook (Sigmatel 9758 AC97 codec).

Disclaimers:
1) This probably won't work on other systems with this chip as
they may be connected differently.
2) Plugging in headphones or external speakers doesn't turn off
the internal speakers with this patch.


diff -NaurP ../alsa-driver-1.0.3/alsa-kernel/pci/ac97/ac97_codec.c alsa-kernel/pci/ac97/ac97_codec.c
--- ../alsa-driver-1.0.3/alsa-kernel/pci/ac97/ac97_codec.c	2004-02-20 08:44:48.000000000 -0600
+++ alsa-kernel/pci/ac97/ac97_codec.c	2004-03-09 21:30:41.000000000 -0600
@@ -173,6 +173,7 @@
 { 0x83847650, 0xffffffff, "STAC9750/51",	NULL,		NULL },	// patch?
 { 0x83847652, 0xffffffff, "STAC9752/53",	NULL,		NULL }, // patch?
 { 0x83847656, 0xffffffff, "STAC9756/57",	patch_sigmatel_stac9756,	NULL },
+{ 0x83847658, 0xffffffff, "STAC9758/59",	patch_sigmatel_stac9758,	NULL },
 { 0x83847666, 0xffffffff, "STAC9766/67",	NULL,		NULL }, // patch?
 { 0, 	      0,	  NULL,			NULL,		NULL }
 };
diff -NaurP ../alsa-driver-1.0.3/alsa-kernel/pci/ac97/ac97_patch.c alsa-kernel/pci/ac97/ac97_patch.c
--- ../alsa-driver-1.0.3/alsa-kernel/pci/ac97/ac97_patch.c	2004-02-11 13:41:18.000000000 -0600
+++ alsa-kernel/pci/ac97/ac97_patch.c	2004-03-11 19:15:33.000000000 -0600
@@ -441,6 +441,21 @@
 	return 0;
 }
 
+int patch_sigmatel_stac9758(ac97_t * ac97)
+{
+	// patch for SigmaTel
+	ac97->build_ops = &patch_sigmatel_stac9700_ops;
+	// turn on stereo speaker, headphone and line-out
+	snd_ac97_write_cache(ac97, AC97_STAC9758_OUTPUT_SELECT, 0x9040);
+	// headphone select and boost
+	snd_ac97_write_cache(ac97, AC97_STAC9758_IO_MISC, 0x2102);
+	// enable mic
+	snd_ac97_write_cache(ac97, AC97_STAC9758_INPUT_SELECT, 0x0203);
+	// enable stereo mic
+	snd_ac97_write_cache(ac97, AC97_STAC9758_VARIOUS, 0x0001);
+	return 0;
+}
+
 static const snd_kcontrol_new_t snd_ac97_cirrus_controls_spdif[2] = {
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH), AC97_CSR_SPDIF, 15, 1, 0),
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "AC97-SPSA", AC97_CSR_ACMODE, 0, 3, 0)
diff -NaurP ../alsa-driver-1.0.3/alsa-kernel/pci/ac97/ac97_patch.h alsa-kernel/pci/ac97/ac97_patch.h
--- ../alsa-driver-1.0.3/alsa-kernel/pci/ac97/ac97_patch.h	2004-02-11 06:14:40.000000000 -0600
+++ alsa-kernel/pci/ac97/ac97_patch.h	2004-03-11 19:12:12.000000000 -0600
@@ -22,6 +22,11 @@
  *
  */
 
+#define AC97_STAC9758_OUTPUT_SELECT	0x64
+#define AC97_STAC9758_INPUT_SELECT	0x66
+#define AC97_STAC9758_IO_MISC		0x68
+#define AC97_STAC9758_VARIOUS		0x72
+
 int patch_yamaha_ymf753(ac97_t * ac97);
 int patch_wolfson00(ac97_t * ac97);
 int patch_wolfson03(ac97_t * ac97);
@@ -34,6 +39,7 @@
 int patch_sigmatel_stac9721(ac97_t * ac97);
 int patch_sigmatel_stac9744(ac97_t * ac97);
 int patch_sigmatel_stac9756(ac97_t * ac97);
+int patch_sigmatel_stac9758(ac97_t * ac97);
 int patch_cirrus_cs4299(ac97_t * ac97);
 int patch_cirrus_spdif(ac97_t * ac97);
 int patch_conexant(ac97_t * ac97);


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
