Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F783C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 04:22:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10D364F53
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 04:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10D364F53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7563416DF;
	Thu,  4 Feb 2021 05:21:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7563416DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612412555;
	bh=oZ+CLyxGiAzFWswm3LlXB5j+pOhH35cmeKP7y75AX4g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q+hAW0+77jHqyYwUaZMBn7gXawcNmofpM5LjZJaYoTEIUqNXXSHixPt+kl5a6YYRx
	 S5AKYV+2p3BEpIWZ2D9wj8timZwz26WmSn6yfgnOA0bNaKOAvIRt+w18qPwa3+0ivR
	 g3yKqPuAnuFjSh6J3O84nBfFSu4JudWD2SG4nyo8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AE28F80155;
	Thu,  4 Feb 2021 05:21:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9394BF80154; Thu,  4 Feb 2021 05:21:40 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADFFEF80154
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 05:21:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADFFEF80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="WidEyCHM"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601b76490000>; Wed, 03 Feb 2021 20:21:29 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 04:21:24 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Feb 2021 04:21:19 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <thierry.reding@gmail.com>
Subject: [PATCH v3] arm64: defconfig: Enable RT5659
Date: Thu, 4 Feb 2021 09:51:16 +0530
Message-ID: <1612412476-24768-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612412489; bh=RNhRnyFlb2nPp8zHaebXuAihysUSSrPgXpjl2Q5IAZk=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type;
 b=WidEyCHMu+hKQR+e2d10/bkXcsb8KkRzFppsu6svn3WrlwDKtFW7Yof7d9Oo9vPmg
 6O2y4EjtWKsV9mmK43+jWx5lZ/jTYgk3D97dZPGRrGXVYe5NRschdmQXNVaWPOqALR
 6Zu1K/+Q+hvx0VaJh3izmEM9zmAufqqwiXs274BrgMZ5U1vNECNeHosBafO2Rl/2Gq
 hbiigTO2aUiy1dOG3FYwdT5odA2sshHqMzRAoVtYePqVZ96FQ0bxwLwK3zoJ6zc+Vv
 urrgIxsjamG5zbamCa64jbN91C6orP4mfhPt8P5KTGvH29yXzDejE7ZRfnnX+AFcjG
 Z06evQixX8S0A==
List-Id: <soc.lore.kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 arm@kernel.org, Sameer Pujar <spujar@nvidia.com>,
 --cc=linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
 sharadg@nvidia.com, soc@kernel.org, broonie@kernel.org,
 linux-tegra@vger.kernel.org, Bard Liao <bardliao@realtek.com>
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

Enable the RT5659 audio codec driver. Jetson AGX Xavier has RT5658 codec
which is compatible with this driver. This enables user to test external
audio.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 This was part of original series,
 https://lore.kernel.org/alsa-devel/1611944866-29373-1-git-send-email-spujar@nvidia.com/

 Since other patches from above series are already applied, sending this
 separately now.

 Also merging emails/groups from the resend version,
 https://lore.kernel.org/linux-arm-kernel/1612260252-31582-1-git-send-email-spujar@nvidia.com/

 Changelog
 =========
 v2 -> v3:
   - Updated commit message to reflect usage of Jetson AGX Xavier
   - Added 'Acked-by' tag from Jon

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d628125..496fcee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -767,6 +767,7 @@ CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
+CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
-- 
2.7.4

