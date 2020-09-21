Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F7C43466
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:01:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FEB2073A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AYvZkw5S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0wNjDQm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FEB2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B86D16C1;
	Mon, 21 Sep 2020 19:00:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B86D16C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600707686;
	bh=SWeIiCM3jgEYyBNOr14mLMrIAeeCIi1+egzgTKT/beQ=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AYvZkw5SxbB+2KlTAt1oOyOtXakxgs2MKMy/BjAWMvZLt6phbfT96GMnvl0eSQGcJ
	 v1Z01BoyRamzWbQWdYf00KMmz+IODjdNOZNIsfu+FG9z1TtDhiy7EA4x4LKu2padA5
	 tTiMYny2AxDe5UUn10JeHRCd3KSFFUEX97ysEhnQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4BD7F802DB;
	Mon, 21 Sep 2020 18:58:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EFC6F800B2; Mon, 21 Sep 2020 18:58:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14F13F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 18:58:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14F13F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0wNjDQm/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37B5C20C09;
 Mon, 21 Sep 2020 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600707525;
 bh=SWeIiCM3jgEYyBNOr14mLMrIAeeCIi1+egzgTKT/beQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=0wNjDQm/UohWqg+xIGKsAonhHQj/Xf2W0/dZGy842UzPF2dLERAX4ylxd7rVtrgRV
 LDLMPocz/V1tkWNL5s7I4WBVV4S4iMruDOQ2pPhz4X0GcaZtVoCQNvU1DtEWuq7pMc
 imYRBIhTV+/Wx9GJZWG2g0qxD944yQeM/J8jRifk=
Date: Mon, 21 Sep 2020 17:57:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200921104746.2903507-1-kai.vehmanen@linux.intel.com>
References: <20200921104746.2903507-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: imx: add missing MODULE_LICENSE() for
 imx-common
Message-Id: <160070745847.56122.12830031389898392354.b4-ty@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Baluta <daniel.baluta@gmail.com>, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

On Mon, 21 Sep 2020 13:47:46 +0300, Kai Vehmanen wrote:
> Fix build warning:
> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/sof/imx/imx-common.o

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: add missing MODULE_LICENSE() for imx-common
      commit: 5b51b9221f711d205e361f8d1182fd6aea667296

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
