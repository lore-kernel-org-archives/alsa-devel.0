Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E20C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:02:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98352067C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aM1O59yz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlJ1pur9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98352067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 268E417AE;
	Tue, 18 Aug 2020 19:01:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 268E417AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770136;
	bh=vQK60Ocp3gM1Fr89fLe38clUh708rCmn+Vl9Vckyncg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aM1O59yzqwyq1w6H1YMKSiPwObEEDZq7Gntlf3zsYhitkW8RP5eTo8+IclH5YCGC/
	 H90/JtdOwdJqAO848Ek4qbKPlcTmQW1bh+BOHNXjtlm9Zego5uXZui4iD95aPxd8ww
	 e2z6phkKwtkvWK6A4cYQs48MaNeFc7Ai1nHcNGbE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E53F9F80339;
	Tue, 18 Aug 2020 18:55:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D30D4F8033E; Tue, 18 Aug 2020 18:55:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3392AF80339
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3392AF80339
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KlJ1pur9"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C0C620786;
 Tue, 18 Aug 2020 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769710;
 bh=vQK60Ocp3gM1Fr89fLe38clUh708rCmn+Vl9Vckyncg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=KlJ1pur9zhhxqqtEJA2/ufg25NxSrAWe83REzsPY1FWsSOM4VZRmziogXolBmaeVm
 wIKypEe5ExeSocoRQxk55HLLjVC3gB3PIk1mPXMwue4HnPXMFxov1YjuBRGSK0IEF1
 gxO03l7c/WPCZW8LiB+J9lO77fTihBlfUdFpz9p4=
Date: Tue, 18 Aug 2020 17:54:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20200811041836.999-1-michael.wei.hong.sit@intel.com>
References: <20200811041836.999-1-michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH v2 0/2] This patch series is to enable multiple features
 on the Keembay Platform
Message-Id: <159776961931.56094.10298376998030198647.b4-ty@kernel.org>
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com,
 pierre-louis.bossart@linux.intel.com, jee.heng.sia@intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com
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

On Tue, 11 Aug 2020 12:18:34 +0800, Michael Sit Wei Hong wrote:
> Michael Sit Wei Hong (2):
>   ASoC: Intel: KMB: Enable TDM audio capture
>   dt-bindings: sound: intel,keembay-i2s: Add new compatible string
> 
>  .../bindings/sound/intel,keembay-i2s.yaml     |   1 +
>  sound/soc/intel/keembay/kmb_platform.c        | 145 +++++++++++++-----
>  2 files changed, 109 insertions(+), 37 deletions(-)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: KMB: Enable TDM audio capture
      commit: 9c3bab3c4f158bb79ebd7443ef83c32fa1a450a1
[2/2] dt-bindings: sound: intel, keembay-i2s: Add new compatible string
      commit: a106bb6eeaace283bcb9fcaeb2e2ac4097037e4b

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
