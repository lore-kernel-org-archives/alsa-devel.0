Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0EDC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:46:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FECA61506
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FECA61506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF4A41658;
	Tue,  5 Oct 2021 00:45:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF4A41658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633387573;
	bh=E46BBw+MXNnHOxym/ApDbHe4YTocy2jAFcmvLOoXGHk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QA6V1lrk7d4xQTkip02+nugcq0CWUtBRpqs3hg715Y0yvqSzL92TjMZymDBikPYo5
	 hn+TChIFCDUXwfFeHENfofe7bf/XATGMRPMCmvJybdCc56wgkVxm2+t1dKszKlBuiw
	 AxQqBcI4p9+Yu7VJ4ZGZFipJaK64LVgjeArqx7JA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4553DF80229;
	Tue,  5 Oct 2021 00:45:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69500F80240; Tue,  5 Oct 2021 00:45:21 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA411F80171
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 00:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA411F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Szce5aG+"
Received: by mail-lf1-x12d.google.com with SMTP id e15so78080715lfr.10
 for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2021 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2fTrk1dW8VO/fRgbo8lmAbv0WNCdJdQpjahpQhXw3cY=;
 b=Szce5aG+lkjTfx8P23BIkknnmzUBy0ojGErEWMGW0tLncAEngrdCMSfDdDLu4Js5TP
 akObS7LCrpIMi1UbExMI5aq+/Ma4Dznc1+Tf51tdADhbJnqm1u/znDKiM1/oW+LIMVfo
 36z9DtIuy+ilb8fW6l+oIUjeYZUL0+Vr5ZUDQPOOs4DKdDn09V8R5+FJXokKU6gsrwlh
 LzBKMKiTC+5fSlKXkMiKyTb+lyeAL0wY/UV8YkdSJqZZ6BwFAIKcsrxHMYQnHc4uwccd
 eh1MtOKFCzTM2EdViSoh9lf0eVU6WmLAfJL1iJOqWe3MLUCCx4yBtYJlVjferbRagmKu
 peMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2fTrk1dW8VO/fRgbo8lmAbv0WNCdJdQpjahpQhXw3cY=;
 b=BUh0lnsxo+u6TdHyu7zaXzaLVC8gGXlfi8lQa+rD/p1iHicBl/I25VHPp5uQ/CcNQX
 YT/mkkyPwjVrGNTA3VqdataSnfYkgmy+4p1pmVBENl8NSrCkKP4+QYZ1J6+BTqVjmOBJ
 uLvBWR06z3TYyhcsRsMNhKDjremMYDMN4QvitdcXSqU1kTQUWn2feqjNgJ5sm8tKkwcZ
 QnDkEUlKNWRyP2RpX3bi3ZwAkyF5iv63g9RlQ8BnVBf9FsQCdNQJN7YXpdI5gBvydIBd
 1IcIAfij4lmg0zK5fltiY16WDC7dXWTz2h65DrEH7xDRaj5rsOEPz2xlefoWEeLIQNhh
 yACw==
X-Gm-Message-State: AOAM533qKkPchpT4IgNtuYHu1yClFAj8b8/3yu6VRKeeke8Avv87yPjr
 JAyq+b/OguV8sHEdguJbAj4=
X-Google-Smtp-Source: ABdhPJw/eo3ZUEJXOWiwbikfAkOgWmD2T/BAhSqeKEUiKOpHOs3rl+0zJ5FkzWbKzTuFipjeGLkp+w==
X-Received: by 2002:a2e:b162:: with SMTP id a2mr1133204ljm.330.1633387517889; 
 Mon, 04 Oct 2021 15:45:17 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id d4sm1747360ljl.98.2021.10.04.15.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 15:45:17 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: amd: acp-rt5645: Constify static snd_soc_ops
Date: Tue,  5 Oct 2021 00:45:14 +0200
Message-Id: <20211004224514.8783-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
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

The struct cz_aif1_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/amd/acp-rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index d6ba94677ac2..6d5c547a32de 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -91,7 +91,7 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_ops cz_aif1_ops = {
+static const struct snd_soc_ops cz_aif1_ops = {
 	.hw_params = cz_aif1_hw_params,
 };
 
-- 
2.33.0

