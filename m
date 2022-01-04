Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7708C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Jan 2022 11:12:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A85C71706;
	Tue,  4 Jan 2022 12:11:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A85C71706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641294749;
	bh=B+vbm1jv8/ATgxxFPhnEG/8y7cUbx/Ubh8U2UB7ODbA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cod+p2xlB7SW2Y82xZgCwdaswFHjtUm7blhoJDIFhdKfBT6Z5Wc739aBBRLQDmtpE
	 MgDGWdhYKfLtgDO+pL4g+JF4byCSCkicP/YzHh7Fa+6rf2iIweiUDGF0GBWIFhtW3A
	 /su5rnnrpQGOmiTzfWrfI1dPijZavOf8/2SFgEJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88A9CF8050F;
	Tue,  4 Jan 2022 12:10:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B657F804FE; Tue,  4 Jan 2022 12:10:34 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98911F8027C
 for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2022 12:10:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98911F8027C
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EEF85200CC7;
 Tue,  4 Jan 2022 12:10:22 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7C1D200C96;
 Tue,  4 Jan 2022 12:10:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 51B77183AD05;
 Tue,  4 Jan 2022 19:10:21 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: imx-card: improve the sound quality for low rate
Date: Tue,  4 Jan 2022 18:40:35 +0800
Message-Id: <1641292835-19085-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

According to RM, on auto mode:
For codec AK4458 and AK4497, the lowest ratio of MLCK/FS is 256
if sample rate is 8kHz-48kHz,
For codec AK5558, the lowest ratio of MLCK/FS is 512 if sample
rate is 8kHz-48kHz.

With these setting the sound quality for 8kHz-48kHz can be improved.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index f9196fb7e833..6f8efd838fcc 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -120,7 +120,7 @@ struct imx_card_data {
 
 static struct imx_akcodec_fs_mul ak4458_fs_mul[] = {
 	/* Normal, < 32kHz */
-	{ .rmin = 8000,   .rmax = 24000,  .wmin = 1024, .wmax = 1024, },
+	{ .rmin = 8000,   .rmax = 24000,  .wmin = 256,  .wmax = 1024, },
 	/* Normal, 32kHz */
 	{ .rmin = 32000,  .rmax = 32000,  .wmin = 256,  .wmax = 1024, },
 	/* Normal */
@@ -151,8 +151,8 @@ static struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
 	 * Table 7      - mapping multiplier and speed mode
 	 * Tables 8 & 9 - mapping speed mode and LRCK fs
 	 */
-	{ .rmin = 8000,   .rmax = 32000,  .wmin = 1024, .wmax = 1024, }, /* Normal, <= 32kHz */
-	{ .rmin = 44100,  .rmax = 48000,  .wmin = 512,  .wmax = 512, }, /* Normal */
+	{ .rmin = 8000,   .rmax = 32000,  .wmin = 256,  .wmax = 1024, }, /* Normal, <= 32kHz */
+	{ .rmin = 44100,  .rmax = 48000,  .wmin = 256,  .wmax = 512, }, /* Normal */
 	{ .rmin = 88200,  .rmax = 96000,  .wmin = 256,  .wmax = 256, }, /* Double */
 	{ .rmin = 176400, .rmax = 192000, .wmin = 128,  .wmax = 128, }, /* Quad */
 	{ .rmin = 352800, .rmax = 384000, .wmin = 128,  .wmax = 128, }, /* Oct */
@@ -164,7 +164,7 @@ static struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
  * (Table 4 from datasheet)
  */
 static struct imx_akcodec_fs_mul ak5558_fs_mul[] = {
-	{ .rmin = 8000,   .rmax = 32000,  .wmin = 1024, .wmax = 1024, },
+	{ .rmin = 8000,   .rmax = 32000,  .wmin = 512,  .wmax = 1024, },
 	{ .rmin = 44100,  .rmax = 48000,  .wmin = 512,  .wmax = 512, },
 	{ .rmin = 88200,  .rmax = 96000,  .wmin = 256,  .wmax = 256, },
 	{ .rmin = 176400, .rmax = 192000, .wmin = 128,  .wmax = 128, },
-- 
2.17.1

