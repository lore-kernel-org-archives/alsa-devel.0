Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FAC5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:44:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A850210D;
	Mon, 11 Mar 2024 19:44:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A850210D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182687;
	bh=sL2RKPUz7dDRVOIkRhMDv4+bFxzDPiGYLyueB87xlFU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=scX3QoXxSCfteCL3ldNYzilu0BtWJROq6srNO4oiKwdXBEwvfY1V++HYlG7tYyYvx
	 cub0DGQL8h1wa2W8yHNJF62kzMUh1GCR5XmHt549Q/GOanb5RJE8nsJTPuSvVmWYTG
	 IoCQWn9ENREsYOebiwU0bY6QT4UmDxluR3/b+jkY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 907BCF89623; Mon, 11 Mar 2024 19:40:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1D99F80CC2;
	Mon, 11 Mar 2024 19:40:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A35C6F806BD; Mon, 11 Mar 2024 19:40:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2A420F80C7C
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:39:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A420F80C7C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VNekEMJg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D291660BCB;
	Mon, 11 Mar 2024 18:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DAC433F1;
	Mon, 11 Mar 2024 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182397;
	bh=sL2RKPUz7dDRVOIkRhMDv4+bFxzDPiGYLyueB87xlFU=;
	h=From:To:Cc:Subject:Date:From;
	b=VNekEMJgsIzaGGhDfTMUZ3ht8Dy72I/6h4Hb2LF157qRgdMxT+avM/wYRupEuRNlZ
	 TXEry4vdtls1HCIUv+hWcoWXeVpRHA06FnWq+ppY94VjGjLawuoojcGJOb6y2JoG5u
	 I+18x8oa1U2YvMmqCEHwTS0vPC4mRxA2Y/FSVWCswvrCp9pQgXvb5sXpRdbYvXqpEI
	 geBzFE/YRN6Hee4f65pOpYU402LvJ24V7kqpVGY3XUOH2AjP09aOIVeG20AzucysPl
	 saanJPJ06BlTStuKv3CbqFMhLWY4RBctqyaADKo9dEvpzb3RMXN1P9smiLPWuGFSpm
	 Le3FVhm1s2pBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	liam.r.girdwood@linux.intel.com,
	yang.jie@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	hdegoede@redhat.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 1/5] ASoC: Intel: bytcr_rt5640: Add an extra entry
 for the Chuwi Vi8 tablet
Date: Mon, 11 Mar 2024 14:39:45 -0400
Message-ID: <20240311183950.329120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UTOQLPQNHURGYEBLQ3SFKBT4SHT5MEQW
X-Message-ID-Hash: UTOQLPQNHURGYEBLQ3SFKBT4SHT5MEQW
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UTOQLPQNHURGYEBLQ3SFKBT4SHT5MEQW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Alban Boyé <alban.boye@protonmail.com>

[ Upstream commit f8b0127aca8c60826e7354e504a12d4a46b1c3bb ]

The bios version can differ depending if it is a dual-boot variant of the tablet.
Therefore another DMI match is required.

Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240228192807.15130-1-alban.boye@protonmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index df3b370fe7292..c740dec00f83b 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -526,6 +526,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Chuwi Vi8 dual-boot (CWI506) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+			/* The above are too generic, also match BIOS info */
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		/* Chuwi Vi10 (CWI505) */
 		.matches = {
-- 
2.43.0

