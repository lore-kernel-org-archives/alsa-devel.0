From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 14/18] ALSA: hda: move patch_si3054 to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:51 +0100
Message-ID: <1444144075-28963-15-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BFBD92657A6
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:52 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_si3054 to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_si3054.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index 5104bebb2286..5c2a3f7e9b6d 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -75,8 +75,8 @@
 #define SI3054_CHIPID_CODEC_ID      (1<<12)
 
 /* si3054 codec registers (nodes) access macros */
-#define GET_REG(codec,reg) (snd_hda_codec_read(codec,reg,0,SI3054_VERB_READ_NODE,0))
-#define SET_REG(codec,reg,val) (snd_hda_codec_write(codec,reg,0,SI3054_VERB_WRITE_NODE,val))
+#define GET_REG(codec,reg) (snd_hdac_codec_read(&codec->core,reg,0,SI3054_VERB_READ_NODE,0))
+#define SET_REG(codec,reg,val) (snd_hdac_codec_write(&codec->core,reg,0,SI3054_VERB_WRITE_NODE,val))
 #define SET_REG_CACHE(codec,reg,val) \
 	snd_hda_codec_write_cache(codec,reg,0,SI3054_VERB_WRITE_NODE,val)
 
@@ -226,8 +226,10 @@ static int si3054_init(struct hda_codec *codec)
 					    SI3054_VERB_WRITE_NODE))
 		return -ENOMEM;
 
-	snd_hda_codec_write(codec, AC_NODE_ROOT, 0, AC_VERB_SET_CODEC_RESET, 0);
-	snd_hda_codec_write(codec, codec->core.mfg, 0, AC_VERB_SET_STREAM_FORMAT, 0);
+	snd_hdac_codec_write(&codec->core, AC_NODE_ROOT, 0,
+			     AC_VERB_SET_CODEC_RESET, 0);
+	snd_hdac_codec_write(&codec->core, codec->core.mfg, 0,
+			     AC_VERB_SET_STREAM_FORMAT, 0);
 	SET_REG(codec, SI3054_LINE_RATE, 9600);
 	SET_REG(codec, SI3054_LINE_LEVEL, SI3054_DTAG_MASK|SI3054_ATAG_MASK);
 	SET_REG(codec, SI3054_EXTENDED_MID, 0);
-- 
2.4.3
