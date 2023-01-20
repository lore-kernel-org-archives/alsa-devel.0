Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2469EC25B50
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Jan 2023 22:23:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2605435CC;
	Fri, 20 Jan 2023 23:23:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2605435CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674253431;
	bh=deX7jDxlX/W6uQkqoupHiyuH1WVUYRSy7lZvPqAJLbk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mjtUG5rW56qLUBo0czrRXHGj6sXR8os7ccDJEokAuw54rwHVwrk9/9+B4eq6eLInz
	 rY8nrVQ5N3TMmfEfNvNVGmYMvmFxGZ6sHBbng6L/gbcnfSscUh5iI+rinjEqjm4N29
	 LKdZ/oMYYI5q/wP1UyvlvyYMwXpdd1j/LLdKTDTY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BACFAF8024D;
	Fri, 20 Jan 2023 23:23:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C38FF8026D; Fri, 20 Jan 2023 23:22:59 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5740BF80246
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2023 23:22:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5740BF80246
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MX2hM4TQ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0F2D5620A0;
 Fri, 20 Jan 2023 22:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B7C4339B;
 Fri, 20 Jan 2023 22:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674253369;
 bh=deX7jDxlX/W6uQkqoupHiyuH1WVUYRSy7lZvPqAJLbk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MX2hM4TQ+A95PgAsk2oSMOmtuYi/CNxMzUFd3n4OdNLbpv6oGxxm0gT4btzep0acC
 JZRnNbOPfsos+fym+BNN4eEqc5STi/cRQzTQlb4wQHSLn4M+Y9wuwMAH/J7+NpHQxp
 J3n1rFozIqrpYCqZosyt561/jgpnqYz8acIaZzdt0yQzzd5fpDsWBLSj3GNDbDBjji
 Tvb+svcNol1LcxOwjk1Ovikt85ll9zMILbCmgg/pN0dLxGu2j5RYf5Imudq7LIyegk
 XausqtoetS97YMu2auFuaOLykRX/6CTCUP6vgsYUMBIytotxpiYV5ob61zvv/dkIgz
 /n2ilaDAPvxbg==
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20230118161110.521504-1-arnd@kernel.org>
References: <20230118161110.521504-1-arnd@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
Message-Id: <167425336610.1425934.15022702108965764366.b4-ty@kernel.org>
Date: Fri, 20 Jan 2023 22:22:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
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
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 18 Jan 2023 17:10:45 +0100, Arnd Bergmann wrote:
> This data is no longer passed by the platform code, so
> there is no point passing it down at all.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/5] ASoC: samsung: remove DMA filter function and data
      (no commit info)
[2/5] ASoC: pxa: remove snd_dmaengine_pcm_open_request_chan()
      (no commit info)
[3/5] ASoC: ux500: remove platform_data support
      commit: 1766ac5248063c25d1fe46e04bb936c46313ed89
[4/5] ASoC: ux500: remove stedma40 references
      commit: aafe9375b386010e28614f58499d199250a16874
[5/5] ASoC: remove snd_dmaengine_pcm_config->compat_request_channel
      (no commit info)

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

