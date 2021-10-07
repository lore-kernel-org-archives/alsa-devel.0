Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF18C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 21:39:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067B961152
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 21:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 067B961152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72C881663;
	Thu,  7 Oct 2021 23:38:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72C881663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633642773;
	bh=M0JScwCK6dY7QbVsEnkNN+IZlnMsuYMilyBSTNOFTCA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NZxfhU5ZPhWk11Nv9d6y83IiPApTXtA1p2+weHgGH1Cwusg3mqRrGUnLFhZpvyxen
	 2UbB+9E1N280hPe6MiP9CQNSso4BTOQNowyMvaasuTkDcqTnDleBD7vBOlMb/HXJb8
	 e2A+UiErBOinRvZAg3VfcamFQ1QL9qhBeoUi70aM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB274F804E2;
	Thu,  7 Oct 2021 23:37:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8853F804E6; Thu,  7 Oct 2021 23:37:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 837B4F804BD
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 23:37:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 837B4F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lsV5RMPu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CADB6120D;
 Thu,  7 Oct 2021 21:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633642670;
 bh=M0JScwCK6dY7QbVsEnkNN+IZlnMsuYMilyBSTNOFTCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lsV5RMPuJp5pZ9++YPV+7cBgmTN/2UYfsuJlrQSpTeIV2URfpnMo6jL0XkXvmBJSR
 TvJPHujqPw0VldZV57Ux7dIjEcdYY0k3NqipoSPHZs1vN1d+OftGRl3z+tTG1iiR+Z
 gGTj+OJlRgoH3orvmBa7RtgYy0e7lQKVPAwyygO5T3kQyR+OsRKUHY3v/06eyHECHc
 EjeVQ2FjvvaoAXmMknEuZwM8iZ3CqyTzIA9L0mys5pycYIHVPh70ujNOPVJQ1y1snY
 KTIOTRZ+OABxXtiamqJ0H2rN7GEkakYczESmrefKJCxjzPZUK1ZugPufvrTOwfURGD
 oAvAM1FKlip1g==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ASoC: DAPM: Fix missing kctl change notifications
Date: Thu,  7 Oct 2021 22:37:26 +0100
Message-Id: <163364264607.649699.9456169458169532979.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006141712.2439-1-tiwai@suse.de>
References: <20211006141712.2439-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
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

On Wed, 6 Oct 2021 16:17:12 +0200, Takashi Iwai wrote:
> The put callback of a kcontrol is supposed to return 1 when the value
> is changed, and this will be notified to user-space.  However, some
> DAPM kcontrols always return 0 (except for errors), hence the
> user-space misses the update of a control value.
> 
> This patch corrects the behavior by properly returning 1 when the
> value gets updated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: DAPM: Fix missing kctl change notifications
      commit: 5af82c81b2c49cfb1cad84d9eb6eab0e3d1c4842

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
