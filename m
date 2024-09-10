Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FEBECE582
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:24:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3911210;
	Tue, 10 Sep 2024 19:23:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3911210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725989039;
	bh=9aQZ6bj0xYFaHsiENf5jNVgAkdUDB+cDSygiosOo0Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I1yR5SYcOAI0z5hLVFSr/Xmr+b16Lr+xdeoQCvhOrUNta79v/FdQ74h4zkp20QJKy
	 hYm4durIs/mSv+8Q4djhv6yCTcyP2Qfqb7TuWe+HyhjAVUJBmUntj85C3WQur3xGOA
	 OelK1LX5hxcQocmFUo5qnBvCnCF4tdeRNXnahxTA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7412AF805F0; Tue, 10 Sep 2024 19:23:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E16D8F805F4;
	Tue, 10 Sep 2024 19:23:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2A03F801F5; Tue, 10 Sep 2024 19:23:13 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 149F0F800E9
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2024 19:23:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 149F0F800E9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mDzJZ6tx
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DB80CA44AEA;
	Tue, 10 Sep 2024 17:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AAFC4CEC4;
	Tue, 10 Sep 2024 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988990;
	bh=9aQZ6bj0xYFaHsiENf5jNVgAkdUDB+cDSygiosOo0Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDzJZ6txyI0hXZ84xmtXsZNbEdBYepOuKEEYyzhpY8j9yHSizFtBYiuWtlQRprPLJ
	 /FYJX66lYN2E50jTSKzqnIEq4LxfpPq8u7NsZjJ4jftk8lBwRZhDq4A9meCK0binAl
	 UaWTR+t9L9tWb8cPEjPmgDycP+lCEj6ClO6/PityyyJM//xYftj4vycf/sDOvtb2uW
	 5GfqFIgX8e3u5QJ7pAEFS+tQfUK5OSpM+/gG5aoIqT6Cvu7wUXcq5R61SRoofvoGGa
	 4NOqPTNZJdF9iFpmNxVG7qDco8731T1UqEMfWVV+g5bBgpFqc5qdxssypwpVjgVp1N
	 XPTzBvfZXGFeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	robh@kernel.org,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/12] ASoC: intel: fix module autoloading
Date: Tue, 10 Sep 2024 13:22:45 -0400
Message-ID: <20240910172301.2415973-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SAGTZQ4LMW26JR7YK43RI22OQJK2JE7Y
X-Message-ID-Hash: SAGTZQ4LMW26JR7YK43RI22OQJK2JE7Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SAGTZQ4LMW26JR7YK43RI22OQJK2JE7Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit ae61a3391088d29aa8605c9f2db84295ab993a49 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-2-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/keembay/kmb_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 6b06b7b5ede8..ffe558ef4922 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -815,6 +815,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
-- 
2.43.0

