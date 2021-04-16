Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDCCC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 16:04:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D706124B
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 16:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D706124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6BE416B4;
	Fri, 16 Apr 2021 18:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6BE416B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618589057;
	bh=GgzZ0S+TgsvHcoC+LS+Zot6MiDm3+O3n6aq2TyBHn60=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kjjy2+/2Zjtu6Bl91R6Q6gy3pNNf6qh1NDzgs/rpbbEXf5u+/QR9+XCTAvWveucrh
	 dM8jWnmueTI90UF6jNT5IABgRK5U28Fk/cRO2PajffHHEAHPVtNgQXYKsy6kjKuLVv
	 izBQW/0IQNODxfKZrXS/U/KJO1lHX3fU/IoU+TVc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7113FF80271;
	Fri, 16 Apr 2021 18:02:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC067F80128; Fri, 16 Apr 2021 18:02:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E31E1F80128
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 18:02:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E31E1F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d9PZNU2L"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E14BF613B0;
 Fri, 16 Apr 2021 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618588951;
 bh=GgzZ0S+TgsvHcoC+LS+Zot6MiDm3+O3n6aq2TyBHn60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d9PZNU2LNTwlRHAPEkF0S6monO2uDS2mcc4it4hoHaGu/Y7/eonEDt5FaE96zznmH
 GQePLHkm0HLyr988BjTpM60SM5Hv4yOfhXEa1+CvH9iqvZLsvaDcT+rxmemVSQYZ/X
 8kDWY3oGojvgiKqiFDFEXH52tqLszM/9FZ47EnR1aW92eD+ASL6Vp3BHsj6wXSEBTv
 25SoaKJ2Bm14ZXnkcxwOBT/j5YLyC/fTT4Q/IFHP1Qt5GwrloWJwAnPYnKHNjPMt5F
 /DF/cfpxetQVk9TwvQLW9ZaCe20XeZ+l6GmzAEFr4yudiZBNYK7y6xOa3Uh74niDEm
 dl1iwCcXj6isQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: simple-card-utils: Propagate errors on too many
 links
Date: Fri, 16 Apr 2021 17:01:48 +0100
Message-Id: <161858869853.28833.11333855316963570344.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416071147.2149109-1-thierry.reding@gmail.com>
References: <20210416071147.2149109-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>,
 Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org
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

On Fri, 16 Apr 2021 09:11:46 +0200, Thierry Reding wrote:
> The DAI counting code doesn't propagate errors when the number of
> maximum links is exceeded, which causes subsequent initialization code
> to continue to run and that eventually leads to memory corruption with
> the code trying to access memory that is out of bounds.
> 
> Fix this by propgating errors when the maximum number of links is
> reached, which ensures that the driver fails to load and prevents the
> memory corruption.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: simple-card-utils: Propagate errors on too many links
      commit: 0f687d826736a5b4eee03170382fe54d413b912a
[2/2] ASoC: simple-card-utils: Increase maximum number of links to 128
      commit: 343e55e71877415a23372388b3e0c59a9bba42f6

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
