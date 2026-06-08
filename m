Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2792CD8C9F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:30:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1A5F601E2;
	Mon,  8 Jun 2026 13:30:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1A5F601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918248;
	bh=r6n7VzfROoKpU8dQtsIgWZS+PzUAAj4TZpbKmIdcY9s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KtYYdBsA5HDWCeynFx9BNfo702O4IDcAwayKfz93Id07SXRzNNk0jRqlsMxB8nl/Q
	 izUEf7ITcImH/EnPRcVKHaKcVp0iR+iI+6atXEwXIcGpkTLIMdKTkYSzIh6Ur614Vt
	 GayK0uSsYQFOEP2flPZOB5inWp7P4MOVdwDY0Zvg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5C23F805F1; Mon,  8 Jun 2026 13:30:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 145DDF805FD;
	Mon,  8 Jun 2026 13:30:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7299EF8055B; Mon,  8 Jun 2026 10:35:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.55
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907750;
	b=ZEyRXgFeOeMqYQGwMdSnA7M4R9xCdQwVNA7Hn67BLjUKSFXagmf5RPKT+7+XzrtUzMss
	 S8zUGQX6S2taL3PDelrtw+YrbJhdnKG2RvlIQWsSzf6hpUVVBrQo19IJluafbjglC4h3p
	 dMfs4uVeSLJoYGd46TuwhRRRLzi4F9SuXTsVBFVu6rzc0KWHD4nTOn2m8+cW3R01RoXeX
	 MklqyMgyglrx04Cr1UIw24oTIJwOyj6whOP1vXO2b0KPGZUYROl4/sQLeU2cEeeYQE2Ef
	 mQ4KUrOfBc07Hm2fMBTureHzBghl0FKFmTMV8Y3r0ptCK6ZJqEk0iGptxPIuL4raWXQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907750;
	h=From:To:Subject:Date:Message-Id;
	bh=r6n7VzfROoKpU8dQtsIgWZS+PzUAAj4TZpbKmIdcY9s=;
	b=VfNpMId/o1S5/dWzhIm3L/+sh2/TO7L6pRfJG/TQ2l5VzFzRStjbCXGUpm4ylletJ2uN
	 QP1w0RvLmV6A4YbBVItiZ1779thinRUAhVIUr0b37yrJMfjOxtcHDxEUPhRgx1uFuk/WQ
	 HPP4/fQ0r2p9P4Da+l7PCX81jyaRSYMP94yPRH5sO8I2y63fyj2mXUSYoUFT5rhQxoUzw
	 wpDj4bDx+7mbtZ6LdDvPwB6efoor7KQE0wf3dfSPq8TIA769lOdAK9qdRZbOAFy8tNFO7
	 5HiKaeASSrGmN9m6mouktL5trx5TiP7bjFCru9WgaTQwyRLXOxvev5Et8sKHGR9ce5w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.55
Received: from r3-55.sinamail.sina.com.cn (r3-55.sinamail.sina.com.cn
 [202.108.3.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40B74F8001F
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40B74F8001F
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:44 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 7159E92E2FA54055B451A0810323BEE7
X-SMAIL-UIID: 7159E92E2FA54055B451A0810323BEE7-20260608-163544
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 0/7] ASoC: codecs: ES8389: Modify the ES8389 driver
Date: Mon,  8 Jun 2026 16:35:33 +0800
Message-Id: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: VKNZVZ4TCNZVDMDKPZSQCBX4KRQCADMR
X-Message-ID-Hash: VKNZVZ4TCNZVDMDKPZSQCBX4KRQCADMR
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VKNZVZ4TCNZVDMDKPZSQCBX4KRQCADMR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

v0:
  - Modify volatile_register
  - Add MCLK_MASK to resolve the issue related to mclk_src
  - Modify configuration about clock
  - Add private members about HPF at driver and devicetree
  - Add INPUT MUX at route

Zhang Yi (7):
  ASoC: codecs: ES8389: Modify volatile_register
  ASoC: codecs: ES8389: Fix the issue about mclk_src
  ASoC: codecs: ES8389: Modify the clock table
  ASoC: codecs: ES8389: Modify the initial configuration
  ASoC: codecs: ES8389: Add private members related to HPF
  ASoC: codecs: ES8389: Add INPUTL MUX and INPUTR MUX
  ASoC: dt-bindings: ES8389: Add members about HPF

 .../bindings/sound/everest,es8389.yaml        |  18 +++
 sound/soc/codecs/es8389.c                     | 130 +++++++++++++-----
 sound/soc/codecs/es8389.h                     |   8 +-
 3 files changed, 121 insertions(+), 35 deletions(-)

-- 
2.54.0.windows.1

