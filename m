From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 07/15] ALSA: hda/ca0132 - Add AE-5 regular init
	setup
Date: Tue, 18 Sep 2018 14:33:35 -0400
Message-ID: <1537295625-8082-8-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A839F2678BF
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 20:34:41 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so2687822qtn.3
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 11:34:41 -0700 (PDT)
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Takashi Iwai <tiwai@suse.com>, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds AE-5 specific stuff to the ca0132_alt_init function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4b95dc0..163d2ac 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3215,6 +3215,7 @@ static void ca0132_gpio_init(struct hda_codec *codec)
 
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+	case QUIRK_AE5:
 		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
 		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
 		snd_hda_codec_write(codec, 0x01, 0, 0x790, 0x23);
@@ -7432,6 +7433,17 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		break;
+	case QUIRK_AE5:
+		ca0132_gpio_init(codec);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x49);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_PLL_PMU_WRITE, 0x88);
+		chipio_write(codec, 0x18b030, 0x00000020);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
+		break;
 	}
 }
 
-- 
2.7.4
