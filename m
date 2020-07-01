Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C593C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:27:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A4B20780
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vRq/vQzy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU0bGnUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A4B20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84974168B;
	Thu,  2 Jul 2020 00:26:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84974168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593642419;
	bh=Q3eRPK687CJ1TD+vPYTtpnTYTLgMFnwzqhQyWhTTvfI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRq/vQzyvPZT+C/tkqSMPApoeOvq1E18xhQ7ee1bdBTggiGt08i6uTigKFmyHhnfy
	 LkaGJUgv5/Wx4KvAEx/rW5g/J4cydkpDnDef8Mg7Zfj47FcRDNhfCC1N0CXEoJlvXf
	 jITos1CwnhYRfyzEV4Lw+9S6WDFzk2DbiKcjUhRQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14DFEF802E9;
	Thu,  2 Jul 2020 00:23:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53F6DF802EA; Thu,  2 Jul 2020 00:23:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AED84F802E8
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 00:23:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AED84F802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AU0bGnUM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9E2620780;
 Wed,  1 Jul 2020 22:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593642183;
 bh=Q3eRPK687CJ1TD+vPYTtpnTYTLgMFnwzqhQyWhTTvfI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=AU0bGnUMeN653PjKqibdORxjLIr7pxXQi/6VJBzTn6KMk+xQNnfrQsFccxC9l4eEt
 aC/T/aY2uhNS5CNEzSdTzfNFXX9qzBvokTqKf4PiCb3jn40gmzDLLgV5jpDvRk20Jr
 ZAegaSYwl5SVbPfbutZW3TWnFnXh6BNlZb/oYFr0=
Date: Wed, 01 Jul 2020 23:23:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20200630224459.27174-1-festevam@gmail.com>
References: <20200630224459.27174-1-festevam@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: keembay-i2s: Fix reg descriptions
Message-Id: <159364215574.10630.17562111847021411509.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 jee.heng.sia@intel.com
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

On Tue, 30 Jun 2020 19:44:59 -0300, Fabio Estevam wrote:
> intel,keembay-i2s has two register regions:
> - I2S registers
> - I2S gen configuration
> 
> Describe these regions accordingly to fix the following warning seen
> with 'make dt_binding_check':
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: keembay-i2s: Fix reg descriptions
      commit: 9308a3c92642cddb9ef89cc4014282cf14f2e2d2

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
