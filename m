Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A5AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 06:07:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF52023120
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 06:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF52023120
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDD3A16B0;
	Wed, 13 Jan 2021 07:06:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDD3A16B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610518045;
	bh=7CE9mmOTtUeHM03dsqlsdOYUKqygzWg1NX2kSwo1NFw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SphPowHbMmz8wWfF3t6VXTiIZJq9pUB9I6zwgVGacrvIrwFcEvMNjf4dT3iY2V6O0
	 81bnZtDLxPdVVB3ZTn7HOpyIG/ufW7Dx78BLQJD2rsGz9Mij7b0qW6OKS99/ddWXtN
	 QnTL9T20a6QEMHBydqe9Ev1tUMG7+9CHUzpXrXnA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23C30F8026B;
	Wed, 13 Jan 2021 07:06:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AFCDF804C2; Wed, 13 Jan 2021 07:06:31 +0100 (CET)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43A01F8025F
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 07:06:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43A01F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="UXIuD5U6"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="jWbYxSHi"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.west.internal (Postfix) with ESMTP id 7FD8F1B95;
 Wed, 13 Jan 2021 01:06:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 13 Jan 2021 01:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=KmMtZW3LZXLFSWy68G91BENlig
 LhFytnhm96lSzkJKY=; b=UXIuD5U6hOM1PeSc76T8bghdTxcioJVx11QwovyKYd
 4PvuSq6WbgYFQ/X2QqjaC/EHW+TQ4PG+yIBD/aDBEWkwzV+wmuSdp9KRy/ZWxhzt
 n6IEk2A/uLm6pHu6P6l+1yzcWGqxSxkJbfyDiDOvKnhPMIudZLN5j4DH+3xMY/nq
 BRmZSB6yGwEXnJTL/5CzqdiK/rQqwxdXgjd7nNL9c+/NHgtuPqMHrLo8XzKsYqL9
 YPWGll7ksbhXh0Kgw4LIgJTzuB8qNOPwVO+X4bmDJZ+CFfNUMcrKeMt5ZcJ806YP
 ME18OzW5KrBW7y5efSOKGBfF80Ch6hGewVOTfKDHmNIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KmMtZW3LZXLFSWy68
 G91BENligLhFytnhm96lSzkJKY=; b=jWbYxSHimgfdzYv1kRqdLmv56bVvP+IPP
 uYO4Nmg1ZCYswJAfvT0pWoYcCQU8EuBzl3eQS1SZ08HfMljGjbETvmO8yesQoCbm
 i2MQkkJRGp+/yuLa6pb898L4rdM1uQc3vDzJD2FMT+J1Fo0ADqLp+v5E3fBV12z/
 LI7wqoUp3iq6LI91FY4cIe7NR2dZZ1p/PsuzuqKl562xvsiEnkpBHPImXkq4LwAd
 T8u+TmI3MbrtQvaz55iK2RYXAgxPbEXpU8mkPwIUdN0T55EAaqx0V4yRBRAYRZ+y
 d+UOJ3AhMuLdaPLEOGlu4aS9+VbqYGZy3oeBJgbH54b4n4mTKXA3Q==
X-ME-Sender: <xms:2I3-X6fTgSHlfhlUYrVesWYjQW5XlPqG0gF8Vc0mOjJGWxFY2lLsyw>
 <xme:2I3-X0NEWSAl6ug8PcjDZBJcdLaam4C_t3yWAJ9DquzIeE0p226FbJtJ9GHNS2RYn
 JbcDssthugniljh5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdelfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
 ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
 htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
 tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
 rhhg
X-ME-Proxy: <xmx:2I3-X7iaevjNiQOIx9nS208QHLFMirvUGN_RNzdQnXzeM7U8kpYzJg>
 <xmx:2I3-X3-cuGkeIDb24Ti7hJ4CvIXQavn48cKT10BMtNTboT349yzfPw>
 <xmx:2I3-X2uAjIMOKnhlHTq7JnMjtrRVhFK35AUVqEnFyx1iS2eOCWGkpg>
 <xmx:2o3-X0ChZV9Zn_C8kQ7CEA2MEwN77Y-tt905xHzVQVvsjBCeL_SfN2mWJkw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 629A5240057;
 Wed, 13 Jan 2021 01:06:16 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/7] PinePhone BT audio bringup
Date: Wed, 13 Jan 2021 00:06:08 -0600
Message-Id: <20210113060615.53088-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
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

This series makes use of the additional DAIs recently added to the
sun8i-codec driver to add hardware routing for BT SCO (headset) audio
on the PinePhone.

The BT audio connection is represented by the "dummy" bt-sco codec. The
connection to the Quectel EG-25G modem via AIF2 works as well, but I do
not include it here because there is no appropriate codec driver in
tree. We have been using an out-of-tree "dummy" codec driver for the
modem similar to bt-sco, and I'm not sure if such a driver would be
desired upstream.

Changes from v1:
  - Fixed DT binding example to follow new binding

Arnaud Ferraris (1):
  arm64: dts: allwinner: pinephone: Set audio card name

Samuel Holland (6):
  ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
  ARM: dts: sun8i-a33: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
  arm64: dts: allwinner: a64: Allow multiple DAI links
  arm64: dts: allwinner: pinephone: Add support for Bluetooth audio

 .../sound/allwinner,sun8i-a33-codec.yaml      |  4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              |  4 +-
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 25 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++++++++-----
 4 files changed, 56 insertions(+), 14 deletions(-)

-- 
2.26.2

