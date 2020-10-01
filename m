Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE4C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:51:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA767206CD
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JK2sW9x3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5k0sX3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA767206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68D2A1ED7;
	Fri,  2 Oct 2020 00:50:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68D2A1ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601592699;
	bh=VsGhgXRdCnWZqUDrSyjJV8kumHT0TEaqq/cLoqkAokc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JK2sW9x3cLpvU4C4ByrzWV3jUvELqUJ8u7JClLpRiO7Jd6JXoyHxKsfjkAEtOMmKn
	 B6hvS30zFUWV+ChIxgJ3E+zFO96R3U7XrrJJbkZBvw1qNjFmBoR6uSoHYpTq9jpedJ
	 vrp24l7vcmaekn8MTFHXTd9Iwl46kJ6E/1QWLZEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49C24F802F7;
	Fri,  2 Oct 2020 00:47:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE8A4F802F8; Fri,  2 Oct 2020 00:47:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BC52F802EA
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 00:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BC52F802EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V5k0sX3y"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5DF42074B;
 Thu,  1 Oct 2020 22:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601592464;
 bh=VsGhgXRdCnWZqUDrSyjJV8kumHT0TEaqq/cLoqkAokc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=V5k0sX3y/T4DbGcH9xwwRfc+7B3lMopdOq5qZ49bPLrijsAhSo3Gu6X6gyEInBBLC
 xuyIHSavc23u8xoR0Y4tIhM0PTFeu1P/gXAIVAe076NW8xwst5XAjZ+Uvv6iJj8aIi
 49ehqIXP7F0nUMY6XWtzee/uwS3ZaUxg4jhk3Xyk=
Date: Thu, 01 Oct 2020 23:46:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20201001152425.8590-1-ckeepax@opensource.cirrus.com>
References: <20201001152425.8590-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Pass full name to snd_ctl_notify
Message-Id: <160159237543.44588.14038213779147686140.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Adam.Brickman@cirrus.com
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

On Thu, 1 Oct 2020 16:24:25 +0100, Charles Keepax wrote:
> A call to wm_adsp_write_ctl() could cause a kernel crash if it
> does not retrieve a valid kcontrol from snd_soc_card_get_kcontrol().
> This can happen due to a missing control name prefix. Then,
> snd_ctl_notify() crashes when it tries to use the id field.
> 
> Modified wm_adsp_write_ctl() to incorporate the name_prefix (if applicable)
> such that it is able to retrieve a valid id field from the kcontrol
> once the platform has booted.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Pass full name to snd_ctl_notify
      commit: 20441614d89867142060d3bcd79cc111d8ba7a8e

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
