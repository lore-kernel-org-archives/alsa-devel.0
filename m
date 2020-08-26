Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D54C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:06:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F472087C
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L2CB5THn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UeOWj1bL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F472087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C43B1729;
	Wed, 26 Aug 2020 13:05:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C43B1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598439968;
	bh=FB5dmCCAQT1g/LCtWZJGxs6ua7+RUMQfGz4FPPM/CRc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L2CB5THnNpRaA+y7Z/nfiSRzUtQu6jiWaI+IajXGUk3zVT55ahsIZrRmYkLUs1f0b
	 ntv6/6zRj6wweHRYNpNBZ1DWQFqrqnR3PClUz55iIAxkEp3C53jb+OF6EmvIKKVqmt
	 8ubRixg12OicJ4etEOW1nx2WG79zAApa9tUa1KBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F316CF8016F;
	Wed, 26 Aug 2020 13:05:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 606FFF801D9; Wed, 26 Aug 2020 13:05:16 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFB38F80143
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 13:05:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFB38F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="UeOWj1bL"
Received: by mail-pj1-x1041.google.com with SMTP id z18so722352pjr.2
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mqlq1PfT56HOoFMV6L94hJv96dlmh01C5Xs6bahtBkI=;
 b=UeOWj1bLiRwpjx0xxo7VgpqGSSWO0JgJ1jDlPJnXdrM6c/bGEfxHVRjO52822EdGos
 hMjeRcRFC8MnALlN0EL5KFiJ7OeDjlvlw/2zKk58tdxtxb/emtza+ibHAB+OxblK09Lb
 CEPrqLjTKx3bpE5zD7EXrW2cyycWVsGx+84oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mqlq1PfT56HOoFMV6L94hJv96dlmh01C5Xs6bahtBkI=;
 b=JW/4Gb/4VKtUtZ6qoivFIPE+eaLM/eCKG1zkysgZi/V3Smeih7dd7ojMfATDUwgCXn
 a5ZrMNkNTSuDKkFCjLQUSOBEgYrwC2QX34s3MDPaM9QngUccC1h6vy4qYkw1sFlYdl3R
 FgB6PQYCYS68FmeIbKMax7eO6fPGy7BG588p2VMX0lJi8udDEnFvAKyp0AKJ9Sb0CCpg
 jhaAiPZu2BSBEK1JOXeMXue3ZTeB/szjoKTBpV76L6vGvWYSDh4YGtAfqZhfgwxc+Byt
 YADqCt/MCKo4c7HPyICDtGA+OlAy8P0e+/i+cp9dLiYE4X3QwBabyHwtuT0MIPWDkezD
 F5UA==
X-Gm-Message-State: AOAM532+IX+njvqjV3CEYHpZYvO4TFJ2zXzQj2/iHKiqwf3sr0XYC2H0
 Z0S1tsAzwLrMyiSqnEFTSaExnA==
X-Google-Smtp-Source: ABdhPJzkWckbe2f7/EY4eUKIYZ4JNt+7W4ArRJA9yhosyjN47O+337w2fSQAeHRBzXhqgEJos8I9Lw==
X-Received: by 2002:a17:902:9309:: with SMTP id
 bc9mr11228131plb.51.1598439901835; 
 Wed, 26 Aug 2020 04:05:01 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
 by smtp.gmail.com with ESMTPSA id x5sm1888539pgf.65.2020.08.26.04.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 04:05:00 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Add documentation and machine driver for SC7180 sound
 card
Date: Wed, 26 Aug 2020 19:04:52 +0800
Message-Id: <20200826110454.1811352-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
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

Changes from v3 to v4:
- Ducumentation: Addressed suggestions from Rob.
 - Remove definition of dai.
 - Use 'sound-dai: true' for sound-dai schema.
 - Add reg property to pass 'make dt_binding_check' check although reg is not used in the driver.
- Machine driver:
 - Add Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

Changes from v4 to v5:
- Documentation: Addressed suggestions from Rob.
 - Add definition for "#address-cells" and "#size-cells".
 - Add additionalProperties: false
 - Add required properties.

Changes from v5 to v6:
- Documentation: Addressed suggestions from Rob.
 - Drop contains in compatible strings.
 - Only allow dai-link@[0-9]
 - Remove reg ref since it has a type definition already.
Ajit Pandey (1):
  ASoC: qcom: sc7180: Add machine driver for sound card registration

Cheng-Yi Chiang (1):
  ASoC: qcom: dt-bindings: Add sc7180 machine bindings

 .../bindings/sound/qcom,sc7180.yaml           | 124 +++++++++
 sound/soc/qcom/Kconfig                        |  12 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sc7180.c                       | 244 ++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
 create mode 100644 sound/soc/qcom/sc7180.c

-- 
2.28.0.297.g1956fa8f8d-goog

