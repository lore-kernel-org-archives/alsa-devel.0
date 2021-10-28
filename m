Return-Path: <SRS0=jYMw=PQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B4C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 13:00:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2350610C8
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 13:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2350610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D648169B;
	Thu, 28 Oct 2021 14:59:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D648169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635426011;
	bh=GvK75DH60GBTMF2oKEW8i6qrOQxPMn6ekQ4+MJmZ6rQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRcnrRHbi8rdD0AoXzSrFXvIbBz99+2/5BZO6ocVcr6ra3rGKSpQI3Z+Ew6BwdYcW
	 wjbHVgX3noh5VXIXoBDnKmPefMf9JX2GC1WgW+7QNg0J8jEjyPGQ0+nwziIP12W4ym
	 nepMGahK4USQKefNaWEGbAZJztlSeFDVGdGVeLDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC124F8010A;
	Thu, 28 Oct 2021 14:59:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E269FF802E7; Thu, 28 Oct 2021 14:59:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09ED8F8010A
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 14:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09ED8F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jryR/6km"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB746610C8;
 Thu, 28 Oct 2021 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635425949;
 bh=GvK75DH60GBTMF2oKEW8i6qrOQxPMn6ekQ4+MJmZ6rQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jryR/6kmEOc/UVWIyCd9yFf/i7ocGgBx9sI3KtCpt7b1HQnic1yGImQ7QIU6g5dOa
 uSfLFjDzArFHaKAeMz+MdikYOVmFDLW4hoHO8u7AND9R4Xu6edn/2upW49z2RXgxCR
 FmYq13061g1dc2Hruvs1uyVd5jLI9GUJOU/qpJxRGU326P1yHO+bnXYKhld3uTBhxj
 c8LaZfkPD7WwhwQ3MvGMjqn13Cr+8YtJxdL8fKn49oUpfW8ivSc34AH6gpdM2q6o8f
 TrjpI25S26SLxPcb92Ll6wFm+uxVw12rPp9/ua5y6b1P+0VTSAzyg8d2WANbvz/iqD
 8jyYZyRrXPQ/A==
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20211027190823.4057382-1-nathan@kernel.org>
References: <20211027190823.4057382-1-nathan@kernel.org>
Subject: Re: [PATCH] ASoC: qdsp6: audioreach: Fix clang -Wimplicit-fallthrough
Message-Id: <163542594755.950250.9661229895167446444.b4-ty@kernel.org>
Date: Thu, 28 Oct 2021 13:59:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org
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

On Wed, 27 Oct 2021 12:08:23 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> sound/soc/qcom/qdsp6/topology.c:465:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>                 default:
>                 ^
> sound/soc/qcom/qdsp6/topology.c:465:3: note: insert 'break;' to avoid fall-through
>                 default:
>                 ^
>                 break;
> 1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: audioreach: Fix clang -Wimplicit-fallthrough
      commit: c6c203bc4dfed6812cf77e7737074b9cff8dd78d

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
