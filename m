Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D157C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 17:31:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 815E717F6;
	Mon,  5 Dec 2022 18:30:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 815E717F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670261473;
	bh=Iglcsh9dUGdpPN+LIC0wDCQLfKz8jZC48/VNMVNhIzk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E9EofYFeakuPddxk4l0erENAinORL446EwTLMKld7KcHBNkGaiAbqHBOwJfTFj81k
	 GraAQAPASRA01WYdUdu3XKVSlN/efXrarMUzie+whH7C8xDVAilO4Kge+/Fj3jSRcj
	 j84PTNUqBKk3yJzNzCjEYKURTIg8QD/HgJXNkU0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D36B2F80579;
	Mon,  5 Dec 2022 18:29:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEF41F80568; Mon,  5 Dec 2022 18:29:30 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1AAAF80568
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 18:29:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1AAAF80568
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nc2dJC9T"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 12849B8119A;
 Mon,  5 Dec 2022 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5330FC43146;
 Mon,  5 Dec 2022 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670261365;
 bh=Iglcsh9dUGdpPN+LIC0wDCQLfKz8jZC48/VNMVNhIzk=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=nc2dJC9TTCyAIelPevVjJu/JKMyYf7kYI4nY9KqU7Jdq+pekcJrptBiszC/tpR+pi
 0b4a+qaxXiy8gEkB2g8Vd3vFsSIVkQDi2F2msAOP3xjgmPANrgFW8lyhBXCNsJBH1Z
 q/nNgADhbNgQ1/OGtj29X2XS1ofTYIdW8HZbXsaY4zoJzGxF9kXysZ1aVlqGtV56PN
 wfMtB2kPBBaVdRpEA6L6gSRT3JRy8xN9yOBjGwSVWlb9E0+mlvuusrVG5bWv2U8/Rv
 3x0KZ9o9cR2mShhr/lu3SPIs5Bbxw9pivEiiOeKilCqtunulpCOwyyeNiOasnAkhur
 Wp3pmsdY9bmTw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, 
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204113621.151303-1-krzysztof.kozlowski@linaro.org>
References: <20221204113621.151303-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98504: Convert to DT schema
Message-Id: <167026136406.536379.456604968048408965.b4-ty@kernel.org>
Date: Mon, 05 Dec 2022 17:29:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
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

On Sun, 4 Dec 2022 12:36:21 +0100, Krzysztof Kozlowski wrote:
> Convert the Maxim Integrated MAX98504 amplifier bindings to DT schema.
> Few properties are made optional:
> 1. interrupts: current Linux driver implementation does not use them,
> 2. supplies: on some boards these might be wired to battery, for which
>    no regulator is provided.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max98504: Convert to DT schema
      commit: 715f45854f559f361d2c222a0353a3a1818875ed

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
