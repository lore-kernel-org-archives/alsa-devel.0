Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:14:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127AE6521B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127AE6521B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DD381929;
	Mon,  8 Mar 2021 17:13:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DD381929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615220081;
	bh=sNoJxs7tQoGZX/eqrHIyXoYyHfsoy241kBsKf0/1JqA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dj6ZV+dBNIP5ZUKjmtpVDh2oLT4cJhNEoXVrsTbpzChzIsIvUbeCNOzbcbPGzhZTE
	 TSmFiYNLxRos9TEDDiLySIJK6RiMtmXHrN44TD4CBA5eGgzgKchOc7fSikEFufuTXV
	 pEU8DWqLsR4QU+f3zWMFfPinm5c5pporyDnLJkR4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E0B3F80518;
	Mon,  8 Mar 2021 17:09:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76052F804FA; Mon,  8 Mar 2021 17:08:55 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B911AF804E2
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B911AF804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q/aprXmt"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF9765229;
 Mon,  8 Mar 2021 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615219724;
 bh=sNoJxs7tQoGZX/eqrHIyXoYyHfsoy241kBsKf0/1JqA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Q/aprXmt9uV1HkydntrfCGyNjd35ZTQrs4m7D7lnH56rJclMbO2wnpBpAANGjfU69
 ZzeBJzK/2IRCbp1g100fMYplK5UQ16/KG2ZLH0KNO6hICZaXKpoihSfE5YxP+bdgFh
 C9khlcUbnyWPgK0iSCC5Jvf3TZswwRBozo+dyCmrcIT2DfGJfaXXdg4YMam5V2ZruN
 QNfq1LYRc7KgySSxxlmFRXOagVeZnwRb7GOtpPDEvNIw9tgDSI4DYLlxVGH9ET1Cf+
 7hVQTZZ1n9l81YGhLsvj2xR0XR+D2hGR2NaN5KpIJ+TXkzhen+Z/a8vfRmkqibVYIv
 DBWO6ZAdUkFpg==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Shawn Guo <shawnguo@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Jun Nie <jun.nie@linaro.org>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Barry Song <baohua@kernel.org>
In-Reply-To: <20210307162338.1160604-1-pbrobinson@gmail.com>
References: <20210307162338.1160604-1-pbrobinson@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: remove remnants of sirf prima/atlas audio codec
Message-Id: <161521960849.9621.1079723838844075721.b4-ty@kernel.org>
Date: Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>
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

On Sun, 7 Mar 2021 16:23:37 +0000, Peter Robinson wrote:
> In 61fbeb5 the sirf prima/atlas drivers were removed. This cleans
> up a stray header and some Kconfig entries for the codec that
> were missed in the process.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: remove remnants of sirf prima/atlas audio codec
      commit: 016e0d0920451ccdc29ad6a11be92ba71254c1e1
[2/2] ASoC: remove zte zx dangling kconfig
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
