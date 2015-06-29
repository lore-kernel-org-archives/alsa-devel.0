From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Fix TLV size calculation.
Date: Mon, 29 Jun 2015 17:36:43 +0100
Message-ID: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D23CE2659ED
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:36:58 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

TLV size calculation was incorrectly calculated. Fix this according to
include/sound/tlv.h

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d096068..7a19df3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -580,27 +580,26 @@ static int soc_tplg_init_kcontrol(struct soc_tplg *tplg,
 }
 
 static int soc_tplg_create_tlv(struct soc_tplg *tplg,
-	struct snd_kcontrol_new *kc, u32 tlv_size)
+	struct snd_kcontrol_new *kc, struct snd_soc_tplg_ctl_tlv *tplg_tlv)
 {
-	struct snd_soc_tplg_ctl_tlv *tplg_tlv;
 	struct snd_ctl_tlv *tlv;
+	int size;
 
-	if (tlv_size == 0)
+	if (tplg_tlv->count == 0)
 		return 0;
 
-	tplg_tlv = (struct snd_soc_tplg_ctl_tlv *) tplg->pos;
-	tplg->pos += tlv_size;
-
-	tlv = kzalloc(sizeof(*tlv) + tlv_size, GFP_KERNEL);
+	size = ((tplg_tlv->count + (sizeof(unsigned int) - 1)) &
+		~(sizeof(unsigned int) - 1));
+	tlv = kzalloc(sizeof(*tlv) + size, GFP_KERNEL);
 	if (tlv == NULL)
 		return -ENOMEM;
 
 	dev_dbg(tplg->dev, " created TLV type %d size %d bytes\n",
-		tplg_tlv->numid, tplg_tlv->size);
+		tplg_tlv->numid, size);
 
 	tlv->numid = tplg_tlv->numid;
-	tlv->length = tplg_tlv->size;
-	memcpy(tlv->tlv, tplg_tlv + 1, tplg_tlv->size);
+	tlv->length = size;
+	memcpy(&tlv->tlv[0], tplg_tlv->data, size);
 	kc->tlv.p = (void *)tlv;
 
 	return 0;
@@ -773,7 +772,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 		}
 
 		/* create any TLV data */
-		soc_tplg_create_tlv(tplg, &kc, mc->hdr.tlv_size);
+		soc_tplg_create_tlv(tplg, &kc, &mc->tlv);
 
 		/* register control here */
 		err = soc_tplg_add_kcontrol(tplg, &kc,
-- 
2.1.4
