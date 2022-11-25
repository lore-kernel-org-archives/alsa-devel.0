Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E1EC43219
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 14:39:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE9BC172E;
	Fri, 25 Nov 2022 15:38:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE9BC172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669387160;
	bh=iuTi+FfhIxjv1xdL+qu3A8EUi5IhPdwJ2hWZj4UxQlA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=flVm08YtYWG9MiMB0vGgbn5hBFlv7LVOXAb6PGmpjniZy7uL45juw+HOfudBvLIQN
	 dECGmEz3D1+y1AMk0TfuOrxAStnauM45Vr/BVeebUCnWA6Cri/4oY3cg1NP1x+K/YI
	 oYeyBCGQb0ijXto5+u+xkBzve4aV+tFeIeM95xuw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 612CEF800B6;
	Fri, 25 Nov 2022 15:38:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DE62F80236; Fri, 25 Nov 2022 15:38:29 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0731AF800B6
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 15:38:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0731AF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UInR8Tp9"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 19811B82B0E;
 Fri, 25 Nov 2022 14:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A7C433D6;
 Fri, 25 Nov 2022 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669387102;
 bh=iuTi+FfhIxjv1xdL+qu3A8EUi5IhPdwJ2hWZj4UxQlA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UInR8Tp9VfIP1TsXq7DZrl14Tk2LkRVLxwnnVahrgi9yU9WjnGX3IKd+b9BZKtgYf
 jTSvV870xpbnmB5GU/k9tESu66Dnelmz+qAwLaOYNwRSlVvIUCGulMu48Y9gWi8OUU
 vF9d1YdC31PF+V30mYxPvWtG64HrClFz46/je9KKI2y2IUsCBvwIKi4Pl1rjWpbxRM
 ToJ+RiQKTdGLu1u+JOXSIE3vBO1hnto5s6Rc3g9UCnFh0/y732yVwqul9HQPSLcqND
 vVEBPPDz1yfTTe0YEKQCcmHFf+xyvUfkA3UzvwGRZk+uUrZhWvoIzpSw8bf7zxAovY
 fsKDn6iRv/vjg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com
In-Reply-To: <20221124134556.3343784-1-rf@opensource.cirrus.com>
References: <20221124134556.3343784-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Switch to using namespaced exports
Message-Id: <166938710147.543323.1489768823749219688.b4-ty@kernel.org>
Date: Fri, 25 Nov 2022 14:38:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Thu, 24 Nov 2022 13:45:54 +0000, Richard Fitzgerald wrote:
> Use EXPORT_SYMBOL_NS_GPL() instead of EXPORT_SYMBOL_GPL() and patch the
> three drivers that use cs_dsp to add the MODULE_IMPORT_NS().
> 
> To make the namespace more specific the KConfig symbol for cs_dsp is
> changed from CS_DSP to FW_CS_DSP.
> 
> Richard Fitzgerald (2):
>   firmware: cs_dsp: Rename KConfig symbol CS_DSP -> FW_CS_DSP
>   firmware: cs_dsp: Make the exports namespaced
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] firmware: cs_dsp: Rename KConfig symbol CS_DSP -> FW_CS_DSP
      commit: d7cfdf17cb9d072b41547e7cc882ecd900aa6589
[2/2] firmware: cs_dsp: Make the exports namespaced
      commit: e57d904ac4be6de7ecc9083f51a9a38f72482f82

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
