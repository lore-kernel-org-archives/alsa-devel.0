Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BDC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 17:03:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3427606A5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 17:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3427606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 632BC16BE;
	Mon, 11 Oct 2021 19:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 632BC16BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633971822;
	bh=sA9IPFPv1s4drjA088OPVEJGCy9qliVmy40+zSZtmG0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQBrZ5ay1KW1ctH1Rpe5Cn5K+QsmulctAo/BWTNV+cpYL7WV8oAB5tye59fLi7a//
	 D7UeDfyQ6ftnnZFVQZ0N57v0vbuxIPPIh0Q5A2tLPZ2ZzDSV1YnBlUKQpeoKYfj38h
	 8sajKDwUe/dBvhhg39G7BJEN6+Er1G9mcCrDYxQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1415AF804E3;
	Mon, 11 Oct 2021 19:02:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07D7BF8016D; Mon, 11 Oct 2021 19:02:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23C81F8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 19:02:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23C81F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SYyYWH9m"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95BDA60F6E;
 Mon, 11 Oct 2021 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633971719;
 bh=sA9IPFPv1s4drjA088OPVEJGCy9qliVmy40+zSZtmG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SYyYWH9mT/iTcdd9Z0mFqZXKMTVYnCoSOPHBr/QCsUzmbNnV28TlSnR/5VR+P/FaB
 bWfaHzBfBsr6IOO9IkCYXkCqiT3amj5kcOjOa4YsVWPFJKJNwGCWtCAv1STSuvd8QC
 RGaewUOX+MyOhkQGV1f0t+lAZNbyrsyjFATIQpOOMdiq10nRqpnEcc6/5KADLVCrpG
 7JkETWoPbRO1rb4DvFKAcSk5X09neTSbONIPiMxFBQqejgNRHPlngzQqKbLOrlc/VZ
 bgASmtGH86JPDlLWi2ExGEoPIbqQ1Py2oFWKliNT20BNgVXSjV885PKI8Z/uKCJx8O
 eOmskq8GQilyw==
From: Mark Brown <broonie@kernel.org>
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: Kconfig: Select fch clock support with machine
 driver
Date: Mon, 11 Oct 2021 18:01:42 +0100
Message-Id: <163397094549.6567.3180566951499093730.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011055354.67719-1-AjitKumar.Pandey@amd.com>
References: <20211011055354.67719-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sunil-kumar.Dommati@amd.com, open list <linux-kernel@vger.kernel.org>,
 Basavaraj.Hiregoudar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com
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

On Mon, 11 Oct 2021 11:23:53 +0530, Ajit Kumar Pandey wrote:
> We are using fch clock controller as parent mclk source for rt5682
> codec. Add config to enable clock framework support for 48MHz fixed
> clock when machine driver config is selected.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Kconfig: Select fch clock support with machine driver
      commit: 281ddf62f551321982c7d6f525a83a3b3c1d5eae

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
