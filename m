Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E6C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 14:54:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FC2A2139;
	Tue, 30 Nov 2021 15:53:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FC2A2139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638284044;
	bh=gaLHEZOmGrFT2whpn0ScRYWbeNzDqi8Z4Q8Px2n88DE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7zyHiy/6TzH9mtf1FVc8aU2kpc5v9e9EnAZiYbDN17uY1ivMuxj1MCdskbjW5Jfy
	 nC1j9B1kjwVyHrNq8sMy1iVErt3bz771abmMocqt89m3oD+uY613jqYLfHHTlv5WkG
	 6sNeJq7Q/FecVTLZn78tcxtEetpRu7lENZypkcKI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A60CF804AD;
	Tue, 30 Nov 2021 15:50:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A3F3F804AD; Tue, 30 Nov 2021 15:50:36 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EFF1F802C4
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 15:50:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EFF1F802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UOFC5uPQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DD932B81A4A;
 Tue, 30 Nov 2021 14:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5559C53FCF;
 Tue, 30 Nov 2021 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283828;
 bh=gaLHEZOmGrFT2whpn0ScRYWbeNzDqi8Z4Q8Px2n88DE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UOFC5uPQvQvgY4pCkxbuVz3nVqxmOmzDO0LVs0gboUAxziUqPkoavLxipY6vM6bPM
 ZTyh8ZgJUT75pvNw03LwgLVTwFaBxsYb1P5isr1wWWEmD5tPrsKhdlD3YU7XbKBryW
 icSZF8x/Xmqwl2sWQX8vOIkuQs8N1fXwwlRIvADBSkqT+YVldsoM18xgAY3QAU+pmR
 0a3FmmRQLUk4iUrqBmIb22Td2qRhi7qiZGbaY86UHaVc4KDS4k3LoiSH5b2Rag1P2Q
 4GNH5vb8boGQhBGCgEtxcDQGuMsvKAKVkBzCxq7ku09KxMjFPuOsQIMaqyKNSuZHBm
 a0KvDgaX1a8SA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/43] ASoC: Intel: sof_sdw: Add support for SKU
 0AF3 product
Date: Tue, 30 Nov 2021 09:49:39 -0500
Message-Id: <20211130145022.945517-2-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, libin.yang@intel.com,
 cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
 Gongjun Song <gongjun.song@intel.com>, tiwai@suse.com,
 yang.jie@linux.intel.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, liam.r.girdwood@linux.intel.com,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, vamshi.krishna.gopal@intel.com,
 yong.zhi@intel.com
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

From: Gongjun Song <gongjun.song@intel.com>

[ Upstream commit 8f4fa45982b3f2daf5b3626ca0f12bde735f31ff ]

This product supports SoundWire capture from local microphones
and two SoundWire amplifiers(no headset codec).

Signed-off-by: Gongjun Song <gongjun.song@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20211105022646.26305-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 25548555d8d79..05fe300b796c8 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -199,6 +199,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_PCH_DMIC),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0AF3"),
+		},
+		/* No Jack */
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_SDW_FOUR_SPK),
+	},
 	{}
 };
 
-- 
2.33.0

