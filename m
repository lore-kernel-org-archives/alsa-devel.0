Return-Path: <SRS0=7xvc=JU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10BC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:07:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AA061153
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AA061153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 461B516D5;
	Fri, 23 Apr 2021 20:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 461B516D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619201272;
	bh=YbpNM4K31aRIxPFNPRngdp3JX6jWNS9uIk3mzuvOktY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9jasGcUqeoMWgHEOD8C4JTdImBj+Y/cIH4l1C2zr6YRxLhN/U1rHkzGJFHy4SGwS
	 JPifctg2fQ1937Fkp947ix0jM+oabli1yAZc9X1ra2Njz9mJSqZr2W56XaWO8KaZ+A
	 SfbU08FuYCUjTtfm+hPLUVm8n947pLQSRSd5/3Wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF8A8F80256;
	Fri, 23 Apr 2021 20:07:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACC3EF80256; Fri, 23 Apr 2021 20:06:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4F2AF800AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 20:06:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4F2AF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S0BZfldW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146D361207;
 Fri, 23 Apr 2021 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619201214;
 bh=YbpNM4K31aRIxPFNPRngdp3JX6jWNS9uIk3mzuvOktY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S0BZfldW30deqp3hGXg+7p9+Yh8a6YdO/1DU8oLuxXyWgo+Ow8JjoFJPqrubfoxAc
 NGnk77goO6zxn3GXVep8RsuKtB5X1EdKMz6OvpuB/iCtJZjvz9h5JNpniKLcETtfPu
 p9Gaxj7hs76PgsZ/wDY7AKdTGipH6dInzCAKFS0zLoTfmMSmHAVl9hA4om3SuiEhng
 sZ0o9Fi6GwO1R9k8WG/Uo4B79daggxHsvycOpEDO/CE4tVqdBO/NwbKdsV/Bu6k1OV
 h7o7zeAs6z4jiv5e+OJFyZzWVMjX6lKRNPTRSjRvgVrppjyNLII22iDSYGFxjM9H1t
 OshMkoS6TG8IA==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 0/5] ASoC: clock provider clean-up
Date: Fri, 23 Apr 2021 19:06:18 +0100
Message-Id: <161920094855.15254.10977006167383713745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Wed, 21 Apr 2021 14:05:07 +0200, Jerome Brunet wrote:
> The purpose of this patchset it remove the use the clk member of
> 'struct clk_hw' in ASoC. 'struct clk' is a per-user reference to an actual
> clock. In the future, the clk member in 'struct clk_hw' may go away.
> 
> The usage of this member by a clock provider usually falls into either of
> following categories:
> * Mis-usage of the clock consumer API by a clock provider.
> * Clock provider also being a user of its own clocks. In this case the
> provider should request a 'struct clk' through the appropriate API
> instead of poking in 'struct clk_hw' internals.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: stm32: properly get clk from the provider
      commit: 65d1cce726d4912793d0a84c55ecdb0ef5832130
[2/5] ASoC: wcd934x: use the clock provider API
      commit: 104c3a9ed07411288efcd34f08a577df318aafc0
[3/5] ASoC: rt5682: clock driver must use the clock provider API
      commit: 8691743c511d6f92d7647d78ea1e5f5ef69937b1
[4/5] ASoC: lpass: use the clock provider API
      commit: 27dc72b44e85997dfd5f3b120e5ec847c43c272a
[5/5] ASoC: da7219: properly get clk from the provider
      commit: 12f8127fe9e6154dd4197df97e44f3fd67583071

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
