Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B59C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:19:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0775A23159
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0775A23159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4419916D0;
	Wed, 23 Dec 2020 03:18:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4419916D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608689967;
	bh=H1AdHkaBE5KZkU3gYtSTtWOkJBNX+B4Axt/lxQXiXEo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YT2mJ94lIS3c7kfbeFVlcgJkA1nlJiU+/huxNthThr3+GSwiuDrNQHxKyuTv5Bwxt
	 kUMFKBkTXrWQEYStt6+E8eDY6mNE2+AvmFG/h4OK6mEpG2eNt8Iz9v0QodNIj6JqxL
	 CFL5ykd6Bg1S8N7Opk991fT7Y/FIP9yRj2VLOCR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69A09F80168;
	Wed, 23 Dec 2020 03:18:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F76AF8021C; Wed, 23 Dec 2020 03:18:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 736E1F80168
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 03:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 736E1F80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YmW1+lVn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2942722285;
 Wed, 23 Dec 2020 02:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608689879;
 bh=H1AdHkaBE5KZkU3gYtSTtWOkJBNX+B4Axt/lxQXiXEo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YmW1+lVnRPieZmWp1OTdxheXA2UZTV81WNkrzPQMIdsr0P3K97rHD+MyHUGKN45lm
 T4OFHBtN3BswCtwt+qOrisyf8mw0Pu6FlGnva7PvzrlEYvcSf51peAYPXP/kVujJU7
 gNWVMm9CGmIcWptVsoiTcu8/l17o+V/cCZpDb10olKzBs9Q1EDJ4p8DC0LJKa8qKxI
 e7ikl95kuM/vadLUpssIM55NtdEbsy6oWsup8cW8Ml+K+CapUeI0mE7iLwXerXReRV
 mAjbOI7Asej/GlzcukOMF1ZdaU3qjifHFeCtkYocCXsD7TloRxuhGEP04Q6sJnPuWT
 EI0RdiY03y/3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 070/217] ASoC: Intel: sof_sdw: add quirk for new
 TigerLake-SDCA device
Date: Tue, 22 Dec 2020 21:13:59 -0500
Message-Id: <20201223021626.2790791-70-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021626.2790791-1-sashal@kernel.org>
References: <20201223021626.2790791-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 488cdbd8931fe4bc7f374a8b429e81d0e4b7ac76 ]

Add quirks for jack detection, rt715 DAI and number of speakers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Link: https://lore.kernel.org/r/20201111214318.150529-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index b29946eb43551..ca968901ac96f 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -48,6 +48,16 @@ static int sof_sdw_quirk_cb(const struct dmi_system_id *id)
 }
 
 static const struct dmi_system_id sof_sdw_quirk_table[] = {
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0A32")
+		},
+		.driver_data = (void *)(SOF_RT711_JD_SRC_JD2 |
+					SOF_RT715_DAI_ID_FIX |
+					SOF_SDW_FOUR_SPK),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.27.0

