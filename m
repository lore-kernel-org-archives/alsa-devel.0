Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C0EC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61EE64DA5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61EE64DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C7DB1759;
	Wed, 27 Jan 2021 18:16:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C7DB1759
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF0B4F804DF;
	Wed, 27 Jan 2021 18:14:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 553ECF804E0; Wed, 27 Jan 2021 18:14:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D46BEF804C3
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 18:14:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D46BEF804C3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k41fwHk9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8018864DA0;
 Wed, 27 Jan 2021 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611767687;
 bh=lQkobph4usbUMMigcmlpp7KsK1FvowDUodLLlOaWFrs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=k41fwHk99+lNz176E44xBeipUPX0pvdK/StQvWNv4QLo9BOHPmqkpaoNMRBgLflX4
 CNmRslfAy3/YJrfpLfipC4iKaDnK0kdCmnDLOh9bXyhcmx0aVksylbGkJW6G7jL/Eu
 XDT13wWf541eduEAiE9AgD/3q2uGdf9eSGCSbpZ7VpBDsbNm6QSHvq4EOisVAWLV+a
 m+tovQ+IUd6HFzA9c/sRbf9TqGpSUgNGA7xJ+/MSalpK3bDWNE1w1NxiPhEE8uDHZC
 O2EPyUHKO6H21VnGA0gzcrLh6BAZIkN1jy26DH29msUsMwGkMWV9swQJZ/x3ADYpMm
 jl8AUZ6r9Dn9w==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
In-Reply-To: <20210127135620.1143942-1-judyhsiao@chromium.org>
References: <20210127135620.1143942-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v2] ASoC: max98373: Fixes a typo in max98373_feedback_get
Message-Id: <161176762855.34530.16920302960520466046.b4-ty@kernel.org>
Date: Wed, 27 Jan 2021 17:13:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Judy Hsiao <judyhsiao@google.com>, cychiang@google.com,
 Stephan Gerhold <stephan@gerhold.net>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, dianders@chromium.org, tzungbi@chromium.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
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

On Wed, 27 Jan 2021 21:56:20 +0800, Judy Hsiao wrote:
> The snd_soc_put_volsw in max98373_feedback_get is a typo, change it
> to snd_soc_get_volsw.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98373: Fixes a typo in max98373_feedback_get
      commit: ded055eea679139f11bd808795d9697b430d1c7d

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
