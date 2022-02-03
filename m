Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82310C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Feb 2022 15:20:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3CEE1701;
	Thu,  3 Feb 2022 16:20:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3CEE1701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643901653;
	bh=fkmhh2nZS2bagIZM4kmtINyEqgLkLtHyNbDGIR19QK4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVVGixmSYGzZG+1ydpbikj/cGSVEZCj/mTIOzLowjvIWgv3VDeF6ueYgcqvVzKZrA
	 zuvjl2bXu76L3DeUFKhvfgKYLLYbFmtkmyQ2RNLqX9eCIMwh1U5Z9oBjc2yEDkYs2c
	 2hmOjI8Z6y9X9sg4RxacHZ8YjWtRMPq0a+f3+Drw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7706EF80159;
	Thu,  3 Feb 2022 16:20:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7813F802BE; Thu,  3 Feb 2022 16:19:59 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BE5CF80159
 for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2022 16:19:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BE5CF80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DC9ynJZa"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D68C160A3D;
 Thu,  3 Feb 2022 15:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA348C340ED;
 Thu,  3 Feb 2022 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643901594;
 bh=fkmhh2nZS2bagIZM4kmtINyEqgLkLtHyNbDGIR19QK4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=DC9ynJZa+R+9SOT/YIloZ9GcbI/zr64/t3eSSVzxeuznNUMa26bSiCkkw9HH2YgyG
 zFlhNwq0uxgIeliXGw9FtAlHzJYGDad/DOydDYO6VyGJjnADCoPCclltYruIF1v9D0
 YepaWy1Ry4Bj4A0l7OW5mIQG2ZLYb/3YMTVbW3tb6LBcs4I0AJzVlOZvimOQXebDZL
 fCqlOGwwdK8INjcHiwGwcybJcqNDWw1UsE6gWgPgmhLDZFFyN8770HHK3zRQmO735H
 HhalisnBmwCMNH0Zm1tvaN3uZL9Hyz4fqh3dj+o+cG9HvrXYGsJZrq9IAAVCK6/1e6
 J3u8IaCMCd/4Q==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20220202164545.30457-1-ckeepax@opensource.cirrus.com>
References: <20220202164545.30457-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8962: Allow switching between analog and digital
 inputs
Message-Id: <164390159261.786717.3589990399602455425.b4-ty@kernel.org>
Date: Thu, 03 Feb 2022 15:19:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: martin.kepplinger@puri.sm, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, shengjiu.wang@nxp.com, lgirdwood@gmail.com,
 daniel.baluta@nxp.com
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

On Wed, 2 Feb 2022 16:45:45 +0000, Charles Keepax wrote:
> When the DMIC_ENA bit is set the analogue inputs are disconnected from
> the digital core of the chip, in favour of the digital microphones.
> Currently the driver will always enable DMIC_ENA whilst the GPIOs are
> configured for the DMIC function, this means the user can't currently
> use both the analog inputs and the digital inputs in one system.
> 
> Add an additional DAPM mutex that allows switching between analog and
> digital inputs into the digital core.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Allow switching between analog and digital inputs
      commit: b5083c0c948ac7f52ca700af219cb491735ecd4b

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
