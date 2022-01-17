Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A7CC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jan 2022 13:22:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84A5F17B5;
	Mon, 17 Jan 2022 14:21:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84A5F17B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642425747;
	bh=cLpfRqHBURM9rPTwgK+plOEmXlOGSYOFoD1NYi3A9mc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Yzl6D0lRBFCV1uoNiVnff5S1ENfu+P8UuvHAvJcZyhZFAVGP+ndwCdM2mjQi7OVc3
	 p2YvFX36yKYybg7eZ1xM3dTLf7wbic2O4cmt8FMo1bbx9OECMiMYc2sNA0iRcQh2K4
	 /McArc7wIDEzKEwxEz7eoaye8hnoM7Wjr3PoTJCU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20BF0F80249;
	Mon, 17 Jan 2022 14:21:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09E59F80249; Mon, 17 Jan 2022 14:21:32 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2F56F800EB
 for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2022 14:21:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2F56F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="AuQBprJ8"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id 9FE951F439D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1642425686;
 bh=cLpfRqHBURM9rPTwgK+plOEmXlOGSYOFoD1NYi3A9mc=;
 h=From:To:Cc:Subject:Date:From;
 b=AuQBprJ8i3XCaq30qQMFk4a9PThm05/O46+YIvsdbm1F+SQT5ZBUWBz4gAhyQiSj1
 ll7IXNX9lzGT1dFT8+Y6yppTQeRGlFzdji++G2JEcXNxHah7P13D1RYZQPwkWZG1SH
 ueqe792bXa1IwliwmL0uQW4/DBSVFVoYxHYL/LbBeWqSPneJiVIH7LlO7ana3HqGWE
 H0oDsoH004kaMx7wt/Fn3qBd3JpBzmMUpOKlScZ/YZG0CXxOP+/8fxzD/qZVisSZQ+
 aHdfRBtNkPgVNmPw7KGYTObE/6NySch99Pr7G29on7YxfuDeS//DZ7jPX8YSq7FdAd
 speTeoYIXz7Uw==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] fsl-asoc-card: Add optional dt property for setting
 mclk-id
Date: Mon, 17 Jan 2022 10:21:04 -0300
Message-Id: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ariel.dalessandro@collabora.com, kuninori.morimoto.gx@renesas.com,
 Xiubo.Lee@gmail.com, tony@atomide.com, shengjiu.wang@gmail.com, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, nicoleotsuka@gmail.com,
 broonie@kernel.org, bcousson@baylibre.com, michael@amarulasolutions.com,
 festevam@gmail.com
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

This is a follow up of patchset:

    [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx

Sound cards may allow using different main clock inputs. In the generic
fsl-asoc-card driver, these values are hardcoded for each specific card
configuration.

Let's make it more flexible, allowing setting mclk-id from the
device-tree node.

Changes in v2:
* Split patch adding mckl-id property.

Ariel D'Alessandro (5):
  dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
  dt-bindings: tlv320aic31xx: Define PLL clock inputs
  ASoC: bindings: fsl-asoc-card: Add mclk-id optional property
  ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id
  ASoC: fsl-asoc-card: Remove BCLK default value for tlv320aic31xx card

 .../devicetree/bindings/sound/fsl-asoc-card.txt    |  1 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |  9 ---------
 include/dt-bindings/sound/tlv320aic31xx.h          | 14 ++++++++++++++
 sound/soc/codecs/tlv320aic31xx.c                   |  2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++++-
 7 files changed, 24 insertions(+), 13 deletions(-)
 delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h

-- 
2.34.1

