Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC66C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 13:26:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 012C5A4A;
	Mon, 11 Dec 2023 14:26:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 012C5A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702301208;
	bh=CR4WEiVLSbI2eaXlZ+1qwly9qiLQTKtm9P5IJp8GAYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IuOt0y+OlsoZ3Ck/+iYSQmKVSj54inFIWYyaLGR/sKPkdtrLb2ezIcG2CpPZXhz4Z
	 hj3Xd4RplKGOAXtVrCrbS/CWHZn0nLkBg3ijfEjdR5r7f1trwl+zEM7UxwLROYQd0n
	 gIJA/zKiNROdsZWrZNPsNogcKmpZq+bQDVGr2poU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7D24F805A0; Mon, 11 Dec 2023 14:25:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D541DF805C6;
	Mon, 11 Dec 2023 14:25:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CDFFF80114; Mon, 11 Dec 2023 14:25:53 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4D53FF80114
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 14:25:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D53FF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JdrWVEgw
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 71B4E6127C;
	Mon, 11 Dec 2023 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5879BC433CA;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301145;
	bh=CR4WEiVLSbI2eaXlZ+1qwly9qiLQTKtm9P5IJp8GAYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdrWVEgwfxDc3wu20xBwcrinYaKy9S/4VKOe2QcSwApLUdLd98hme+dafUfnIfslC
	 VFr1/X/On6ADNdadg3HQG8Ax2xuuvxNT/v+BxdjKJ3PpC5icWCBW6pi1Ikt0N1xasX
	 QfFluSUWQuyWw8FnN3K2H8hR/KQcbswmsVnSuHwMMDzeSF4zQew0e/Xt3fVj/KSI21
	 y5y2UN6d8W4EpJM1HsnUl9J/6mppJ62SjUYm+zftSjaCYoilQBDmmSx3TiToYW2520
	 Ok1fnf7nOvLnsPhR0dT4Z7hMU7KgPWAavD97ZovBr6TYAGYJqrkFTSM2gkq5RVTGR3
	 zIpKvPf2igNsg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rCgIq-0007Fh-0m;
	Mon, 11 Dec 2023 14:26:32 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	broonie@kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 1/2] ASoC: ops: add correct range check for
 limiting volume
Date: Mon, 11 Dec 2023 14:26:07 +0100
Message-ID: <20231211132608.27861-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 26UFHDZHUYRWCX7BVC45QUA2U22WV6YP
X-Message-ID-Hash: 26UFHDZHUYRWCX7BVC45QUA2U22WV6YP
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/26UFHDZHUYRWCX7BVC45QUA2U22WV6YP/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit fb9ad24485087e0f00d84bee7a5914640b2b9024 upstream.

Volume can have ranges that start with negative values, ex: -84dB to
+40dB. Apply correct range check in snd_soc_limit_volume before setting
the platform_max. Without this patch, for example setting a 0dB limit on
a volume range of -84dB to +40dB would fail.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 55b009d3c681..2d25748ca706 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -661,7 +661,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 	kctl = snd_soc_card_get_kcontrol(card, name);
 	if (kctl) {
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-		if (max <= mc->max) {
+		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
 			ret = 0;
 		}
-- 
2.41.0

