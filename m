Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF7C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:24:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41573206E3
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uE1GW9eg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtByFzwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41573206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C80A7168C;
	Thu, 23 Jul 2020 22:23:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C80A7168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595535888;
	bh=LAhMqvfEs+etTZ4a9zE5Wb1PwG/5eexU9ix48zE0uHY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uE1GW9egn1wxc7DuU3W9bdCf05rhWFha0V4Zv+E6SNRaWTBQ9WCl4wZ/Xdj8xW+DY
	 jTLd6EoT9MlTTtEHK200X5AxUagdC2wTDNbgwlvdlFH5fav7VoFtN8n+dvw1aQlmjm
	 a1K9cdlwNkaTuYrdkQED9rHQ7GOfKX5L64u9D6kI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C30E0F802EC;
	Thu, 23 Jul 2020 22:20:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDCA6F802F7; Thu, 23 Jul 2020 22:20:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80C99F802EB
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 22:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80C99F802EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AtByFzwe"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5979820B1F;
 Thu, 23 Jul 2020 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595535620;
 bh=LAhMqvfEs+etTZ4a9zE5Wb1PwG/5eexU9ix48zE0uHY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=AtByFzwe3FV8zOR5RXV2pJ0rR8bD85mMsHrSFWarGAXHqidjg/feYLgkzo61nKiBV
 sglmdAHwSi8zyRaJ7nah7LSMLGrQEJtgyeNj5GGBm84jrh/FIqRh4Fs5ynZfS3UGpA
 wsA4kNJeqPeWM6VuzwxcieBZMKN+l9ytzSinxGHk=
Date: Thu, 23 Jul 2020 21:20:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20200722174215.988974-1-katsuhiro@katsuster.net>
References: <20200722174215.988974-1-katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] dt-bindings: sound: convert ROHM BD28623 amplifier
 binding to yaml
Message-Id: <159553557414.41908.16965363721793838358.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
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

On Thu, 23 Jul 2020 02:42:15 +0900, Katsuhiro Suzuki wrote:
> This patch converts ROHM BD28623UMV class D speaker amplifier binding
> to DT schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: convert ROHM BD28623 amplifier binding to yaml
      commit: 7349885d87c66cfd5bd99332283d92ff509f15ff

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
