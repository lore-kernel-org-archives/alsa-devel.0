From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [HDA patch] MFG support
Date: Wed, 10 Aug 2005 22:28:50 +0300
Message-ID: <20050810192850.GD20213@sashak.softier.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

This patch adds support for Modem Functional Group (MFG), just
generic definitions and also possibility for 9600 sample rate.
It is needed for HDA modem driver (next patch).

Regards,
Sasha.


This adds Modem Functional Group (MFG) support and option for 9600
sample rate.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/hda/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.22
diff -u -p -u -p -r1.22 hda_codec.c
--- alsa-kernel/pci/hda/hda_codec.c	29 Jul 2005 11:17:20 -0000	1.22
+++ alsa-kernel/pci/hda/hda_codec.c	10 Aug 2005 13:39:46 -0000
@@ -432,22 +432,26 @@ void snd_hda_get_codec_name(struct hda_c
 }
 
 /*
- * look for an AFG node
- *
- * return 0 if not found
+ * look for an AFG and MFG nodes
  */
-static int look_for_afg_node(struct hda_codec *codec)
+static void setup_fg_nodes(struct hda_codec *codec)
 {
 	int i, total_nodes;
 	hda_nid_t nid;
 
 	total_nodes = snd_hda_get_sub_nodes(codec, AC_NODE_ROOT, &nid);
 	for (i = 0; i < total_nodes; i++, nid++) {
-		if ((snd_hda_param_read(codec, nid, AC_PAR_FUNCTION_TYPE) & 0xff) ==
-		    AC_GRP_AUDIO_FUNCTION)
-			return nid;
+		switch((snd_hda_param_read(codec, nid, AC_PAR_FUNCTION_TYPE) & 0xff)) {
+		case AC_GRP_AUDIO_FUNCTION:
+			codec->afg = nid;
+			break;
+		case AC_GRP_MODEM_FUNCTION:
+			codec->mfg = nid;
+			break;
+		default:
+			break;
+		}
 	}
-	return 0;
 }
 
 /*
@@ -507,10 +511,9 @@ int snd_hda_codec_new(struct hda_bus *bu
 	codec->subsystem_id = snd_hda_param_read(codec, AC_NODE_ROOT, AC_PAR_SUBSYSTEM_ID);
 	codec->revision_id = snd_hda_param_read(codec, AC_NODE_ROOT, AC_PAR_REV_ID);
 
-	/* FIXME: support for multiple AFGs? */
-	codec->afg = look_for_afg_node(codec);
-	if (! codec->afg) {
-		snd_printdd("hda_codec: no AFG node found\n");
+	setup_fg_nodes(codec);
+	if (! codec->afg && ! codec->mfg) {
+		snd_printdd("hda_codec: no AFG or MFG node found\n");
 		snd_hda_codec_free(codec);
 		return -ENODEV;
 	}
@@ -1163,6 +1166,7 @@ int snd_hda_build_controls(struct hda_bu
 static unsigned int rate_bits[][3] = {
 	/* rate in Hz, ALSA rate bitmask, HDA format value */
 	{ 8000, SNDRV_PCM_RATE_8000, 0x0500 }, /* 1/6 x 48 */
+	{ 9600, SNDRV_PCM_RATE_KNOT, 0x0400 }, /* 1/5 x 48 */
 	{ 11025, SNDRV_PCM_RATE_11025, 0x4300 }, /* 1/4 x 44 */
 	{ 16000, SNDRV_PCM_RATE_16000, 0x0200 }, /* 1/3 x 48 */
 	{ 22050, SNDRV_PCM_RATE_22050, 0x4100 }, /* 1/2 x 44 */
Index: alsa-kernel/pci/hda/hda_codec.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.h,v
retrieving revision 1.10
diff -u -p -u -p -r1.10 hda_codec.h
--- alsa-kernel/pci/hda/hda_codec.h	4 Jul 2005 16:51:39 -0000	1.10
+++ alsa-kernel/pci/hda/hda_codec.h	10 Aug 2005 13:39:46 -0000
@@ -514,6 +514,7 @@ struct hda_codec {
 	struct list_head list;	/* list point */
 
 	hda_nid_t afg;	/* AFG node id */
+	hda_nid_t mfg;	/* MFG node id */
 
 	/* ids */
 	u32 vendor_id;
Index: alsa-kernel/pci/hda/hda_generic.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_generic.c,v
retrieving revision 1.6
diff -u -p -u -p -r1.6 hda_generic.c
--- alsa-kernel/pci/hda/hda_generic.c	13 Jun 2005 13:16:39 -0000	1.6
+++ alsa-kernel/pci/hda/hda_generic.c	10 Aug 2005 13:39:46 -0000
@@ -881,6 +881,11 @@ int snd_hda_parse_generic_codec(struct h
 	struct hda_gspec *spec;
 	int err;
 
+	if(!codec->afg) {
+		snd_printdd("hda_generic: no generic modem yet\n");
+		return -ENODEV;
+	}
+
 	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL) {
 		printk(KERN_ERR "hda_generic: can't allocate spec\n");


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
