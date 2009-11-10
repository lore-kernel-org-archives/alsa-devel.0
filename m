From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ALSA: possible read past array
	alc88[02]_parse_auto_config()
Date: Tue, 10 Nov 2009 20:11:55 +0100
Message-ID: <4AF9BAFB.3090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E00F24577
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 20:00:03 +0100 (CET)
Received: by ewy21 with SMTP id 21so794181ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 11:00:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The test of index `i' is after the read - too late - and
unsafe: if snd_hda_get_connections() fails in the last
iteration a read beyond the array is possible.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 sound/pci/hda/patch_realtek.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ff20048..fd094f5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4684,9 +4684,9 @@ static int alc880_parse_auto_config(struct hda_codec *codec)
 			spec->multiout.dig_out_nid = dig_nid;
 		else {
 			spec->multiout.slave_dig_outs = spec->slave_dig_outs;
-			spec->slave_dig_outs[i - 1] = dig_nid;
-			if (i == ARRAY_SIZE(spec->slave_dig_outs) - 1)
+			if (i >= ARRAY_SIZE(spec->slave_dig_outs) - 1)
 				break;
+			spec->slave_dig_outs[i - 1] = dig_nid;
 		}
 	}
 	if (spec->autocfg.dig_in_pin)
@@ -9813,9 +9813,9 @@ static int alc882_parse_auto_config(struct hda_codec *codec)
 			spec->multiout.dig_out_nid = dig_nid;
 		else {
 			spec->multiout.slave_dig_outs = spec->slave_dig_outs;
-			spec->slave_dig_outs[i - 1] = dig_nid;
-			if (i == ARRAY_SIZE(spec->slave_dig_outs) - 1)
+			if (i >= ARRAY_SIZE(spec->slave_dig_outs) - 1)
 				break;
+			spec->slave_dig_outs[i - 1] = dig_nid;
 		}
 	}
 	if (spec->autocfg.dig_in_pin)
