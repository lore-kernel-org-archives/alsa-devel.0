Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0498EB64DD
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 23:17:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9589F950;
	Thu, 13 Jul 2023 01:16:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9589F950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689203821;
	bh=ZyuiWzGM9QePvtgOw/zkkwTBfsCaKneK7VJV37MCYHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CWg3Jcgh3Sz23/vfruwl7DyqSRzFIOzjtJp19Io0GdAj8c4frmZVLpa5DQGQPiuyI
	 py7dqitG/1H45HDYUakB5t3SNeV+jNvZPvHUXOlThOf0F9Xcmov1gsGqxiGW9ykSmF
	 UOMNrX3E13W9AZUFDW3xtAOg7GH6/eT7+nZH/e4Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 787A1F805B4; Thu, 13 Jul 2023 01:14:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE26BF805AC;
	Thu, 13 Jul 2023 01:14:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24368F80571; Thu, 13 Jul 2023 01:14:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21219F8027B
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 01:14:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21219F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U/hJm4vm
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DBA7761947;
	Wed, 12 Jul 2023 23:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B209BC433CA;
	Wed, 12 Jul 2023 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689203658;
	bh=ZyuiWzGM9QePvtgOw/zkkwTBfsCaKneK7VJV37MCYHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U/hJm4vmH6x6R213PvNvlm1FI6AKH8VhqjVRn0o9SitLpFuV/rLS+ZDTFTArLAmSl
	 3z6v4ajrh3sPIa2LekFrjsc+mkMGjIbVSptjKpdGg2Z/i9Gowhi/JNJWxXo3Ylys6R
	 o3Cqz9/Gicj2q8Uzg4yT5Q6iFqgHiCWRS4z04qVk2Pf7s4Mg0f6zRToTTKzonBJOIS
	 gC7fxhYzhOLHsxb95dcqB4y8tBpZxagiqnE3tH+zk0H6zkP+dAqi/Bo7gPs8pyxhRl
	 BO2KXPL1mFe4fRoNOHdsY32OXSAJBEW3FIC+eD2XY7xt6RKhklNKGAFgFnzlMfQ3yt
	 T8xhB8GXRdnhw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Jul 2023 00:13:54 +0100
Subject: [PATCH 05/10] ASoC: adau1701: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-5-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZyuiWzGM9QePvtgOw/zkkwTBfsCaKneK7VJV37MCYHg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO3/uZY5QNBmGcSn4rf2mODTsNtqLX6JrRrs
 XpWfRfmB0SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8ztwAKCRAk1otyXVSH
 0PteB/4gampxLjwqYH3skRZTqilbrZu9SlPoLfZrJvrSvoOcgBXT/I1vrB0Pva3LEcjBluSTdS+
 HIbOnbrJ/w8ecu2gssUQ1Yyiw1OKgcQfh7m3kt0+FRe792/K3KGO7jwLi1cnbA7BJYIf2kz1WNL
 Jq9p1Qv3mw8XmMMWwaWhY60AXGa/QtdgA/F4VgUdbTLU/S2wVHVbyhH0ViSxy4dzg4oxCKYa4zT
 OmWXDjHM8tlHlP62XMoWFyRmkQbWm1VLf+hcbjcM79hU/r8uMPMT9rxMDaXXIb23ZwExiLw17EG
 xrZfo3TlyqaApEnSJnS1DPy3+PRVPAIiAnu6uIIX3CGcpYzP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: ZPB5DAX5UXJRC5ZRTKA4VCR2PWRCSWTG
X-Message-ID-Hash: ZPB5DAX5UXJRC5ZRTKA4VCR2PWRCSWTG
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZPB5DAX5UXJRC5ZRTKA4VCR2PWRCSWTG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the adau1701 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 8c8de3b3c901..94831aad7ac6 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -778,7 +778,7 @@ static const struct regmap_config adau1701_regmap = {
 	.reg_bits		= 16,
 	.val_bits		= 32,
 	.max_register		= ADAU1701_MAX_REGISTER,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 	.volatile_reg		= adau1701_volatile_reg,
 	.reg_write		= adau1701_reg_write,
 	.reg_read		= adau1701_reg_read,

-- 
2.39.2

