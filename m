Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B398C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 13:42:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EC8626E2;
	Thu,  2 Dec 2021 14:41:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EC8626E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638452554;
	bh=PlPFJ8yiFNiELG6ZKJrv244m16FQdttBYXV4NOdMySc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdgyog/8Y2JKbMaHTjKH58zo4ku5fuAQl0c02IFLDw8BtIiHkoG9cv8XZCeIqXuLB
	 flLyObdpboTo7swiKxf9VOEPunA7s2QtYLEtoKsCjlm3bVRYvl00RC+nt5caMiN8zp
	 nJ41DBE6SGQmfWCSjr8fHXlie8/PI5pmxLx8jAuQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2B0DF804E2;
	Thu,  2 Dec 2021 14:40:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E91DF800CE; Thu,  2 Dec 2021 14:40:47 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBA0EF800CE
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 14:40:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBA0EF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U9ixmgjU"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 18C10B823AC;
 Thu,  2 Dec 2021 13:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32FBC53FCF;
 Thu,  2 Dec 2021 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638452443;
 bh=PlPFJ8yiFNiELG6ZKJrv244m16FQdttBYXV4NOdMySc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=U9ixmgjUB/x4jPNJKujvw+QF8lOoMn2+J+yWCCCA4yHsKH70yKigsZKZCYeiNP+St
 3pBKhgbb7YTs2FqYFJVDfezGRLetnmylcluIEE31IHcHWU+5spfa0XPKbabhpOVpWo
 tlFeaSCTMFtysvSmONLGYAiEfaC+P7WpCA0P7+l4JOEpQLMi3foxxemqBC38NDvhq0
 pfRcScgSYIc8JPcPYcVX+8YGLHU/JTnxcAXO9dIkPiB7SLOdG0EankQLOWg7NRWqVz
 2+NzFFVL4l0qj/gjO3Xkr9d2AbbBrVmy5xn4Zrq3LtEc/lwwI05eGjd0u68MKpQH8r
 CDsCaCL1eeK7A==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Oder Chiou <oder_chiou@realtek.com>
In-Reply-To: <20211201095629.21818-1-oder_chiou@realtek.com>
References: <20211201095629.21818-1-oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: Fix the wrong state of the JD in the HDA
 header
Message-Id: <163845244138.1057742.16653206454807354643.b4-ty@kernel.org>
Date: Thu, 02 Dec 2021 13:40:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, jacal_tseng@realtek.com,
 danielz@nvidia.com, spujar@nvidia.com, albertchen@realtek.com,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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

On Wed, 1 Dec 2021 17:56:29 +0800, Oder Chiou wrote:
> The patch fixes the wrong state of the JD with 1M pull up resistor in the
> HDA header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5640: Fix the wrong state of the JD in the HDA header
      commit: e3dd4424c2f40aae9080667c4da42b0d7f9be711

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
