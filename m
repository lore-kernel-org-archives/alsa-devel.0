Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367E6C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 14:50:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BD5E2077;
	Tue, 30 Nov 2021 15:49:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BD5E2077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638283815;
	bh=y95rrPScOeNkOYR7yvkD1RXg59JxHr3Ihjwo6aV5tvk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ChSKEgsVfOFuslL412cdAPNNVQTu5tV0Nxefnjr7qL/VYvDIOxcdnho1vnzwBTS6M
	 RIWzDVF2RKZ/nmyoX8Wrd7axa8gJZsdegwpk+56uQSvVFAicHDsy7jnR7PA19ufiAQ
	 BzYm8ynBBJ06fRxqEue3bOgUpHL0FMn2/suHdntA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2CA3F804FD;
	Tue, 30 Nov 2021 15:47:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9967CF80506; Tue, 30 Nov 2021 15:47:39 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA6F6F804FA
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 15:47:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA6F6F804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bYl9P4Wl"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 73D01CE1A3D;
 Tue, 30 Nov 2021 14:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0DCC53FC1;
 Tue, 30 Nov 2021 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283650;
 bh=y95rrPScOeNkOYR7yvkD1RXg59JxHr3Ihjwo6aV5tvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bYl9P4Wl0EOF60SobxkIh9VzuHCPrixojk6kBs8G8nkZi4k4eeTVDpCymbiD2CPRe
 XAdL5S0Yp8gVGFTmTtmnkc+yI1sfQ8vw7ULoASmaWaqDhQ1xz9mZCKGJnHpsae3jKx
 RH4WEC7MmW2gsXK7edgU+LIUKtO4FaynLn39Aivot8K6UKGwJnfmHKeLw9FJzsggI3
 5zfoTxCJl2d8gUe+dJxoMub37I7Fh8qpwEzgEEwtRLrt0lrwaSQqLeMMzxcV2zAx+j
 AHe0/ds+JpzLnCGwtC7ituHC9TdrW+BAk1FiDOp+lw5NYe3nOc3uYMUQ1+uB46q3qO
 dTxc0xYw+u9Sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/68] ASoC: Intel: sof_sdw: Add support for SKU
 0B13 product
Date: Tue, 30 Nov 2021 09:46:02 -0500
Message-Id: <20211130144707.944580-6-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
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

[ Upstream commit 6448d0596e48dbc16a910f04ffc248c3f3c0a65c ]

This product supports SoundWire capture from local microphones
and one SoundWire amplifier(no headset codec).

Signed-off-by: Gongjun Song <gongjun.song@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20211105022646.26305-6-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d0bea028b9b76..25cdd61f09a80 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -288,6 +288,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					RT711_JD2 |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B13"),
+		},
+		/* No Jack */
+		.driver_data = (void *)SOF_SDW_TGL_HDMI,
+	},
 	{}
 };
 
-- 
2.33.0

