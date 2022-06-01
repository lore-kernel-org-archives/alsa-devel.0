Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4C9CCA468
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jun 2022 13:53:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32FD1170B;
	Wed,  1 Jun 2022 15:52:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32FD1170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654091607;
	bh=ysGPMCEE6zTrrAwWhMonkdrC5EuSx87LJP4/nYS+s1I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RLrWjjNr7eUE3uvZ2nEpWydwEcRg3SLO2cfcp1SV2E8kup+LVSb7F3bMJTbQyd3ge
	 xrCnOKIzsTmprTZzte/xiq6tjDQJGICJwrY3n8eL9pU7TA375gp0sNzhJFuF/1pyFr
	 2D84mppVIrqpX4cwTB6tdTkz8ggW3pZP7al6lB0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BADFEF80089;
	Wed,  1 Jun 2022 15:52:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17E02F8019B; Wed,  1 Jun 2022 15:52:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81B8FF80089
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2022 15:52:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81B8FF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SY4xLlgw"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 248E8615BF;
 Wed,  1 Jun 2022 13:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E7C385A5;
 Wed,  1 Jun 2022 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654091550;
 bh=ysGPMCEE6zTrrAwWhMonkdrC5EuSx87LJP4/nYS+s1I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SY4xLlgwdKS1BYyhrIPkkk3tfdAYRB8+khQCVCQR/8NGqJa1y+g6zTw8iwN7KfHkt
 dor9ROPxn+gC41ux6gj6b5SbTok9vmvDIxf3woPopYpsEuF4YivCT42veeVokVclP/
 0YYiBGORwMAYcMujIK0dqSF4W1IBA71HbdVHWYhykyk24jg4N5sRqTlDMBWQQToDOB
 EvRnZvPQ4GFK6vJdhoK+RSNGO0mp9pwE72T27LKJ5wi6uQllJyv5OTUdhyDJARbq//
 5hfZ1qCuR32xzTCeCEOJ870C3GnsnLCqVhMfSGSkitgqnucPDB1zCK7SFotlpMnfXY
 aamniYLNElBOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 06/49] ASoC: amd: Add driver data to acp6x
 machine driver
Date: Wed,  1 Jun 2022 09:51:30 -0400
Message-Id: <20220601135214.2002647-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220601135214.2002647-1-sashal@kernel.org>
References: <20220601135214.2002647-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.com, Mark Brown <broonie@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Vijendar.Mukunda@amd.com
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit e521f087780d07731e8c950f2f34d08358c86bc9 ]

Currently all of the quirked systems use the same card and so the
DMI quirk list doesn't contain driver data.

Add driver data to these quirks and then check the data was present
or not.  This will allow potentially setting quirks for systems with
faulty firmware that claims to have a DMIC but doesn't really.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20220411134532.13538-2-mario.limonciello@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 9a767f47b89f..959b70e8baf2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,108 +45,126 @@ static struct snd_soc_card acp6x_card = {
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CF"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CG"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CQ"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21AW"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21AX"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21BN"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21BQ"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CH"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CJ"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CK"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D8"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D9"),
@@ -157,18 +175,21 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 
 static int acp6x_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct acp6x_pdm *machine = NULL;
 	struct snd_soc_card *card;
 	int ret;
-	const struct dmi_system_id *dmi_id;
 
+	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
-	if (!dmi_id)
+	if (dmi_id)
+		platform_set_drvdata(pdev, dmi_id->driver_data);
+
+	card = platform_get_drvdata(pdev);
+	if (!card)
 		return -ENODEV;
-	card = &acp6x_card;
 	acp6x_card.dev = &pdev->dev;
 
-	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-- 
2.35.1

