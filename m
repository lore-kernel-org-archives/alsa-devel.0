Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD5C33CB6
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:10:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B93F24685
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J/OxbDXD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIyGq3q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B93F24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B347B17D9;
	Thu, 16 Jan 2020 18:09:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B347B17D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579194619;
	bh=4z7q+7VvAcjGrwi3nxqGkGVrcs3uToO4B2azdz8hsWA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J/OxbDXDw1EEt4CQT8Zxvxh8QIY4TBplPVFch8hSWyo9e5F/LOo0dGyUqGmgsRT9s
	 JOUyVhs9uV++1pQyWgKzP+9aM+SnH0fjNwa34TkRL0orSCxT7bUNcz7xKELv2qV5tO
	 Hj+o+NOAkcU6hK29IoO3mN3WlXq26kX9jsx/D6YM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB3F3F8016F;
	Thu, 16 Jan 2020 18:06:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29C73F8028E; Thu, 16 Jan 2020 18:06:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B8B3F8016F
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 18:06:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B8B3F8016F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HIyGq3q+"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6BCF20663;
 Thu, 16 Jan 2020 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579194398;
 bh=KBiI/mXxZvZHLjI05KG9vEFVUmFKB4m2QAtN/vyAklQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HIyGq3q+aJ2xHHnBIhpPOG7JOU6Wzhj49DUJ4bIZSXsrn2EIJDiN3dHwf+QzecVrp
 XhCwBvJDiINnOyRLH1rLvdXi6FdiRP+19lqMdzqMUqXQ2mhMjuK9uvqtcxVgWcGok5
 E4HxEo2EkUDaMr57hoDwTQDGQYhMSfoFZIaYbdr8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 16 Jan 2020 11:59:22 -0500
Message-Id: <20200116170509.12787-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Subject: [alsa-devel] [PATCH AUTOSEL 4.19 324/671] ASoC: fix valid stream
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
index 551bfc581fc1..53fefa7c982f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -42,8 +42,8 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
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
