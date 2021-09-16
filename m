Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBE9C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:17:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B056113E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1B056113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DBDB18A6;
	Thu, 16 Sep 2021 17:16:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DBDB18A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805435;
	bh=mIZBLtgTVepC4euvVy0u2XkqTe2j3KMWlM2rpeK+new=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1c/U0mB+EvnxMc9MhhniCcxHpvMhaxPlpomo+9mx5CNpJfDafUEd6JaP4D8tFg0t
	 Ddi1ALWPvTwE7C2AmkgohdfAnP2Fx7zp9H3Cj3IjRBb8CIpqHhmZbjti5F56L2jGzl
	 HttHVuHMO2kv/Mqecff3KooOtKqonjSungHP3ytE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26AEBF804E3;
	Thu, 16 Sep 2021 17:15:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DD5EF804CA; Thu, 16 Sep 2021 17:15:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64003F8025A
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64003F8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DroIQkDw"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7D2F6124B;
 Thu, 16 Sep 2021 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805323;
 bh=mIZBLtgTVepC4euvVy0u2XkqTe2j3KMWlM2rpeK+new=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DroIQkDwsFILs63vTg/OR5CTakw1WQO2KktSTfrOPv8FOchaqtplhyyEyxyxo6r8T
 72NKQqbidW3OP4wZIrph0SpEihc2/pvDLzAT1ojo5safgJl+aQSQ1duS89Y7GksasO
 ea6iaDwmbT4arBDOhDxcelqyPev+w7OEhTVsBQLX/RXCt+DX/4mW/lz1busF0QqiJo
 IEfZmh8keeuFJGD/b49ALJcTS+jRNVibZzLrFzujE8wu4mhmoLqBKtetCVnOJuhg1X
 HtQhXi2kUSJWs5i5sBrJvqcewkVZFOZHQ9cwgaVZTI2sAn7ETbpExgMN9fDpxkdAWU
 rasCjRR5sHaIQ==
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: cs42l42: Minor fix all errors reported by
 checkpatch.pl script
Date: Thu, 16 Sep 2021 16:14:30 +0100
Message-Id: <163180495858.19842.11561225019667500130.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916110932.10293-1-vitalyr@opensource.cirrus.com>
References: <20210916110932.10293-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Thu, 16 Sep 2021 12:09:32 +0100, Vitaly Rodionov wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Minor fix all errors reported by checkpatch.pl script
      commit: 7a20dec45d0701671abca965b0dd3e4cda2af3d3

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
