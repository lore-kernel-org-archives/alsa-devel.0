Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E3EC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 14:55:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05D112A3A;
	Wed, 14 Dec 2022 15:54:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05D112A3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671029707;
	bh=l9Cc7KBiFu1aontYPmP7BSrxji8RnQamGv94FhyVBtQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WwRZDGAgRnINlbvM5+B/sImIO3f298m9QgTLpeOwCpAzQN9PmWda44T0MunEeOx0Q
	 7KUKetz82hMPP1k2lZWUeBqvqOgtqysmdFxQ7BlyD/pcNnAXKxcxMQz78MAxTBieQW
	 tmF99Dv2D38HZ5V7LCv3DjRtfv0otFTwOlh21cw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACDBEF80141;
	Wed, 14 Dec 2022 15:53:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B903EF80519; Wed, 14 Dec 2022 15:53:53 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9688F80141
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 15:53:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9688F80141
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YtCSZl8c
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0ECC6B816B0;
 Wed, 14 Dec 2022 14:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F2AC433F1;
 Wed, 14 Dec 2022 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671029627;
 bh=l9Cc7KBiFu1aontYPmP7BSrxji8RnQamGv94FhyVBtQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YtCSZl8cvB/QXhSAYKuhZzPHHG628lXAjbD5nxDroyMCbvlbzmn7reW7vnAciU7Lp
 L18g/NewmYNWBIQcuNwkBGwLxXhwhaAuG44G8Gp7/BCpXH8HmSPTBLD8zRW2vAJkPP
 FzzIENgFmllE4nHGe3I8oS+Wc7dQKArbGXDrAFIniv2hY8N5NSm+P8CAmuEwTsIzu6
 xeDryC4NdcptuHz6LGDzfdZxest+XAoPitTd/kDbswuYX9rxIm8Ey7SEDyn0XjnKOF
 Ahs2z/7vqiId4Qe16/Q+KpGE3PrrYa/MsloFuPLAeRtFyZy75yuMIlZz+q8hVguNLi
 gzn9l49Pyqkig==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221213123319.11285-1-hdegoede@redhat.com>
References: <20221213123319.11285-1-hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: rt5670: Remove unbalanced pm_runtime_put()
Message-Id: <167102962625.215050.8714321914472971117.b4-ty@kernel.org>
Date: Wed, 14 Dec 2022 14:53:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Bard Liao <bard.liao@intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, 13 Dec 2022 13:33:19 +0100, Hans de Goede wrote:
> For some reason rt5670_i2c_probe() does a pm_runtime_put() at the end
> of a successful probe. But it has never done a pm_runtime_get() leading
> to the following error being logged into dmesg:
> 
>  rt5670 i2c-10EC5640:00: Runtime PM usage count underflow!
> 
> Fix this by removing the unnecessary pm_runtime_put().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5670: Remove unbalanced pm_runtime_put()
      commit: 6c900dcc3f7331a67ed29739d74524e428d137fb

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
