Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8554ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 12:55:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A79C87664;
	Mon, 24 Oct 2022 14:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A79C87664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666616152;
	bh=R1hLjeE/13RmZT9ufBz7rWLCq9H/tdDCnbvNc5MNSl8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOGKSYhQ/+pc2VNf3nRz0VeniuHoqpuVtsq6UBo3I9RPkI8IlohiwaPAg7kQdah+y
	 2UjQ+JLjo1GgVWkkwMHCOvMgHBxugQ9EiDIlkLYxRkGSD3RSQA8R+eotaj+PRubDeM
	 s7sqj7OdMto4Jpd93yLCMNi0DDXg+67A5W7mQ5zQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D15E2F8053D;
	Mon, 24 Oct 2022 14:54:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 109D2F8053D; Mon, 24 Oct 2022 14:54:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91B28F80506
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 14:54:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91B28F80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S7KytBzr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC016133B;
 Mon, 24 Oct 2022 12:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FAAC433C1;
 Mon, 24 Oct 2022 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666616073;
 bh=R1hLjeE/13RmZT9ufBz7rWLCq9H/tdDCnbvNc5MNSl8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=S7KytBzrEgUtUvhGpSBPw7Ci7Dxyb9OFPQEbkKVNQlekdg+ZQ4mJD3y8aEOzncjew
 raradZC55KujNvnu2t3Wkr/opFo1x5/QrOcSlOD8p5SmKKiBZKiEK8ainnHCkV7Vam
 cc//z2BK+Sj83zqcBD74KQGINKt9CztkjbKXhm0OSmmu1z9avL875s4v8UTegY4LDu
 VzG8SFuGv3N55n3iVRXsQgxIv6sHe5cPPLv/Zr1LlnDau04jbbR483flnOBHVK47hD
 OUTWxy+IJwIobFo/Qk3bZuy21AXjptm2Z5gCKLHj5/h5AvSUUkzVsFXkmls4YqSosP
 DhWPGoEo8Zmgw==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>
In-Reply-To: <20221021175721.4005601-1-robh@kernel.org>
References: <20221021175721.4005601-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Message-Id: <166661607199.206380.14009012211378211408.b4-ty@kernel.org>
Date: Mon, 24 Oct 2022 13:54:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Fri, 21 Oct 2022 12:57:21 -0500, Rob Herring wrote:
> Convert the dmic-codec binding to DT schema format.
> 
> The '#sound-dai-cells' and 'sound-name-prefix' properties were not
> documented, but are in use, so add them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert dmic-codec to DT schema
      commit: 8da313ad1bd020859e2ee8a3e8e97e52425e539c

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
