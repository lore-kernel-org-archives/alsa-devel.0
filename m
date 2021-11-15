Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5029C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:35:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC0B63223
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBC0B63223
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6CE31684;
	Tue, 16 Nov 2021 00:35:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6CE31684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019356;
	bh=Pdcmps+Wn75c6JYbY9VoGfURQ8Z1Y05nyXoNRHD+OTQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B8FUiX/lyDyKl3UR33JfWS8+UK3Odmy2PpxZiV6IaKLX4qmpCYF2LeYCHOwaKf5o8
	 n9jHGQHByUGS4LuRwMqNmWrVaRCI/V/9ZzaSZlj8LZkVg3Gu2kWlZSeEx/9+IXAdcW
	 9GPXGR2IoGNkbiIkgEo3+0PqrXsygDaM0lJ+JKfs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 199ADF8028B;
	Tue, 16 Nov 2021 00:35:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 152FAF8027D; Tue, 16 Nov 2021 00:35:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE827F800FA
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:34:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE827F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h9m4ZIUr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A5E26324A;
 Mon, 15 Nov 2021 23:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019294;
 bh=Pdcmps+Wn75c6JYbY9VoGfURQ8Z1Y05nyXoNRHD+OTQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=h9m4ZIUrYZJK46lFpAoZLfySpdLpVZ0GK2DIqZpF4Kd0mSTzKJDj1FQ/zbaXv1DKC
 I4ww6c5oL8jCQN9zyRfWz4qeFdHA9E477Ud1xYqSQDJT3YpP0TJtRYpZZb2xnN25LO
 SL5TlCs6J8u6IgIkKayqz51CIECSrK2/LeYuQWJ07RRWTC8gdaJIVAGkKHSuK4lR/D
 3lssK6vcRJDHyoDQB7BNFPz59inGpI3WBdA05DzkArcjxptyVeoYJRzxm4eyUP2Uuv
 8ptP4okq7Fyp/mAa69PaljWPI87N5APdtfYYOeJ+S35ncK2+sf/uuKEAxEaXS0HY4V
 iYDsatuTKTQZA==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20211115120154.56782-1-simont@opensource.cirrus.com>
References: <20211115120154.56782-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: wm_adsp_control_add() error: uninitialized
 symbol 'ret'
Message-Id: <163701929291.675332.10025590314980830752.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:34:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 kernel test robot <lkp@intel.com>
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

On Mon, 15 Nov 2021 12:01:54 +0000, Simon Trimmer wrote:
> This patch fixes the static analysis warning as it is correctly
> indicating a possible code path, it cannot know that for the affected
> firmware versions subname would always be NULL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: wm_adsp: wm_adsp_control_add() error: uninitialized symbol 'ret'
      commit: a6e849d0007b374fc7fbb18d55941c77aa7c3923

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
