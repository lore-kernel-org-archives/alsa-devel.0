Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B6FC54FD0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:01:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1405220728
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YurTR40N";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="004dV1Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1405220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6744316A9;
	Fri, 24 Apr 2020 19:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6744316A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587747677;
	bh=saCxWONFF6Ajrmk2HrposfiqAXDWGeFxx/Lx98AgvqU=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YurTR40NWtqTmJ24zUCkQqvKij8f0gLhMnE6UV4OGra3dqi8ynNrHvmyxFrNlCLGq
	 jkl9kQlTneroQHfcF8fVGpgCk6ZqX19HhHhVYqtYu0MG63+tKblW8IlltatGPX4XGz
	 cscoQa2mXd8RVQtTzBNwWUUFvWN5CwqcZOruWkXA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF67FF80121;
	Fri, 24 Apr 2020 19:00:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 401B0F80142; Fri, 24 Apr 2020 19:00:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51765F80116
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 19:00:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51765F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="004dV1Bp"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31F722071E;
 Fri, 24 Apr 2020 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587747619;
 bh=saCxWONFF6Ajrmk2HrposfiqAXDWGeFxx/Lx98AgvqU=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=004dV1BpZDKBoSg+Ux1SpeI1Eu/4hJw+KT5F+3sqEqMGbBX/WZWFo55pdtLkfgvNW
 2NP1n0aeXo5FOi5jjogTPlWdX+ukEmUhwgzgrw46OfczRNn0HEe1OkANiAAjU31hbW
 hlrmf0GFzWIPA0VQUZ8o5vDrRnsfYRZvLH0GILa8=
Date: Fri, 24 Apr 2020 18:00:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
In-Reply-To: <20200424092520.23989-1-perex@perex.cz>
References: <20200424092520.23989-1-perex@perex.cz>
Subject: Re: [PATCH] ASoC: snd-sof-intel-hda-common - add hda_model parameter
 and pass it to HDA codec driver
Message-Id: <158774761712.7990.3593052889032074457.b4-ty@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Fri, 24 Apr 2020 11:25:20 +0200, Jaroslav Kysela wrote:
> It may be useful to pass the specific model to the generic HDA codec
> routines like the legacy HDA driver (snd-hda-intel) allows.
> The model name "sofbus" is tricky anyway.
> 
> Original proposal: https://lore.kernel.org/alsa-devel/20191203161908.7496-1-perex@perex.cz/
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: snd-sof-intel-hda-common - add hda_model parameter and pass it to HDA codec driver
      commit: b8d3ad51dfec3631763cfef3d30c16f40140058b

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
