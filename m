Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233BC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:03:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1882067C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oN2L84cJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="opiKH/kZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1882067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE094170C;
	Tue, 18 Aug 2020 19:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE094170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770207;
	bh=F0d1tHSMqIeJXGRCk/zltyPc2lru14KSafh0tiFtELM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oN2L84cJ1FN9Bcd77DS/psNArqbKvY7Mp6j748YQndVJeV174T1aYXQ2M5u11V/Nj
	 zOMQT0PCozgQSOiAH7FfpxZ56tWtqMSN8rLs3Gh6ezmdUZK3zsT5YehVviRUq1hYRE
	 VZWRQZDtfTXz9DJ5PdNJWBHGHZNXk5ppEKp1mvnQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADA60F8029A;
	Tue, 18 Aug 2020 18:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83271F8033F; Tue, 18 Aug 2020 18:55:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EBCBF80341
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EBCBF80341
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="opiKH/kZ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FEAB20786;
 Tue, 18 Aug 2020 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769720;
 bh=F0d1tHSMqIeJXGRCk/zltyPc2lru14KSafh0tiFtELM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=opiKH/kZMfaz3lDHneR7+ihHEGL/mIrOfTr5dG01Giq1h9rJ79uKzp2hh8nRr0HG/
 yj99c358vIf+E66L2K5eL7Ah159k+TSf1kwfZ5494B8HV43X9KDojhCvf18GdRDlku
 OlxQRtm/3/ihRjCYDOyFCcTXcsgZXROtHqB2icnE=
Date: Tue, 18 Aug 2020 17:54:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
Subject: Re: [PATCH 0/7] Allwinner A64 digital audio codec fixes
Message-Id: <159776961932.56094.2705667823777375165.b4-ty@kernel.org>
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Vasily Khoruzhick <anarsoul@gmail.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, 25 Jul 2020 20:25:50 -0500, Samuel Holland wrote:
> This series fixes a couple of issues with the digital audio codec in the
> Allwinner A64 SoC:
>   1) Left/right channels were swapped when playing/recording audio
>   2) DAPM topology was wrong, breaking some kcontrols
> 
> This is the minimum set of changes necessary to fix these issues in a
> backward-compatible way. For that reason, some DAPM widgets still have
> incorrect or confusing names; those and other issues will be fixed in
> later patch sets.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: Add a new compatible for the A64 codec
      commit: cef305d4eb0733f25215793ed30b056a7db9bb62
[2/7] ASoC: sun8i-codec: Fix DAPM to match the hardware topology
      commit: 90cac932976e93b17203b4216ba83bdcd68e0ed0
[3/7] ASoC: sun8i-codec: Add missing mixer routes
      commit: e47d2dcd88fc3e6837f8aa0060ce820ec9001e26
[4/7] ASoC: sun8i-codec: Add a quirk for LRCK inversion
      commit: 7518805fb636308909a6a7953e9fdb194abb15f8
[5/7] ARM: dts: sun8i: a33: Update codec widget names
      (no commit info)
[6/7] arm64: dts: allwinner: a64: Update codec widget names
      (no commit info)
[7/7] arm64: dts: allwinner: a64: Update the audio codec compatible
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
