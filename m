From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: fsl_ssi: Add missing __iomem annotations
Date: Sun, 24 Nov 2013 14:36:43 +0100
Message-ID: <1385300203-24850-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-164.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id CD9292616FB
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:36:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

There are two places in the fsl_ssi driver where the pointer to the register set
is missing the __iomem annotation. Adding it fixes the following warnings from
sparse:
	sound/soc/fsl/fsl_ssi.c:747:45: warning: incorrect type in initializer (different address spaces)
	sound/soc/fsl/fsl_ssi.c:747:45:    expected struct ccsr_ssi *ssi
	sound/soc/fsl/fsl_ssi.c:747:45:    got struct ccsr_ssi [noderef] <asn:2>*ssi
	sound/soc/fsl/fsl_ssi.c:756:9: warning: incorrect type in argument 2 (different address spaces)
	sound/soc/fsl/fsl_ssi.c:756:9:    expected void volatile [noderef] <asn:2>*addr
	sound/soc/fsl/fsl_ssi.c:756:9:    got unsigned int *<noident>
	sound/soc/fsl/fsl_ssi.c:759:9: warning: incorrect type in argument 2 (different address spaces)
	sound/soc/fsl/fsl_ssi.c:759:9:    expected void volatile [noderef] <asn:2>*addr
	sound/soc/fsl/fsl_ssi.c:759:9:    got unsigned int *<noident>
	sound/soc/fsl/fsl_ssi.c:761:25: warning: incorrect type in argument 1 (different address spaces)
	sound/soc/fsl/fsl_ssi.c:761:25:    expected unsigned int [noderef] [usertype] <asn:2>*addr
	sound/soc/fsl/fsl_ssi.c:761:25:    got unsigned int *<noident>
	sound/soc/fsl/fsl_ssi.c:769:45: warning: incorrect type in initializer (different address spaces)
	sound/soc/fsl/fsl_ssi.c:769:45:    expected struct ccsr_ssi *ssi
	sound/soc/fsl/fsl_ssi.c:769:45:    got struct ccsr_ssi [noderef] <asn:2>*ssi
	sound/soc/fsl/fsl_ssi.c:775:9: warning: incorrect type in argument 2 (different address spaces)
	sound/soc/fsl/fsl_ssi.c:775:9:    expected void volatile [noderef] <asn:2>*addr
	sound/soc/fsl/fsl_ssi.c:775:9:    got unsigned int *<noident>
	sound/soc/fsl/fsl_ssi.c:776:25: warning: incorrect type in argument 1 (different address spaces)
	sound/soc/fsl/fsl_ssi.c:776:25:    expected unsigned int [noderef] [usertype] <asn:2>*addr
	sound/soc/fsl/fsl_ssi.c:776:25:    got unsigned int *<noident>
	sound/soc/fsl/fsl_ssi.c:781:16: warning: incorrect type in argument 1 (different address spaces)
	sound/soc/fsl/fsl_ssi.c:781:16:    expected void const volatile [noderef] <asn:2>*addr
	sound/soc/fsl/fsl_ssi.c:781:16:    got unsigned int *<noident>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3df0318..1a9521a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -751,7 +751,7 @@ static void fsl_ssi_ac97_init(void)
 static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 		unsigned short val)
 {
-	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+	struct ccsr_ssi __iomem *ssi = fsl_ac97_data->ssi;
 	unsigned int lreg;
 	unsigned int lval;
 
@@ -773,7 +773,7 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 		unsigned short reg)
 {
-	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+	struct ccsr_ssi __iomem *ssi = fsl_ac97_data->ssi;
 
 	unsigned short val = -1;
 	unsigned int lreg;
-- 
1.8.0
