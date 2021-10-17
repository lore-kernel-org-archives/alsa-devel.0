Return-Path: <SRS0=RDt5=PF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F0FC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Oct 2021 11:46:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E173461054
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Oct 2021 11:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E173461054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E84A185A;
	Sun, 17 Oct 2021 13:45:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E84A185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634471174;
	bh=ohuMuYmmuyqyemJ4Qv+2X0qk6HWlk0oTy0Gz89ptlUo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpNFRI6ILnE8a/EXmulyEt+oVEiScNvZFS48Ug8rv/Z0pcSnMHVk5X1gLRd+qfGq/
	 CfiiKBmARr58p69kcsMh1LXziS8vzGaw7PCE1AjjCVCdPkrCKJrIpafRgzDc7pzTIc
	 TgAOGA58gJFDLSPbzaLMJ9uQReI4kcf884+ecMh8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E69DF80254;
	Sun, 17 Oct 2021 13:45:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09358F80256; Sun, 17 Oct 2021 13:45:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CE83F800E5
 for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2021 13:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CE83F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ba2+hAgq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 011D360FE3;
 Sun, 17 Oct 2021 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634471115;
 bh=ohuMuYmmuyqyemJ4Qv+2X0qk6HWlk0oTy0Gz89ptlUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ba2+hAgqogX5pyL/+cDfcC/L2/wrEGbJ9jKoi7XLGpqxScs6BytFNYjroMCWo/BVH
 V+GJtRe3JCtiIzpaITvLkS+jLIvdiSb32DsLjoQ3NldEKjX1Yr1DFm8qn725IcxcSv
 jeT3TatImQUuV2OsfLKFo+Nm+84zySMQ/ebFVXr/9mLOLZ/9UAQQRUOge9SjHjiOSr
 ZzcA9VZGfmETOOswrvr4h/N1OIO26N6D8Bkr4ffpswJF7NlbOTyIBoNsIwRP9e8+IO
 +X1ZiW59EdhB9dS+GW6CZDTQsdmututWLb5IXDOjZttz+DPhGsDYCvPpsdTHpiDOkn
 aXlduszwQTqEw==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: (subset) [PATCH 0/4] Getting rid of the reset controller in
 i2s-tdm
Date: Sun, 17 Oct 2021 12:45:06 +0100
Message-ID: <163447061131.1864024.8259786717418291207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
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
Message-ID: <20211017114506.BJQNQvwkY0_ibcCzDxfWS2avCuMaWYt4zBVH1mllmu4@z>

On Sat, 16 Oct 2021 12:53:49 +0200, Nicolas Frattaroli wrote:
> after some discussion with Heiko on IRC, he has admitted to me
> that the rockchip,cru property, and its corresponding half a reset
> controller in the driver, is weighing heavily on his mind.
> 
> The background is that if the lrck only uses one clock for both rx
> and tx direction, then according to the downstream driver, the rx
> and tx resets should be asserted at roughly the same time to keep
> things in sync.
> 
> [...]

Applied, thanks!

[1/4] ASoC: rockchip: i2s-tdm: Strip out direct CRU use
      commit: d6365d0f0a03c1feb28d86dfd192972ddc647013
[2/4] ASoC: dt-bindings: rockchip: i2s-tdm: Drop rockchip,cru property
      commit: 4e52cb9e2c22c9d860910794c82461064baadd9f

Best regards,
-- 
Mark Brown <broonie@kernel.org>
