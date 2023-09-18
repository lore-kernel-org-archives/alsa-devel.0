Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F7EC46CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 13:17:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E35A6C1;
	Mon, 18 Sep 2023 15:16:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E35A6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695043033;
	bh=FtIPupAgoajGdhtCQzmapwF+AUP8svBgsX55hKl9MSE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=j7xUmgfcRWDxI1mFoHKb/0/DUr3iEvaJkUpr9v8w3yMsxP55Gloae21vaKG9YLJvz
	 ialbXgTkuhX2k0ZgC6vuHZuAncvjlhJZDd0e8fAAGVC/cq/MRqbFa77V/THq4R/xrj
	 oGUZjz3UzKMeHtbsD9Ta9k0IAccSEnTbR9uNzmi8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1DBC6F8047D; Mon, 18 Sep 2023 15:15:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3EE4F801D5;
	Mon, 18 Sep 2023 15:15:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10FEBF801F5; Mon, 18 Sep 2023 15:15:50 +0200 (CEST)
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com
 [IPv6:2001:41d0:203:375::dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21ED5F80125
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 15:15:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21ED5F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=jookia.org header.i=@jookia.org header.a=rsa-sha256
 header.s=key1 header.b=0Cv0iCXp
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1695042943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pfa3PBg9asYKtNt2koiep7HfxuIir4IkICmX1c8bfJw=;
	b=0Cv0iCXpSncpg9/iBG2W/hr3ugd7Y6aCght+CRTbusQBhXrfkoyA5e3PqQAVcCNmSrKE10
	bFRCKoSTwnljO2/jOD21GAH9z4qCHGdOPWlA3r/nJ64qGw2H7cCwfQmc6jvmqtFAVuJv5j
	YjAzkWFqdFp9/rFy0yOiFg/kYyfVynqPM2BBOYQ5vWSSKy3CWwD0lVFVWPRZ/J6fYBzkcr
	Wz1w9KkU9qpGG1K9hZn5iJexFKp8hrHD4Gmn1qEgxlaCeZGPVyoIWVzxQOv2lmGP+eTm6h
	X/6sdcR7IwrSKdKHWOsBqTKN5S08v9k5dTh2SBP2ja393+93AshOUuudHaFhQQ==
From: John Watts <contact@jookia.org>
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	John Watts <contact@jookia.org>,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] ASoC: wm8782: Allow higher audio rates
Date: Mon, 18 Sep 2023 23:15:29 +1000
Message-ID: <20230918131532.2257615-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: ZYS2G7WPVTBIOXQLT72Z6SHU3UEDSX5O
X-Message-ID-Hash: ZYS2G7WPVTBIOXQLT72Z6SHU3UEDSX5O
X-MailFrom: contact@jookia.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZYS2G7WPVTBIOXQLT72Z6SHU3UEDSX5O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The wm8782 supports higher audio rates than just 48kHz. This is
configured by setting the FSAMPEN pin on the codec chip.

This patch series introduces the 'wlf,fsampen' device tree property
to indicate the pin status and control the maximum rate available
when using the codec.

v3 -> v4:
- Default value is specified in device tree documentation

v2 -> v3:
- Rate is now properly constrained using ALSA constraints

v1 -> v2:
- Switched from max-rate property to wlf,fsampen property
- Clarified property is optional, not required

John Watts (3):
  ASoC: wm8782: Constrain maximum audio rate at runtime
  ASoC: wm8782: Use wlf,fsampen device tree property
  ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen property

 .../devicetree/bindings/sound/wm8782.txt      |  7 +++
 sound/soc/codecs/wm8782.c                     | 63 +++++++++++++++----
 2 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.42.0

