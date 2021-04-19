Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60956C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 17:36:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8B461246
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 17:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8B461246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E2231680;
	Mon, 19 Apr 2021 19:35:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E2231680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618853774;
	bh=YCfcgeyod+s62omSZg8wbLwKTLkzYlS6VAq3eMipkLw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cp8J6bMRz5hRWIGji6mPxk5Rk8IZTBRXCGN+LIPnOJ49cwR4cKM0O/NYUiBoSmDL/
	 38f/8hTy+e1k2YCXvyCGkHmAU3iZW77/9XsyjlEFrk7ZlO4SDF7rKaezjEUffXc+/Z
	 MJ/WbyIHIkptdbCensH6R5jQ8V+x7J+9Ogi8BohU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7453F8025A;
	Mon, 19 Apr 2021 19:34:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD209F80227; Mon, 19 Apr 2021 19:34:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8F7BF8014D
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 19:34:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8F7BF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GNg2kVB5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 823DB61027;
 Mon, 19 Apr 2021 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618853667;
 bh=YCfcgeyod+s62omSZg8wbLwKTLkzYlS6VAq3eMipkLw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GNg2kVB5WIN+gLZi5vNQeft3fhkV0o8FE8k2udUtCjcHNhOYdzCyRcBhPrVfvBk1/
 SUPdh4HMcFrvNA/TU6Y0BKnDqeZ26G9mmqEhrfkSWe4LK2Kzr+OO1rG61VYZCHBnZ1
 4MJUwue5Auz5iNy3J3TTpNNuTmRhc2lOiR8vyDWbpH3RnnGVaWJR7BajWnHgsCRUBw
 JbBeR6AUYxO8+Qwc+EYkZImhxkWSsIHoYP8Gu/tVxdVxJuAPLvxlzrozgQcqRrHuFa
 W6m08g3tWTZYzQ+xr1iEeNx/OcBI7lKKAmow9dwErwB32RIkTqmKRVvgwdnxRG/ctZ
 AlckM549ysADA==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Niklas Carlsson <Niklas.Carlsson@axis.com>,
 Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: sigmadsp: Disable cache mechanism for readbacks
Date: Mon, 19 Apr 2021 18:33:48 +0100
Message-Id: <161885301897.45150.10509642492570383427.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419144901.9441-1-Niklas.Carlsson@axis.com>
References: <20210419144901.9441-1-Niklas.Carlsson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Niklas Carlsson <niklasc@axis.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, kernel@axis.com, linux-kernel@vger.kernel.org
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

On Mon, 19 Apr 2021 16:49:01 +0200, Niklas Carlsson wrote:
> The ALSA control readback functionality only works for non-volatile
> controls, i.e. control values that does not change on their own without
> driver interaction.
> 
> This doesn't work for readbacks since the DSP firmware updates the
> control value. Disable the cache mechanism in the driver if the control
> name matches the prefix used for readbacks to ensure that the control
> value is valid.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sigmadsp: Disable cache mechanism for readbacks
      commit: 11a9b987611f17e6a95e9bb34c1f5f9aa0b6ae25

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
