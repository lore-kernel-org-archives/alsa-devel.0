Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBC5C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:30:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5D6610A2
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E5D6610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0032E167B;
	Fri, 12 Nov 2021 22:29:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0032E167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636752599;
	bh=v321wXb5ExpBsj4Ht3Qt02JFmLNjlWOT5QGSF6eP2c4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpHpNshFIW3kL74Pxc0jRl7yXLvW5K0+plpjM8E0tXrSzdDcA+Y+6RJNy48yziWzV
	 dpkyRmv36nGjMDKocy7UNjMSQ62RIEeoheOKQmvsebV+fp9g0RtFAGiSMiRHedaL5X
	 03i2RZ7xKathiCv5E9dJg37pkO1B9lNKjjdyFfGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77DE9F804FA;
	Fri, 12 Nov 2021 22:27:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA3F7F804F2; Fri, 12 Nov 2021 22:27:30 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EFBCF804B1
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 22:27:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EFBCF804B1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="p2zWjtdF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F0ED610A5;
 Fri, 12 Nov 2021 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636752438;
 bh=v321wXb5ExpBsj4Ht3Qt02JFmLNjlWOT5QGSF6eP2c4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=p2zWjtdFVCfkIXqUZlsxUQ4l9cDZOIKpi/xRyzdcIJgkX8AhyJ7jozju67mq06Mbs
 3qsAGOo220UFWIGCorTrlAFyqqY4BlNJ2JG6Xk69IopMcV72L/kUrbjZc2rnmgmtfS
 ep48q+UvpQvWi1976fD5NkXJXmB8ixZm/IGbEaGv0BZJFrbqKsqx1nK6iHwPboq6Fl
 reOHDJR6q2EqrNwx9Bm47ew8m8+VtQSymhTZQiLE9WyPBBE8KMC5BKEs59KgA65dZm
 0iVbQGFiiTDxJ84EcVUy3nB+oetDToIY8i6BEfvWyKFT9OPvpLIDKzDZf0GXimOUHP
 lzXjJZ6CoM75g==
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20211109095450.12950-1-derek.fang@realtek.com>
References: <20211109095450.12950-1-derek.fang@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5682: Avoid the unexpected IRQ event during
 going to suspend
Message-Id: <163675243626.742274.8169094214133344079.b4-ty@kernel.org>
Date: Fri, 12 Nov 2021 21:27:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

On Tue, 9 Nov 2021 17:54:49 +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
> 
> When the system suspends, the codec driver will set SAR to
> power saving mode if a headset is plugged in.
> There is a chance to generate an unexpected IRQ, and leads to
> issues after resuming such as noise from OMTP type headsets.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/2] ASoC: rt5682: Avoid the unexpected IRQ event during going to suspend
      commit: a3774a2a6544a7a4a85186e768afc07044aa507f
[2/2] ASoC: rt5682: Re-detect the combo jack after resuming
      commit: 2cd9b0ef82d936623d789bb3fbb6fcf52c500367

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
