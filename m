Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A80C001DB
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 19:03:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BC9A1F1;
	Thu, 29 Jun 2023 21:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BC9A1F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688065422;
	bh=13f/HRpmv2My9g/tfBPFpPeoyAwq/ztDRUY5fqnxFVQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=A7J7/+fbxK2bHyTaD5Oog0akncKGBfORaGthBaN8rx+HS3403p2dc2Hqqcg/BmvOB
	 9eMucdfMtuXItf7IpsjpW5xxsM0xi82bg/ZcnOdnFdJMC1aer/XmVS5QeC/t8xcrwI
	 xmEC/Ojq+1UXz9HFHYtiuU39Aj9NyvejWgtlSTUc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11568F8027B; Thu, 29 Jun 2023 21:02:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1A86F80567;
	Thu, 29 Jun 2023 21:02:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E00DF8057F; Thu, 29 Jun 2023 21:02:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DBA42F8055A
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 21:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBA42F8055A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FnVgii/K
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8D9C561602;
	Thu, 29 Jun 2023 19:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E5C433CD;
	Thu, 29 Jun 2023 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065333;
	bh=13f/HRpmv2My9g/tfBPFpPeoyAwq/ztDRUY5fqnxFVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FnVgii/KuC175mwNDzx63t1/l+K+ariDQ5N38vwa2URCFNeoD/KbEmRWETxdWlTMU
	 kVcT7qDxiAuZlyJhAMyAozV0/DlLK0BoRg8stf9DqofZam5mixpDoWinbwti/13ehQ
	 lO6R+1y0euPo+MpM4D64cR/3JJLfW5VXgVDGkEqdQ6KzFtpHPzfIeGS1dSMTR8apG7
	 ygQW1dNFReUHXGh5kLrWez+JSk9Ij/cTP6at2Zk5wkchZdFoH6ZLDRHw0rWmua8GhL
	 yH+yiQFQ3Jkta2bGSnyw2fSkdu3SuWLnE7BlwzDV8pH4QqOuaKF7CErndNh8VNOMUZ
	 G0DkGToouXq9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 1/5] ASoC: ops: Check bounds for second channel in
 snd_soc_put_volsw_sx()
Date: Thu, 29 Jun 2023 15:02:08 -0400
Message-Id: <20230629190212.908306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.248
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 44H4JSNH2I7DSTI2R23DEB2JSOVPO43J
X-Message-ID-Hash: 44H4JSNH2I7DSTI2R23DEB2JSOVPO43J
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/44H4JSNH2I7DSTI2R23DEB2JSOVPO43J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 97eea946b93961fffd29448dcda7398d0d51c4b2 ]

The bounds checks in snd_soc_put_volsw_sx() are only being applied to the
first channel, meaning it is possible to write out of bounds values to the
second channel in stereo controls. Add appropriate checks.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220511134137.169575-2-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 453b61b42dd9e..00e6a6e46fe52 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -460,6 +460,12 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	if (snd_soc_volsw_is_stereo(mc)) {
 		val_mask = mask << rshift;
 		val2 = (ucontrol->value.integer.value[1] + min) & mask;
+
+		if (mc->platform_max && val2 > mc->platform_max)
+			return -EINVAL;
+		if (val2 > max)
+			return -EINVAL;
+
 		val2 = val2 << rshift;
 
 		err = snd_soc_component_update_bits(component, reg2, val_mask,
-- 
2.39.2

