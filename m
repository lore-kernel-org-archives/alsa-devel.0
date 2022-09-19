Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEA1C6FA82
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 23:15:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F7F41661;
	Tue, 20 Sep 2022 01:14:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F7F41661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663629348;
	bh=b1MqEh6B42D87J4TSbATtghLyrLWxYN99xDJ54qoJjU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3JaNk8q0xLu8gKx9BD+fkcFsdeE8qZVzv9hsf5DNk0HZcAKw1+TshLE2UsDQ7VtB
	 vm/VTfRSuzFQiqN8kX48h5FoWt3ZHaqfqna0rrPi9G8jQIHfsz7njtZahw5kL6i84L
	 kWx50zFsJbU8701CjjV1r91KKhkCIQkCef18O7fc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD03EF805DA;
	Tue, 20 Sep 2022 01:10:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56C33F805DA; Tue, 20 Sep 2022 01:10:46 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE1A6F805D7
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 01:10:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE1A6F805D7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KI1qtB8d"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5E111B821D9;
 Mon, 19 Sep 2022 23:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E82C43470;
 Mon, 19 Sep 2022 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663629041;
 bh=b1MqEh6B42D87J4TSbATtghLyrLWxYN99xDJ54qoJjU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=KI1qtB8dtbf2FWe6H6nRxplkR+NFVCp3Fa07+UpVQle4opGMzGzwsl7MKYGYnmQs+
 Mhk9JCWW2EDm3w8V7xI5QXHzf2VwBS/dWd03/tgajaTxJ8+ToxR9MtEPf4YlPxR/j8
 U3MBfXV0vt73WHMLljw6baL9kynOtDE2Zxv/x/BrgsDrauzgreTminioG5Sxr2vaqL
 XJe2gEuEHNlsgfBoNnN6DoYtWh4FBx2yZsHcDFP25wNeR1Qp734KFoGd3554cLOX02
 xgqopEYOSK6Zaa+SuYAl173l9b8QhlIFPf4P2UJQr92xIdOrzKWbkF3pGaQh6GK3y6
 1sMPXQ+BtELVQ==
From: Mark Brown <broonie@kernel.org>
To: Ban Tao <fengzheng923@gmail.com>, robh+dt@kernel.org,
 jernej.skrabec@gmail.com, wens@csie.org, lgirdwood@gmail.com, 
 alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
 samuel@sholland.org
In-Reply-To: <1662966333-18000-1-git-send-email-fengzheng923@gmail.com>
References: <1662966333-18000-1-git-send-email-fengzheng923@gmail.com>
Subject: Re: [PATCH v10 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Message-Id: <166362903874.3419825.606503427543635077.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 00:10:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, 12 Sep 2022 00:05:33 -0700, Ban Tao wrote:
> DT binding documentation for this new ASoC driver.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
      commit: 5cf934e84659ca2f03db6254978d56f053745366

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
