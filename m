Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB19C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:38:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FCD61A0C
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63FCD61A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93C841699;
	Tue, 16 Nov 2021 00:37:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93C841699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019487;
	bh=f/RAxHWMo22E5/g2HCmdkZC4w/uvaz1Ts603+IKDTac=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfar8IQmg+O2SBl4DDRZIVoWl8EQH4hiGLTVm0ZMfo6VI4BCP90/SqK8bzauknTVU
	 X4k9usrknx+eCdt001b6pfUeYLr1wgKYREvzGZK285ji6KxRqWz4ujCdEq6yNQJYNy
	 tUCywDKQlJB5EdR8zjWolIJqqFgg9H/XnVOly8NU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90833F80508;
	Tue, 16 Nov 2021 00:35:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77D8AF804FC; Tue, 16 Nov 2021 00:35:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B52FF804BD
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:35:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B52FF804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CrVOZeG+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6A7A63255;
 Mon, 15 Nov 2021 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019311;
 bh=f/RAxHWMo22E5/g2HCmdkZC4w/uvaz1Ts603+IKDTac=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CrVOZeG+YfIgfam6NwLGYshVRJFS14Pkm26czAJx+CXeMU/3u+H0b2dRcRzHnhOFz
 OWLY4BHgq8j57QnPxQZOv4PDgvs4qry2F2f+Fm5SLT8s0Py2ur8KP6N4sNZ4M5xjh1
 tkNPE1RQ3MZlC2dlkKSS6djy09I6sGO+73z8veZs36GX8+sPOyIpI6fIxIks6COdDu
 CcP2lg9/N48zkXw6JZuLo5VeNH3zqrZkeMF2Zqf/PJq55V4AYBIGKxebyUjYOuaadj
 h4TmLQuIPTz3EJ2RRZL5mPoz3AnWiy4PzozHDc1wnB6ho4tpE8mBobl3YQoBb9xb1l
 gVxycreKjUupA==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20211028140902.11786-1-rf@opensource.cirrus.com>
References: <20211028140902.11786-1-rf@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 0/3] ASoC: cs42l42: Fix definition and handling
 of jack switch invert
Message-Id: <163701930968.675370.11970784121248131390.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:35:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

On Thu, 28 Oct 2021 15:08:59 +0100, Richard Fitzgerald wrote:
> Summary: The driver applied the opposite of the DT setting to the
> wrong register bit.
> 
> The jack plug detect hardware in cs42l42 is somewhat confusing,
> compounded by an unclear description in the datasheet. This is most
> likely the reason that the driver implemented a DT property for the
> wrong register bit, that had the opposite effect of what was
> described in the binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: dt-bindings: cs42l42: Convert binding to yaml
      commit: 0f9710603e803ae9b64ed3b54019170b323968d7

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
