Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B415C33CAF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:46 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2902075B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RWrbvaR/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZKb/mhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2902075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 384C6180B;
	Thu, 16 Jan 2020 18:14:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 384C6180B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579194944;
	bh=A4tBFImjKelPBjffczRdTsy/TUiKXYvXb4SqnUNQnp0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWrbvaR/OZac2cxKlgU3hRzHBoW8qN/kGFuJys771ChTSNH414hlJXGNPnwYJgV+3
	 tYHLiWpgVDArilIyTd/l1UlzfLtB4hJfkWm1Xw6Uccql2Xjs3KGn518vNPbVD9ovbz
	 PnQWXvIiSgPqeVfknNCpBZACoV+HkFxzWBLZwImI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 478F0F80292;
	Thu, 16 Jan 2020 18:10:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6710AF8028B; Thu, 16 Jan 2020 18:10:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D465F80277
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 18:10:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D465F80277
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rZKb/mhg"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00CAB24683;
 Thu, 16 Jan 2020 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579194630;
 bh=QhRsUq9msnENjXA9Ib0cZ115aEFwzDmLlcwdVXqiUkY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rZKb/mhg8C+6V+WNufOg4CeBXr1/rUtXmue4R+oECb8rU/kzvsO/raj7U0rFsKhma
 NJwGChr6V2em1Imu3TozB2su14csAuRuOnpbUD73taKXQ1IH1iqqqRJUC9kREzB6/M
 PA9wkxgWQeS8U2m/vBqPrJ6+Dcozk0YtmJhLA2Tg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 16 Jan 2020 12:02:08 -0500
Message-Id: <20200116170509.12787-227-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [alsa-devel] [PATCH AUTOSEL 4.19 490/671] ASoC: es8328: Fix
	copy-paste error in es8328_right_line_controls
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 630742c296341a8cfe00dfd941392025ba8dd4e8 ]

It seems 'es8328_rline_enum' should be used
in es8328_right_line_controls

Fixes: 567e4f98922c ("ASoC: add es8328 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092300.68712-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index e9fc2fd97d2f..3afa163f7652 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -231,7 +231,7 @@ static const struct soc_enum es8328_rline_enum =
 			      ARRAY_SIZE(es8328_line_texts),
 			      es8328_line_texts);
 static const struct snd_kcontrol_new es8328_right_line_controls =
-	SOC_DAPM_ENUM("Route", es8328_lline_enum);
+	SOC_DAPM_ENUM("Route", es8328_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
