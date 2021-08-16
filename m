Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE509C432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8384960560
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8384960560
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B30D16AE;
	Mon, 16 Aug 2021 19:05:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B30D16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629133565;
	bh=+z3+YzSUEPziONpahSudSFlJvPXb7i6H++q1llwpzAA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I0Bi47WMY8ftW75pSYXCn1yxW4MfwFoA9zdt1+stlonIOJ2KAiqpCwNHsGWc6rMvr
	 COKt+g3zt6KNyTgkYpOKHr1rPssFZTysEOG7gUV4Fbh3NGph/c2yt1XxCvIolZRG0i
	 sda9Y/RaOhez/c15iOWDAWj2PI5/AwfnzkobnWAw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D117F80246;
	Mon, 16 Aug 2021 19:05:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4621BF80249; Mon, 16 Aug 2021 19:05:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF5B7F80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 19:05:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF5B7F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PHSvv0gy"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8055F60F39;
 Mon, 16 Aug 2021 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629133506;
 bh=+z3+YzSUEPziONpahSudSFlJvPXb7i6H++q1llwpzAA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PHSvv0gy4WlvdLM6ttP4dohXm/C38wZ0kmv4SURd9IG6cK8zMfQ5KAmlub/AG0cC9
 RJkAMrV6OxsfKtzwD54DXXuyBlmyXgOTFjLdi3ukwxGKLotq/m56sTVmxrPnQCnKDc
 UHR6N/ry7IzOmE0pqnWuplPwh6b6rCMcmBl1gw1p13n+rvn+YT43YGf+UPxukLtZ55
 7OMrOzMHkaQnIr+HZER+savLsGyf+m5b68prk8TwUWVlyoHU4KZ0TiD8klrRS7POFl
 dCcIwk4py2SeMYJ69rSkXT5F1RG17sHZceHME3kerXZMaQXSaTY0VjoazjweehfQLv
 izI24H4/FDiqw==
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: sh: rz-ssi: Fix dereference of noderef expression
 warning
Date: Mon, 16 Aug 2021 18:04:39 +0100
Message-Id: <162913223313.13582.16813599087905835194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816132049.28128-1-biju.das.jz@bp.renesas.com>
References: <20210816132049.28128-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Chris Paterson <Chris.Paterson2@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
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

On Mon, 16 Aug 2021 14:20:49 +0100, Biju Das wrote:
> Fix following sparse warning:
> sound/soc/sh/rz-ssi.c:156:15: sparse: warning: dereference of
> noderef expression
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
      commit: d40dfb860ad72a32b9c2aeae739a2725f8ce011a

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
