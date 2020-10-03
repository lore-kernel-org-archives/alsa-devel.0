Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D9AC41604
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:21:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B095B206B8
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FmdKPvKn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM5gZ26q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B095B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8313E18E3;
	Sat,  3 Oct 2020 16:20:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8313E18E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601734856;
	bh=a+sRAu5FvR8UNMmAT6ZCuMr7SzbCGNrqucqkHxFTiXI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FmdKPvKnZY0Bl23GZgGvpJJumOj1QrwpTysKvQdalPsMm4c/2qyFMXEkDsv4PBsfl
	 l5fnqf+yIw2mhczQHTzYdtOmUeenYjtLMCO2klBM+zfM2+rXcKjiRw7wiAT+3JemBZ
	 Jv/rnTfbFoIOhQX0G7jkA+0+6fp9Bl/NnHrWewHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9767AF801DB;
	Sat,  3 Oct 2020 16:20:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E460FF8022D; Sat,  3 Oct 2020 16:20:03 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12031F800BB
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2020 16:19:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12031F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OM5gZ26q"
Received: by mail-wm1-x342.google.com with SMTP id l15so2943412wmh.1
 for <alsa-devel@alsa-project.org>; Sat, 03 Oct 2020 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sAKeLC7pKBrSZOIJOxRnqxVieh8N56D+SKtFZ1KaxX0=;
 b=OM5gZ26qxRLmtq3I0KrEhNN1Ve7bUeZ5qW6c2m+KV3XDw+XP6F5HqAN3aFsBoqh8/R
 r5EXMUPngagmQJ7ZJholjm7QwETF1PfOB3Xb523NuW6hZA6u3QkQMehgAUhPAB470rkm
 WHhTeJ7td0LNj4Gu3DHDpUOMI2dmdf+tSrrZLE5/1d+rwZGtgrHEs/XVMtd2Yp1pQLu+
 7ZGUy0XtT1GdMyKfga3jgcE/Cu8HeGl+a+9PtDYOrkh/mQKaxiGMmUdmQYnNI1Cu/7t1
 BvoDjDzc92Lry8+4eHcryQXaeALTKc3wo9rtquDtuSYTLXigTYuUqVWeCDrMWhtktc5G
 MePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sAKeLC7pKBrSZOIJOxRnqxVieh8N56D+SKtFZ1KaxX0=;
 b=dKvLwwDDhidXMn9p3wT5owVawj4C/m3sH9pUPG6+mlR+3mkyqMQwgOlhIG3HaWHXbr
 8TA4Mz1+Nv1j0zoFCey0l2lU7goW61qSRiST7QeWmEj8eR1ReB7uURYXKAjGZaXXrtS5
 rFoUSFZyhvrf+V+7/8uwUG+ERMb5HT1UrarJJ7nF8PLc4rZhztcaaCRC8c6S85s3bSeQ
 1m4DrMnGFhnK9uqW92s9x0swHPUN4ZtLCGHerby9sz0Lmka4qQJNjGAIHp0AcpXcLZTO
 5oojKUIix9S1hD+JHYVnXHDTYheOVRMyBJDNUxX7HX5C4LKWr1U/QAa+/CWRkETNps2a
 J5Vg==
X-Gm-Message-State: AOAM531zfCvj0gc3CHWapsweEe41Huh6kgSeZ7cJDt/dxzCaTowA/iCF
 SHAdsvTQdohSTn4Ty4iH/pI=
X-Google-Smtp-Source: ABdhPJyTeQ1m65Ns5vfNh53o537krrvtVOgQyCvbeT2a8kq2REcyo1Fx0HsdEvdPwNM5+u1CS7dBuQ==
X-Received: by 2002:a05:600c:216:: with SMTP id
 22mr7667470wmi.149.1601734794185; 
 Sat, 03 Oct 2020 07:19:54 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 07:19:52 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 00/14] Add Allwinner H3/H5/H6/A64 HDMI audio
Date: Sat,  3 Oct 2020 16:19:36 +0200
Message-Id: <20201003141950.455829-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi,

To avoid using set-tdm property of the simple-soundcard we will introduce
a specific soundcard for Allwinner HDMI later.

So I have dropped the simple-soundcard, the title of the serie is no more
relevent...

Regards,
Clement

Change since v5:
- Drop HDMI simple soundcard
- Collect Chen-Yu Tsai tags
- Configure channels from 9 to 15.
- Remove DMA RX for H3/H5
- Fix Documentation for H3/H5

Change since v4:
- add more comment on get_wss() and set_channel_cfg() patch
- merge soundcard and DAI HDMI patches

Change since v3:
- add Samuel Holland patch to reconfigure FIFO_TX_REG when suspend is enabled
- readd inversion to H6 LRCK sun50i_h6_i2s_set_soc_fmt()
- Fix get_wss() for sun4i
- Add a commit to fix checkpatch warning

Change since v2:
- rebase on next-20200918
- drop revert LRCK polarity patch
- readd simple-audio-card,frame-inversion in dts
- Add patch for changing set_chan_cfg params

Change since v1:
- rebase on next-20200828
- add revert LRCK polarity
- remove all simple-audio-card,frame-inversion in dts
- add Ondrej patches for Orange Pi board
- Add arm64 defconfig patch

*** BLURB HERE ***

Clément Péron (6):
  ASoC: sun4i-i2s: Change set_chan_cfg() params
  ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
  ASoC: sun4i-i2s: Fix sun8i volatile regs
  ASoC: sun4i-i2s: fix coding-style for callback definition
  arm64: defconfig: Enable Allwinner i2s driver
  dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel
    possibility

Jernej Skrabec (3):
  ASoC: sun4i-i2s: Add support for H6 I2S
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  arm64: dts: allwinner: h6: Add I2S1 node

Marcus Cooper (4):
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  arm64: dts: allwinner: a64: Add I2S2 node
  arm: dts: sunxi: h3/h5: Add I2S2 node

Samuel Holland (1):
  ASoC: sun4i-i2s: Fix setting of FIFO modes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   6 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  13 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  14 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  13 +
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 376 +++++++++++++++---
 6 files changed, 368 insertions(+), 55 deletions(-)

-- 
2.25.1

