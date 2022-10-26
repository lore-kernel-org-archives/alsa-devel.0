Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B49C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Oct 2022 19:07:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD2323951;
	Wed, 26 Oct 2022 21:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD2323951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666811224;
	bh=jigvxwCetpLc5oF2VkisZsZ/3RMk0Gd+pZHEiA7h9SY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TddV/IjqzA+1qNSZ0g4FbdSTHAUR3LQidRAay1Au2ztNENw01XFBHXGdQvcT+/teC
	 V1WFq3d6HfkixQdSe7xXheaU4PbbPJJqAeCPOcpWlzAL6HwQb0Sn6pHTeVwKHV1CHQ
	 rRyv18vDznBlxnh8pg6dRV42Wn2JB45KdxGQU+9A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 625BFF8057B;
	Wed, 26 Oct 2022 21:04:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EB3EF8057C; Wed, 26 Oct 2022 21:04:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF214F80568
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2022 21:04:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF214F80568
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kojtzzgA"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7D0BB62041;
 Wed, 26 Oct 2022 19:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1438C433C1;
 Wed, 26 Oct 2022 19:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666811077;
 bh=jigvxwCetpLc5oF2VkisZsZ/3RMk0Gd+pZHEiA7h9SY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kojtzzgAaRJHO7+uca3F+Lf981cTgd1JdwRSskFAw07Eazw4QUigKFVcy/7aVHho9
 tZBexbTcfk5HlMk8KxRjRcE0e65AEvVeSToebu36IbL6sLFvlFJGF6UfkFvxuatAAs
 R8ES+3Hn5hy0IhrkZxUbbvLogzSYHHsdQRf299A2m9kwf7WpNWglW13gzJyLsOzILp
 +Tz9/Upa8PKIRHn1PC+pnmxkWUH8QIyjBq1B20eKBz8BJR105CfCE/73To5ygCnfcK
 7kRIwg07ayMVmI4MlycHnIyxBYkdIOSeoBi5jxFkt2KznYYIUcOkc1L075O9PehC1U
 xxrbEVXnj4qdQ==
From: Mark Brown <broonie@kernel.org>
To: Nícolas F. R. A. Prado <nfraprado@collabora.com>
In-Reply-To: <20221024220015.1759428-1-nfraprado@collabora.com>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
Subject: Re: (subset) [PATCH v2 0/4] Add missing dt-binding properties to
 rt5682(s)
Message-Id: <166681107571.960840.18310900106684311348.b4-ty@kernel.org>
Date: Wed, 26 Oct 2022 20:04:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Mon, 24 Oct 2022 18:00:11 -0400, Nícolas F. R. A. Prado wrote:
> This series adds the missing sound-dai-cells to rt5682s and supplies for
> both rt5682s and rt5682.
> 
> These properties are already used by sc7180-trogdor.dtsi (and derived
> DTs like sc7180-trogdor-kingoftown.dtsi), so the commits in this series
> are really just documenting their usage.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
      commit: 1c44873993d97f1da264ae9a7adb336d6af8ff9b
[3/4] ASoC: dt-bindings: rt5682: Set sound-dai-cells to 1
      commit: 07b16192f3f01d002d8ff37dcd4372980330ea93

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
