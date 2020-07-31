Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA41C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:41:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616E20838
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nYUvCu1I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kLtktgDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98F8F1686;
	Fri, 31 Jul 2020 10:40:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98F8F1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596184900;
	bh=1pWA9vInJ1hR/hwUHbANhCnxu18DNGtvrheXFFb39MI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nYUvCu1IkBB2dLvj0OBuXNBkznV1YhMkwsK4KXZij0s+DtMdWEdONzvwXR0UQ38k/
	 lAig6QPAjXbJF4LtqE+kZKThH+l+HISBDJBnnSfSOx8Yw0t4JXUb9Z9k9Hog69uA0N
	 o9YRLgaSIvoROGq6ZMxzoWHPZ+09McKOcWK7bDsw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CCFEF8011C;
	Fri, 31 Jul 2020 10:40:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98A14F80171; Fri, 31 Jul 2020 10:40:47 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B918F8011C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 10:40:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B918F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="kLtktgDT"
Received: by mail-pj1-x1044.google.com with SMTP id t6so3355475pjr.0
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hLoyOTSzLDQ51ZbDgjh9dBtvJJhP5tr3Wm8F7z1KJp4=;
 b=kLtktgDT7wK6kb+GRIVgYIgjMj1Q9zyL3263W8/hcM8IocBdBKdKdeUWIuG2YcWJuw
 owIX3/G2px/aecdN3/RT5vBPi5W7AXvDXV4aF4lOivG0ZpLsy2bLJW6qhwXCELjewcVU
 76iWJ4aNwDz09t9sM9bHrlyBWuEtn1gagW/Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hLoyOTSzLDQ51ZbDgjh9dBtvJJhP5tr3Wm8F7z1KJp4=;
 b=KEQKheVGhq/HRw5SqKGm8Hay8RXiHRH5FBS/lvt9vPXSmW5CQCgiapT5WSZmmwSuZU
 XrH69rssFW1i2uRb6G496cbtqb0iNq81++xtFuCPxlS/XyXOlvSBtUu45F1JCaqD+wo4
 y+z06kkmmCnUat/oK48ClCEHnqidhkK0l9R91D4eQd0thDR0P37OM3HVowytaGuaVxtq
 V0EQ5tTEJ0LScL7gdmpoTz7PA4Z8RI6O/2a4CJlDlT8GDK9AZfxxI3Dcnx0ALYbPDDCW
 wiQi2T8HEOq4/q2VNohOBq8mgxF1V6L+dUxgk2xGCJTBSs7pb9eof8BpNFnqk98+OgkR
 OAsQ==
X-Gm-Message-State: AOAM533myWLQhWXcbxxSjv9s1ZCs3gF8MmIfkEQ0d/GgqgXaPTwh+5LH
 XnBRrrERGzbPRvGdT7REhYeYZw==
X-Google-Smtp-Source: ABdhPJxis69iyu05nHzc4VnRq1YCk+CFnP8XU11HDYI1OHzqsIuE+QhGaGTRXtID4jo9NYYZYlLyAw==
X-Received: by 2002:a17:90a:a60a:: with SMTP id
 c10mr3247968pjq.117.1596184835298; 
 Fri, 31 Jul 2020 01:40:35 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
 by smtp.gmail.com with ESMTPSA id x10sm8856411pgp.47.2020.07.31.01.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 01:40:34 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add documentation and machine driver for SC7180 sound
 card
Date: Fri, 31 Jul 2020 16:40:21 +0800
Message-Id: <20200731084023.2678931-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
 tzungbi@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, alsa-devel@alsa-project.org,
 Andy Gross <agross@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Mark Brown <broonie@kernel.org>, dianders@chromium.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, dgreid@chromium.org,
 linux-arm-kernel@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
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

Note:
- The machine driver patch depends on LPASS patch series so it is not ready to be merged now.
  ASoC: qcom: Add support for SC7180 lpass variant https://patchwork.kernel.org/cover/11678133/
- The machine driver patch is made by the collaboration of
  Cheng-Yi Chiang <cychiang@chromium.org>
  Rohit kumar <rohitkr@codeaurora.org>
  Ajit Pandey <ajitp@codeaurora.org>
  But Ajit has left codeaurora.

Changes from v1 to v2:
- Ducumentation: Addressed all suggestions from Doug.
- Machine driver:
  - Fix comment style for license.
  - Sort includes.
  - Remove sc7180_snd_hw_params.
  - Remove sc7180_dai_init and use aux device instead for headset jack registration.
  - Statically define format for Primary MI2S.
  - Atomic is not a concern because there is mutex in card to make sure
    startup and shutdown happen sequentially.
  - Fix missing return -EINVAL in startup.
  - Use static sound card.
  - Use devm_kzalloc to avoid kfree.

Changes from v2 to v3:
- Ducumentation: Addressed suggestions from Srini.
- Machine driver:
  - Reuse qcom_snd_parse_of to parse properties.
  - Remove playback-only and capture-only.
  - Misc fixes to address comments.

Thanks for the review!
Ajit Pandey (1):
  ASoC: qcom: sc7180: Add machine driver for sound card registration

Cheng-Yi Chiang (1):
  ASoC: qcom: dt-bindings: Add sc7180 machine bindings

 .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++
 sound/soc/qcom/Kconfig                        |  12 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sc7180.c                       | 244 ++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
 create mode 100644 sound/soc/qcom/sc7180.c

-- 
2.28.0.163.g6104cc2f0b6-goog

