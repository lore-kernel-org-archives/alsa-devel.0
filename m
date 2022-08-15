Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7613C00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 16:27:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39E7215F9;
	Mon, 15 Aug 2022 18:26:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39E7215F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660580866;
	bh=7V+endEttnNu6oxaF3HKatJcXsg7TXNiTQ5xwRdEMlo=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KK0iQpTdixF3F7Q9+P0E175j+nWdgJ6pLD0YeWvYCyHNuuAyXBULb2s/IfMmrePqn
	 2xbJoz871s0fM0kz05akVqsKjaPxFOKv6HydhPXWcSvFqVnb1P9894+Azskjmc6NJ5
	 DDVosdW+EUFD/wSGCGnSAltiP1Nn6isDVfETzHM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3076DF805C4;
	Mon, 15 Aug 2022 18:23:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D2F3F805BF; Mon, 15 Aug 2022 18:23:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 997F0F805B2
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 18:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 997F0F805B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="o3QlHTQ+"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7A086611E1;
 Mon, 15 Aug 2022 16:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0972FC433C1;
 Mon, 15 Aug 2022 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660580603;
 bh=7V+endEttnNu6oxaF3HKatJcXsg7TXNiTQ5xwRdEMlo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=o3QlHTQ+RKrNDBzNNBnd+uDpMhEj0MRGvXgSGZe9NjqxNhdn6F6kT26tSBdqnU0nB
 fwx3yLQCO4TmcWVRnTsH/j3XI8I/14HDR1pIrVoOwlIGxJJpF5zwecicLguPy6ZIeO
 7uhcyW/GrhhFYp9pSLZomonOIeh+pHZ6SA1zBm5mIO6kGKpJ0VZ9FrUefiqIEUaoaF
 k9dsBapJ95LJiFRJOlZSgy4cEHae/JLldXS1+R3vylL+071ANZGIkuOTZNFjcotUFP
 /cJFTX6JNIiCjcH8UmjLMON/wJJDkyY/j2Wq+ZmoeSTIemkaGpok1lvR62AQBrKYAY
 0AiJUF8KSs8wA==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, Matt Flax <flatmax@flatmax.com>
In-Reply-To: <20220814222218.119786-1-flatmax@flatmax.com>
References: <20220814222218.119786-1-flatmax@flatmax.com>
Subject: Re: [PATCH v4] ASoC: codecs: dt bind. doc for the new TI SRC4392 codec
Message-Id: <166058060275.769843.4261026899082443606.b4-ty@kernel.org>
Date: Mon, 15 Aug 2022 17:23:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: robh@kernel.org, alsa-devel@alsa-project.org
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

On Mon, 15 Aug 2022 08:22:18 +1000, Matt Flax wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: dt bind. doc for the new TI SRC4392 codec
      commit: 020adbfb2edae4dd90d7774d08936261e218c171

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
