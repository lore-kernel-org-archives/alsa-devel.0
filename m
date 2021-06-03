Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC41C47096
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:45:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52708613EE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52708613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A43961732;
	Thu,  3 Jun 2021 20:44:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A43961732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622745922;
	bh=QX2fUiCiUmkxlGVHfxkr10DT8U2SkzWtLEr1gPbhSJI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J0zkLro81Kg1B/6LYXmXoGruZxOCr5iSWguecaw1PFl5gTYcYHtYuC363k05x0Xxm
	 EmpikVD3HaFvl5wjcX2qUSQkcCleajdSfObI2LI6gwZgiXmVkw/eSU29ZGa/taRaKJ
	 THhIdf9kCnNov4Gvji+vGSpJ9wq35S6XSS/UE/mA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56071F804C3;
	Thu,  3 Jun 2021 20:43:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44F6AF804BD; Thu,  3 Jun 2021 20:43:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 463FDF80253
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 20:42:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 463FDF80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P/yoLykb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53EEB613F6;
 Thu,  3 Jun 2021 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622745770;
 bh=QX2fUiCiUmkxlGVHfxkr10DT8U2SkzWtLEr1gPbhSJI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P/yoLykbA2nbCiCPzNXK5wuNLtsWUWwzswOFPDtigEoGBh919yhCp5x/Fxn86U0KU
 C2Om9LQzx6vdrWoHWCcVcxLKIjfuOhrscbhTrwKJIILodx9mLI4x7ZR41lMjrlmGAo
 xGwur70iBcThRy4us3by+zZ7UkI0tWISZq6ivvVYnCvYBsSZeUCuDkIk99VS3FKXiI
 E3DoWJYF2dLclCqPv+A6qGo3v5+jt0yvuXEl7TJeOLwW1+5/aqBIYCyayajqTP8f/W
 OAqdC+w9OnUmge4auSIjBj66YZjpMuB/qhWovoHfSA5kDRfxAPQk7UQWVftM/Lxnxm
 tzhICfRiwbsig==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: gx-card: fix sound-dai dt schema
Date: Thu,  3 Jun 2021 19:41:57 +0100
Message-Id: <162274557551.14795.13902548000738010349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524093448.357140-1-jbrunet@baylibre.com>
References: <20210524093448.357140-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
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

On Mon, 24 May 2021 11:34:48 +0200, Jerome Brunet wrote:
> There is a fair amount of warnings when running 'make dtbs_check' with
> amlogic,gx-sound-card.yaml.
> 
> Ex:
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:1: missing phandle tag in 0
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:2: missing phandle tag in 0
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0: [66, 0, 0] is too long
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: gx-card: fix sound-dai dt schema
      commit: d031d99b02eaf7363c33f5b27b38086cc8104082

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
