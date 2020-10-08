Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4FDC433E7
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 22:04:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB7922242
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 22:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oCXrox9Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZItfGq8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB7922242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B91C216A3;
	Fri,  9 Oct 2020 00:03:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B91C216A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602194647;
	bh=a9Ail/qdFEZX2JwtyGVuRlxv0Gv5RrrOtq42kRFg5Vw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCXrox9YyviBI8SrjIddbQKMMkYu0ZI1sRknLSRNpc5JHVjJWBRqslnsYLVtIpiR2
	 EHS2QWZP0qMK8mHEXdkfmgakcuXGOvdtd4qqlBV0hsZ6a0PvALjmOGROmxqChDnc64
	 UmHyRUCp1dSj01W4XSeVhJjUV0pVB54OlJGZd/AQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C277F80225;
	Fri,  9 Oct 2020 00:01:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BCA0F80226; Fri,  9 Oct 2020 00:01:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 944CCF80224
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 00:01:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 944CCF80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZItfGq8P"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0ED3422243;
 Thu,  8 Oct 2020 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602194502;
 bh=a9Ail/qdFEZX2JwtyGVuRlxv0Gv5RrrOtq42kRFg5Vw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ZItfGq8P3wb9cQh63ObzPaVust3eYOQJ4rSjDNC4BrQvfn1NTQwlnnMQ2WdtuhBiQ
 kT5vIU8nfEOUhh9CsOSymeYWW1MMLQwRVEfbNyPZpRS1sfYcr9qFRXggYnLp5zenSQ
 umBD1hs30+3bJKCfY1DZxO6DsqPPA3chZUlz0sxo=
Date: Thu, 08 Oct 2020 23:01:40 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>,
 robh+dt@kernel.org
In-Reply-To: <20201007155341.10139-1-dmurphy@ti.com>
References: <20201007155341.10139-1-dmurphy@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
Message-Id: <160219448332.29664.500640476412734254.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 7 Oct 2020 10:53:40 -0500, Dan Murphy wrote:
> Add the binding for the TAS2764 Smart Amplifier.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
      commit: 696bef70438359c1be333b62b2d879953768450d
[2/2] ASoC: tas2764: Add the driver for the TAS2764
      commit: 827ed8a0fa50bdd365c9f4c9f6ef561ca7032e49

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
