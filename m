Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90103C77B72
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 11:04:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E1BBEED;
	Thu, 20 Apr 2023 13:03:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E1BBEED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681988655;
	bh=d0X3yg7haQvgsR2Vxh0jBkmYqiZKufzWZYdFlrBGUqM=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o7AIS2qUTliC2gt7E2ifGi7I+F9nsjO08KmhVMOcoWouc5iIVWwdhtqN6TAzLKDrz
	 X4o3WiIFm0O/kZv0HogrBVmXLDsAFqjWnOgmuL/yfQ0UemPrqmm0ce68C4HMAhM5jR
	 SAVLjuVavnFYsVYrFNifcXTUJqj3jdLxPtmosKxQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B887F80542;
	Thu, 20 Apr 2023 13:02:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 209DBF8052E; Thu, 20 Apr 2023 13:02:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4CBE1F80149
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 13:02:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CBE1F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ezVcqUeS
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 27475647C7;
	Thu, 20 Apr 2023 11:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB23EC4339E;
	Thu, 20 Apr 2023 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681988523;
	bh=d0X3yg7haQvgsR2Vxh0jBkmYqiZKufzWZYdFlrBGUqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezVcqUeSR9dSgjLSw0n3Eyt5elJqr6yOtX3KDYBdWsoxx6c7UgQxRdoH0uNeQuNkA
	 JRHzvXIUC7tzi6UqVlqsK5nZ7QkIQ/ZFy++V/reMU498Bf0NZyPnd2ChmboL6X0cF0
	 N1Rh92yHxRsrSMigJwrBb7rsq0RpNJI2kE3YGqv+oKrp8Cog06VJKlys3garPYtpJr
	 wtF5avOnOYI+VhlGckmNwgCHfCv35pHQVHz9gcnRs/IyKmEfWqH0Yjrrv59d1FLcBG
	 tOwSGzRQvI3jBseeY2n39Iz0xnTVHkcj3W9z0ErK/0LyqVkeUI8lTw+oQc7ezq6hUV
	 vzhlz+OzBtcnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 05/17] ASoC: amd: yc: Add DMI entries to support
 Victus by HP Laptop 16-e1xxx (8A22)
Date: Thu, 20 Apr 2023 07:01:34 -0400
Message-Id: <20230420110148.505779-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420110148.505779-1-sashal@kernel.org>
References: <20230420110148.505779-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JW6YFLIL4HLZFSI7C77TQ2PCNUTOQ5BB
X-Message-ID-Hash: JW6YFLIL4HLZFSI7C77TQ2PCNUTOQ5BB
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Ge-org Brohammer <gbrohammer@outlook.com>,
 Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
 lgirdwood@gmail.com, tiwai@suse.com, mario.limonciello@amd.com,
 Syed.SabaKareem@amd.com, lxy.lixiaoyan@gmail.com, fengwk94@gmail.com,
 leohearts@leohearts.com, mendiebm@gmail.com, aniol@aniolmarti.cat,
 wimvanboven@gmail.com, xazrael@hotmail.com, dukzcry@ya.ru,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JW6YFLIL4HLZFSI7C77TQ2PCNUTOQ5BB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ge-org Brohammer <gbrohammer@outlook.com>

[ Upstream commit 205efd4619b860404ebb5882e5a119eb3b3b3716 ]

This model requires an additional detection quirk to
enable the internal microphone.

Tried to use git send-email this time.

Signed-off-by: Ge-org Brohammer <gbrohammer@outlook.com>
Link: https://lore.kernel.org/r/PAVP195MB2261322C220E95D7F4B2732ADABC9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4a69ce702360c..0acdf0156f075 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -269,6 +269,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A43"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
+		}
+	},
 	{}
 };
 
-- 
2.39.2

