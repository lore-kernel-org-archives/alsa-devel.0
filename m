From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: [PATCH] hda/patch_si3054: new codec vendor IDs
Date: Mon, 25 Sep 2006 11:01:01 +0300
Message-ID: <20060925080101.GA7996@sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Marvin Stodolsky <marvin.stodolsky@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

There are new IDs for Si3054 based HDA modems.

Sasha

---
There are additional IDs for Si3054 codec based HDA modems. Most of
them were discovered on discuss@linmodems.org list - Thanks to MarvS
and all linmodems.org folks.

Signed-off-by: Sasha Khapyorsky <sashak@alsa-project.org>

---
diff -r 63e58b008259 pci/hda/patch_si3054.c
--- a/pci/hda/patch_si3054.c	Mon Sep 04 13:03:51 2006 +0200
+++ b/pci/hda/patch_si3054.c	Sun Sep 24 03:20:25 2006 +0300
@@ -297,7 +297,12 @@ struct hda_codec_preset snd_hda_preset_s
 struct hda_codec_preset snd_hda_preset_si3054[] = {
  	{ .id = 0x163c3055, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x163c3155, .name = "Si3054", .patch = patch_si3054 },
+ 	{ .id = 0x11c11040, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x11c13026, .name = "Si3054", .patch = patch_si3054 },
+ 	{ .id = 0x11c13055, .name = "Si3054", .patch = patch_si3054 },
+ 	{ .id = 0x11c13155, .name = "Si3054", .patch = patch_si3054 },
+ 	{ .id = 0x10573055, .name = "Si3054", .patch = patch_si3054 },
+ 	{ .id = 0x10573155, .name = "Si3054", .patch = patch_si3054 },
 	{}
 };
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
