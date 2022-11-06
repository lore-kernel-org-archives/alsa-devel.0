Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9BFC433FE
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Nov 2022 17:08:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35E741EF;
	Sun,  6 Nov 2022 18:07:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35E741EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667754504;
	bh=Xr2JnALXiCEHV6yOKw+uqHFWEolwa49PFgHJkuLuG2o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HteHZqeTTKFR5pWNEi9KR+fbHQ7raEvmnLEr9CBPP2Cf1AOxyN17yaKDnQCF37Ut3
	 IKBmAaB6y0KCKvhSYnwiqR98Oya9Q3bnD/X6/3sraxYekpm6fJnI3THBcHdL6c/0C+
	 dLHLIss8vfEXTCvgYqu1xt5XorVBHU+N46S9I36g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAFE5F805C5;
	Sun,  6 Nov 2022 18:04:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4AFEF805C6; Sun,  6 Nov 2022 18:04:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9B49F805B3
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2022 18:04:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9B49F805B3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BWI8eJQQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9761160BFF;
 Sun,  6 Nov 2022 17:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BE0C433C1;
 Sun,  6 Nov 2022 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667754276;
 bh=Xr2JnALXiCEHV6yOKw+uqHFWEolwa49PFgHJkuLuG2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BWI8eJQQeGwJYHLP1B+eFcC+b390JI55HpfagH8/5w395HWj7Oj0smCdJrFnIYii6
 LN6+0AQ3FqMfiKK4v28/dshUu0Js4q5vLzBbMVZRUX9wUZedTClE/hTZ6uZo9zpeLc
 ZuCiu3zV3Svp1blFTNposFR0sQycnTep6c3NZHtjSjW7t28Yd7Hf/8whwtZppw/zha
 rcgoweOxFZYEO1bioKQG+xrO8+/+F3kx+mv4b0a41Xtu3Yznl+tqnJQEdFHYlk3ubR
 vGX2FdtinvtdHXbFTz1gNQoeLQOTQVQYJ5bE33nv+1+gdOvZQiODUWGWqfL3jats93
 KRyrVbc3ifHFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 22/30] ASoC: amd: yc: Adding Lenovo ThinkBook 14
 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Date: Sun,  6 Nov 2022 12:03:34 -0500
Message-Id: <20221106170345.1579893-22-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221106170345.1579893-1-sashal@kernel.org>
References: <20221106170345.1579893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, linkt <xazrael@hotmail.com>,
 Syed.SabaKareem@amd.com
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

From: linkt <xazrael@hotmail.com>

[ Upstream commit a450b5c8739248069e11f72129fca61a56125577 ]

Lenovo ThinkBook 14 Gen 4+ ARA and ThinkBook 16 Gen 4+ ARA
need to be added to the list of quirks for the microphone to work properly.

Signed-off-by: linkt <xazrael@hotmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2cb50d5cf1a9..09a8aceff22f 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,20 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D0"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D1"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.35.1

