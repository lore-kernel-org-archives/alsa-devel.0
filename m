Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7BC47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:18:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA06961952
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06961952
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C756916F1;
	Wed,  2 Jun 2021 18:17:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C756916F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622650699;
	bh=fryZbV1WG4/wnitfveidkv/aHaYOjUvgIZf3uaJiM3o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=skkN75qG7/X/vjZ3VaNbI0cBfSqMXrg1lMjkFnoEaYkDVDAkLJfXUTftfOyMkefNz
	 MOFV+PWPSGAwaJgxwXzQRembRiZxPdjLtp314rFhWw5GLMg6bAiO29hz9/gyXViX5y
	 K9i05UtIC0rpfrr1oozZwcyVyTY1Z2jXL+buy5DI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32D9EF80424;
	Wed,  2 Jun 2021 18:17:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9D51F80424; Wed,  2 Jun 2021 18:17:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EF37F80141
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 18:17:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EF37F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SOmayTI+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 436826161E;
 Wed,  2 Jun 2021 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622650642;
 bh=fryZbV1WG4/wnitfveidkv/aHaYOjUvgIZf3uaJiM3o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SOmayTI+r7KWzNhNiQ4aT9RO2AIDsWzg5lxqXvOuWcI0HmC4Yxp0KgqzibkA3f1cs
 +jbAgJW31flOiymggoiiWsj7gHbtG9E4VCWCbZDqJM2y9jDBRWJsbiJfOrieqKQtkM
 Agpk3wd7BaWhKR841LAai/VtYRTgaOHQMlUCP1dOM+onjj2KJ6PZqX/tatrID2Qijp
 FrJHEd6ks6njghmJIJyGIQr/MH+UzTw1KQF5MiMmUUP1Ev02KgzRhEu3bTTqs+164i
 0Ck4+WzjmG/N5KT8YBKbgTBYt1/Yz5XBT5/UfKD9oV1+p5Oa2eXYMbXkLclWKY+QwV
 NKx2QVqyTa6XQ==
From: Mark Brown <broonie@kernel.org>
To: Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH] ASoC: AMD Renoir - add DMI entry for Lenovo 2020 AMD
 platforms
Date: Wed,  2 Jun 2021 17:16:52 +0100
Message-Id: <162265045454.22459.12647691279142134758.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531145502.6079-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20210531145502.6079-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Gabriel Craciunescu <nix.or.die@gmail.com>,
 lgirdwood@gmail.com, tiwai@suse.com, Mark Brown <broonie@kernel.org>,
 stable@kernel.org
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

On Mon, 31 May 2021 10:55:02 -0400, Mark Pearson wrote:
> More laptops identified where the AMD ACP bridge needs to be blocked
> or the microphone will not work when connected to HDMI.
> 
> Use DMI to block the microphone PCM device for these platforms.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: AMD Renoir - add DMI entry for Lenovo 2020 AMD platforms
      commit: 19a0aa9b04c5ab9a063b6ceaf7211ee7d9a9d24d

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
