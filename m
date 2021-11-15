Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B37C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:38:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD061B48
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BBD061B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D19A1698;
	Tue, 16 Nov 2021 00:37:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D19A1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019510;
	bh=2BLuML7QlU7NsI1hA9jTUfLKUXT81kLYlx9JSVSAxQM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W4ocIgXhjq0U/PqNQCRq7WJqgpzfJnHyomWmE+8+8lQW66LvWGifML9/1p9BJXhZN
	 XhBF6d09IWCs4eHkKX+aGqM+IKHaKri24xjgmQg/ikaa3Oe8R0JFVxI6iJzDu6JjWW
	 /OZj0mrSiRfWpvKyTPLBEtBuL1d7SyQnayHDc4Y4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D6E7F80515;
	Tue, 16 Nov 2021 00:35:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6259F804FB; Tue, 16 Nov 2021 00:35:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D8E5F80134
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:35:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D8E5F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ECdCqy8b"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D71BB61B3D;
 Mon, 15 Nov 2021 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019309;
 bh=2BLuML7QlU7NsI1hA9jTUfLKUXT81kLYlx9JSVSAxQM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ECdCqy8bYsf1/UCfEWI36qc+40S1DXBLScAOAQeEkCr4OWKhjDIE4O1q1aHq9ZVDm
 uAPrv65eA5Boy/Ehv/PHcxqWuYg/rD06quBG7Mx6SJhiblxBzxVNNiZL0z9srVfOgp
 Ft8lvyUq3fPfEfg2eqAmY5PaTJbBZjfbjpNUvzBJr3IR4cxRZpzngqJghg+ZI0e6TS
 t/UE/bPXIlD4WcSjQeRmuKJ9y+tBJwbxmV3cfyi4AVuNiDSLuyx4dzihtgtpJBmgbh
 aQcaumIcBJf6B4TSE7s5gWvgmLz2twbgdD08sz/+gv5caB6Lak+67joNIXuuPefX77
 OmtdLp3qAqV2w==
From: Mark Brown <broonie@kernel.org>
To: - <patches@opensource.cirrus.com>, David Heidelberg <david@ixit.cz>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211028124639.38420-1-david@ixit.cz>
References: <20211028124639.38420-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: sound: wlf,
 wm8903: Convert txt bindings to yaml
Message-Id: <163701930762.675370.11238236735151846802.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:35:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
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

On Thu, 28 Oct 2021 14:46:38 +0200, David Heidelberg wrote:
> Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
> binding documentation to json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: wlf,wm8903: Convert txt bindings to yaml
      commit: 5ecc573d0c542c0f95497ba4586a6226814e4e18

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
