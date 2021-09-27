Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91726C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:50:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1693460F44
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1693460F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94AB616B9;
	Mon, 27 Sep 2021 19:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94AB616B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765043;
	bh=U+5FEPb2ykBBvXf2EaK/CEH5DxGcdV5BAMDU68iBY3Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fyaX3uglfKVoSR5p9D4oZQ9YaBkF9z8jopyFFirglwBlbT+/oWuydCT8juRUK2e/q
	 ABQs36xmA525lV8MdI6DEdxx+mjMPiBkjtfX7Uhw+LcLOCFQE93N3oRgpbZQwZd2QT
	 n1X21CLetQg3szQPD81Qf6C1E6h6pSmpbV7iEp3s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76D8EF80511;
	Mon, 27 Sep 2021 19:47:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC32EF804FF; Mon, 27 Sep 2021 19:47:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 642C2F804FA
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 642C2F804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cVuMLT0Q"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7527660FC2;
 Mon, 27 Sep 2021 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764844;
 bh=U+5FEPb2ykBBvXf2EaK/CEH5DxGcdV5BAMDU68iBY3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cVuMLT0QyB3dpq6pzOx5+1zefbd/qMVYYY93hKmh/Hk4xLgArNrDgL3phpcJD70OM
 EPU9xyDeKOvkLauQiGBnxk1y57MQkpCjWgjEryJzTGKHDIGXDYasfI7OHE664lKQOm
 sEMzH4nVWUEEu5kRcwblx9r+LLINdfcrMydgKNQXaCb2YypkTIJGgmSvwmDG2XVD+X
 NxNXStXJUquox3kL0Py8H3/wKZYVMc6xZaAVz9VfuLmLcDlobVqanKVA8meegPb9WW
 jOzkqzWy6aZRxxevnjhnGwAaNicyNNayfAj/CvzdApIJE0/jmceHc+rveUzdQVNGly
 pCywO6jbw2X2A==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: ak4118: Update to modern clocking terminology
Date: Mon, 27 Sep 2021 18:45:31 +0100
Message-Id: <163276442021.18200.954207813181292849.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916150804.20058-1-broonie@kernel.org>
References: <20210916150804.20058-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Thu, 16 Sep 2021 16:08:04 +0100, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the ak4118 driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4118: Update to modern clocking terminology
      commit: 2b0a5d8d2884db6cec12131db3c2a78edb88afa1

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
