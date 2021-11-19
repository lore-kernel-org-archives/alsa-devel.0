Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Nov 2021 07:03:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79E3A1697;
	Mon, 22 Nov 2021 08:02:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79E3A1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637564610;
	bh=oBj7QbVGHlYfnfMUOtd1HZT668Gjf5aMJe4be82ORbo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D4f4RIKMlE0y68EfjvdQojKGhemnIFMx+gPkIUQ2We5AWIT+D1ETJR5XJej1bcYk/
	 QZ/mYgxnyciEhY5tc7p6i9rODVymHEsZeGs5Tn1cW0GETSV3yuUs7zojemINpWRlfB
	 4ftDO5SZKEqcu65zto6r0yXVRRcLXaTb9LCsUbGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EE93F80302;
	Mon, 22 Nov 2021 08:01:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9F27F80217; Fri, 19 Nov 2021 16:34:05 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDF0FF800FA
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 16:34:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDF0FF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=fail reason="signature verification failed" (2048-bit key)
 header.d=collabora.com header.i=@collabora.com header.b="LU1D/2zn"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id 239861F47554
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637336040; bh=oBj7QbVGHlYfnfMUOtd1HZT668Gjf5aMJe4be82ORbo=;
 h=From:To:Cc:Subject:Date:From;
 b=LU1D/2znRnmWQq9S9C99bWFA/kPVCKSRmdq6IEpjNr/rKOJ4bFAO3EQ2mLbFD0TP/
 PlOdn37gYW6Uquu+IGHXIg04zDysKrMQgoR8P+UJ8FGWNAxgKbd00zRG2r7hqQZtsa
 0TtEArzfJ6/8/a0yJ5y1xg8qI0QcAcyK8h1+A+FYGLxkLFT/Tt/ayZIlJOLDEjEC2v
 5v/EY0JnOPiVMeR5EavyjjUDwy8Sw3Q9IV2zfUDPaYUJtQJvzuV0b29l0ZlpDKaimj
 lAUIfOpTh2FmOrTcVSToFOwkzS3NbFST9BvuKJdoirPFTV0ExeGt2bt7Ps+ZIYZlRh
 jJR0rwu89STRQ==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
Date: Fri, 19 Nov 2021 12:32:43 -0300
Message-Id: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Nov 2021 08:01:48 +0100
Cc: bkylerussell@gmail.com, ariel.dalessandro@collabora.com,
 kuninori.morimoto.gx@renesas.com, Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
 tiwai@suse.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
 broonie@kernel.org, michael@amarulasolutions.com, festevam@gmail.com
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

The tlv320aic31xx codec allows using BCLK as the input clock for PLL,
deriving all the frequencies through a set of divisors.

In this case, codec sysclk is determined by the hwparams sample
rate/format. So its frequency must be updated from the codec itself when
these are changed.

This patchset modifies the tlv320aic31xx driver to update its sysclk if
BCLK is used as the input clock. This allows to be used by the generic
fsl-asoc-card, without having to add a specific driver.

Ariel D'Alessandro (5):
  ASoC: tlv320aic31xx: Fix typo in BCLK clock name
  ASoC: tlv320aic31xx: Add support for pll_r coefficient
  ASoC: tlv320aic31xx: Add divs for bclk as clk_in
  ASoC: tlv320aic31xx: Handle BCLK set as PLL input configuration
  ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec

 sound/soc/codecs/tlv320aic31xx.c | 105 ++++++++++++++++++++-----------
 sound/soc/codecs/tlv320aic31xx.h |   2 +-
 sound/soc/fsl/fsl-asoc-card.c    |  12 ++++
 3 files changed, 83 insertions(+), 36 deletions(-)

-- 
2.30.2

