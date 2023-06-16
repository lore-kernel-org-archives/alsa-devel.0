Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14620EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 16:19:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 919AA857;
	Fri, 16 Jun 2023 18:18:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 919AA857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686932379;
	bh=2kVal/nzSVsBGlkTLFoOeXQi1g+H/v+1G/o1A1F/w8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=capWvciYEuYmCZAE3o5zp0QPWmc+h9yn9pS/hZBw6fLy3V15+AsxDEEY/Dv4fgxOt
	 mc6ZW/hXkS543KiRFSn3VqW4eIcaqjhkzk93ISsimIV9Soh40J/EDAPPsPHBRSokOQ
	 5ZgcNO3mHguTzVtccOK18XsOd7PVubpS1bvJ8jzA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CD57F8057E; Fri, 16 Jun 2023 18:18:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E837CF80563;
	Fri, 16 Jun 2023 18:18:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76C16F80155; Fri, 16 Jun 2023 18:18:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19C37F800BA
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 18:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19C37F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GrVEVq1b
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E5FA6615F5;
	Fri, 16 Jun 2023 16:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B1C433C9;
	Fri, 16 Jun 2023 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686932224;
	bh=2kVal/nzSVsBGlkTLFoOeXQi1g+H/v+1G/o1A1F/w8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GrVEVq1bRU5Mg0ACZT55lDnFZeiTMf+M6dru4Wh+DSqNh7s4Vhw5B9PdIFes+ZDNr
	 dfQtRh4VGI6oh6z8mmWKmcub2E4Ex18wP+8ZNHzEjzMho8/RQOYQngw8gBoBzpMF7k
	 QwOTbsYe3qgzdApg00VJ9HS48KDfRhAG0Y1oDNdyRcE6mZIOIdBL2+zz5BUQIUauoZ
	 OwF0FpoVVQMd4Kxk99NkNKgpbui0GCyGvDvBbV9GYMSzS3W1Ygr1ujQ0N00uHH8WAN
	 G/mKEJjPiDj5SBAA2T5x79mzLD/MOSctCSPaA54vvu1tAWPtbQwrfCIupIeNYjPRas
	 YWHg0p7GlGJgA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Juerg Haefliger <juerg.haefliger@canonical.com>
Cc: linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
In-Reply-To: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
References: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
Subject: Re: [PATCH] ASoC: codecs: wm0010: Add MODULE_FIRMWARE macros
Message-Id: <168693222248.298269.5546880276593537709.b4-ty@kernel.org>
Date: Fri, 16 Jun 2023 17:17:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: PVYSLRLP263N36RSX5VETDWPYSLDFHJU
X-Message-ID-Hash: PVYSLRLP263N36RSX5VETDWPYSLDFHJU
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PVYSLRLP263N36RSX5VETDWPYSLDFHJU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 16 Jun 2023 13:54:32 +0200, Juerg Haefliger wrote:
> The module loads firmware so add MODULE_FIRMWARE macros to provide that
> information via modinfo.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wm0010: Add MODULE_FIRMWARE macros
      commit: 60e07fa49b3201d7201cdd7286e7d51e8d937a28

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

