Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4396C4167B
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Dec 2023 20:34:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 664C4A4C;
	Mon,  4 Dec 2023 21:34:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 664C4A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701722055;
	bh=jl9mkb3+8I4qmhnlzh34M7GhRZZUr41HM/ua32/te84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tzx5sUg94tihSFeOkOVZAKSd99GnVaVXgFxbrUewj4Pp8kFQNUBhjh6YspMo7ttvf
	 51dkUHXMvo8G2Wp7T9rN1TIOVn3TeFPc/EMSsPb/RGkeCRS3ngT4x/6lMgznFEDBDu
	 gSIokfNID2+W8hl6RNaiggvf/2ti6ZknyOga74G0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D4F3F8058C; Mon,  4 Dec 2023 21:33:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2050F80557;
	Mon,  4 Dec 2023 21:33:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E94A9F8024E; Mon,  4 Dec 2023 21:33:38 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E00C6F800D2
	for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2023 21:33:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E00C6F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fpm/RZDv
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 63EC5B81218;
	Mon,  4 Dec 2023 20:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E0DC43391;
	Mon,  4 Dec 2023 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722008;
	bh=jl9mkb3+8I4qmhnlzh34M7GhRZZUr41HM/ua32/te84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpm/RZDv1oxz2nwwbBAtu2ZUxFgTMQeW696xFxP6L84YuDYJX7qnqq45UTLM8m/Lo
	 IyFNGNk2+u1A6LRA7pEG1u2vaRSd/7tmwxOWJYOYFQAw8TODiJCZSdAsFK48ISEFM3
	 /k5bCmsWMOK5VAIRBAeMOIQgiaL7ScuNSqtjnsJ1J8D3MWmPaLr67LY3NKVbQug8gL
	 RIbAo2BkNwfnhgZLDO7GMBUn9m2ZjbgQtYXGiPwcK65zBhQyfuIv/+fPFMNqAk2EpV
	 Nzt+ui63sNRJOg4FIASqdS9ZqhzKpsq9OslnnBTbnFXR7MZO1EkSX9uBsPOjG3H5vB
	 mBN0CsTUSFZeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	kernel test robot <lkp@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rf@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/32] pinctrl: lochnagar: Don't build on MIPS
Date: Mon,  4 Dec 2023 15:32:24 -0500
Message-ID: <20231204203317.2092321-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2CDYKGJ3IWWGJGN2X7TWCFIVFBY7DSLI
X-Message-ID-Hash: 2CDYKGJ3IWWGJGN2X7TWCFIVFBY7DSLI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2CDYKGJ3IWWGJGN2X7TWCFIVFBY7DSLI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 6588732445ff19f6183f0fa72ddedf67e5a5be32 ]

MIPS appears to define a RST symbol at a high level, which clashes
with some register naming in the driver. Since there is currently
no case for running this driver on MIPS devices simply cut off the
build of this driver on MIPS.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311071303.JJMAOjy4-lkp@intel.com/
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231115162853.1891940-1-ckeepax@opensource.cirrus.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/cirrus/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
index d6318cb57aff2..e7e827a8877a0 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -12,7 +12,8 @@ config PINCTRL_CS42L43
 
 config PINCTRL_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar pinctrl driver"
-	depends on MFD_LOCHNAGAR
+	# Avoid clash caused by MIPS defining RST, which is used in the driver
+	depends on MFD_LOCHNAGAR && !MIPS
 	select GPIOLIB
 	select PINMUX
 	select PINCONF
-- 
2.42.0

