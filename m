Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B9C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:34:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DA8611AE
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7DA8611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97C8083E;
	Tue,  5 Oct 2021 00:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97C8083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633386836;
	bh=LKig4MrPzfslwphRF1C+TQxSwRMj5tYu3qW2lxnVEJE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i3OnOEuEYU8lz6uPIv6i9elpQckm7buhi2WX7lwue1AhyCw7HIr77r8woSKhbEXPy
	 uw1OuJl7tzIESMT7kg1u6HWawQY8L7Gt1g2aadyoZAjHLdmpCIUSk5yewRXoAVbEWZ
	 Bgq1ym9c2VIOsKLpNXOhC6DKftNnqMh1vl+AQQlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1253DF8010B;
	Tue,  5 Oct 2021 00:33:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61F04F80240; Tue,  5 Oct 2021 00:33:04 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B93A3F8010B
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 00:33:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B93A3F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hbn40zV2"
Received: by mail-lf1-x12f.google.com with SMTP id y23so38622625lfb.0
 for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2021 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tikr9EZMT945WPgYWh9Nfqx3BfJVYbeGQaW2V2Yhcjc=;
 b=hbn40zV29ZqI9m3bYnmFea9qlG+KWcRoGwl3SuBlw6vqWg0UPWZ3abCwH+w6z8lAKQ
 VDX1qYxE9VcxhK5XkvllwPHKqg/rgeJM43WOWxp7BUZ/7wk8tPuguFVbIDX4sOXFNaoO
 Ko3QC3IHurqaKD9oKx3F1e5r5GPxax2Pwuj3MzUObZky1UrH7j6oKLHYOvftTKoKNnRY
 TfStbxzA4f9EP5+rPpKfmUg3yBvCwbBAe+isbb0+AG7bALsQatIrUQVG+r5p7vVwKpwj
 Y0EM+2rfxZKnf81+ttcBw8R3yFk4tYHPlOMxnjH2pdXYnZYbfgUjo/c72W5vnlyU8ryz
 vofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tikr9EZMT945WPgYWh9Nfqx3BfJVYbeGQaW2V2Yhcjc=;
 b=pSCl2EhZ9muM+q31AIGGURI1GCSQ8caaADoub4s4XTmYvFXhOydAxeWKbgE7RBlQ+x
 LgVzRV4khOd91lwYFIdvR9D+Ob293oN++uz0dMTFQHRSXHgCCCbkktm3lobGSCtAvRhW
 QwVBxmhwi+QFVE1Gq5Hxdu/Ty6j65vWbtqocJ7B6oEdpW7AEJCKsmjP+dwCwE2akD63E
 rexPNwtUCcrRQJOOYGOKha2qWC6kozRfG5UvBrMHUHRyNzAd8844LGsJ4cu/DkfpmIOS
 6oxbiwbcg+vUJqmCRqGkOWf46Hditjr6f0H28JhE+1MPSA3tV8275Uq02smB34mS5s5M
 8+cg==
X-Gm-Message-State: AOAM5313CkckquKSWZjdi/wTAN4pCYlUumDjlZPrml7sfJqEYiA5nJtq
 z2qjb7Vh0stt3BMqKFEaMlY=
X-Google-Smtp-Source: ABdhPJyl1lB1gU6D9sYaeLTA2kEb1dZvr0LkhbFsLyqv308ce6J8EhrkdCkJUkJ0pJSZ+yXLEIH4/Q==
X-Received: by 2002:a2e:bd02:: with SMTP id n2mr15081247ljq.40.1633386779597; 
 Mon, 04 Oct 2021 15:32:59 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id d27sm1749729ljo.119.2021.10.04.15.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 15:32:59 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: qcom: apq8096: Constify static snd_soc_ops
Date: Tue,  5 Oct 2021 00:32:55 +0200
Message-Id: <20211004223255.5634-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The struct iapq8096_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/qcom/apq8096.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1a69baefc5ce..c7b7d0864d1a 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -60,7 +60,7 @@ static int msm_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops apq8096_ops = {
+static const struct snd_soc_ops apq8096_ops = {
 	.hw_params = msm_snd_hw_params,
 };
 
-- 
2.33.0

