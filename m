Return-Path: <SRS0=sDoq=M5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240AC4338F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 00:51:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E53B60EE5
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 00:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E53B60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8ECF2172A;
	Fri,  6 Aug 2021 02:50:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8ECF2172A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628211067;
	bh=STQ4jFjhT2tAmblc4n9G9SuqeStkebra6JvvzascIDk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rGT3cTrJ4UE/aGYk8tjFgoPo++8o21vmnuc9oPL3DTLXaEJXJ5NKwRFnw1uZy0Fbi
	 o5pAs0uk5LxTuE8gFb+c6LG68L0et21vrKoEQ78LArarAHRYE7sb6+BCGmPA0fHv56
	 fXYahQxSRLU3hvtn63vKd3ZZ6EywzagI5JvNNi30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCC84F804E5;
	Fri,  6 Aug 2021 02:48:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 747FFF804E4; Fri,  6 Aug 2021 02:48:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4987F8049E
 for <alsa-devel@alsa-project.org>; Fri,  6 Aug 2021 02:48:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4987F8049E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RlqQV+Lj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B86D0611B0;
 Fri,  6 Aug 2021 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628210913;
 bh=STQ4jFjhT2tAmblc4n9G9SuqeStkebra6JvvzascIDk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RlqQV+LjV79/5T6Sgc9AYyJVBE7WqUD0pgceK4Wl3br44c5rO547dKLvO94s8BZMl
 V8xpSEK4DtZRj7RG9EWrRPAC25M2VHzrfTzF4UethXekitZLBdFiP0uyVpFRQROyUr
 ECao3mAf63mONRJfpwAolwuY+vWnwA0aJ5Krshz+ra0rhz117qRQyvIUm8+cf5aXgN
 IApP4ynfieNpBS4O0MLOFaCORNdLxiOe7lLm+WTiFagMY3KEs3Z2kxPj5C4UhZd8mv
 o1v89LuEAJ5HSillKDoFiekthSutAYruewBrs+bjs0SOtH+InZJXiP6uRAJ2GmFzVK
 sfGMqdAI3roGg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: add Multi Button Headset Control
 support
Date: Fri,  6 Aug 2021 01:47:52 +0100
Message-Id: <162821054282.18754.16317109735589826799.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716105918.7301-1-srinivas.kandagatla@linaro.org>
References: <20210716105918.7301-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

On Fri, 16 Jul 2021 11:59:18 +0100, Srinivas Kandagatla wrote:
> WCD938x has Multi Button Headset Control hardware to support Headset
> insertion, type detection, 8 headset buttons detection, Over Current
> detection and Impedence measurements.
> This patch adds support for this using wcd-mbhc apis.
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: add Multi Button Headset Control support
      commit: bcee7ed09b8e70b65d5c04f5d1acd2cf4213c2f3

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
