Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B78C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A7A217F1;
	Tue, 21 Dec 2021 20:13:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A7A217F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640114076;
	bh=PAs5jiYeFo0MBioLBW42YrvXg3HDfr/75mvKAgP84o4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z43rfdGOs2Pg8SE3cH75KOCwpSqgbeqcM3PS86ZULCDrp4vniSkKvuozghJHJQhiK
	 VvN3fo95qluY75oiwjwgLbOA9GJkMROvtHQTeCSo0ZTYiwFwlF+SspeWhFmF8mbMEy
	 DVf0sB/fl5aL8DByX1+wCk8pVvQpAqIwG59Lwrcs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C345F804FA;
	Tue, 21 Dec 2021 20:12:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AE6AF804FA; Tue, 21 Dec 2021 20:12:50 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF20DF804E6
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 20:12:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF20DF804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mU333hz0"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 090666178F;
 Tue, 21 Dec 2021 19:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B6EC36AE8;
 Tue, 21 Dec 2021 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640113957;
 bh=PAs5jiYeFo0MBioLBW42YrvXg3HDfr/75mvKAgP84o4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=mU333hz0r1ky9N5/Cxf891yMrzILchntrHGZPscClx+sfRB1ORC2u1lgzqaabDVbg
 MzFK5rtV5d0fpUUQMeCKfCXCVsKeUxEBxlMBEbZVGWOfIi9fOrROjFdWx5dy2Kv8xv
 7ROsBWlNoLI1YYooIMxAoSdCPfqW8bNz7nw0elqS482K9+BvB+zdQD5NV7OMLUIjht
 0f4iA9t8RiETnFfczdqAmNTvNLfd2nWTHgFEFBKa/t5/LDy+DMSwEhqfYrzZDW8Q5s
 r6pVoYlqnn3PDsjS/mRgtuV0iwFXJriQoUFKKBL12hUJTuXyvWRsG24T8u3qx0hmoP
 BDfONoq1OfehQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org, perex@perex.cz,
 Vincent Knecht <vincent.knecht@mailoo.org>
In-Reply-To: <20211220193725.2650356-1-vincent.knecht@mailoo.org>
References: <20211220193725.2650356-1-vincent.knecht@mailoo.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
Message-Id: <164011395475.93163.15678068758276605566.b4-ty@kernel.org>
Date: Tue, 21 Dec 2021 19:12:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
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

On Mon, 20 Dec 2021 20:37:24 +0100, Vincent Knecht wrote:
> AK4375 is an audio DAC with headphones amplifier controlled via I2C.
> Add simple device tree bindings that describe how to set it up.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
      commit: 70ba14cf6dfd7ebd1275562bb9637b8d0ddb8f49
[2/2] ASoC: Add AK4375 support
      commit: 53778b8292b5492ec3ecf1efb84163eac2a6e422

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
