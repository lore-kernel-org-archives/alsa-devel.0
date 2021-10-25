Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1453CC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:41:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E9560F70
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64E9560F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8684516DC;
	Mon, 25 Oct 2021 18:40:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8684516DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635180087;
	bh=/+1k99dardJpt43GXzNTf7jcp7+7Kejj39Ekr6ZBxmw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GP697Zgkp032NHMALyfD8QhbOFQHiMoTjfGfswrTP73kElhtfiM1R2GjS8XUPaNUX
	 arTnXchgHVQQCwJMB0frP4juCYJyBPdtXbYgQutodaySvbwQfmRvcFSGjw3ZVzrbrS
	 PHA+J74hGgxdYhMm7g97cVuIb/tllesU7E+4xVn0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80A59F804E2;
	Mon, 25 Oct 2021 18:39:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D50CF80166; Mon, 25 Oct 2021 18:39:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E98AF8025A
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E98AF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c/qh8KSm"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A9F60F9B;
 Mon, 25 Oct 2021 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635179980;
 bh=/+1k99dardJpt43GXzNTf7jcp7+7Kejj39Ekr6ZBxmw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/qh8KSmYDq/kS4yWOtElCF2X7RXbxQ+koGDUEJEyBax0tOOfevxflJunpTtnbzYA
 9vC+j9w7MMOV3tvdqEzoIO2IRPqDRBKXCyXYwF/FS3nzD1Sw2VsylXb3p/K9nbGhk2
 sajBgRL2xLO59wpKOyyWRMkU3KF6w3bMRnQIpx48HmconRLGDmSsIWUa6YMRbLogDx
 rPyCh3V0nzMkfoKWNzPfqOHH55FiltYPz5xJzeujzZFyXGQybtNgfYGm3irFFudyfT
 OmRmQ9H/Ti8KM9SxTaMvnBtl47A8Cgz/xxghUfOqxp+n2tZmQV89FoQtK/Yd9qvkFZ
 nLZpaNC7+pq6w==
From: Mark Brown <broonie@kernel.org>
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: acp: Add acp_machine struct for renoir
 platform.
Date: Mon, 25 Oct 2021 17:39:22 +0100
Message-Id: <163517996155.3558038.16782674915140335935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025074808.471333-1-AjitKumar.Pandey@amd.com>
References: <20211025074808.471333-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
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

On Mon, 25 Oct 2021 13:18:00 +0530, Ajit Kumar Pandey wrote:
> Add acpi_mach struct for renoir platform to select machine driver
> based on codec and amp ACPI id.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add acp_machine struct for renoir platform.
      commit: 8a8e1b90bd2cc7db85ba544e63c8dc01fe113fa9

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
