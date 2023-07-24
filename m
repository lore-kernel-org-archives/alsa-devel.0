Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4432EC001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jul 2023 01:17:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 519C2851;
	Mon, 24 Jul 2023 03:16:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 519C2851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690161449;
	bh=xEpElImn3p8MPYWlbdt3LfPA+Di4BTbGE8mBNTEISDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m4edBkCuERByaRy3UeONaJX/AGfd/2v3Nwz3+2cYKhKld+Bxy4/UrEFnuX1ZOUz2I
	 TVAtAe8+ghUc2XMTNz4oNJjYzHerDhXT5XIgcfpoIvA9WUInfRpDCZnfK3nh/HLJL8
	 BdQKoGHI1gLHFHGI8QIoIyJJlMOHnE0GCxntUU0s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 612D1F805B0; Mon, 24 Jul 2023 03:15:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A97F4F805A0;
	Mon, 24 Jul 2023 03:15:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84238F805A9; Mon, 24 Jul 2023 03:15:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36B44F80551;
	Mon, 24 Jul 2023 03:15:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36B44F80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rxXPT41A
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0430660F05;
	Mon, 24 Jul 2023 01:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C1C433C8;
	Mon, 24 Jul 2023 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690161298;
	bh=xEpElImn3p8MPYWlbdt3LfPA+Di4BTbGE8mBNTEISDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxXPT41AX0Ktf+iAmLIIg2+bglBpkZ0SJwx3T9DxBOGudIzN4TEzTUB//jthdeNSg
	 oeW7AxGc69xOsnpgE7bFOLyoqT3JsBAHKuXeBUX110Iuu1WHvNMG/CVnrdAsUDJ1l7
	 ru4GqEiQSk+EvtQtLwRo9TjIGwTg9vK4f20bqSdeYsT4qvi252VGVMU0c0kzuq1CB3
	 LSyJ1MYV1DJYpggORh4rxI3+vDbBmiJNk48sRh3GMbh51LRO/c3sSFrxLmviSzGM/o
	 Rs0H6QRt+sj02kg+ggOmu3CO1Ej61A+uk5Lg/r62hx6C1rUqbbuySZk8EiLwwcV5kz
	 Y+CJXlnvfVS2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	Vsujithkumar.Reddy@amd.com,
	Vijendar.Mukunda@amd.com,
	AjitKumar.Pandey@amd.com,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 15/58] ASoC: SOF: amd: Add pci revision id check
Date: Sun, 23 Jul 2023 21:12:43 -0400
Message-Id: <20230724011338.2298062-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FKJC6L5H4XB3YNWQ2TJEWTV5PMHQYFIA
X-Message-ID-Hash: FKJC6L5H4XB3YNWQ2TJEWTV5PMHQYFIA
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FKJC6L5H4XB3YNWQ2TJEWTV5PMHQYFIA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit 1d4a84632b90d88316986b05bcdfe715399a33db ]

Add pci revision id check for renoir and rembrandt platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://lore.kernel.org/r/20230523072009.2379198-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.h     | 3 +++
 sound/soc/sof/amd/pci-rmb.c | 3 +++
 sound/soc/sof/amd/pci-rn.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 1c535cc6c3a95..dc624f727aa37 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -55,6 +55,9 @@
 
 #define ACP_DSP_TO_HOST_IRQ			0x04
 
+#define ACP_RN_PCI_ID				0x01
+#define ACP_RMB_PCI_ID				0x6F
+
 #define HOST_BRIDGE_CZN				0x1630
 #define HOST_BRIDGE_RMB				0x14B5
 #define ACP_SHA_STAT				0x8000
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index eaf70ea6e556e..58b3092425f1a 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -65,6 +65,9 @@ static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pc
 {
 	unsigned int flag;
 
+	if (pci->revision != ACP_RMB_PCI_ID)
+		return -ENODEV;
+
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index 4809cb644152b..7409e21ce5aa7 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -65,6 +65,9 @@ static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci
 {
 	unsigned int flag;
 
+	if (pci->revision != ACP_RN_PCI_ID)
+		return -ENODEV;
+
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
-- 
2.39.2

