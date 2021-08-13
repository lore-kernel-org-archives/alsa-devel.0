Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEE5C432BE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 17:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27476112E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 17:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E27476112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3C5C174B;
	Fri, 13 Aug 2021 19:26:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3C5C174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628875644;
	bh=VThyJvP43YmAmnkp3rqr1CPohIuzoclnjntpTJXxW7I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A/A55GdDt5XTuLoaMlb70LYw5elQkx1BBbyPPS3mMp1ljip3Wkwn7Px8g0HGWFGM0
	 eSc9iX9H7b0spBJn+P0pkpkpcS6a845BnqD5FnhYyFkf5VUgvzBi6T1nlIBjUQ0NU1
	 RchwECsDPD/593/XkTOHQvv4Tg5zkcQgna81jbhk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 469A6F800E5;
	Fri, 13 Aug 2021 19:26:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2B55F802D2; Fri, 13 Aug 2021 19:26:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40064F800E5
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 19:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40064F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aPUZgdas"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 604FF60F57;
 Fri, 13 Aug 2021 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628875585;
 bh=VThyJvP43YmAmnkp3rqr1CPohIuzoclnjntpTJXxW7I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aPUZgdaswye7wTBsjEWm4y/fB50R9EeVpV2SFWjaLX1ikmwuogbyrNeaMeziZoEbA
 eh+2+lgPmteJ5DrpEMViPUyqFaJQMW/Su5GEtDqH+yHLon0/XnZQDddnovHOaWo6TS
 u0lGmkoxE7Z3yanYENgcnrqv+zaAhWG1i8j60khqBZyrMsc1tj1H1gBuAZgO7wXV5f
 3Dx+NOSIb0Q//zPDt0lv2M8WpyH7y8MSRaeqVSCTHc5IcS+ffoISur6fx0KM0YUuRk
 PqWfO6YZEwmcyE0iefMiU7er9Ld3BVIy88Lu0rIWpL9tANjmykJyAc/gYiuIlMzwUu
 ImOLbKFM7vowQ==
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ASoC: rt5682: Remove unused variable in
 rt5682_i2c_remove()
Date: Fri, 13 Aug 2021 18:26:00 +0100
Message-Id: <162887455325.19744.837395939498410454.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
References: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 Stephen Boyd <swboyd@chromium.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
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

On Fri, 13 Aug 2021 07:34:05 -0700, Douglas Anderson wrote:
> In commit 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if
> wrong device ID") I deleted code but forgot to delete a variable
> that's now unused. Delete it.
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Remove unused variable in rt5682_i2c_remove()
      commit: a1ea05723c27a6f77894a60038a7b2b12fcec9a7

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
