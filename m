From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/14] ALSA: lola: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:06 +0200
Message-ID: <20180725212414.19795-7-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B11AC26779F
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 48D66AE31
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

The BDL entries in lola driver are little-endian while we code them as
u32.  This leads to sparse warnings like:
  sound/pci/lola/lola.c:105:40: warning: incorrect type in assignment (different base types)
  sound/pci/lola/lola.c:105:40:    expected unsigned int [unsigned] [usertype] <noident>
  sound/pci/lola/lola.c:105:40:    got restricted __le32 [usertype] <noident>

This patch fixes the declarations to the proper __le32 type.

Also, there was a typo in the original code, where __user was used
that was intended as __iomem.  This was caused also by sparse:
  sound/pci/lola/lola_mixer.c:132:27: warning: incorrect type in assignment (different address spaces)
Fixed in this patch as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lola/lola.c     | 4 ++--
 sound/pci/lola/lola.h     | 4 ++--
 sound/pci/lola/lola_pcm.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 9ff600084973..254f24366892 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -369,9 +369,9 @@ static int setup_corb_rirb(struct lola *chip)
 		return err;
 
 	chip->corb.addr = chip->rb.addr;
-	chip->corb.buf = (u32 *)chip->rb.area;
+	chip->corb.buf = (__le32 *)chip->rb.area;
 	chip->rirb.addr = chip->rb.addr + 2048;
-	chip->rirb.buf = (u32 *)(chip->rb.area + 2048);
+	chip->rirb.buf = (__le32 *)(chip->rb.area + 2048);
 
 	/* disable ringbuffer DMAs */
 	lola_writeb(chip, BAR0, RIRBCTL, 0);
diff --git a/sound/pci/lola/lola.h b/sound/pci/lola/lola.h
index f0b100059efd..bd852fed8bb6 100644
--- a/sound/pci/lola/lola.h
+++ b/sound/pci/lola/lola.h
@@ -220,7 +220,7 @@ struct lola_bar {
 
 /* CORB/RIRB */
 struct lola_rb {
-	u32 *buf;		/* CORB/RIRB buffer, 8 byte per each entry */
+	__le32 *buf;		/* CORB/RIRB buffer, 8 byte per each entry */
 	dma_addr_t addr;	/* physical address of CORB/RIRB buffer */
 	unsigned short rp, wp;	/* read/write pointers */
 	int cmds;		/* number of pending requests */
@@ -275,7 +275,7 @@ struct lola_mixer_array {
 struct lola_mixer_widget {
 	unsigned int nid;
 	unsigned int caps;
-	struct lola_mixer_array __user *array;
+	struct lola_mixer_array __iomem *array;
 	struct lola_mixer_array *array_saved;
 	unsigned int src_stream_outs;
 	unsigned int src_phys_ins;
diff --git a/sound/pci/lola/lola_pcm.c b/sound/pci/lola/lola_pcm.c
index 310b26a756c9..e70276c3ea20 100644
--- a/sound/pci/lola/lola_pcm.c
+++ b/sound/pci/lola/lola_pcm.c
@@ -316,10 +316,10 @@ static int lola_pcm_hw_free(struct snd_pcm_substream *substream)
  * set up a BDL entry
  */
 static int setup_bdle(struct snd_pcm_substream *substream,
-		      struct lola_stream *str, u32 **bdlp,
+		      struct lola_stream *str, __le32 **bdlp,
 		      int ofs, int size)
 {
-	u32 *bdl = *bdlp;
+	__le32 *bdl = *bdlp;
 
 	while (size > 0) {
 		dma_addr_t addr;
@@ -355,14 +355,14 @@ static int lola_setup_periods(struct lola *chip, struct lola_pcm *pcm,
 			      struct snd_pcm_substream *substream,
 			      struct lola_stream *str)
 {
-	u32 *bdl;
+	__le32 *bdl;
 	int i, ofs, periods, period_bytes;
 
 	period_bytes = str->period_bytes;
 	periods = str->bufsize / period_bytes;
 
 	/* program the initial BDL entries */
-	bdl = (u32 *)(pcm->bdl.area + LOLA_BDL_ENTRY_SIZE * str->index);
+	bdl = (__le32 *)(pcm->bdl.area + LOLA_BDL_ENTRY_SIZE * str->index);
 	ofs = 0;
 	str->frags = 0;
 	for (i = 0; i < periods; i++) {
-- 
2.18.0
