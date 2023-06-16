Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC7EB64DA
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 10:27:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78580836;
	Fri, 16 Jun 2023 12:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78580836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686911227;
	bh=9/v84xVX9Fh50n5P16H8hP2KaHmXMwGYY7S3patTJbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Eq366a420ALJWNJyF9da0HNIj47zvb0tG3x3VCpDluqAzPXVEipuv/dMxFHaExndj
	 5fJIw6Xls1k8v9jv2ZK2QUrb7uziDq1tmgTP8WMpymUGwHpYThf7BPlUJ4Kcp5uLe6
	 LT8VLQEldcF0wB9Q7vkfmShBN7FPJb1kfCuvRD1Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B17CAF80301; Fri, 16 Jun 2023 12:25:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2160EF80301;
	Fri, 16 Jun 2023 12:25:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 938F4F80246; Fri, 16 Jun 2023 12:25:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29768F80130
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 12:25:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29768F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KawVhXQY
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB0362B57;
	Fri, 16 Jun 2023 10:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CD3C433CB;
	Fri, 16 Jun 2023 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686911132;
	bh=9/v84xVX9Fh50n5P16H8hP2KaHmXMwGYY7S3patTJbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KawVhXQY+jLjXMWyCkjNF2z3m+EmPrGDG6a/M9MnK8z6HjqgXIswTdKhAwNszK0H7
	 7XJDKmzhKF+cc67gnqxIm5tkB4tj+csjYOEaHVdwCHusQhxjildiuFGkZbKs2Ddxk0
	 Hrj4unEwdJq6k/ehph1LxE13duU9drSA9zzViqrzqqLIM5EyBaRjehiJv1xbSvDdCw
	 z+Df+QChOe0bGLgmPfyc+I7uoXN9jxk3oO04MXC6Rw6q8QHVQLDVINwc3MnvuWsjfY
	 9sYL61nV8eyu3rdY3NpKAn4aYVpA6iisQi6pfjKcweErYr1IJio1khX8JK91aJl9B9
	 A62OR7GRBwVhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 06/30] ASoC: codecs: wcd938x-sdw: do not set
 can_multi_write flag
Date: Fri, 16 Jun 2023 06:24:54 -0400
Message-Id: <20230616102521.673087-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102521.673087-1-sashal@kernel.org>
References: <20230616102521.673087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7EE5IQ42WTKNS5UGKVFUDD7ON75FJTZP
X-Message-ID-Hash: 7EE5IQ42WTKNS5UGKVFUDD7ON75FJTZP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7EE5IQ42WTKNS5UGKVFUDD7ON75FJTZP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 2d7c2f9272de6347a9cec0fc07708913692c0ae3 ]

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523165414.14560-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 402286dfaea44..9c10200ff34b2 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1190,7 +1190,6 @@ static const struct regmap_config wcd938x_regmap_config = {
 	.readable_reg = wcd938x_readable_register,
 	.writeable_reg = wcd938x_writeable_register,
 	.volatile_reg = wcd938x_volatile_register,
-	.can_multi_write = true,
 };
 
 static const struct sdw_slave_ops wcd9380_slave_ops = {
-- 
2.39.2

