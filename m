From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] ALSA: hda/ca0132: Limit values for chip addresses to 32-bit
Date: Fri, 31 Mar 2017 18:00:04 -0700
Message-ID: <20170401010005.90685-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sven Hahne <hahne@zeitkunst.eu>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Michael Davidson <md@google.com>, Greg Hackmann <ghackmann@google.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

With the previous unsigned long value clang generates warnings like
this:

sound/pci/hda/patch_ca0132.c:860:37: error: implicit conversion from
'unsigned long' to 'u32' (aka 'unsigned int') changes value from
18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
        spec->curr_chip_addx = (res < 0) ? ~0UL : chip_addx;
                             ~             ^~~~

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- Remove unnecessary cast to u32

 sound/pci/hda/patch_ca0132.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 07a9deb17477..2023fe472be1 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -857,7 +857,7 @@ static int chipio_write_address(struct hda_codec *codec,
 				  chip_addx >> 16);
 	}
 
-	spec->curr_chip_addx = (res < 0) ? ~0UL : chip_addx;
+	spec->curr_chip_addx = (res < 0) ? ~0U : chip_addx;
 
 	return res;
 }
@@ -882,7 +882,7 @@ static int chipio_write_data(struct hda_codec *codec, unsigned int data)
 	/*If no error encountered, automatically increment the address
 	as per chip behaviour*/
 	spec->curr_chip_addx = (res != -EIO) ?
-					(spec->curr_chip_addx + 4) : ~0UL;
+					(spec->curr_chip_addx + 4) : ~0U;
 	return res;
 }
 
@@ -933,7 +933,7 @@ static int chipio_read_data(struct hda_codec *codec, unsigned int *data)
 	/*If no error encountered, automatically increment the address
 	as per chip behaviour*/
 	spec->curr_chip_addx = (res != -EIO) ?
-					(spec->curr_chip_addx + 4) : ~0UL;
+					(spec->curr_chip_addx + 4) : ~0U;
 	return res;
 }
 
-- 
2.12.2.564.g063fe858b8-goog
