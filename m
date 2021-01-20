Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24597C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 14:43:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FFB2336E
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 14:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FFB2336E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4580317B5;
	Wed, 20 Jan 2021 15:42:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4580317B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611153807;
	bh=86k/MhCGSrJKkip7llvxzh7qujn8rsp+6Wwt4jyxvDQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j5PebTq0gh/F/XfE57idAy+7yzULJOR6CKJvnjAt2zIPu98XtmJqKTlFuuMeRNjyW
	 KCtuqH2qztrk/Kd5VZTfAhJxBRxQLk/yhCVSyrZGte/8749OrQr/Teb15bs3mzKDzP
	 29JB6Mcn0HCjpIXKNLg55ECo9PYZflXzor1hTeVY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2FFAF8012C;
	Wed, 20 Jan 2021 15:42:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 436BAF8016E; Wed, 20 Jan 2021 15:42:34 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAEA2F8012C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 15:42:29 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BBB97A0046;
 Wed, 20 Jan 2021 15:42:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BBB97A0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1611153748; bh=5+CO6EYjJLO0X0s5gywNEhBjjj1gJ/sEzV50VqcgNQE=;
 h=From:To:Cc:Subject:Date:From;
 b=JwVlomU0CThUMYXMboRh9BSo7EA4t67TBUB4/fwoKY3D3SW1pFKKIgjXMK5VBdckM
 lzC31zG34p7Bm2+A6EpStz8hbB/XXa0mdD3wLeXPZDMoAYHd808Nw0JRMAndyynJPS
 ZnjV310D1Bay56TYR4ySKaMgg4m1GfV3DolM8DCg=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 20 Jan 2021 15:42:23 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: AMD Renoir - refine DMI entries for some Lenovo products
Date: Wed, 20 Jan 2021 15:42:11 +0100
Message-Id: <20210120144211.817937-1-perex@perex.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 stable@kernel.org
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

Apparently, the DMI board name LNVNB161216 is also used also
for products with the digital microphones connected to the AMD's
audio bridge. Refine the DMI table - use product name identifiers
extracted from https://bugzilla.redhat.com/show_bug.cgi?id=1892115 .

The report for Lenovo Yoga Slim 7 14ARE05 (82A2) is in buglink.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=211299
Cc: <stable@kernel.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index deca8c7a0e87..050a61fe9693 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -165,10 +165,24 @@ static int rn_acp_deinit(void __iomem *acp_base)
 
 static const struct dmi_system_id rn_acp_quirk_table[] = {
 	{
-		/* Lenovo IdeaPad Flex 5 14ARE05, IdeaPad 5 15ARE05 */
+		/* Lenovo IdeaPad S340-14API */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "81NB"),
+		}
+	},
+	{
+		/* Lenovo IdeaPad Flex 5 14ARE05 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "81X2"),
+		}
+	},
+	{
+		/* Lenovo IdeaPad 5 15ARE05 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "81YQ"),
 		}
 	},
 	{
-- 
2.29.2
