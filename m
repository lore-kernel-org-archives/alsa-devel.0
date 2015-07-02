From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix TLV size calculation." to
	the asoc tree
Date: Thu, 02 Jul 2015 12:41:04 +0100
Message-ID: <E1ZAcrY-0007mr-NV@debutante>
References: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C5BB26598D
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 13:41:12 +0200 (CEST)
In-Reply-To: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix TLV size calculation.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7084ffbff494669b06ceb457150c38887e26d2a3 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 29 Jun 2015 17:36:43 +0100
Subject: [PATCH] ASoC: topology: Fix TLV size calculation.

TLV size calculation was incorrectly calculated. Fix this according to
include/sound/tlv.h

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d0960683c409..7a19df313fe8 100644
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
