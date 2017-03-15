From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ALSA: hda/ca0132: Remove double parentheses
Date: Wed, 15 Mar 2017 15:41:23 -0700
Message-ID: <20170315224123.175587-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sven Hahne <hahne@zeitkunst.eu>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

The extra pairs of parantheses are not needed and causes clang to
generate warnings like this:

sound/pci/hda/patch_ca0132.c:1171:14: error: equality comparison with extraneous parentheses [-Werror,-Wparentheses-equality]
        if ((buffer == NULL))
             ~~~~~~~^~~~~~~
sound/pci/hda/patch_ca0132.c:1171:14: note: remove extraneous parentheses around the comparison to silence this warning
        if ((buffer == NULL))
            ~       ^      ~
sound/pci/hda/patch_ca0132.c:1171:14: note: use '=' to turn this equality comparison into an assignment
        if ((buffer == NULL))

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 11b9b2f17a2e..9cc1bbbbef32 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1168,7 +1168,7 @@ static int dspio_write_multiple(struct hda_codec *codec,
 	int status = 0;
 	unsigned int count;
 
-	if ((buffer == NULL))
+	if (buffer == NULL)
 		return -EINVAL;
 
 	count = 0;
@@ -1210,7 +1210,7 @@ static int dspio_read_multiple(struct hda_codec *codec, unsigned int *buffer,
 	unsigned int skip_count;
 	unsigned int dummy;
 
-	if ((buffer == NULL))
+	if (buffer == NULL)
 		return -1;
 
 	count = 0;
-- 
2.12.0.367.g23dc2f6d3c-goog
