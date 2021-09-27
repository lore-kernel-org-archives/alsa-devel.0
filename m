Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB23C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:53:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1874C604AC
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1874C604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACCBE16B1;
	Mon, 27 Sep 2021 19:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACCBE16B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765223;
	bh=MFzBCd7WIw8UFh7ciOOL3Lyu+G+BmRBAF7OXTVUAHP0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D649LRHBVDt3iwexyDPZtToOLH0AtVzT+GfxFHuu7Ztisz0QSJZLL2+yE8LwtWRaL
	 5Pl00Z885E+MGKnirgW5SckOOmZGtzWfJJ+lGZiV6DLrf+cemnACqPX4l7xB76JdGm
	 4xHXroxpLNxJrZz4AYYD4WPaRPjEiFADUjGm5Ua0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9CC3F80559;
	Mon, 27 Sep 2021 19:48:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64A88F80548; Mon, 27 Sep 2021 19:47:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAEA8F80542
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAEA8F80542
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HzKHFJ9j"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 806336101A;
 Mon, 27 Sep 2021 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764867;
 bh=MFzBCd7WIw8UFh7ciOOL3Lyu+G+BmRBAF7OXTVUAHP0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HzKHFJ9jt2zOkZL+kfIerCdOyj8sU7pOVcVpbTNaLYk2N3Y3JOAELG2CKtX5VwGLQ
 gdckQvpfa8iGsM4gFZtqYqWIwJZJX+599idb06JOZGI/Lay+zEgE8UwawEemaszHAQ
 Gq9RU/JOzoJWiQOCiO0ZuC4m5f1KtyVVffbPCzMM/IMAlBVinJH7sO91qc4hue05hD
 Lx8Ag69IW1pe/aapLF+N9o7Wib2IRaP+pGo8MhD4IiURnz7HWD7fY5SMcFLm+d6Juy
 CVwbifiWfgzNSuoeju6UwghM3mNspJN/wP/b5KOul72XsJjntyOuaeDBfobXLg1GWd
 Wb4Djwx66vSrA==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2] ASoC: cpcap: Use modern ASoC DAI format terminology
Date: Mon, 27 Sep 2021 18:45:40 +0100
Message-Id: <163276442023.18200.13119333110460590938.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213034.31427-1-broonie@kernel.org>
References: <20210921213034.31427-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Tue, 21 Sep 2021 22:30:34 +0100, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the cpcap driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cpcap: Use modern ASoC DAI format terminology
      commit: 99a26f2416fc1fadcfb4519ae5de5265b109e268

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
