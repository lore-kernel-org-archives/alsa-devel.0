Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7960C64E7B
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 17:22:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A69221FA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A69221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA7EE17EA;
	Wed,  2 Dec 2020 18:21:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA7EE17EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606929749;
	bh=WR3l9fx0LdxhzyaH3WCnW3jWjnkhtRskU3evFluW7jk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ef6TBbqT8VoF745iratAe3D1/jQjkTdrr/6qYWT9E09iDSl7ovBeao16lt5fYhJtu
	 jNEGxYG73iKVSClape2M/7lJpgO3uzlm/lm8E6omc1YTRvvoLSOUWg0kcqoK02gRK/
	 LzFtuTzArts7+9adBQkCyjb4XrAdxxrNPhhFi1XM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA913F804C3;
	Wed,  2 Dec 2020 18:20:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63298F804CA; Wed,  2 Dec 2020 18:20:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10BD7F804AB
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 18:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10BD7F804AB
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Tzung-Bi Shih <tzungbi@google.com>, robh+dt@kernel.org
In-Reply-To: <20201201132614.1691352-1-tzungbi@google.com>
References: <20201201132614.1691352-1-tzungbi@google.com>
Subject: Re: [RESEND PATCH 0/6] ASoC: mediatek: mt8192: support new machine
 rt1015p_rt5682
Message-Id: <160692956494.33960.780147549576992424.b4-ty@kernel.org>
Date: Wed, 02 Dec 2020 17:19:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
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

On Tue, 1 Dec 2020 21:26:08 +0800, Tzung-Bi Shih wrote:
> The series supports new machines with rt1015p and rt5682.  Reuses most of
> the code in mt8192-mt6359-rt1015-rt5682.c.
> 
> The first 3 patches refactor the existing mt8192-mt6359-rt1015-rt5682.c.
> For easier to support newly added components later.
> 
> The 4th patch fixes a typo in DT bindings document.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: mediatek: mt8192: rename common symbols
      commit: a5f8037505cbae5b877dea3e15acce4c29e9e797
[2/6] ASoC: mediatek: mt8192: extract rt1015_rt5682 specific DAI link
      commit: 2b53d2e16f735d8f13b77fefe03ce6b43c726beb
[3/6] ASoC: mediatek: mt8192: move rt1015_rt5682 specific data
      commit: ba499c36d12bcea9d4eba0b021c508bfe13c515d
[4/6] ASoC: dt-bindings: mt8192-mt6359: fix typo in the example
      commit: 6552c35de1915c8b423e4969ada1f1f8a53847e1
[5/6] ASoC: dt-bindings: mt8192-mt6359: add new compatible for using rt1015p
      commit: 6986256fdfefc2eeaec5f21d7937d57850fd57fe
[6/6] ASoC: mediatek: mt8192: support rt1015p_rt5682
      commit: cfd8bb254c9985266e4be7f59042170a72548a8f

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
