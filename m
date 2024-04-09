Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04B3C67861
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:09:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3338A2BCC;
	Tue,  9 Apr 2024 15:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3338A2BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712668173;
	bh=bqwaqDPwZwF2/ArlMn7guYurYsRr70Krg4VvKA29s3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dTV9Lu+ViG81wYEyTlLZxXE1btCCu3EyM0+K1pnZSWQ4/lKdjX687/XNOmu/jwue1
	 ykPzmD9LJ2Ie8AOxM423zqMPpCixHyfvDEpqtb5A/gpmUrcgv5fgjFQ1p7Ur30khxJ
	 1V4OHy50wil5qdWMB2X+A/g5yfqPvCiecDLSCgOo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EFBFF8060E; Tue,  9 Apr 2024 15:08:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE978F80615;
	Tue,  9 Apr 2024 15:08:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57F35F805C0; Tue,  9 Apr 2024 15:08:11 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B7C4FF8026D
	for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2024 15:07:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7C4FF8026D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fRJW1/JE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8E32D616FA;
	Tue,  9 Apr 2024 13:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED4C43390;
	Tue,  9 Apr 2024 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668077;
	bh=bqwaqDPwZwF2/ArlMn7guYurYsRr70Krg4VvKA29s3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fRJW1/JET2KcykiHBgr7D75cc+0taxIalUKuY5B2dwbdcS8L7/izvDDh2dYPYeX9s
	 0fHcpwVqLXf7a/XyB3WD8cIEIVqzUN6qiJb1eWRfmnwSGlanHG8uB0QqwsauxC0B41
	 hXVkVNTcgwlTur7Kmq3NQGvqzg/zWK2rZjijD3v6pnVLto3CsqPC1yAXeG8XNPtma2
	 +MfRNrQXjClifCCsYW3BHGjk/H7UsuJipp8Qocl5iXVu2BR2LzEcDxO/pc1AN8tLrp
	 Uw3uxBWNAbPPrheBAXlrHxuTUFD0frtZOcte6FAtkgfKA1/U+gm+rql0BBO/KVrLhQ
	 NzwEPTCWBCy4w==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240407191559.21596-1-hdegoede@redhat.com>
References: <20240407191559.21596-1-hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to
 Asus T100TAM too
Message-Id: <171266807550.28088.15662614766655326891.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 14:07:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: HZKPR7Z7ES3T6KLF47W6CICGPXKPMTSB
X-Message-ID-Hash: HZKPR7Z7ES3T6KLF47W6CICGPXKPMTSB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HZKPR7Z7ES3T6KLF47W6CICGPXKPMTSB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 07 Apr 2024 21:15:59 +0200, Hans de Goede wrote:
> The Asus T100TA quirk has been using an exact match on a product-name of
> "T100TA" but there are also T100TAM variants with a slightly higher
> clocked CPU and a metal backside which need the same quirk.
> 
> Sort the existing T100TA (stereo speakers) below the more specific
> T100TAF (mono speaker) quirk and switch from exact matching to
> substring matching so that the T100TA quirk will also match on
> the T100TAM models.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too
      commit: e50729d742ec364895f1c389c32315984a987aa5

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

