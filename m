From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: sigmatel fixes
Date: Wed, 25 Jan 2006 10:22:19 -0700
Message-ID: <20060125102219.E29602@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6BD1E17A
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 18:22:24 +0100 (MET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

* Fix init sequence so manually retaskable jacks don't get added to
  the line_out list.
* Update intel mobo config defaults to specify surround outputs
  as line outs rather than speakers.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.16
diff -u -r1.16 patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	24 Jan 2006 10:34:34 -0000	1.16
+++ alsa-kernel/pci/hda/patch_sigmatel.c	25 Jan 2006 17:17:56 -0000
@@ -277,14 +277,14 @@
 };
 
 static unsigned int d945gtp3_pin_configs[10] = {
-	0x0221401f, 0x01a19022, 0x01813021, 0x01114010,
+	0x0221401f, 0x01a19022, 0x01813021, 0x01014010,
 	0x40000100, 0x40000100, 0x40000100, 0x40000100,
 	0x02a19120, 0x40000100,
 };
 
 static unsigned int d945gtp5_pin_configs[10] = {
-	0x0221401f, 0x01111012, 0x01813024, 0x01114010,
-	0x01a19021, 0x01116011, 0x01452130, 0x40000100,
+	0x0221401f, 0x01011012, 0x01813024, 0x01014010,
+	0x01a19021, 0x01016011, 0x01452130, 0x40000100,
 	0x02a19320, 0x40000100,
 };
 
@@ -855,12 +855,14 @@
 
 	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL)) < 0)
 		return err;
+	if (! spec->autocfg.line_outs && ! spec->autocfg.hp_pin)
+		return 0; /* can't find valid pin config */
+	stac92xx_auto_init_multi_out(codec);
+	stac92xx_auto_init_hp_out(codec);
 	if ((err = stac92xx_add_dyn_out_pins(codec, &spec->autocfg)) < 0)
 		return err;
 	if ((err = stac92xx_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
 		return err;
-	if (! spec->autocfg.line_outs && ! spec->autocfg.hp_pin)
-		return 0; /* can't find valid pin config */
 
 	if ((err = stac92xx_auto_create_multi_out_ctls(spec, &spec->autocfg)) < 0 ||
 	    (err = stac92xx_auto_create_hp_ctls(codec, &spec->autocfg)) < 0 ||
@@ -922,9 +924,6 @@
 
 	snd_hda_sequence_write(codec, spec->init);
 
-	stac92xx_auto_init_multi_out(codec);
-	stac92xx_auto_init_hp_out(codec);
-
 	return 0;
 }
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
