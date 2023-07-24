Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF5FC001DC
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jul 2023 01:17:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C60E9820;
	Mon, 24 Jul 2023 03:16:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C60E9820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690161462;
	bh=U1z3VtG0pGPvExFdvOAtlP5ooExECdMsVdDb35dBOsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IwLDYQBJvBOYHtrZydWIed5iBG0aliQX3rOkLuTrELrKdsilyDP3FiuXfw/H+YNha
	 VURSnAc42/m8kFHS1KjTCLTbvm57I46sOjnqWL1C2UcBXHsIFWst4HnDGfPzaYro8o
	 i0egK1a/w/JRALt1CSPUHdKksD1d80pP0qm74C9c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB914F805B4; Mon, 24 Jul 2023 03:15:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0824EF805B6;
	Mon, 24 Jul 2023 03:15:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B5EBF805A8; Mon, 24 Jul 2023 03:15:17 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C87DF805A1
	for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2023 03:15:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C87DF805A1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Xn3DDn/C
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ABAD660F0C;
	Mon, 24 Jul 2023 01:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC69C433C8;
	Mon, 24 Jul 2023 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690161308;
	bh=U1z3VtG0pGPvExFdvOAtlP5ooExECdMsVdDb35dBOsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xn3DDn/Caje5nwwGD7glM8v4wnJVReHguZQXHjCp+xXniTaIGleLoO8IetAYChgl2
	 D13LW4/H9SoGPNwc4ReX4JGlFBu1DAfIsrE7forGTZFd2pPYzG02K3a7sBOX3AU5ug
	 NELPmb+91VFAHFiZwH+lvYuQS3wVG1hDG1UDS9JsfD1WtyK0eiWL0jWhCKkTzCUmIM
	 rsofGCL+hXarbaq4qIIQaw2QoUE/vl0eoQLMZBSL+DCW2zqZHY3owrVyNKZ+LKtsLj
	 DDb7UDh9MnAWJZh3xvsbkha1VbmNOOmDqlkRoxxZfXSCL5CIxtlGJpBdRWlFzDPjP5
	 nhlXKDfE5tUaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 19/58] ASoC: amd: vangogh: Add check for acp
 config flags in vangogh platform
Date: Sun, 23 Jul 2023 21:12:47 -0400
Message-Id: <20230724011338.2298062-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NM6XONKQBECXCSMS7CHYCHWR4SBVMJ2Y
X-Message-ID-Hash: NM6XONKQBECXCSMS7CHYCHWR4SBVMJ2Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NM6XONKQBECXCSMS7CHYCHWR4SBVMJ2Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit e89f45edb747ed88e97a5771dd6d3dd1eb517873 ]

We have SOF and generic ACP support enabled for Vangogh platform
on some machines. Since we have same PCI id used for probing,
add check for machine configuration flag to avoid conflict with
newer pci drivers. Such machine flag has been initialized via
dmi match on few Vangogh based machines. If no flag is
specified probe and register older platform device.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://lore.kernel.org/r/20230530110802.674939-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/vangogh/acp5x.h     | 2 ++
 sound/soc/amd/vangogh/pci-acp5x.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index bd9f1c5684d17..ac1936a8c43ff 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -147,6 +147,8 @@ static inline void acp_writel(u32 val, void __iomem *base_addr)
 	writel(val, base_addr - ACP5x_PHY_BASE_ADDRESS);
 }
 
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
 static inline u64 acp_get_byte_count(struct i2s_stream_instance *rtd,
 				     int direction)
 {
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index e0df17c88e8e0..c4634a8a17cdc 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -125,10 +125,15 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 {
 	struct acp5x_dev_data *adata;
 	struct platform_device_info pdevinfo[ACP5x_DEVS];
-	unsigned int irqflags;
+	unsigned int irqflags, flag;
 	int ret, i;
 	u32 addr, val;
 
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	irqflags = IRQF_SHARED;
 	if (pci->revision != 0x50)
 		return -ENODEV;
-- 
2.39.2

