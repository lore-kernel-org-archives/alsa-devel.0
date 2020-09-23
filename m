Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B1C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:04:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457B02145D
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LD6ulFYR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuAS9sop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457B02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CA4517AD;
	Wed, 23 Sep 2020 21:03:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CA4517AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600887839;
	bh=P/6V8zqaWnueVc+Vqwg9aMc3rGYu3mhTxfjx8T+ePjQ=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LD6ulFYR313Nal9q9ZYJiRpztYaiKQ05JzY87niVamCIC32gFL+6hIObe8nopo4AF
	 GQNEQUjSWRpKoJgLvlBzDabEEv18pelSeazvA790/mhZbZBrI6O2pXEe913u7koXGS
	 AClObpV0UDayp/tJFIUd7nY2zGTzQXaLxLbUGbzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A7C3F802A2;
	Wed, 23 Sep 2020 21:01:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B06C6F8021C; Wed, 23 Sep 2020 21:01:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E8E1F80171
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 21:01:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E8E1F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AuAS9sop"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B371A206FB;
 Wed, 23 Sep 2020 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600887684;
 bh=P/6V8zqaWnueVc+Vqwg9aMc3rGYu3mhTxfjx8T+ePjQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=AuAS9sop85eNWOX8QcZWnKk3N6nAtH+lG6/dJNgW/83HCACekHiIMW65hefcFxdOJ
 UAEexlm7xzVYPR1ozuWYB2Aa2pnHXiEVPA619kDjkzXBDRV1o+WHIukOVQpmOKDpiB
 Q8OF2wT/BdjtYj59mDj46v+178HflfvPQv+FZlvc=
Date: Wed, 23 Sep 2020 20:00:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
References: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC: Intel: sdw machine driver updates for 5.10
Message-Id: <160088761879.35939.7233440363301647263.b4-ty@kernel.org>
Cc: pierre-louis.bossart@linux.intel.com, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com
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

On Wed, 23 Sep 2020 11:05:08 +0300, Kai Vehmanen wrote:
> Series including fixes and improvements for Intel SoundWire
> machine drivers.
> 
> Bard Liao (1):
>   ASoC: Intel: add support for new SoundWire hardware layout on TGL
> 
> Pierre-Louis Bossart (4):
>   ASoC: Intel: sof_sdw: remove ternary operator
>   ASoC: Intel: add codec name prefix to ACPI machine description
>   ASoC: Intel: sof_sdw: remove hard-coded codec_conf table
>   ASoC: Intel: sof_sdw_rt700: add codec prefix
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASOC: Intel: sof_sdw: restore playback functionality with max98373 amps
      commit: 7cc3b56f7324ae120cf3ce57cf0366398eb02f60
[2/6] ASoC: Intel: sof_sdw: remove ternary operator
      commit: f1bf9a6b4e5ed3a764c1f5715a02f438b7c2889f
[3/6] ASoC: Intel: add codec name prefix to ACPI machine description
      commit: f93808308aab34071259fa8cffbda273bc346ea7
[4/6] ASoC: Intel: sof_sdw: remove hard-coded codec_conf table
      commit: 23c8aa3ebabf0008c1d05c38e9723e5deb720ba0
[5/6] ASoC: Intel: sof_sdw_rt700: add codec prefix
      commit: fbcc27d18115f5e2bdad15a087831190c3f05d9b
[6/6] ASoC: Intel: add support for new SoundWire hardware layout on TGL
      commit: e787f5b5b14061bf76518d780b9bc0e9e7dd2739

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
