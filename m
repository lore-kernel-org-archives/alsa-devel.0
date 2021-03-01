Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C9AC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:38:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E8061477
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E8061477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0718168B;
	Tue,  2 Mar 2021 00:37:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0718168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614641905;
	bh=X3zQMo928GW1qVxc5UjuLGk4bT1FV3lRMqtNQ5gZEHQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVUA4oXrWFjHKcz1iSgwEAvPmsVuNJxOATfQY0/wZx+RzHCEMv8X+5AtsOJDseERL
	 r6ehBkv1q2JCbf2r0bgSSykhhJWdbBCRpFGXgA1p5r6HCJJhRFecU0jil3yV+1r6j3
	 3ZlUZ53w27T/hMaRks46OCQA6X1uNmoMCEjPFUuw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E070FF8032B;
	Tue,  2 Mar 2021 00:36:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFE1BF8032C; Tue,  2 Mar 2021 00:36:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64D1BF802E0
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 00:36:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64D1BF802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="s1P7a/mj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BE5060240;
 Mon,  1 Mar 2021 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641763;
 bh=X3zQMo928GW1qVxc5UjuLGk4bT1FV3lRMqtNQ5gZEHQ=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=s1P7a/mjPGC7cZDiw1TfVmHhV0R72JCZggtix7XvoqHKtV3+2Fwj7gNdwveotxJSo
 Ns08mHLd6d4I0ATAfU5c7q+CHXFWUg8Mp1eFs6Y5mQrIPuxn3goxofVqAziZQTkcZF
 HOTb8a6fnL61+In1rc16SLanz4mCK4shbNUmoGBPnWObU8K5exmkrDivVHtT6g1YBI
 aNfRNtO77UHIwhR/FeqXzrJ5i9smW5lMqmZ/+5LSrpX0LfjT/hNvF/nMEQzBvXAj7a
 CA+FMKRSYJuJyWVDppqtP1eWAxmJrTuUAHCqXzKUsH3TGbk5/2IzgbknebgTdJ85lX
 vohvxTS4hHU/Q==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-amlogic@lists.infradead.org,
 Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Banajit Goswami <bgoswami@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org
In-Reply-To: <20210221153024.453583-1-krzk@kernel.org>
References: <20210221153024.453583-1-krzk@kernel.org>
Subject: Re: [PATCH] ASoC: constify of_phandle_args in snd_soc_get_dai_name()
Message-Id: <161464168095.31144.11030304529781910068.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sun, 21 Feb 2021 16:30:24 +0100, Krzysztof Kozlowski wrote:
> The pointer to of_phandle_args passed to snd_soc_get_dai_name() and
> of_xlate_dai_name() implementations is not modified.  Since it is being
> used only to translate passed OF node to a DAI name, it should not be
> modified, so mark it as const for correctness and safer code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: constify of_phandle_args in snd_soc_get_dai_name()
      commit: 54928c5c63c83afd5a1c2a91802a9c37e9a4ff88

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
