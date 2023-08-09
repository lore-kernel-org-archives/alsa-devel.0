Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48259C001E0
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Aug 2023 18:51:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60FF1828;
	Wed,  9 Aug 2023 20:51:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60FF1828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691607113;
	bh=rftLgkSKOtXUv4wd6JIw1V0s7EO3TYi1OpM0hWfrrA0=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GV1v6l2k0+D3BBzYo2RonynncDBpssBSwo0PQ+oXxvaJeASMxrtEyzybzJ+PVSFvv
	 TD6VkYhVl1CGTeGt7ZhVkulSFctQewyBJFDNYs2dd3AqB7FPvAPNsp/md3u/qXhRp+
	 +N2v8uAtmiJaDPI/E6AAQc+uh1P0noW34nI6FHIE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05CB3F80134; Wed,  9 Aug 2023 20:50:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E07DF8016E;
	Wed,  9 Aug 2023 20:50:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 703E4F8016E; Wed,  9 Aug 2023 20:50:37 +0200 (CEST)
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25A39F800FE
	for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2023 20:50:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25A39F800FE
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 0459DFB08;
	Wed,  9 Aug 2023 20:50:30 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wj_B-az9m8JC; Wed,  9 Aug 2023 20:50:27 +0200 (CEST)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Peng Fan <peng.fan@nxp.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	kernel@puri.sm,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	David Heidelberg <david@ixit.cz>
Subject: [PATCH v1 0/5] Device tree and config updates for the Librem 5 devkit
Date: Wed,  9 Aug 2023 20:50:09 +0200
Message-Id: <cover.1691606520.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: J3M4EXU6RVDIJNTOL746IZSTWANSZEBA
X-Message-ID-Hash: J3M4EXU6RVDIJNTOL746IZSTWANSZEBA
X-MailFrom: agx@sigxcpu.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J3M4EXU6RVDIJNTOL746IZSTWANSZEBA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The device tree updates ensure the A53 don't get powered off and fix a
DT warning. This isn't testable with the arm64 default config unless we
enable the rsi wifi modules too so do this as well.

While at that include two binding file updates.

This is against next-20230809 that include David's option,gtm601
conversion.

Guido Günther (5):
  dt-bindings: sound: gtm601: Add description
  dt-bindings: mmc: Fix reference to pwr-seq-simple
  arm64: dts: imx8mq-librem5-devkit: Mark buck2 as always on
  arm64: dts: imx8mq-librem5-devkit: Drop power-supply
  arm64: defconfig: Enable Redpine 91X wlan driver

 .../devicetree/bindings/mmc/mmc-controller.yaml    |  2 +-
 .../devicetree/bindings/sound/option,gtm601.yaml   |  6 ++++--
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   | 14 +++++---------
 arch/arm64/configs/defconfig                       |  1 +
 4 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.40.1

