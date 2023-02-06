Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE454C05027
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Feb 2023 21:39:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F217F1E4;
	Mon,  6 Feb 2023 22:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F217F1E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675719543;
	bh=3iD31edkdUHtR+qWce/Oi3JEyusbFB/JSiYqBPNRtAs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=q+t+TXo83nSGlGXf3mkAgJxYTEryLWbjzAe6WmwbCoUvKmnuF1WAd9dgqwTM7GAbc
	 O6matVsPyb/qVbcbBvsRVkwpbzGs8eA6PlDhYndKMMk3XyGAoYt9hlMitMKYX5YCSi
	 Gqs+3oVe/SXwfeQ75m8huZNkyVD9DOzZaqEbco+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E13CF80533;
	Mon,  6 Feb 2023 22:37:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10080F80533; Mon,  6 Feb 2023 22:37:45 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0AA6F800F5
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2023 22:37:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0AA6F800F5
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BC7npsMj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E44B2CE1A9C;
 Mon,  6 Feb 2023 21:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E87EC433D2;
 Mon,  6 Feb 2023 21:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675719450;
 bh=3iD31edkdUHtR+qWce/Oi3JEyusbFB/JSiYqBPNRtAs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=BC7npsMjyT4OxrtrtrU1hSPVABbayP64phjkZ6mT5iMZUW/BiHrUjMR2UgY9LH2P5
 HRhnxliIwkJTXdV7V9mlwq8S4elOdbyFtlovIc3eLdDPIFGOSBTt9sV7VFHzd5wkZq
 25BQfAjvYLt5nLUuyKzHEKCgcI9vicezocTaTZGFGR/o68nXxIqXkYtN61mT9JZov1
 CEG2q1I1K4T/9ZTWz5Y4W5/kafRJk2Zx6Zg2IJ+d8gGck7HRQ4NSKLV+8r3QvB3oCm
 VWnXCSBHYua9hDxSEvgEJUDVbRghD8QKNtAd10BqW9wPEd6JBVKSMlKBehC2fNibg2
 jNXL2xvx4FYKw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Daniel Beer <daniel.beer@igorinstitute.com>
In-Reply-To: <cover.1675497326.git.daniel.beer@igorinstitute.com>
References: <cover.1675497326.git.daniel.beer@igorinstitute.com>
Subject: Re: [PATCH v3 0/2] Two bug fixes for tas5805m codec driver
Message-Id: <167571944937.1296981.10882189914536189021.b4-ty@kernel.org>
Date: Mon, 06 Feb 2023 21:37:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
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
Cc: Andy Liu <andy-liu@ti.com>, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sat, 04 Feb 2023 20:55:26 +1300, Daniel Beer wrote:
> This pair of patches fixes two issues which crept in while revising the
> original submission, at a time when I no longer had access to test
> hardware.
> 
> The fixes here have been tested and verified on hardware.
> 
> Changes v2 -> v3:
>   - Resubmit with cover letter
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas5805m: rework to avoid scheduling while atomic.
      commit: 147323792693bf013f60dca160be1d32bd4d180a
[2/2] ASoC: tas5805m: add missing page switch.
      commit: e0576cd642ced1ac65370b4516b7be9f536a0498

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

