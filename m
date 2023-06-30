Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9000BEB64DA
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jun 2023 17:09:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CB3584D;
	Fri, 30 Jun 2023 19:09:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CB3584D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688144990;
	bh=+TALhmyFtgKroMvNw2bI8fW8G+hi4j0JetMcBBInhwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JLpnK8DkMUkw1G6WPKKA72MZNfE5Vjnl/KUTkqDoIhQ3ujO7IEDRiHE/Y5ueTE/bl
	 h3HGs02fzN8mh1WvKlcrVFZ9pbRazYiJ0N/RA32SYLHu3zt9dYKnhxO0WaVPGIcj5s
	 aCYHl+eNGHDhUE6mUpRmLaHkLLGchbQFIwm3rSyQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7054FF8057E; Fri, 30 Jun 2023 19:08:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C07FF80568;
	Fri, 30 Jun 2023 19:08:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDE6AF80212; Fri, 30 Jun 2023 19:07:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 73E01F800E3
	for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2023 19:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73E01F800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nGu4/INP
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 64E84617BA;
	Fri, 30 Jun 2023 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8BFC433C0;
	Fri, 30 Jun 2023 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688144868;
	bh=+TALhmyFtgKroMvNw2bI8fW8G+hi4j0JetMcBBInhwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nGu4/INPGHBWuGY8Gmtx8U3spkkOXTk0kN00eE53RwlJBFjxaH/RdyKbQ2TpvIxT5
	 PonZiGSskwnkyqrtz39o6F51SjNXOE6FrugxU22LCit7JGEhrs9G3cTfLgAR1TWuK6
	 m7HAHFFT5trWHlcrWNpUDGid2op781CvxfSlJ00FJFYUgDfgEg5CmO/xIvvAmFBzC/
	 t5OojyugAvPcmPhCCqpeF1ZDPw+6IxDiY3geAFTuHYuYw4bTDu4QnVlP5ytGstJ4po
	 RYSQLmH7Q1WerE8xqjgzxo3M/l0JJOvFyhzhTkKpgW+S+HD1czgcdrR2OyLpHJBm3c
	 RmyRrZA0Tz8jw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
 lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
 kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 Stable@vger.kernel.org
In-Reply-To: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-Id: <168814486610.50974.12621138895837915220.b4-ty@kernel.org>
Date: Fri, 30 Jun 2023 18:07:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: HOG7I4F5FJZ5VW7ND6PT7ZYVQJPKOWSZ
X-Message-ID-Hash: HOG7I4F5FJZ5VW7ND6PT7ZYVQJPKOWSZ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HOG7I4F5FJZ5VW7ND6PT7ZYVQJPKOWSZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 28 Jun 2023 10:24:04 +0100, Srinivas Kandagatla wrote:
> For some reason we ended up with a setup without this flag.
> This resulted in inconsistent sound card devices numbers which
>  are also not starting as expected at dai_link->id.
>  (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)
> 
> With this patch patch now the MultiMedia1 PCM ends up with device number 0
> as expected.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device number
      commit: ac192c1a54f9562efe6bac910e6e7aae7b5fbea3

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

