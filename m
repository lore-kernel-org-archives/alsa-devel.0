Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C778C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 17:36:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D085611F2
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 17:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D085611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 862A21695;
	Mon, 19 Apr 2021 19:36:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 862A21695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618853814;
	bh=6Wfch/JjyRBuNjNSZiqSdBS3Gqg0YG6Wg5de1/OCJLM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d5EPM+Uys2BRXq8ycg+TO39pGaL4YBsIvLl/bmGua9QEMD+mLLOH2vN4AmyLYqnLF
	 OopunGzzyBYsq9XZFv4RvjgG1Oky25LtQ+xJdRy9Jd7nrVxAK1/iUT8fvrLfEeCXBe
	 Hdn8uNQv9b04II5qZs+Y/uy45GA4qgUFj7qn3Pbk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5B5DF8032C;
	Mon, 19 Apr 2021 19:34:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6005FF8032C; Mon, 19 Apr 2021 19:34:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F1CCF8028B
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 19:34:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F1CCF8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b19m3GeK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F1E3611F2;
 Mon, 19 Apr 2021 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618853672;
 bh=6Wfch/JjyRBuNjNSZiqSdBS3Gqg0YG6Wg5de1/OCJLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b19m3GeKFVTlSCC5AiKwGLmeBnMol1rXSOCg5z7YJZi4EKThqadsC+XruwN1BQjyV
 BuCyj2oSXYUwCDjedUk/YRkn0rQdWlaDdyFP9tZMAQEopPCagW3FxOcnEwIjhyO+Wj
 gkV8HuQo4GQlWdmhWrxbcSvNY5uO53pJIiOAmyXUHQKxDv8zvGEYs8Bpp8OwvTrIXG
 R8pn8Gp+sxGSSKPRJJ4USaE2OJp5NEf0er21dM79C23aaMMtJ+mH/jL9bctJaGgB91
 XQwsd72XXb5VaxBglgBewcxHrC5JUbJjxLHJ4M/3NZLdSyvXE7JVglQ3py9Wp6mVQA
 YXV9eiRK4mcTg==
From: Mark Brown <broonie@kernel.org>
To: David Ward <david.ward@gatech.edu>, Liam Girdwood <lgirdwood@gmail.com>,
 Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH 0/5] ASoC: rt286/rt298: Fixes for DMIC2 config and combo
 jack
Date: Mon, 19 Apr 2021 18:33:50 +0100
Message-Id: <161885301897.45150.11168954333556318124.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418134658.4333-1-david.ward@gatech.edu>
References: <20210418134658.4333-1-david.ward@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mario Limonciello <mario_limonciello@dell.com>,
 Mark Brown <broonie@kernel.org>, Shuming Fan <shumingf@realtek.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Sun, 18 Apr 2021 09:46:53 -0400, David Ward wrote:
> The last two patches in this series fix a longstanding issue that prevented
> the ALC3263 codec from using a headset mic. This codec can be found on Dell
> systems including the Latitude 13 7350, Venue 11 Pro 7140, and XPS 13 9343.
> In fact, there is an ACPI quirk for the XPS 13 9343, which forces it to use
> legacy HD Audio just to avoid this issue:
> 
> https://lore.kernel.org/alsa-devel/CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: rt286: Fix upper byte in DMIC2 configuration
      commit: dfa7b01dbdc9723ced606425b47005bb583a8778
[2/5] ASoC: rt286: Configure combo jack for headphones
      commit: b15c3ea7e0d2c53b33adc8ca0896de378d6df853
[3/5] ASoC: rt298: Configure combo jack for headphones
      commit: f3bd4dde9f048fa711e98626c8c3bc4d1eae3436
[4/5] ASoC: rt286: Make RT286_SET_GPIO_* readable and writable
      commit: cd8499d5c03ba260e3191e90236d0e5f6b147563
[5/5] ASoC: rt286: Generalize support for ALC3263 codec
      commit: aa2f9c12821e6a4ba1df4fb34a3dbc6a2a1ee7fe

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
