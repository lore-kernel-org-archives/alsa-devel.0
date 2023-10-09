Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C92CD6101
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Oct 2023 16:20:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCE5FE9A;
	Mon,  9 Oct 2023 18:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCE5FE9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696868422;
	bh=Y5wdZoSN5IMGtbcM+xe2nsU6jP+OkHwT0xytzE7h6iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J2XnAUYDRevpl4E0/Mi8Wg/No3EAAE3EQUhEbFDu9cQiwp7dvU6ETtTXaKZ63gs33
	 KUbDNG88TfnABqN7OcpEVJUjB4z7gt6gTagURbPpy5cC1VqtmRJD2fzIsW0k8htlQV
	 p6Lhcshg+JAkInT4V1GOK3LfGQGgPIpz7iGVl5g4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B440F80310; Mon,  9 Oct 2023 18:19:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CB62F80310;
	Mon,  9 Oct 2023 18:19:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D3A6F80310; Mon,  9 Oct 2023 18:19:00 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB898F80166
	for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2023 18:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB898F80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EhLxMwmA
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 9D67CB81210;
	Mon,  9 Oct 2023 16:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097B4C433CA;
	Mon,  9 Oct 2023 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696868331;
	bh=Y5wdZoSN5IMGtbcM+xe2nsU6jP+OkHwT0xytzE7h6iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EhLxMwmAykDV2tsGTVIO8Mx1bEzNGMGZxPWHbvS0VMS8TcV1/JWKZKdQymqtdmSiA
	 45FjYxGbz+41a6zVFlokz+n1lgzYNNSJrb6WdpPiVhoZ5bVs/UKCaJ7q+c5y8YZxK1
	 SAGMvMSv8fZi9YtL9iiOWGNtGkPPkB4QLBcg/+VP29HVkRKavXbT6cz/aBCuzSxQNx
	 dyxqRElF+9s+2a4YPh2sQ3tVcBd5ilw116Ryza6a0DgVHkEK2/VmpLvjnMR80O0M/0
	 RpOCUjqHh8TmAswd1cvES9s/sKjsjcnHrxgO4J1yhkU9e2Jk3JlwiZj/ZrpwH45HGj
	 fGbauvZ7Lq+Ew==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20231003155422.801160-1-krzysztof.kozlowski@linaro.org>
References: <20231003155422.801160-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wsa-macro: fix uninitialized stack
 variables with name prefix
Message-Id: <169686832875.101967.8301588803886718212.b4-ty@kernel.org>
Date: Mon, 09 Oct 2023 17:18:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: RBGHOVEO6F6UTSPIZRHKKB2I6SI2IHGB
X-Message-ID-Hash: RBGHOVEO6F6UTSPIZRHKKB2I6SI2IHGB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RBGHOVEO6F6UTSPIZRHKKB2I6SI2IHGB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 03 Oct 2023 17:54:22 +0200, Krzysztof Kozlowski wrote:
> Driver compares widget name in wsa_macro_spk_boost_event() widget event
> callback, however it does not handle component's name prefix.  This
> leads to using uninitialized stack variables as registers and register
> values.  Handle gracefully such case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
      commit: 72151ad0cba8a07df90130ff62c979520d71f23b

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

