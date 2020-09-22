Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E829C4727E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:09:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7EA207C4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gx29tErv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMNPJ/4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7EA207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 042B016C8;
	Tue, 22 Sep 2020 02:08:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 042B016C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600733339;
	bh=s5dUcarZmio2YYfXTULqBJzhaIWKGjOQf2x0nvA/GrI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gx29tErvw4dhhl6LI+cGs4Uv1mhS1bGFU7Ts+t9Qoat+ZTL8pXG+y/qemCt8q6vYl
	 3zhCrZ5C+IQTswtqQIGhTh1rb0CqW5sljmeAeMOovgZkj3jv2/222ImloC+8trgzM6
	 cRn2AC6af7neLsR8I0511/gwQfZGGH0xjMP/4uR4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3B58F8028E;
	Tue, 22 Sep 2020 02:06:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE5CAF802C3; Tue, 22 Sep 2020 02:06:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED796F8021C
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 02:06:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED796F8021C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eMNPJ/4B"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7682221789;
 Tue, 22 Sep 2020 00:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600733191;
 bh=s5dUcarZmio2YYfXTULqBJzhaIWKGjOQf2x0nvA/GrI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=eMNPJ/4BEuU24Kodl56/I1E0z3XmHRRU8GA0fCjT8AWiyZUGD9/DtDTTaUfVFHAkl
 oSsahVRqMEERD9wEUKzVSGPrQcxqlyESpQsSKegBaBkanpaucXVc7yItj/CNbyv6Wi
 GxBdN0N6UdinMUkBcQR4KL8tugfYAMY+pud8Bdlc=
Date: Tue, 22 Sep 2020 01:05:38 +0100
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 Dan Murphy <dmurphy@ti.com>
In-Reply-To: <20200918164320.11577-1-dmurphy@ti.com>
References: <20200918164320.11577-1-dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
Message-Id: <160073312816.6173.10659050151011957467.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Fri, 18 Sep 2020 11:43:20 -0500, Dan Murphy wrote:
> The I2C addresses listed in the yaml are not correct. The addresses can
> range from 0x41 through 0x48 based on register configurations. Fix the
> example and the description.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
      commit: b23d9eb897a1209e4d741fd69e5490f1b5b9e7cf

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
