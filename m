Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD536C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 14:24:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104A260F5C
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 14:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 104A260F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93B111680;
	Tue, 17 Aug 2021 16:23:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93B111680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629210266;
	bh=BghacR8oaU4UL7U6wQSFD1t7wDKOPESMTm6bkFZ1ZZE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FmJiWASh8P4GhbZqVUQeB09pHASIB8gHSxReyBUH8zKmElnqgozZgE1mB/X7vyvTa
	 ou7nKhBCR7NxBBh1c7uyHtAF+KOsRMRCXbL8BFOvCBF9C1nBzSB/K8QHIb7Tr98HZm
	 Njv9fTx/LJJzcI+JxOqN8UW52eX6WZPrvykbLTPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D2D2F804DA;
	Tue, 17 Aug 2021 16:23:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57B07F804CF; Tue, 17 Aug 2021 16:23:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D765FF80272
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 16:23:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D765FF80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vAbAFVUv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 223C160FDA;
 Tue, 17 Aug 2021 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629210180;
 bh=BghacR8oaU4UL7U6wQSFD1t7wDKOPESMTm6bkFZ1ZZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vAbAFVUvZH/p5z1b6N/U8D5YVzQyTPrQ+UYTVz4FiYK555tiEmJn6WpL/qUlbCKRF
 VYCT1xRWJntGK9gsvEVaK/J1GGArhUBlskIU/1es7azdUXXMsTOp9a4ha2PIa6Wvsb
 /gK08/JG2MU9NJoqHGLTi5HMk76tNKjzMcOMOoRuXXcchNqk7j8wSTI2e/TCQSxlF5
 FA/O0vSzOOj4+cuqggkcBf9tJp4AGqx44x5mxCuuynHXLAVoSMp7v1zLXK5lEl98Fq
 jHgqGoWE/OVYOJatX3z13JdNwiameSv00d+ge8V4WjwAJGeV0UWNsEDhnV4JJQw1fB
 rzjCZjJK3zekQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Aakash Hemadri <aakashhemadri123@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: tegra30: Fix use of of_device_get_match_data
Date: Tue, 17 Aug 2021 15:22:33 +0100
Message-Id: <162920984134.3104.358684242050344444.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1629148177.git.aakashhemadri123@gmail.com>
References: <cover.1629148177.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Helgaas <bjorn@helgaas.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-tegra@vger.kernel.org
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

On Tue, 17 Aug 2021 02:44:50 +0530, Aakash Hemadri wrote:
> This patchset fixes my previous incorrect patches.
> 
> 356b94a32a75 ("ASoC: tegra30: i2s: Use of_device_get_match_data")
> 80165bb80433 ("ASoC: tegra30: ahub: Use of_device_get_match_data")
> 
> Aakash Hemadri (2):
>   ASoC: tegra30: ahub: Fix incorrect usage of of_device_get_match_data
>   ASoC: tegra30: i2s: Fix incorrect usage of of_device_get_match_data
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tegra30: ahub: Fix incorrect usage of of_device_get_match_data
      commit: ea2efedefbc34f782db396c3d90e80aa1fff57a5
[2/2] ASoC: tegra30: i2s: Fix incorrect usage of of_device_get_match_data
      commit: 240fdf3f42fc6505adecaf5a74fac75b3c702cf1

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
