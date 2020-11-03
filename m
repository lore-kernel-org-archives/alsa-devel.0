Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB68C388F2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:32:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5BD21D40
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dz2TmUg7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQZvAR/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5BD21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AD5A175A;
	Tue,  3 Nov 2020 11:31:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AD5A175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604399537;
	bh=Qs+HuCzY5JkfXj1+wAR4/wBV61DLgjv4CLSWekVUehc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dz2TmUg7FH7MysMUgM3y9EPb8+yVmi8xBuchWneo8904nOjUdiv3gy+JmcngvU6bm
	 QiglH3e78Q1b3naNS0Ng6IK4Qttfcib+Pi5NVgsWcsdH5p6cp0u6wnm36kDRIflCDb
	 8mYXDYBCboZnSc+/WK4LJEvXGN+wCgPTPvpBJT3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8A35F80162;
	Tue,  3 Nov 2020 11:31:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AA9AF80171; Tue,  3 Nov 2020 11:31:24 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0453F80108
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 11:31:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0453F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UQZvAR/U"
Received: by mail-pg1-x542.google.com with SMTP id i7so11403753pgh.6
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2020 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RwCtdM6b4YnLjvtF8V5rJbVv42DObRc22ofZtbywkoY=;
 b=UQZvAR/UeA2aq5TkvBMNg5oIDgOrWLrClw42qxh46HFMKXlIpXT3ncoh/MumsJYKvU
 FgzwtrDYJlyU2fOZjkh/DlO4gUFtIZlHDt76cAdycCpF4q4QiZCUC0uT3K0ENeQan4wZ
 3lIazIqT09oR/tjrddyUtqirSs5lvwJ8u8pEqP/hv27dtjZFgACeWpdVSxFNDt6eUYNc
 aBrwYjHWCIsof63x9EU9Q89UIwGGyFCfAejGYIPJQS/XDbniwLgozK0s9NUZjUtaVQx/
 cUsdbrpsBJoey+4Z+wrz6bDNNU1B049jWI7C/7MML6J8Wn3yo/vY/P0UyA3EgaAW5Y+4
 3P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RwCtdM6b4YnLjvtF8V5rJbVv42DObRc22ofZtbywkoY=;
 b=di3IE/qDJD8E2/H7mmaUWIMPiD7ylyawHZbnpUF6zgxUHtXDrzTiO7azQTusahR/jx
 1n71HDWjKf5mXC+hjZwMEO0LqaZsqcfjWI9VpFxQjvnIzvwSlXiyR55JNX5nUU3m1+I2
 Uoe3UqYygEJmJCTB2QG9skTe5fLoyWL4pcLLrzfdLFHrIoH68bFBFLr7vkXxumj5U4jt
 7rH2SjA1Hv95Bj/kRUhtWT0hxeJ+/TtDAmmPzGaBGne/tiTXAFcKPA29I36UPTO31oDm
 bfRaJGoJgOzMKTcq4YiTe+LCa3vMEXNAq9lq/nhEalFmmREIdRi9ks54DlN5i2jc+cn3
 E8qA==
X-Gm-Message-State: AOAM532fWXDH4V+UiJggQtMMKMz+hH9CcKHM9i6QQlBOj1hU24/jVjS/
 n4DBNl26E1VonYKINtAEnRs=
X-Google-Smtp-Source: ABdhPJxOkMLdjKssOgQo2Tmo6jO227+Icksti352LshSjn6MUs89LphDpnDlbGA2KYYZdcxdzqlbBg==
X-Received: by 2002:a17:90a:7e0a:: with SMTP id
 i10mr3144330pjl.89.1604399476622; 
 Tue, 03 Nov 2020 02:31:16 -0800 (PST)
Received: from localhost (114-34-18-97.HINET-IP.hinet.net. [114.34.18.97])
 by smtp.gmail.com with ESMTPSA id 6sm9777051pfh.112.2020.11.03.02.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 02:31:16 -0800 (PST)
From: Ajye Huang <ajye.huang@gmail.com>
X-Google-Original-From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Modify documentation and machine driver for SC7180
 sound card
Date: Tue,  3 Nov 2020 18:30:49 +0800
Message-Id: <20201103103051.34553-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dianders@chromium.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Rohit kumar <rohitkr@codeaurora.org>, tzungbi@chromium.org,
 srinivas.kandagatla@linaro.org, linux-arm-kernel@lists.infradead.org,
 cychiang@chromium.org
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
- The patch is made by the collaboration of
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>
 Cheng-Yi Chiang <cychiang@chromium.org>

v5:
- Machine driver:
  - Fix a format string warning (Reported-by: kernel test robot <lkp@intel.com>).
    detailed info at https://lore.kernel.org/patchwork/patch/1331087/

v4:
- Machine driver: Addressed suggestions from Tzung-Bi.
  - Remove redundant judgments in dmic_set() and dmic_get().
  - Remove 1 level indent of judgment of IS_ERR(data->dmic_sel).

v3:
- Machine driver: Addressed suggestions from Tzung-Bi.
  - move variables "dmic_switch" and "dmic_sel" into struct sc7180_snd_data.
  - Remove redundant judgments in dmic_set().

v2:
- Documentation: Modify the dimc-gpios property description and examples.
- Machine driver: 
  - Remove "qcom,sc7180-sndcard-rt5682-m98357-2mic" compatible
  - See gpio property and use anadditional control.

Thanks for the review!

Ajye Huang (2):
  ASoC: google: dt-bindings: modify machine bindings for two MICs case
  ASoC: qcom: sc7180: Modify machine driver for 2mic

 .../bindings/sound/google,sc7180-trogdor.yaml | 58 ++++++++++++++++++
 sound/soc/qcom/sc7180.c                       | 61 +++++++++++++++++++
 2 files changed, 119 insertions(+)

-- 
2.25.1

