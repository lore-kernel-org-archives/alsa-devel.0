Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7DFC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 17:49:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9101A61465
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 17:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9101A61465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E38B1831;
	Tue, 16 Nov 2021 18:49:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E38B1831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637084995;
	bh=U0uJnmvVRMMo7C3x8GRHz3KXCbkWYuBn1tLvqBuIMCU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rkyvaVWg74O7VnVMgQgD0I1kfuKDOzoKJzNHKpeDGkOetdICQ94/dIe/rznfofq6t
	 7SLvqDvtKpq67JTljK7/nUtxypWUgA9jdhW/2/Lf9QNxF/auPovoTxJ5e/ORDPIYEg
	 5h+2hhjNtbMf3gNr49mMg412t5RcjPjBTBkSBZrQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A796F804BC;
	Tue, 16 Nov 2021 18:48:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09A01F804C3; Tue, 16 Nov 2021 18:48:21 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CFAAF800FA
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 18:48:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CFAAF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QbvhBld2"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B340761BE1;
 Tue, 16 Nov 2021 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637084894;
 bh=U0uJnmvVRMMo7C3x8GRHz3KXCbkWYuBn1tLvqBuIMCU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QbvhBld2HUmsHAaSlaInRRARLBF+2DdnIRPCgmfd/27vtUokL3wzeP3gR2OkgSNiy
 6X+eZUK9FqiOwJ/p+h0U5G0j0jnRj475XrBuIthzNHnaFnvTPV3NgtxPciGkGNFmdH
 f8YhlN/FqLdAqDJafSy4APSreq6Q8bKoBKPuxxlKjJ+SG5KX8gSl7k60LxUpSyfhty
 xa/5JGPeyoufrJP42aFtxF4IlhSSvjJAlOSVpl5vrUkia7+MkmhZfmT+kDr/HWOtoZ
 qHt/qTPCq7298/6yajRsv41EBWs/i0itjDnRsLToPswBUttwG8I4jm+gqhYYUtQ9g6
 V+vThZT8JG6rg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/5] ASoC: qdsp6: fixes and improve error reporting
Message-Id: <163708489246.808719.13508862895307481528.b4-ty@kernel.org>
Date: Tue, 16 Nov 2021 17:48:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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

On Tue, 16 Nov 2021 11:47:16 +0000, Srinivas Kandagatla wrote:
> During testing on a laptop we found few issues with the existing q6dsp code,
> first 3 patches should fix these issues. Also during debug we found that
> some of the errors reported are not very useful, so update error reporting
> in two places.
> 
> Thanks,
> srini
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/5] ASoC: qdsp6: qdsp6: q6prm: handle clk disable correctly
      commit: 2f20640491edda3c03eb6b899d0b92630d3d4c63
[2/5] ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
      commit: 861afeac7990587588d057b2c0b3222331c3da29
[3/5] ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
      commit: 721a94b4352dc8e47bff90b549a0118c39776756
[4/5] ASoC: qdsp6: q6adm: improve error reporting
      commit: 0a270471d68533f59c5cfd631a3fce31a3b17144
[5/5] ASoC: qdsp6: q6routing: validate port id before setting up route
      commit: 6712c2e18c06b0976559fd4bd47774b243038e9c

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
