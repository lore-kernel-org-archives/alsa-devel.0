Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CE4C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 13:50:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B65E022A7;
	Fri,  3 Dec 2021 14:49:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B65E022A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638539448;
	bh=AnDiFrsgV5WgdCgD8vjRtGdtU3v0T9/rxm9SYGxtvnE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=penr85wyM1KsHxl9/fyIH7P8WFgsZZYMWiwEWVW/bxlU/k/imAjqFsTBvoxontgc4
	 Kcv/L8b+FsQBeRzyJjz9PDw3lc+21EthtixxsBNEMdlBdCMhAOrEp9PKKNV550h11I
	 EUDpS8g99+rhvD1mCqvoIWVZNGP3ss1FY6zIkzys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16DC0F80085;
	Fri,  3 Dec 2021 14:49:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83AE2F80246; Fri,  3 Dec 2021 14:49:56 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5A1FF80085
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 14:49:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5A1FF80085
Authentication-Results: alsa1.perex.cz;
 dkim=fail reason="signature verification failed" (2048-bit key)
 header.d=collabora.com header.i=@collabora.com header.b="U4qKWwHG"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id AE14E1F46E6B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638539389; bh=AnDiFrsgV5WgdCgD8vjRtGdtU3v0T9/rxm9SYGxtvnE=;
 h=From:To:Cc:Subject:Date:From;
 b=U4qKWwHGBDOLXZNq09fFcdqG5Z0XOoQSRBlzu69SNN/pCMIkTqYPVmTGrVflpYhZc
 wzOEwvU7RzU3bn1wHyYOVfLkpJJK1hGOlA1NsHggtOJcgnv0zLSIGNN7MnNk6DgDC4
 gPtCqQ8n4X9+cI1JrO8ofbrC6wh4bl2ittvPPsrYO8P6Hh37HmwLEZRN6nh4BS+Yte
 THRnwVeBVc4rbY4EKE8SF8QfgE0B9Fvyagc++Js66UmJrzbscdgNnneNl5toYzxWXa
 DwFILZWXXsrD4plKThLJ+R3Lto9OsxPBJbGGN81MmGURWGYr5rq/MV3uDmaVBJIPbd
 hm6Qgag1EZ4Kg==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting
 mclk-id
Date: Fri,  3 Dec 2021 10:49:26 -0300
Message-Id: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
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

Ariel D'Alessandro (4):
  dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
  dt-bindings: tlv320aic31xx: Define PLL clock inputs
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
2.30.2

