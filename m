Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C439AC7EE2F
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Feb 2023 12:50:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B06B1868;
	Sun, 26 Feb 2023 13:49:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B06B1868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677415826;
	bh=yAKKZS93DzBbBINmZ67z5s72Cs2zUCyYJViPEg1/Iyc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jGI46gosXcs0PAF1KpL02Zx7DpufY1AQQkUSpBY1vMejwop1VZDavhrMUy5wt25L+
	 aq5ttS4i9pVKkW6wKmUfdS/e04KxVFF4S0bR6JxmUqnJEEFlvXOx/gdvvqlZxxRU8e
	 JItCcsYZfhVH1x/jKyhS6fFq0RO+F3lEQSFmy2Hk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 070F2F8053B;
	Sun, 26 Feb 2023 13:49:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7427EF8052D; Sun, 26 Feb 2023 13:49:07 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7CC6EF800DF
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2023 13:48:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CC6EF800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qp2pI8J/
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E74FC60C1F;
	Sun, 26 Feb 2023 12:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FC8C4339C;
	Sun, 26 Feb 2023 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677415687;
	bh=yAKKZS93DzBbBINmZ67z5s72Cs2zUCyYJViPEg1/Iyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qp2pI8J//AKX4bbskvSW7LqB8nwGHcFwA4+KF2iS4ECxC9l3ZH6MUY+3NAKfv/Ae5
	 p+6HXpL3Y0qX33Z2V+gR71ns+YZB02tOVKVi5GyWwMTUuhbJxNyjVDGIfkNXP0By/b
	 +OBOaEnqNmpVMm2rZ10Iy7+y5Ikk9GaW00r4r+2yues/l3+XFTkCdhlbP7kLHoPqcK
	 0vrNFWo+R4dwP9lCBQuSyKFHaaIqJZTp0GH51d8vNJvGR5WCqaf9hbtNB8D+0Ju8kn
	 2R9GoecYsIfBiYAJi0xG8UIBQVXd59MOg8RcbIi71etKohPEyUkm23Tm5kt2PyjMed
	 grOpHdqWM9RuQ==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 26 Feb 2023 12:47:56 +0000
Subject: [PATCH 1/3] ASoC: mt6358: Fix event generation for wake on voice
 stage 2 switch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-asoc-mt6358-quick-fixes-v1-1-747d9186be4b@kernel.org>
References: <20230224-asoc-mt6358-quick-fixes-v1-0-747d9186be4b@kernel.org>
In-Reply-To: <20230224-asoc-mt6358-quick-fixes-v1-0-747d9186be4b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yAKKZS93DzBbBINmZ67z5s72Cs2zUCyYJViPEg1/Iyc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj+1UA+dtvLWAoGO6f76qudLS6vUAWHu8gYMrdKViY
 zbBwra2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/tVAAAKCRAk1otyXVSH0HPfB/
 9AMgPSX7Cs9sm1+9clPmQLcJowiC/LkJjILn2UY0FykRyCcV5LygYf2P2FvKWbYxlpAGUUqYcic+zX
 NFKw+jYmb3Fo4at8hkoQJHP+0SXEpg0TFD3GbvWB4irPoyQBkiU8moJSVugdyv+9h4f6QNCHFnqV7W
 onn0TRjbm/usiX17wVkSceuej7eFjwyMpIQraiUCflU5p2VUnNPiyfXAhCShePQ85xc8Bz+Ols0W3u
 05H9hEE6clJgrHE1YWmd8ou2zkmdvaDDo4NDVcr9G/0BeTM7oKjUg33lqIlrvMXtG2Wn5BLc/qkZQf
 m8BOAYUfOKb0AoNJNWPPbuhgaMJzZz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: ICSO7EJYTPXOAFI3CFO3YZ34NFL5XKQO
X-Message-ID-Hash: ICSO7EJYTPXOAFI3CFO3YZ34NFL5XKQO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ICSO7EJYTPXOAFI3CFO3YZ34NFL5XKQO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ALSA control put() operations should return 0 if the value changed so that
events can be generated appropriately for userspace but the custom control
for wake on voice stage 2 doesn't do this, fix it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6358.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 93f35e8d26fc..9004377461f7 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -567,6 +567,8 @@ static int mt6358_put_wov(struct snd_kcontrol *kcontrol,
 			mt6358_disable_wov_phase2(priv);
 
 		priv->wov_enabled = enabled;
+
+		return 1;
 	}
 
 	return 0;

-- 
2.30.2

