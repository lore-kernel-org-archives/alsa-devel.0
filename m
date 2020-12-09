Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61439C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 15:26:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13A023AA8
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 15:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13A023AA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C289416E4;
	Wed,  9 Dec 2020 16:25:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C289416E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607527579;
	bh=CRYp/3j7eBIlyjABbHFVQU8zh+mIhHgp1AHkSD+k+is=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJ+yUu8CMWsNz9gdrBBfBDoeAiyI60jmiGwWV09trJz6oMQ9LpbtrTJ5ISQtfBsz9
	 t+KMyl7ITPDfiLaptqe9JWG/Z3mgP0Aapmm7ZVLciw5iHbLkLt+USLsnUUmmO2N1rm
	 JK7Af312GTxQ/JWr+eWD+7PGhb6bK938roitoqcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31AFBF804C3;
	Wed,  9 Dec 2020 16:24:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E92EF804D6; Wed,  9 Dec 2020 16:24:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34BDEF804C3
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 16:23:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34BDEF804C3
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: ALSA development <alsa-devel@alsa-project.org>,
 Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20201208181233.2745726-1-perex@perex.cz>
References: <20201208181233.2745726-1-perex@perex.cz>
Subject: Re: [PATCH v2] ASoC: AMD Raven/Renoir - fix the PCI probe (PCI
 revision)
Message-Id: <160752715603.48520.13957694146754978483.b4-ty@kernel.org>
Date: Wed, 09 Dec 2020 15:19:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, stable@kernel.org,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

On Tue, 8 Dec 2020 19:12:33 +0100, Jaroslav Kysela wrote:
> The Raven and Renoir ACP can be distinguished by the PCI revision.
> Let's do the check very early, otherwise the wrong probe code
> can be run.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: AMD Raven/Renoir - fix the PCI probe (PCI revision)
      commit: 55d8e6a85bce21f748c42eedea63681219f70523

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
