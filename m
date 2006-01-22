From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: [patch] hda/patch_si3054.c: support for Agere's HDA soft modem
Date: Sun, 22 Jan 2006 03:02:59 +0200
Message-ID: <20060122010259.GA13628@khap>
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

Hello Takashi,

There are addition of Agere's modem IDs for patch_si3054.c. Reported in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733

Sasha.


This adds support for Agere's variant of Si3054/5 based HDA modem.

Signed-off-by: Sasha Khapyorsky <sashak@alsa-project.org>

Index: alsa-kernel/pci/hda/patch_si3054.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_si3054.c,v
retrieving revision 1.6
diff -u -p -r1.6 patch_si3054.c
--- alsa-kernel/pci/hda/patch_si3054.c	17 Nov 2005 14:57:47 -0000	1.6
+++ alsa-kernel/pci/hda/patch_si3054.c	11 Jan 2006 22:31:10 -0000
@@ -297,6 +297,7 @@ static int patch_si3054(struct hda_codec
 struct hda_codec_preset snd_hda_preset_si3054[] = {
  	{ .id = 0x163c3055, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x163c3155, .name = "Si3054", .patch = patch_si3054 },
+ 	{ .id = 0x11c13026, .name = "Si3054", .patch = patch_si3054 },
 	{}
 };
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
