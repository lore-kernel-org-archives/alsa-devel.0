Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F0C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:29:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D39610A5
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9D39610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB327166A;
	Fri, 12 Nov 2021 22:28:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB327166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636752543;
	bh=AgghWFlwj08jaTwHsQSldw9SQNW5vIHNTtQtXlYwbGE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oN07M0Ke54BKAlRh1o31K0VfH57laaKznGS0PnQWN1lvPVsmXLxwigMiQwPq79iHV
	 J88RVZGQctHpCqaBgDNJGZQNwmn1I2cxGbI9Or+COQGIqJbCLZVkLJyu5zhozsynyQ
	 YgvYOtqic/LZn8tjfaa8c9E3H+it2Q0i7TVR1358=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79CB4F804E0;
	Fri, 12 Nov 2021 22:27:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61B39F804BC; Fri, 12 Nov 2021 22:27:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 577DBF80086
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 22:27:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 577DBF80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="n2UXpwF4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A06A60F51;
 Fri, 12 Nov 2021 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636752436;
 bh=AgghWFlwj08jaTwHsQSldw9SQNW5vIHNTtQtXlYwbGE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=n2UXpwF46ZHr8RG9z+KSfNX3P7bqADR4UCcejG6a16Dlvxa7hZ2j3W9tqnsOukEM8
 ovvD1b01DPBDORbfKPIZbGfAy0VpCMQqtODj95CuvcOOSZtrWeGW2jVz7gjKcXJZSJ
 qgKEL0dZSJ59EE58ZvXq4swBtokITPUevjJtFjIHunj0EdzbqzbNqI/E2yr0JBHYpr
 baQgKGJRvdy8XO5fReaB4rcgW4c2fyONBxZfslARfEh6508OU43MFPPynVvLc1+OLy
 4DPwWqrrUyw2Mag2swc58KGkP3/bLwOGnjQAjuu1CzfucXV/bCrzqSVCbODUVR0jc2
 EDkT3zOtW2eRw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, perex@perex.cz, cy_huang <u0084500@gmail.com>
In-Reply-To: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
References: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: rt9120: Fix settings and make compatible
 with rt9120s
Message-Id: <163675243417.742274.8712537973718036345.b4-ty@kernel.org>
Date: Fri, 12 Nov 2021 21:27:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, cy_huang@richtek.com,
 allen_lin@richtek.com
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

On Wed, 10 Nov 2021 11:45:18 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series add the below changes
> - Fix the wrong ocp level setting.
> - Fix clock auto sync issue.
> - Make the driver compatible with rt9120s
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/3] ASoC: rt9120: Update internal ocp level to the correct value
      commit: 9bb4e4bae5a19ca68527392e85ad5ee88fc4b786
[2/3] ASoC: rt9120: Fix clock auto sync issue when fs is the multiple of 48
      commit: 8f1f1846d78a318c7cdb8268b47a964a3dbc0075
[3/3] ASoC: rt9120: Add the compatibility with rt9120s
      commit: dbe638f71eaed5c7b5fbbf03fb044e429c4a2d48

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
