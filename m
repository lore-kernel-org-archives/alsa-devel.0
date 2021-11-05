Return-Path: <SRS0=XtK2=PY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211AFC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 15:24:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F51D6124A
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F51D6124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B0CE1689;
	Fri,  5 Nov 2021 16:23:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B0CE1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636125858;
	bh=qOEY7Np9ULGeqGYGXyeEfvvrjIzs7P0LvNLNYvHhPq8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5RNkTQ5h64QKjK5DU5UlgmaIotH7a5gqMn8Dh0ZG7DrSqyd+7PvR7uP+krdV+Y3U
	 vCMCeO5YHSXNlSLoJiiU7pwJMgSdAQQwthmLNCpPL2Zx9N6nX2+OmezE+MVWiqVlrg
	 jbyrOwRiP1prGdALRQNP2F5K6J6LPHHZ73sfdUIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37A15F802BE;
	Fri,  5 Nov 2021 16:22:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E6F0F80431; Fri,  5 Nov 2021 16:22:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1A81F80279
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 16:22:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1A81F80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Sx44Vfkp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B97660EFE;
 Fri,  5 Nov 2021 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636125756;
 bh=qOEY7Np9ULGeqGYGXyeEfvvrjIzs7P0LvNLNYvHhPq8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Sx44VfkpsBXc6pg+GAXCvvzHNVh2VgmvAAS/WY7JiwAWjCGTsWZnOueKUyR7eC1Wd
 uAD6tj+y16+g4Zcxk8SmLSLPStMIaB+QPhYi7epykEtfYR5aKEiRFMmPdMVBXoox+g
 3OT00+N0Ou8N6ZLnlo8f2vEqxtEEY1/DNXTI+xIpxvB2Ab6FqGDR/X4v8+0PYCeYbq
 fRfngmMMaFgTycKaMwYFyjFomhZmKx58jJA91M+88mZSAzyHrBog+tRAVFMJFQc1iA
 7sChO0DnaCMc84pcC4LZzmwuwbKsje/FkDIXQrZOwW9f6/frSLrTW+YLPBaXkUDwlY
 mQsr7ZBUP3aBg==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20211105090925.20575-1-tiwai@suse.de>
References: <20211105090925.20575-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: DAPM: Cover regression by kctl change notification
 fix
Message-Id: <163612575521.951053.6704784727751788107.b4-ty@kernel.org>
Date: Fri, 05 Nov 2021 15:22:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
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

On Fri, 5 Nov 2021 10:09:25 +0100, Takashi Iwai wrote:
> The recent fix for DAPM to correct the kctl change notification by the
> commit 5af82c81b2c4 ("ASoC: DAPM: Fix missing kctl change
> notifications") caused other regressions since it changed the behavior
> of snd_soc_dapm_set_pin() that is called from several API functions.
> Formerly it returned always 0 for success, but now it returns 0 or 1.
> 
> This patch addresses it, restoring the old behavior of
> snd_soc_dapm_set_pin() while keeping the fix in
> snd_soc_dapm_put_pin_switch().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: DAPM: Cover regression by kctl change notification fix
      commit: 827b0913a9d9d07a0c3e559dbb20ca4d6d285a54

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
