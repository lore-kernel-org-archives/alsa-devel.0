Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A65C77B73
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Apr 2023 02:39:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFA22F6F;
	Thu, 13 Apr 2023 04:38:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFA22F6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681353581;
	bh=V38LfrFY2SLpHVHDJ43NpZ8FgQwpzlAV8uCds+Dx+lw=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dt9wZ3RKUuvius83Hh7KTjZUHxPI+OdWJAKtYBYA0f95WPJagt302MMg/l9/4pWzX
	 juxZ18kSUHhMJf7Ko/e9D2oJ52g+5SFxt1EIQ34RAgdDM/ubvRWdtJXxNy4RzRQoho
	 6qOiDH/pgL8227QnvjuWwPS3Jz+pWjBK/378vxJI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA06EF80579;
	Thu, 13 Apr 2023 04:37:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6C1EF8056F; Thu, 13 Apr 2023 04:36:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 471E8F80567
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2023 04:36:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 471E8F80567
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VIRGrAa0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 26C4563A64;
	Thu, 13 Apr 2023 02:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A3EC433EF;
	Thu, 13 Apr 2023 02:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681353410;
	bh=V38LfrFY2SLpHVHDJ43NpZ8FgQwpzlAV8uCds+Dx+lw=;
	h=From:To:Cc:Subject:Date:From;
	b=VIRGrAa0Qrjr3PVLsoHQ65ABX6Cp3+b0iB43h83+DUFjUjFJ+4LqyPtS1YU32H53i
	 O3ys4pNzohQRqUlovvaIEo7PdNKWwSz46s55OhHAk7lLF+uwUvbfuoXdri/K6YSo9H
	 e+VZKKiIlNT+Re/79Tu5lopgtNpRfqGM+B+WzCxuhKaJLhMGOu2olj//MU7abaDQCm
	 Xv0MKIxtZ1nH/5bt6myPTfq6BO+NlJczuTQT/W7ikdZvzHhufnCgT3i+OxBne0FIk9
	 sFe53mTINr9mNLeBrmMJ8f3Bzizp4Lyytt9nkVuRqfCgAr8WvJ+AFdTY+xnVNIbd0X
	 hBgYZvaCIWE8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/17] ASOC: Intel: sof_sdw: add quirk for Intel
 'Rooks County' NUC M15
Date: Wed, 12 Apr 2023 22:36:29 -0400
Message-Id: <20230413023647.74661-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: I3MARQW3S2P7AMHCXKFMSKZQ7WSYPNHT
X-Message-ID-Hash: I3MARQW3S2P7AMHCXKFMSKZQ7WSYPNHT
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Eugene Huang <eugene.huang99@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
 liam.r.girdwood@linux.intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, tiwai@suse.com, gongjun.song@intel.com,
 shumingf@realtek.com, yong.zhi@intel.com, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I3MARQW3S2P7AMHCXKFMSKZQ7WSYPNHT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Eugene Huang <eugene.huang99@gmail.com>

[ Upstream commit 3c728b1bc5b99c5275ac5c7788ef814c0e51ef54 ]

Same quirks as the 'Bishop County' NUC M15, except the rt711 is in the
'JD2 100K' jack detection mode.

Link: https://github.com/thesofproject/linux/issues/4088
Signed-off-by: Eugene Huang <eugene.huang99@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230314090553.498664-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index ee9857dc3135d..d4f92bb5e29f8 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -213,6 +213,17 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_SDW_PCH_DMIC |
 					RT711_JD1),
 	},
+	{
+		/* NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_SDW_PCH_DMIC |
+					RT711_JD2_100K),
+	},
 	/* TigerLake-SDCA devices */
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.39.2

