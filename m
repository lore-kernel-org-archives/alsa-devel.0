From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Fix kerneldoc errors in
	patch_ca0132.c
Date: Mon, 10 Nov 2014 17:32:33 +0100
Message-ID: <1415637155-20918-3-git-send-email-tiwai@suse.de>
References: <1415637155-20918-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CD04E262600
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 17:32:40 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ACB38ABE7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:32:40 +0000 (UTC)
In-Reply-To: <1415637155-20918-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4f7ffa8c4a0d..e0383eea9880 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2417,7 +2417,7 @@ static int dspxfr_one_seg(struct hda_codec *codec,
  * @reloc: Relocation address for loading single-segment overlays, or 0 for
  *	   no relocation
  * @sample_rate: sampling rate of the stream used for DSP download
- * @number_channels: channels of the stream used for DSP download
+ * @channels: channels of the stream used for DSP download
  * @ovly: TRUE if overlay format is required
  *
  * Returns zero or a negative error code.
@@ -2556,10 +2556,7 @@ static void dspload_post_setup(struct hda_codec *codec)
 }
 
 /**
- * Download DSP from a DSP Image Fast Load structure. This structure is a
- * linear, non-constant sized element array of structures, each of which
- * contain the count of the data to be loaded, the data itself, and the
- * corresponding starting chip address of the starting data location.
+ * dspload_image - Download DSP from a DSP Image Fast Load structure.
  *
  * @codec: the HDA codec
  * @fls: pointer to a fast load image
@@ -2570,6 +2567,10 @@ static void dspload_post_setup(struct hda_codec *codec)
  * @router_chans: number of audio router channels to be allocated (0 means use
  *		  internal defaults; max is 32)
  *
+ * Download DSP from a DSP Image Fast Load structure. This structure is a
+ * linear, non-constant sized element array of structures, each of which
+ * contain the count of the data to be loaded, the data itself, and the
+ * corresponding starting chip address of the starting data location.
  * Returns zero or a negative error code.
  */
 static int dspload_image(struct hda_codec *codec,
-- 
2.1.3
