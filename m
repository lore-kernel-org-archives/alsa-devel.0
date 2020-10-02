Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE5EC4363D
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:57:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFCF206C9
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kU1tkJSc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwQHKB9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFCF206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA29F1941;
	Fri,  2 Oct 2020 22:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA29F1941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601672234;
	bh=s7RDbJSRahvKFYJrNcA14JYV8asj/ImPRRlYyNwGmdw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kU1tkJScwaz7kkVM0awwOlU+xoOLtOsjAdoImU3C39ULwRlSRQuLPgSeN546eEazX
	 JXHihgoJUibLvQ15FFcmcLCrk+l8wKPrHWy7w0EmDkn+4jGGxLrfgAoIcYuJWOcazS
	 9HuUlzbmiAt3XcPwh/DEFtybXdC+1rMhpOiYGgFk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E4AFF801F9;
	Fri,  2 Oct 2020 22:56:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22EDFF800AB; Fri,  2 Oct 2020 22:56:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 246A2F800AB
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 22:56:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 246A2F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QwQHKB9u"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F8052065D;
 Fri,  2 Oct 2020 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601672175;
 bh=s7RDbJSRahvKFYJrNcA14JYV8asj/ImPRRlYyNwGmdw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=QwQHKB9uOQvGJ47KHmqTkJBTMyvi8BxbXZr7QHXhil+R1t0eITcOIYCs+uFTUHkzU
 8I8RD43wGq9d83nVXCrpdBIjVsrF/giMN4Ve3m0GK42/lJNirD+ElQ0/YdhjXuciF7
 KPO4gOsLm4Dy8jgGZiMOWI3ERcDG7zTp7AmKoKb8=
Date: Fri, 02 Oct 2020 21:55:15 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 tiwai@suse.com, perex@perex.cz
In-Reply-To: <20201002165908.637809-1-christophe.jaillet@wanadoo.fr>
References: <20201002165908.637809-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: wm8523: Fix a typo in a comment
Message-Id: <160167211500.21762.1306114025374461159.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 2 Oct 2020 18:59:08 +0200, Christophe JAILLET wrote:
> It is likely that this header file is about the WM8523.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8523: Fix a typo in a comment
      commit: 98bd2b506a309faca2f5a8388dadfc983123e14a

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
