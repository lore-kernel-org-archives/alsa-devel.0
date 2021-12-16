Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B319C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Dec 2021 02:22:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AEA0192C;
	Thu, 16 Dec 2021 03:21:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AEA0192C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639621333;
	bh=nkUMHXuChFJ8SQgxBc9IJz2hTIZPrCqyutTFbE6fZns=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kSYnvJPLTfDAQpYpDQ7KtageW2gzVugJN8EBW0F2RUllJuLRsm5kJj6ij1TEXmlZh
	 z/MV3Oo7OVHM1F1KTOoFIxlc/LHlh8vynQIQLIm67Ua3XiVsefbx8hAX6PEYVZlI9z
	 UWun+moyIdcWASarXnaaTlK7ZVj+7djf7GgclMeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13345F80158;
	Thu, 16 Dec 2021 03:21:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A5E4F80157; Thu, 16 Dec 2021 03:21:20 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0926F80157
 for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2021 03:21:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0926F80157
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T14vMczy"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EC7D461BD5;
 Thu, 16 Dec 2021 02:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398ACC36AE4;
 Thu, 16 Dec 2021 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639621274;
 bh=nkUMHXuChFJ8SQgxBc9IJz2hTIZPrCqyutTFbE6fZns=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=T14vMczy1z/wkd6xvGn6Vjn82zR//KMjlmv3PY/WmrCY21PtkDw9UqBO5x8A5PVVN
 K3DaQ/boRM6SKh4o4OT23Brugxa81aEa2zkSgxzvTWf7gcAP8RPx84tKixS7Nb9mFL
 7w0OvQ53P2PMOspSqEiKLS5eAfyCJBmBGEEvXgpKGzSEst4KPaLjWvt9LP5/b5h3hP
 jxOleB2O17pecn+5RkWVRbufzCvkf+8MepmTZkJTiDALkqMJA14SDaI1Dcmqn4PLYL
 nhv4k76OYzKLSvM9oTaBY3uxJtMvro/Dznuw3xTmQGzCIj1M4gr+Li0Vfarwb8JyCG
 LQjv8LZYZpvFQ==
From: Mark Brown <broonie@kernel.org>
To: David Heidelberg <david@ixit.cz>, Thierry Reding <thierry.reding@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
In-Reply-To: <20211211224946.79875-1-david@ixit.cz>
References: <20211211224946.79875-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,
 tegra-audio: Convert multiple txt bindings to yaml
Message-Id: <163962127187.2075333.9430552763697046784.b4-ty@kernel.org>
Date: Thu, 16 Dec 2021 02:21:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, ~okias/devicetree@lists.sr.ht
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

On Sat, 11 Dec 2021 23:49:44 +0100, David Heidelberg wrote:
> Convert Tegra audio complex with the
>   * ALC5632
>   * MAX98090
>   * RT5640
>   * RT5677
>   * SGTL5000
>   * TrimSlice
>   * WM8753
>   * WM8903
>   * WM9712
> codec to the YAML format.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: nvidia,tegra-audio: Convert multiple txt bindings to yaml
      commit: 88dffe43cbc625eb52a57daa0d1c0fb7037b63d2

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
