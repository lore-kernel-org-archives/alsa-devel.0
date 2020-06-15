Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABF2C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:47:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E71206DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c0bCeVrk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="15OE0Gfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E71206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C66B1665;
	Tue, 16 Jun 2020 01:46:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C66B1665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592264823;
	bh=8Vkipt8UfbkmfZZK+DRY5P5ncOAbz5M/RzUt969ESmw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c0bCeVrkTwaRayObCcAsVqstKvNrLbmC2C9JsBwfKiybsKRThC9hejvH7XU9h2Qd8
	 zUux2wNaAOYq5J984xfSFJm6ZlrZHlo8M9WDEkauh1t7N8r9R+2xaz1mMtzfmormf6
	 qw6kRai6XgkGz/ieLbtwnSjgr/4JcoH0e8KuSglM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03287F80315;
	Tue, 16 Jun 2020 01:40:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C82CF80322; Tue, 16 Jun 2020 01:40:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89A82F80315
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 01:40:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89A82F80315
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="15OE0Gfd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B40AD207D3;
 Mon, 15 Jun 2020 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592264446;
 bh=8Vkipt8UfbkmfZZK+DRY5P5ncOAbz5M/RzUt969ESmw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=15OE0GfdU5anTbWdKV3yQxD6FHb7qhfPpu0vuE/CA69VJcF+/tLGCrMBOzYZ6oQWA
 wsJqqLK098WW4nmCiacMnlxe2NI0+Ofzekk8uLtn4k61yPtHjSsGZoapaoU6xqug2x
 nZXZ6qYoncvkvolJnI0q4XJXz21uEClolssSgqaI=
Date: Tue, 16 Jun 2020 00:40:44 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
 Steve Lee <steves.lee@maximintegrated.com>
In-Reply-To: <20200602084337.22116-1-steves.lee@maximintegrated.com>
References: <20200602084337.22116-1-steves.lee@maximintegrated.com>
Subject: Re: [V7 PATCH] dt-bindings: Added device tree binding for max98390
Message-Id: <159226439189.27409.1555596796262164094.b4-ty@kernel.org>
Cc: ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
 steves.lee.maxim@gmail.com
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

On Tue, 2 Jun 2020 17:43:37 +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: Added device tree binding for max98390
      commit: 6b76bf3e0ff66eee4b714921fbabd588f90ab1fb

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
