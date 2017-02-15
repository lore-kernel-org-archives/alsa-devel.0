From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/2] ALSA: hda - add sanity check to force the
	separate stream tags
Date: Wed, 15 Feb 2017 17:09:43 +0100
Message-ID: <20170215160943.26504-2-perex@perex.cz>
References: <20170215160943.26504-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EB2C265142
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 17:10:58 +0100 (CET)
In-Reply-To: <20170215160943.26504-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It seems that newer Intel chipsets have more than 15 I/O streams (total).
This patch forces the separate stream tags, when this hardware is detected
to avoid SDxCTL.STRM field overflow and an unexpected behaviour.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/hda_intel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7d77bb5..16108f0e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1778,6 +1778,14 @@ static int azx_first_init(struct azx *chip)
 	chip->playback_index_offset = chip->capture_streams;
 	chip->num_streams = chip->playback_streams + chip->capture_streams;
 
+	/* sanity check for the SDxCTL.STRM field overflow */
+	if (chip->num_streams > 15 &&
+	    (chip->driver_caps & AZX_DCAPS_SEPARATE_STREAM_TAG) == 0) {
+		dev_warn(chip->card->dev, "number of I/O streams is %d, "
+			 "forcing separate stream tags", chip->num_streams);
+		chip->driver_caps |= AZX_DCAPS_SEPARATE_STREAM_TAG;
+	}
+
 	/* initialize streams */
 	err = azx_init_streams(chip);
 	if (err < 0)
-- 
2.9.3
