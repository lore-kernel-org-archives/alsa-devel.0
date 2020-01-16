Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CCBC33CB6
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D24924748
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sC3Dadpq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hToWdV+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D24924748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D13E817F2;
	Thu, 16 Jan 2020 18:42:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D13E817F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579196623;
	bh=3P+MDDCJ817c1oFiQBMNue9DqkqseMgl83K+CaoKNLc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sC3Dadpqzvml5MAfzD+3JiCn9LKy+0oBqno2aKBOLWRfiZdgYgD/+9KeiXYSuqH1y
	 Q8pYGi0HjhtlKR3OYvBVx7yit2ccAwVS/A0g0UAVELZZvBACsSfuyk4rZl9W+HY7ml
	 zRL1vd4r3zUTkEw7aKLfFNVkuYeKLMGyFhoPvXwY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64CF0F80299;
	Thu, 16 Jan 2020 18:38:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10894F80276; Thu, 16 Jan 2020 18:38:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25B87F8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 18:38:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25B87F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hToWdV+K"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8267E246DD;
 Thu, 16 Jan 2020 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579196320;
 bh=DFY2xJ6oT72ntgufKPgHkk3dp5CRgSUSTNJfVJtkg/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hToWdV+Km+6kDlybUFPYBC3xSS07l+gWxswA851Yg90F7+1rpNqyF6AKFopIfl7Ju
 c0GbLaK5J0WR9+GOweycNdzgWl0BmEXDhvd1XMGZGCzkRXXBkwlkmpTRuqWFp556Nx
 I7fC71mf76tOywkQAeRt1MMt9fo9t3T1DBloC6JM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 16 Jan 2020 12:34:33 -0500
Message-Id: <20200116173641.22137-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Subject: [alsa-devel] [PATCH AUTOSEL 4.9 124/251] ASoC: fix valid stream
	condition
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 6a7c59c6d9f3b280e81d7a04bbe4e55e90152dce ]

A stream may specify a rate range using 'rate_min' and 'rate_max', so a
stream may be valid and not specify any rates. However, as stream cannot
be valid and not have any channel. Let's use this condition instead to
determine if a stream is valid or not.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d69559e45872..635b22fa1101 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -48,8 +48,8 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
 	else
 		codec_stream = &dai->driver->capture;
 
-	/* If the codec specifies any rate at all, it supports the stream. */
-	return codec_stream->rates;
+	/* If the codec specifies any channels at all, it supports the stream */
+	return codec_stream->channels_min;
 }
 
 /**
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
