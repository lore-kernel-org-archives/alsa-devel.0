Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93630ECE582
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:23:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09AAFB65;
	Tue, 10 Sep 2024 19:23:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09AAFB65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725989020;
	bh=NeZBarf5sytU+4tlKJN+FOzynrWMMCnZ2J23Xvo9Q78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C6hs0P5Vd59uTw51hDXDBefdLD/oGtgzu1f2lD+3SbhL7ity0Fbuc04QpEEy7kprt
	 xThK4KQZrfADaWdpshDFjJDjDmBz4eB+yFVvCe4tqeulC5TinKac5XA5iqxBla9O26
	 jawwF0f4VSTizHo1g8p5XaHsAGkod1NPMhPADQ9s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0FFAF805BA; Tue, 10 Sep 2024 19:23:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE54FF805A0;
	Tue, 10 Sep 2024 19:23:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5D14F801F5; Tue, 10 Sep 2024 19:23:11 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 905F6F800E9
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2024 19:23:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 905F6F800E9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MRkUVtxe
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DAE41A44AFD;
	Tue, 10 Sep 2024 17:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B68C4CED8;
	Tue, 10 Sep 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988987;
	bh=NeZBarf5sytU+4tlKJN+FOzynrWMMCnZ2J23Xvo9Q78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRkUVtxeRyALDpbPc2ifVh0Wi/8aLUyursPkWikvmLBc/pKlH2t8mPUqli8XoZB0C
	 vTZQ2N4Tc27TFYlD3/3X5lTYeBKzlNzwHZ+zvdaiU0dNcbtAEGPv5O/P1WzJ5ossC9
	 C8R3Mlh/6GAdSKD4Va4VYsov/Vw2ICjqpgZ5IK58KfDZFo8aDjF32ok+SnCw8+OsuA
	 b57Leda+TbXRlVbBiP1Yk0VF6WUVMGYhMJqswWXM241nxLFAmTfR9MnlXBsVSMYLwq
	 t99X1xgUCmAZX6wpV8hNphx64mGjMx88hB0H66y+500ml61YqqyY39OBrHbATLzUtf
	 FfdCwLIjsZayg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/12] ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga
 Tab 3 X90F DMI match less strict
Date: Tue, 10 Sep 2024 13:22:44 -0400
Message-ID: <20240910172301.2415973-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AYIIJBMQQ2L7ZW3SMDAGYDAAAXAHIXT7
X-Message-ID-Hash: AYIIJBMQQ2L7ZW3SMDAGYDAAAXAHIXT7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AYIIJBMQQ2L7ZW3SMDAGYDAAAXAHIXT7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 839a4ec06f75cec8fec2cc5fc14e921d0c3f7369 ]

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://patch.msgid.link/20240823074305.16873-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-cht-match.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 5e2ec60e2954..e4c3492a0c28 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -84,7 +84,6 @@ static const struct dmi_system_id lenovo_yoga_tab3_x90[] = {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90, codec missing from DSDT */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
-- 
2.43.0

