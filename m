Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A8C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 20:02:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C37600D3
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 20:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C37600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5AD816BA;
	Mon, 14 Jun 2021 22:01:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5AD816BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700920;
	bh=NWfwBAl37uZr0GzMxOWdBMjl8COCgIrfBVJda3rqPoY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HjmAU7yz6aLunuO8oVEgvCHiKOHLdgZ4WSRq9ssxfZownuafrP3LBXWm8VjhGHvI9
	 IeEL0IRwrB0mvQt7bWcBda+tN2nuUZmG57rsvhm/h8KhDUJsv1gGj3gl4LAIQxv6wu
	 mmQnF92Z7pZGdzPYjuxTqOmHa9MWc8a1R4pyEhQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFC33F80542;
	Mon, 14 Jun 2021 21:55:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10F57F80543; Mon, 14 Jun 2021 21:55:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A47AF80539
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:55:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A47AF80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rWKkz30e"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C236134F;
 Mon, 14 Jun 2021 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700526;
 bh=NWfwBAl37uZr0GzMxOWdBMjl8COCgIrfBVJda3rqPoY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rWKkz30eXbWepa4X39gBPY5Oc/8LEHE2qHSC5TnegqqsDZt2CmSTIn+a+caQFvvVC
 1pSBvO0749Uxq2dgXKoPRdOhijbHDLeMu1HuA88391XR68/D/rIOwsL88wUPTFoWG6
 FrziAAtZ4N8DvRCxbPhiXZpGEDcrtPHblIAoPXDtignI258IVvZBDFd2c9HP/DjMg5
 XsNejABziWzewG2APjpka5O6NUW3kTVDbrCQTSYMSpQa1LB2A6RxSuoYW+udv8cR+/
 o0FWrhmOvr7noVgGkgf6sJCmowF+8e3PVK6xhQ3Y/hTncUgSXfvgNOvONxHXatulrc
 CT61/f6R+SLxw==
From: Mark Brown <broonie@kernel.org>
To: agross@kernel.org, rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, plai@codeaurora.org,
 tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 swboyd@chromium.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
 devicetree@vger.kernel.org, bgoswami@codeaurora.org,
 bjorn.andersson@linaro.org, judyhsiao@chromium.org,
 alsa-devel@alsa-project.org, perex@perex.cz
Subject: Re: [PATCH v3] ASoC: qcom: Fix for DMA interrupt clear reg overwriting
Date: Mon, 14 Jun 2021 20:53:55 +0100
Message-Id: <162369994007.34524.2234994672815898510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210609072310.26099-1-srivasam@codeaurora.org>
References: <20210609072310.26099-1-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Wed, 9 Jun 2021 12:53:10 +0530, Srinivasa Rao Mandadapu wrote:
> The DMA interrupt clear register overwritten during
> simultaneous playback and capture in lpass platform
> interrupt handler. It's causing playback or capture stuck
> in similtaneous plaback on speaker and capture on dmic test.
> Update appropriate reg fields of corresponding channel instead
> of entire register write.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Fix for DMA interrupt clear reg overwriting
      commit: da0363f7bfd3c32f8d5918e40bfddb9905c86ee1

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
