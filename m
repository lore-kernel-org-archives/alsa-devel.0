Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7457C5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:41:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1182A4A;
	Mon, 11 Mar 2024 19:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1182A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182489;
	bh=6i6wxaZzYQIHnPtoUFQzJHucGTNeOHrxMItXv93pAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qutWnlQ59rhS1/2FuXt/AtHVSi2ODlaDDj9r2WIG2in6wrV9DQFlH7XXwKYaWnPK3
	 cZCCCyoYk1GSSaOOQQnoMVlQ/JKa4zB/P/oDcb8JaoV4h9WvXVCCMypx/bwJqy6+AD
	 t7ZeiEBL+STQj+ExfbwtDS14DzEAX3t5PDJ0bMtY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5FC5F80736; Mon, 11 Mar 2024 19:38:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3654F8074E;
	Mon, 11 Mar 2024 19:38:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2095F8071D; Mon, 11 Mar 2024 19:38:29 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA5E9F80563
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:38:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA5E9F80563
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IfnVScOu
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D635C60F75;
	Mon, 11 Mar 2024 18:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE713C433F1;
	Mon, 11 Mar 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182305;
	bh=6i6wxaZzYQIHnPtoUFQzJHucGTNeOHrxMItXv93pAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfnVScOudG9GBttddhPMiypPsv5PpD3evz7o4TzKVwsPyp97RIjfGf5APCl/977uR
	 sKsOpq8J29/V1UIJ7Cg8BdyNuSNVa57BoM/dB6fcNgYnXXy48ot2NULMFbqvbzsNq5
	 EnNOnkOSMIahJyYyeBOQMJhHMIJgYt0dZCOsyKaPvVa9kMcBM/BOv1O47dS/+Gdq+B
	 YlFGWPvKsw2dbdBtyJuLvbUtlLrVn96AVXEcm8vUGJpcYcfNDI2hW0BfBRt2E+XmsD
	 iOLCpXnyILISZ5AlWNZSSo4sz3mUNIgiAC4rtSaEd38rCRfIGTxW7WU5My1C5gCJcZ
	 QLS0OL7FT0BtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.6 12/12] ASoC: wm8962: Fix up incorrect error
 message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:37:26 -0400
Message-ID: <20240311183727.328187-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6VEDDLBZE3WSZJUQBZOXAEHPGDDULHWU
X-Message-ID-Hash: 6VEDDLBZE3WSZJUQBZOXAEHPGDDULHWU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6VEDDLBZE3WSZJUQBZOXAEHPGDDULHWU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 914f8eb418357..4f50b07848fd8 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2933,7 +2933,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0

