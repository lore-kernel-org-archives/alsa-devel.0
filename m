Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0A0C07E9B
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:35:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9B9613F4
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9B9613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E8BD1726;
	Sat, 10 Jul 2021 04:34:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E8BD1726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884509;
	bh=FUpAEdQq+XfwL3GPsyMFhIPGfekmtIg7/BW20ILiQFM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E4D4bLubYDK2NnEuZHbvjZirPnVUNVCcqhJClsFTB3wPxb6vgwNaeleJjpj5Dd+Kt
	 tgtx2+Nd5SfTX3t7bMYgqSdMdzkr8p/uGz9VR85vgdOmIYLfEvPQ1f8KfvZMPufc+I
	 DM6jAqp9bSjMTH+OrS/8IvebkxRz6gCRSSUipUEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10E87F805D7;
	Sat, 10 Jul 2021 04:24:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4DF6F805BB; Sat, 10 Jul 2021 04:24:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42E13F805CA
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42E13F805CA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q8zmeyy6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2873F613EC;
 Sat, 10 Jul 2021 02:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883872;
 bh=FUpAEdQq+XfwL3GPsyMFhIPGfekmtIg7/BW20ILiQFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q8zmeyy6HAOM8glGPPIuJozy8dcC2ItVLixOTYMUouWd/eCae8yLwFQ+LJaZzNzmC
 nXTThFzy2SjTlZFk6whDlsd8X62BkLypudBu+ufG/RiNkMQpK8lmXkuXgsOBYY0Ztg
 2tOspkH8qfsCrLEw8huJt49kbSxyxGdL1EqcLp3+qZhI+AFu+uPK13p/wQp93Kpt8J
 xp6KNKG+UgbBkNMj3JtXDwSfbC/JtwZP4GhxkIo9bju+EY/uR1/zDwqH7+eWZMP7Rq
 Rj/iJVuO8rN3SwJ6PZOYDDNevdtjWpYpfPYKpLSKDe9XrLbBt983hn01vWbtgTHwfB
 3bKv4k0gIDikw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/93] ASoC: Intel: sof_sdw: add
 SOF_RT715_DAI_ID_FIX for AlderLake
Date: Fri,  9 Jul 2021 22:22:57 -0400
Message-Id: <20210710022428.3169839-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bard.liao@intel.com>
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

From: Libin Yang <libin.yang@intel.com>

[ Upstream commit 81cd42e5174ba7918edd3d006406ce21ebaa8507 ]

AlderLake needs the flag SOF_RT715_DAI_ID_FIX if it is using the
rt715 DMIC.

Reviewed-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210505163705.305616-11-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 53c9b47d1ad4..2770e8179983 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -196,6 +196,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_RT711_JD_SRC_JD1 |
 					SOF_SDW_TGL_HDMI |
+					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_PCH_DMIC),
 	},
 	{}
-- 
2.30.2

