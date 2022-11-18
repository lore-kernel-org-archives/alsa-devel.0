Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A87AC4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Nov 2022 14:05:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AE13169E;
	Fri, 18 Nov 2022 15:04:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AE13169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668780326;
	bh=2Etd7TTDGGQdc+eZ6ZY5zWcGDhXbE1E4P6nTodPzyHM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DDPBkClWUk93U9oBQ23V+91Z2Hrgxqly/lYj+KqDsrn0u9KnKgZJgOtY6mooplOaS
	 RBqYW7wKIy/HBP6d7uH0ZLzp8Hv82PkC6oHd6fOtQMXnFKwSU/OdoUSCsNMQzeuqvf
	 bc3SV/9BbtCnweSm+vkeDU9JvDV15j3Jh3R4qk4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14990F8020D;
	Fri, 18 Nov 2022 15:04:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B810F8020D; Fri, 18 Nov 2022 15:04:34 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B42E5F800FD
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2022 15:04:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B42E5F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LRI94Akw"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8098562557;
 Fri, 18 Nov 2022 14:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12590C433C1;
 Fri, 18 Nov 2022 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668780266;
 bh=2Etd7TTDGGQdc+eZ6ZY5zWcGDhXbE1E4P6nTodPzyHM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=LRI94Akwvj+M1u5ha7m2UTmQseNSMmZGrna/rH7PvgMy8dtRQjFvQDA0s0WS+6zA/
 xnyKsxczpvoukVdGYFFB6gPQMvmZ775/Ou2z9q1Ps39mgH2scRVlufQcyziWsPVmf1
 QuaHzmC13ig/Z4hNHDe1Z3uVcKaAlr58rB+giU71yHQtGEfTXIGLhAa9XC/WH8a2Wn
 tilnZAKph7ZPV8u+B2bJnyEbAS5XYun9zaySnnnlKMPf9YPJqve83vLjXyfsXuJjas
 0vBBmm1WefiNyE3qCSUTvaAGgSdv3WZanZrGfOmgrX6UbofbfKojgmUpyKlfirqKjH
 GXkSsVxQmHwkg==
From: Mark Brown <broonie@kernel.org>
To: Ban Tao <fengzheng923@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20221116034621.37762-1-samuel@sholland.org>
References: <20221116034621.37762-1-samuel@sholland.org>
Subject: Re: [PATCH] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
Message-Id: <166878026369.872655.5958604584244669942.b4-ty@kernel.org>
Date: Fri, 18 Nov 2022 14:04:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On Tue, 15 Nov 2022 21:46:21 -0600, Samuel Holland wrote:
> The Allwinner D1 SoC has a DMIC codec like the one in the H6. It appears
> to be register-compatible with the H6 variant, and the existing Linux
> driver has been tested on a D1-based board, the Lichee RV 86 Panel.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
      commit: b1af5b34d6b315ed34abb0fa9049bcf1babbd537

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
