Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E3FC54EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 13:28:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED2C1850;
	Tue, 20 Sep 2022 15:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED2C1850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663680508;
	bh=emZ0PSvN7PdJPmfg7UowvInfJkjTANIHUiCWV15huMs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T2Pu2Fv0DPf+KPhKRqYB6hmKAc9fWSWt1/PVsY9EPQRDBdvwz137XAfGU4mvrDjlx
	 BGf9uf42LeQGhQtwVmclPdkkfZveZnu6kJ5uM9lLXvOv2BQzJSwLI3rHkwxl3DyLIK
	 XkUmr520iILCQcBz2cphRUarvH+HDTnUuhktU4M0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C5B8F80155;
	Tue, 20 Sep 2022 15:27:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11013F804DA; Tue, 20 Sep 2022 15:27:36 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FFAAF800C9
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 15:27:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FFAAF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="euL0dHN1"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 415F0B818E4;
 Tue, 20 Sep 2022 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CB7C433D6;
 Tue, 20 Sep 2022 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663680451;
 bh=emZ0PSvN7PdJPmfg7UowvInfJkjTANIHUiCWV15huMs=;
 h=From:To:Cc:Subject:Date:From;
 b=euL0dHN1z+HxNswXUDd143M2jKANlGQv+76sWsqypWhASSucurFxAkg4GzKyKDdmp
 wdJQsg5o/1RDQMELAs5PVDbtl3EcL7RkSWjhVnUvPE3Vw1l5rh2mVQh5TGDiM+hUBQ
 pWv5Wiv3mEurVDQLV83VKKYRWL05qFAYeuS60ZMbDa7KfD/lJHTmQPGS85zN6f44Js
 LatCP3mq6iIeCZvrTAlRtlKeUSVY3CzM7fws/xGAVXRjKNaQb3tuDzl8mUP2GYoNu0
 FXen0Tq5HXNQMEfrzzf+iAngb9maU0QvpQWNTOV2ZD4eec0sNxyW7YqIRIVipx36DP
 v4kVHR1lrDFQQ==
Received: by pali.im (Postfix)
 id DA93D97E; Tue, 20 Sep 2022 15:27:27 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 0/5] ARM: mvebu: Add audio support for Armada 38x
Date: Tue, 20 Sep 2022 15:26:43 +0200
Message-Id: <20220920132648.2008-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

This patch series add audio support for Armada 38x. It contains commits
from Marvell linux repository

https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/a1d70444cb0476a7524273274ca8e6d52ce6f1fe
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/f365c93237787c7a64f2617da9425eb01e09e71f
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/b645bfa9121214d6456de3df6b8e577f2c01c6b3
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/829c96c206f2930e5323064cef57158bd780730d

first two squashed, rebased on top of the current linux master branch
(at v6.0-rc6) with additional patches which adds S/PDIF support on
Turris Omnia - A385 board.

Marcin Wojtas (3):
  ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
  ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
  ARM: mvebu: add audio support to Armada 385 DB

Pali Rohár (2):
  ARM: mvebu: Add spdif-pins mpp pins for Armada 38x
  ARM: dts: turris-omnia: Define S/PDIF audio card

 .../devicetree/bindings/sound/mvebu-audio.txt |  14 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts |  27 ++++
 arch/arm/boot/dts/armada-388-db.dts           |  69 +++++++++
 arch/arm/boot/dts/armada-38x.dtsi             |  24 ++++
 sound/soc/kirkwood/kirkwood-i2s.c             | 136 +++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h                 |   2 +
 6 files changed, 269 insertions(+), 3 deletions(-)

-- 
2.20.1

