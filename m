From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] "empty" generic mfg-only codec
Date: Tue, 13 Sep 2005 03:18:47 +0300
Message-ID: <20050913001847.GA30146@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de> <20050907160343.GA3375@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050907160343.GA3375@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

This patch allows generic creation for mfg-only codecs, so some basic
codec info (like vendor_id) will be shown from proc file.

Not tested.

Sasha.


This creates "empty" hda generic for unknown MFG-only codecs.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/hda/hda_generic.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_generic.c,v
retrieving revision 1.8
diff -u -p -r1.8 hda_generic.c
--- alsa-kernel/pci/hda/hda_generic.c	9 Sep 2005 13:21:47 -0000	1.8
+++ alsa-kernel/pci/hda/hda_generic.c	12 Sep 2005 22:49:23 -0000
@@ -881,10 +881,8 @@ int snd_hda_parse_generic_codec(struct h
 	struct hda_gspec *spec;
 	int err;
 
-	if(!codec->afg) {
-		snd_printdd("hda_generic: no generic modem yet\n");
-		return -ENODEV;
-	}
+	if(!codec->afg)
+		return 0;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL) {


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
