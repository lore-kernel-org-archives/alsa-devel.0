From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: [PATCH] hda driver, correct bug in model "auto"
Date: Tue, 19 Jul 2005 23:34:20 +0200
Message-ID: <42DD71DC.1090002@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040300020503010904000300"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7607E1D7
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 23:34:21 +0200 (MEST)
Received: from localhost.localdomain (rob92-2-82-66-38-107.fbx.proxad.net [82.66.38.107])
	by postfix3-2.free.fr (Postfix) with ESMTP id D8C0EC020
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 23:34:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1])
	by localhost.localdomain with esmtp (Exim 4.52)
	id 1DuzjI-00006M-Ab
	for alsa-devel@alsa-project.org; Tue, 19 Jul 2005 23:34:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040300020503010904000300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

- Correct some index variable inversion in patch_cmedia.c
- Correct the channels order in model autodetection (not sure of this
part, I need validation)

Signed-off-by: Nicolas Graziano <nicolas.graziano@wanadoo.fr>



--------------040300020503010904000300
Content-Type: text/x-patch;
 name="hda_auto.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hda_auto.diff"

Index: pci/hda/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.20
diff -u -r1.20 hda_codec.c
--- pci/hda/hda_codec.c	13 Jun 2005 13:16:39 -0000	1.20
+++ pci/hda/hda_codec.c	19 Jul 2005 20:53:04 -0000
@@ -1804,12 +1804,20 @@
 			}
 
 	/* Swap surround and CLFE: the association order is front/CLFE/surr/back */
-	if (cfg->line_outs >= 3) {
+	if (cfg->line_outs == 3) {
 		nid = cfg->line_out_pins[1];
 		cfg->line_out_pins[1] = cfg->line_out_pins[2];
 		cfg->line_out_pins[2] = nid;
 	}
 
+	if (cfg->line_outs >= 4) {
+		nid = cfg->line_out_pins[1];
+		cfg->line_out_pins[1] = cfg->line_out_pins[3];
+		cfg->line_out_pins[3] = cfg->line_out_pins[2];
+		cfg->line_out_pins[2] = nid;
+	}
+
+
 	return 0;
 }
 
Index: pci/hda/patch_cmedia.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_cmedia.c,v
retrieving revision 1.10
diff -u -r1.10 patch_cmedia.c
--- pci/hda/patch_cmedia.c	13 Jun 2005 13:16:39 -0000	1.10
+++ pci/hda/patch_cmedia.c	19 Jul 2005 20:53:04 -0000
@@ -408,7 +408,7 @@
 		/* search for an empty channel */
 		for (j = 0; j < cfg->line_outs; j++) {
 			if (! assigned[j]) {
-				spec->dac_nids[i] = i + 0x03;
+				spec->dac_nids[i] = j + 0x03;
 				assigned[j] = 1;
 				break;
 			}
@@ -444,11 +444,10 @@
 			len = snd_hda_get_connections(codec, nid, conn, 4);
 			for (k = 0; k < len; k++)
 				if (conn[k] == spec->dac_nids[i]) {
-					spec->multi_init[j].param = j;
+					spec->multi_init[j].param = k;
 					break;
 				}
 			j++;
-			break;
 		}
 	}
 	return 0;

--------------040300020503010904000300--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
