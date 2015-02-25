From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sound/oss/opl3: remove some stray whitespace
Date: Wed, 25 Feb 2015 16:30:36 +0300
Message-ID: <20150225133036.GO19745@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Himangi Saraogi <himangi774@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Removed an extra tab and a extra space character.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/oss/opl3.c b/sound/oss/opl3.c
index 607cee4..b6d19ad 100644
--- a/sound/oss/opl3.c
+++ b/sound/oss/opl3.c
@@ -666,7 +666,7 @@ static int opl3_start_note (int dev, int voice, int note, int volume)
 	opl3_command(map->ioaddr, FNUM_LOW + map->voice_num, data);
 
 	data = 0x20 | ((block & 0x7) << 2) | ((fnum >> 8) & 0x3);
-		 devc->voc[voice].keyon_byte = data;
+	devc->voc[voice].keyon_byte = data;
 	opl3_command(map->ioaddr, KEYON_BLOCK + map->voice_num, data);
 	if (voice_mode == 4)
 		opl3_command(map->ioaddr, KEYON_BLOCK + map->voice_num + 3, data);
@@ -717,7 +717,7 @@ static void freq_to_fnum    (int freq, int *block, int *fnum)
 
 static void opl3_command    (int io_addr, unsigned int addr, unsigned int val)
 {
-	 int i;
+	int i;
 
 	/*
 	 * The original 2-OP synth requires a quite long delay after writing to a
