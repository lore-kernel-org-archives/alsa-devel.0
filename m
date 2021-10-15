Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF288C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 19:43:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9880160FE3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 19:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9880160FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42D29186B;
	Fri, 15 Oct 2021 21:42:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42D29186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634326990;
	bh=NX0GHNqpx89R98YUTjMD/yK9Gvdhvc7bZbMidk8XqzU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NI+MyQN4z6wMOrd+DJuvGO3tbskHkKTduD4O0XZBttRG9LXwUtuoIQPsIuZPA2xuc
	 4ygSymV5BquFVN2zKAkSkfV5XyzIkmbLcBpPgmfor2yPqsvI2Z/ft0NEhlE8VXap+p
	 //MKi8MQ6a3O08H/rVYJwSECE6U6/gJeZrYkeKUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB7FEF8016C;
	Fri, 15 Oct 2021 21:42:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3BBDF80167; Fri, 15 Oct 2021 21:42:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1AA0F80167
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 21:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1AA0F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ccbpQhws"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66C4E604DC;
 Fri, 15 Oct 2021 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634326927;
 bh=NX0GHNqpx89R98YUTjMD/yK9Gvdhvc7bZbMidk8XqzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ccbpQhwsCdMffps9yp/QMCKv7eaGoytpQpKBbh1ZBUEmQbhJ9kpzkaN7o9ibLXQbm
 j3KPARXZqvQ1QQXuxZ9Yt54bEwTY5+VTdeCUay7FKjtrQVK7DO+cswYrQ6JlaSup4w
 dw7ppS5Cw2CnhvVhckdXxOh9nvtEW09M04+3Yf5NRXxmIh7jUpJOo5Da+0NwmvPpMw
 WZiFsg1wYCAi/dtId3bRF8Net977kkAhNam67HsnoSsSQtYGAT80tzFJOXhoGUiadq
 5dJQAnH3roYe8BuXjFSCTc+GBlihyPcifArvRQeMli32Z4euwUnlZL0DZG+8zDa7Mw
 yaRKDOXV2B0/w==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: soc-component: improve error reporting for register
 access
Date: Fri, 15 Oct 2021 20:41:59 +0100
Message-Id: <163432688461.1314975.13635332088074397801.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014161330.26645-1-srinivas.kandagatla@linaro.org>
References: <20211014161330.26645-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
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

On Thu, 14 Oct 2021 17:13:30 +0100, Srinivas Kandagatla wrote:
> Currently errors on register read/write/update are reported with
> an error code and the corresponding function but does not provide
> any details on the which register number did it actually fail.
> 
> register number can give better clue and it should be easy to
> locate the code and fix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-component: improve error reporting for register access
      commit: b296997cf539976c62f81cdd367924809fdcc14e

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
