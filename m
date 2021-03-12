Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D24C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE1C64F80
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE1C64F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5365E18B1;
	Fri, 12 Mar 2021 21:26:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5365E18B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615580829;
	bh=8REJj3Y9QOcOPMWgnj7DTjSfqgT3/WHmgg80wudwrUY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=krS6jIxLyuw3PoLHShxDlMRqnJVDmcrte0WErDqbwTgJCDE80xCGzhXMEYXTPViVk
	 TqdfhTMW8ZYg6K+vL4YR7s2nGBhhJUqdwxeiSZqKCw++Vzzu3WOkcQ+zE8qx22fyQ5
	 UzVfvHaeHBxu2nLanIlleKFAQAWUmGaMF1Qjm2QM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AF48F80424;
	Fri, 12 Mar 2021 21:25:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6994CF80425; Fri, 12 Mar 2021 21:25:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74337F800AB
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 21:25:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74337F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rCogVS0l"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF8AB64F77;
 Fri, 12 Mar 2021 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615580714;
 bh=8REJj3Y9QOcOPMWgnj7DTjSfqgT3/WHmgg80wudwrUY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=rCogVS0llx+MNZSr0Q5l92YWncdktECXO2bi8AqxfxIhSDf6D7DgZYdJn2K1f5a52
 qKF+y8nMjWldGaZlFJeAPzZ8or2020LN+Nd6oq5NoU1Hkmqamgzfgqkf/gzK4pX5iC
 kNdlbfC/lzfhw3YMTTfoSDNoMCjtmJEKmwQrK10kUlCS8qdgn/UZEY54njb8CIAgLU
 KDmCr/wTXhjUPvPIFxE37wlysdLErAUahyIpBeWJoTNJOPi/VRBee2oTXXAgNIDlI+
 As9FzL39rlHzQGfoqgeK5OpZNo3F6zx77XdzhtVhN3T85sAY+GcqYI6Fq+owYvbT56
 e3pPk2b6O8K0A==
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, lars@metafoo.de
In-Reply-To: <949671bd00c14b6d9aa5e85cc14be5d4@realtek.com>
References: <949671bd00c14b6d9aa5e85cc14be5d4@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt1015p: add acpi device id for rt1015p
Message-Id: <161558062957.11113.13025947723315918621.b4-ty@kernel.org>
Date: Fri, 12 Mar 2021 20:23:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, , kent_chen@realtek.com,
	kent_chen@realtek.com, "[陳建宏]"@alsa-project.org,
	shumingf@realtek.com, Derek@alsa-project.org,
	Shuming@alsa-project.org, 方德義@alsa-project.org,
	derek.fang@realtek.com, 范書銘@alsa-project.org,
	"Flove(HsinFu)" <flove@realtek.com>
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

On Fri, 12 Mar 2021 02:45:15 +0000, Jack Yu wrote:
> Add acpi device id for rt1015p.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015p: add acpi device id for rt1015p
      commit: 464b489a7885d6a89b0dfa7b7f1f56e2db80700d

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
