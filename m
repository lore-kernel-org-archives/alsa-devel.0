Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47BC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:12:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A436B64E02
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A436B64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AC8016BE;
	Fri, 29 Jan 2021 16:11:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AC8016BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611933120;
	bh=QMoYD6s9WDPdWg8KUXgUjIwAc7bAg6bqwXWxos925OI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JYTw7JhFymheD6Anf9O+/Q3gWDpbMXPG+PK6x+snG+YRQWYuDDSXX8LTdaOufm8WV
	 Xb8duaUeOc0vzB4TRClL86pgFurF+nQmuXZrNCCzC7a9m8iCzTQS8NZZ1HY0DkNx4c
	 LwkWUmy4F8pq/AF8DRiTJa5dLDrqjNicJ/htOWxA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C51D2F804B4;
	Fri, 29 Jan 2021 16:10:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 214F6F80259; Wed, 27 Jan 2021 14:56:37 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 749ADF8011C
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 14:56:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 749ADF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="n/IjJ3Ty"
Received: by mail-pf1-x42b.google.com with SMTP id y205so1241886pfc.5
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rzFHnjdjolgtpWkflpOnmhYdtFmZsj/BB+DFeZwIjKs=;
 b=n/IjJ3Tyhzz3Pe7z0TqbnPyg888eGH2O5Q4nUOCKwr/L9kPwvan+2slLx3ylTggwZx
 pTs8T3niZCEFucfg+VeHaOq4lbDsDTKQoxbU8wwF/CUodOCJ6oUo5DnBOEvLMzW1/xJP
 PxNtXTZ48tBW578t3BMt/HeH7AeD8Z8SS+L08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rzFHnjdjolgtpWkflpOnmhYdtFmZsj/BB+DFeZwIjKs=;
 b=QpDLSg2j9uGfkAUqWzyr89p/P2LZ4wesUn3Fwa6c0iEMFh0QmpuCnHh9w19mEOulhd
 Uq+cKqB/c19CBaLfthVLQUe4EUtjpDCjqHfi0EDS+w3ZAJcBGFq+69oywkiFdM67q2dg
 OcAzs+mIdx5WClbShqzZEsYVcrg2DdQvBcqafZJEMKlvV+9QdTf+VC/2GpZonQUQOkEi
 NFNRZ5eUlgQGQsBXyMJX1jbTm2uST+b774riX46cE/uzId9+16bqFZopTwNci4SbLapH
 KYm0uRUE5WS8ZjGnAUKyAu1IFY7jzbmPD1c7AE0tVUkV9PpGu8VUMJzR5Drxi0S6zaF9
 MIdA==
X-Gm-Message-State: AOAM532od29aX3t/+p6QygTR+KNeGIzOCKty/P3JYkFPR5SV1ZSgDKGe
 k4KZwxoIQAUiFPhwv7SFOCb7QQ==
X-Google-Smtp-Source: ABdhPJzxB/U4/4l/L5pINvHz4pnROnfoFxfXjZQ2EpnUVb2HeZ2kp+WJWLBkDtjx7IHNO18m3RWb0w==
X-Received: by 2002:a63:fc48:: with SMTP id r8mr11151181pgk.300.1611755789182; 
 Wed, 27 Jan 2021 05:56:29 -0800 (PST)
Received: from judyhsiao-p920.tpe.corp.google.com
 ([2401:fa00:1:10:a53b:f71a:ed56:92d8])
 by smtp.gmail.com with ESMTPSA id p187sm2526288pfp.60.2021.01.27.05.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 05:56:28 -0800 (PST)
From: Judy Hsiao <judyhsiao@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: max98373: Fixes a typo in max98373_feedback_get
Date: Wed, 27 Jan 2021 21:56:20 +0800
Message-Id: <20210127135620.1143942-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Jan 2021 16:10:20 +0100
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 Andy Gross <agross@kernel.org>, dgreid@chromium.org,
 devicetree@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>,
 tzungbi@chromium.org, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 cychiang@google.com, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
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

From: Judy Hsiao <judyhsiao@google.com>

The snd_soc_put_volsw in max98373_feedback_get is a typo, change it
to snd_soc_get_volsw.

Fixes: 349dd23931d1 ("ASoC: max98373: don't access volatile registers in bias level off")
Signed-off-by: Judy Hsiao <judyhsiao@google.com>
---
 sound/soc/codecs/max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 31d571d4fac1c..746c829312b87 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -190,7 +190,7 @@ static int max98373_feedback_get(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	return snd_soc_put_volsw(kcontrol, ucontrol);
+	return snd_soc_get_volsw(kcontrol, ucontrol);
 }
 
 static const struct snd_kcontrol_new max98373_snd_controls[] = {
-- 
2.29.2

