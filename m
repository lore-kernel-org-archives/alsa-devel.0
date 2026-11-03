Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1F606A336
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=dCyncqyh;
	dkim=pass (1024-bit key, unprotected) header.d=senarytech.com header.i=@senarytech.com header.a=rsa-sha256 header.s=default header.b=f2wG4d2x
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 490986025A;
	Tue,  3 Nov 2026 08:59:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 490986025A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793692759;
	bh=LkxtfK4rd5fOeIucnpzq+F58CLFY3KpfkgjiahXdSyI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dCyncqyhdoRd9zUjFMaY7Tix47V4reMgGXEoZE/EbIa9zrwAqKWUGiK5B04Ubt0Ps
	 2YnuX6Emw/6v6hDmAqLUa20r4hRTyv7x4FTUoNLdZhCKRfuA3HhBK+pDd/IvIn3e1w
	 PnpoJsqSLQxmHOXXS3gebkypEU/uKLqk1RVgopwE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 483C9F80642; Tue,  3 Nov 2026 08:58:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4AD1F8065E;
	Tue,  3 Nov 2026 08:58:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C6BDFF804CF; Tue,  3 Nov 2026 07:41:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=115.236.127.78
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793688095;
	b=WOk/uOt/Q+u7VILyL3/SNZi/FX2UltLhIg/9JxRO4t7fhBLg4p4TJe5CpUgTzKH/MXtu
	 xn84xUS8rklf+oTJYDRaUkwMJ7koaYLVAejWchSarfmrxvN+v7SF0gyUllN/YHvSaZlon
	 uG7e2wTFVfVHrUgVmyu2c1cPGMcoImiLiaI2TaQxNh+svPMJ8T69Oz8fzOQLivMoGbz9e
	 SG2Of/WisWia7WGekQ94pqQUGsnx86EW6vH3SFHOMUqFV2anUW0dekep/qPpDWkVXF+Gp
	 tfy+xGGWlIb/6tnD3gL07tNfW565RamU0SBiFvXc5pLS1SrhWIkQ5De55PcoDTrDohw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793688095;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature;
	bh=LkxtfK4rd5fOeIucnpzq+F58CLFY3KpfkgjiahXdSyI=;
	b=WHem8BcHgaXAYIB51uvxB6JZbct5j5odoyBEnkvydTDkAwWu2F0y6qKgIcggZ+THZg93
	 BiccOcvg1Spnhlh9Q/G+KODzttVnHvWl7fWWMDbGP6ovJml/kIp/3cqTgUg22Q/dJ4kGp
	 LRHjfw5WDbkJT0GqZUI7L95rLmKqB87XWvv1aUMHYt+u3LSOrvMqEAJsi9t+qmFeHfSjK
	 W950jLTxv09ZOCrdqPle0AYo2B46GpsEBLtFCtBnV0xUK6lxgeDHDyrY2WVo36mub5egg
	 Ixexh6PR68DLuKit8nuwije8WhtWCueZODgwPLiseZ4goolscc15QhD9j5H7zFfunFg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=senarytech.com header.i=@senarytech.com
 header.a=rsa-sha256 header.s=default header.b=f2wG4d2x;
	arc=none smtp.remote-ip=115.236.127.78
Received: from mail-m12778.qiye.163.com (mail-m12778.qiye.163.com
 [115.236.127.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C4790F80100
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 07:41:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4790F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=senarytech.com header.i=@senarytech.com
 header.a=rsa-sha256 header.s=default header.b=f2wG4d2x
Received: from Wangqianghua.localdomain (unknown [27.38.136.171])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534b0d0c1;
	Tue, 3 Nov 2026 14:41:22 +0800 (GMT+08:00)
From: Qianghua Wang <qianghua.wang@senarytech.com>
To: linux-sound@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	Qianghua Wang <qianghua.wang@senarytech.com>
Subject: [PATCH] ASoC: Intel: soc-acpi: use dummy topology for SN624x
Date: Tue,  3 Nov 2026 14:41:22 +0800
Message-ID: <20261103064123.115057-1-qianghua.wang@senarytech.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a02418d509d8kunmfda58cfb30caff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkgYVkpMQkpLQ0xNSRpDTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJTFVIQ1VKSE1VSkxKWVdZFhoPEhUdFFlBWUtVS1VLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=f2wG4d2xNar2tRML1bj8EYhaJN2zjDU4tdbUZMxDv9/paWsDiIh0pq1qWuLIsMBlZtz0ntMRignCxk3wzS7rDxbLD6RUIHiWigrUu/m2nRgIRcCM0Fm7J6svbtIBJ2s1ueF6tk4ttKKTmgUK/1ARdjEba0nzt3qYwdZslqJH2NQ=;
 s=default; c=relaxed/relaxed; d=senarytech.com; v=1;
	bh=fTgSatG4MvjMsRT9jq0XYpI+3FtgBlqcdEho8ORyYa4=;
	h=date:mime-version:subject:message-id:from;
X-MailFrom: qianghua.wang@senarytech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: J6LQMA654GTHNHYHSHGODMTEHNCLNDGO
X-Message-ID-Hash: J6LQMA654GTHNHYHSHGODMTEHNCLNDGO
X-Mailman-Approved-At: Tue, 03 Nov 2026 07:58:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J6LQMA654GTHNHYHSHGODMTEHNCLNDGO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The SN624x SoundWire entries in the MTL, ARL, LNL and PTL match tables
point at sof-<platform>-sn624x.tplg. Those monolithic topologies are not
shipped in sof-bin, so the SOF probe fails with a missing topology on
any system that does not carry the out-of-tree files.

The SN624x jack, amp and mic DAIs map onto the generic SDCA function
topologies (sof-sdca-jack, sof-sdca-1amp, sof-sdca-mic) and the HDMI
fragments. Use sof-<platform>-dummy.tplg so the card is always built
from function topologies and no monolithic topology is needed.

Tested on a Wildcat Lake (PTL match table) laptop with SN6244, with
sof-ptl-sn624x.tplg removed: the card probes with sof-sdca-jack-id0,
sof-sdca-1amp-id2, sof-sdca-mic-id4 and sof-hdmi-pcm5-id5. Speaker,
headset, DMIC and HDMI playback/capture work.

Fixes: 32f9c551a91a ("ASoC: Intel: soc-acpi: add SN624x entries for ARL/LNL/MTL/PTL")
Link: https://github.com/thesofproject/sof/issues/11167
Link: https://github.com/thesofproject/linux/issues/6002
Signed-off-by: Qianghua Wang <qianghua.wang@senarytech.com>
---
 sound/soc/intel/common/soc-acpi-intel-arl-match.c | 4 ++--
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c | 4 ++--
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 4 ++--
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-arl-match.c b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
index 310c4b77c..1d5f6677b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-arl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
@@ -769,14 +769,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_sdw_machines[] = {
 		.link_mask = BIT(0),
 		.links = arl_link_sn6242,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-arl-sn624x.tplg",
+		.sof_tplg_filename = "sof-arl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
 		.links = arl_link_sn6244,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-arl-sn624x.tplg",
+		.sof_tplg_filename = "sof-arl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{},
diff --git a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
index cbf79eb2e..a9fef394f 100644
--- a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
@@ -867,14 +867,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[] = {
 		.link_mask = BIT(0),
 		.links = lnl_link_sn6242,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-lnl-sn624x.tplg",
+		.sof_tplg_filename = "sof-lnl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
 		.links = lnl_link_sn6244,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-lnl-sn624x.tplg",
+		.sof_tplg_filename = "sof-lnl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{},
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index e89c5cfd6..704b4e0d2 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -1564,14 +1564,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[] = {
 		.link_mask = BIT(0),
 		.links = mtl_link_sn6242,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-mtl-sn624x.tplg",
+		.sof_tplg_filename = "sof-mtl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
 		.links = mtl_link_sn6244,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-mtl-sn624x.tplg",
+		.sof_tplg_filename = "sof-mtl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{},
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index 0ce51c44b..a5896796a 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -599,21 +599,21 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.link_mask = BIT(3),
 		.links = ptl_link_sn6242,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-ptl-sn624x.tplg",
+		.sof_tplg_filename = "sof-ptl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(3),
 		.links = ptl_link_sn6244,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-ptl-sn624x.tplg",
+		.sof_tplg_filename = "sof-ptl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(3),
 		.links = ptl_link_sn6247,
 		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-ptl-sn624x.tplg",
+		.sof_tplg_filename = "sof-ptl-dummy.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{},
-- 
2.53.0

