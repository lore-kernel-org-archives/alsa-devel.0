Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095BBE6FE33
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2024 17:18:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B65F84D;
	Fri,  6 Sep 2024 19:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B65F84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725643126;
	bh=kWsF+/BUUgOC3v4X1mMJMZI/wMX1wZO9dj6uEviAxYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=veGQ7M0k/QNMBqMJXuyS8dUCzsYGplZ7rZc42TlKOfI5PqtNzkElJngWKbrSAtEN1
	 ySsfxTl4bbijyIir8hFKQMH+aifM5u7NAdWtsH2ggRqsh/fizAi4n3LoEYp5NvqyMx
	 kVs8zERrddjjosLo7WpX6I429zc6zvG4Oco3Fxok=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A92CF805E7; Fri,  6 Sep 2024 19:18:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 85556F805C1;
	Fri,  6 Sep 2024 19:18:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 976F9F8016C; Fri,  6 Sep 2024 19:17:54 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D4ED4F80107
	for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2024 19:17:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4ED4F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UF+ACxCp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2CEE6A45185;
	Fri,  6 Sep 2024 17:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED5EC4CEC7;
	Fri,  6 Sep 2024 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725643070;
	bh=kWsF+/BUUgOC3v4X1mMJMZI/wMX1wZO9dj6uEviAxYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UF+ACxCpnUJzfIueroGIafGBPWzsUWtNZSRkmLuwNAwngsq46EJvBARmrEYTwSFtd
	 k1eEwQehSMmlv+MAfdpDNlhNkvt9sIHv0ZkF2c4K4Uvq2A5Ft2QECBWGajhC9Ms64w
	 GFGZ+FgO7LeCHZaY/211T+aD6wm0H6htJX0E9A/AtRmyTFyGaN+5KYtCm9M8Y2pFvm
	 /9IHXQp7dM9I6UlQN+W+LcZUnWDuNVwSrdqMcomaXWqkKGv+h6SG6/mquNd0nDsouw
	 jkk0X67/Ds2RNFWAsa7+3xWml4Vl/p66QxlHHraNnKZVIJHaXV2Q+wj4Dr9NdBjnwb
	 ZTVWWVTptu7BA==
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 ying zuxin <yingzuxin@vivo.com>
Cc: opensource.kernel@vivo.com, yang.yang@vivo.com,
 ying zuxin <11154159@vivo.com>
In-Reply-To: <20240906084841.19248-1-yingzuxin@vivo.com>
References: <20240906084841.19248-1-yingzuxin@vivo.com>
Subject: Re: [PATCH] ASoC: codecs: Use devm_clk_get_enabled() helpers
Message-Id: <172564306815.1104804.1522611474091349812.b4-ty@kernel.org>
Date: Fri, 06 Sep 2024 18:17:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12
Message-ID-Hash: LNUNUB2GHWCSBPBCS7FL5SULFISTGJMS
X-Message-ID-Hash: LNUNUB2GHWCSBPBCS7FL5SULFISTGJMS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LNUNUB2GHWCSBPBCS7FL5SULFISTGJMS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 06 Sep 2024 16:48:31 +0800, ying zuxin wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Use devm_clk_get_enabled() helpers
      commit: 241c044e743f9c55886828763c99b51b0392c21d

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

