Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1336FC88E40
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:44:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCE6E602AA;
	Fri, 11 Sep 2026 03:44:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCE6E602AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789091078;
	bh=iXgmn2uOSBBdjl+KPdKCofG37astsLuhw9GxPjsdAwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lWfzjK4is4Yz9QVwxxyRhfJCaDKV3zCMixkO/vyQqljuyhdMVUVv4gpW1LHI8ROTC
	 OKiGkZmQhAPOfCA8Wj1eeaDkY0lH5iYInGlSfgdNnunbKCgLWHDtGg6UQaJNQVFAW1
	 MsczGcGL9sHUeqAytuuZ+4cls/lcS2WQm/TiOSOs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 217B6F805FD; Fri, 11 Sep 2026 03:44:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 824C8F80601;
	Fri, 11 Sep 2026 03:44:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D492AF804F3; Fri, 11 Sep 2026 03:43:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789091038;
	b=rUDQKPLdV8NBhUMr38fV6QOqpPai/vWTmVaPjIoKuxcxKSjmi7vlXOSQM7GHwcWSurTM
	 GcHk4Ga9i5IFCOW4Ux3f2CIDG6K/nZ9v4emOxn7aA/IDGyxfS+NwgdCLDNI2ywMfG3qu/
	 QmcB/JpuhRmFBjtevvpX+pkNmz6TJWzrWGxPIzD41H4gjpIwMpwfJoOLV448BVIi+U741
	 sQ6mf9YA+VpI9OwDggDW54pKcML1k1X5nrQHmcmVVXS3JJmqhC5lC7w7ruag1LDBuIHqg
	 JeT6mwX3E2hGlZatgYwMP9zuTVSb6DjzvBCMCprE8Ls8O5fA+c/cB0dQUhLxOfvvbkw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789091038;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iXgmn2uOSBBdjl+KPdKCofG37astsLuhw9GxPjsdAwc=;
	b=cdLqIJ4bZchClHeAslyYAutxibrlsbjS79YI/NS81t0dHJ/T6UiT2kIwlYVNtvnsnF6P
	 /c+U8yXW8hvbaNy2oV4zfe7EiGBFuZw85UV0ev7J3U4GS4EDlgobGNvF+zdfugjb03Z/l
	 8L4K5qE0eJgldU0+xhOfAzV/hCd5r+fbuIACsTTBVcpkfEjTeYmZGGlum064OASMBkZd8
	 RjzOWyF5P+9WV4I4AW/YXRiUybagtWadCGxHmtIX2jL8Zq4UtY8m7BhAFbMS9tJhNQ/Od
	 SdthKrA0bTTfVvMNuzI26hamT42MZWYVnQ+AS3iLV6rv1lE2h2Wlk4bdh61EteMDINQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="g/32rOQX";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB7CFF801F7
	for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2026 03:43:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB7CFF801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g/32rOQX
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CC8060200;
	Fri, 11 Sep 2026 01:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D601F000FF;
	Fri, 11 Sep 2026 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091034;
	bh=s2FQts83Us8TWLpDYKUSvEckML760uaH5kF14k0G0is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/32rOQXM3uuXzsSo8jWDEhKkAlcmmDFIFkqcBk0M7315yGnFxq/+prBItcTuTha+
	 tzY2PbUTg6GgSnqgih2LKnoQR/l5M+acACjxa0ZvOKsFWgmCPnWIDNPrsi8FdWZQ3s
	 Cli26PRHNjpsKt/yvFKaK2ZYdLYYdTqLJD2SK7/u8MxtlNEUfcfokkI8QsmcuJDW0+
	 85b7C75Y+rcvuwfYLtI5wnwGE5XBC5zPgVpfE93DVGSvVFImH3RU97/VGyyhF1q2S9
	 j1x+Rnb/AQ5OcWhbyE8Y3rO3KGI94Q5djLAyJq2WYKLBsaSwCo6/koiBIWrEP0jQdk
	 VxtT+P3K7AE/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kirill Marinushkin <kmarinushkin@birdec.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ASoC: pcm512x: Mend accesses to the I2S_1 and
 I2S_2 registers
Date: Thu, 10 Sep 2026 21:43:50 -0400
Message-ID: <20260911014351.4149354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090937-awry-woven-fb0a@gregkh>
References: <2026090937-awry-woven-fb0a@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3IFUQ7FYPNQBNSBT4CQ5C5AVMKVRYYH4
X-Message-ID-Hash: 3IFUQ7FYPNQBNSBT4CQ5C5AVMKVRYYH4
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3IFUQ7FYPNQBNSBT4CQ5C5AVMKVRYYH4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 3f4b57ad07d9237acf1b8cff3f8bf530cacef87a ]

Commit 25d27c4f68d2 ("ASoC: pcm512x: Add support for more data formats")
breaks the TSE-850 device, which is using a pcm5142 in I2S and
CBM_CFS mode (maybe not relevant). Without this fix, the result
is:

pcm512x 0-004c: Failed to set data format: -16

And after that, no sound.

This fix is not 100% correct. The datasheet of at least the pcm5142
states that four bits (0xcc) in the I2S_1 register are "RSV"
("Reserved. Do not access.") and no hint is given as to what the
initial values are supposed to be. So, specifying defaults for
these bits is wrong. But perhaps better than a broken driver?

Fixes: 25d27c4f68d2 ("ASoC: pcm512x: Add support for more data formats")
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 767d9ae714e3 ("ASoC: pcm512x: sort the register default table")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 3677e9029f91e..5182777b93b06 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -116,6 +116,8 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_FS_SPEED_MODE,     0x00 },
 	{ PCM512x_IDAC_1,            0x01 },
 	{ PCM512x_IDAC_2,            0x00 },
+	{ PCM512x_I2S_1,             0x02 },
+	{ PCM512x_I2S_2,             0x00 },
 };
 
 static bool pcm512x_readable(struct device *dev, unsigned int reg)
-- 
2.53.0

