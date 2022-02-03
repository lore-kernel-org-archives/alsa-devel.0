Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3CCC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Feb 2022 12:53:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7912116F1;
	Thu,  3 Feb 2022 13:52:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7912116F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643892791;
	bh=MX6s01rx/OdEQk4J2Dq8jkWD7sSlbsMea8gvpLM4cko=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMNTJfMh1csHwAEQVVLlHbgyDnBGe93Jd6yH4A5Jods1iFyNrWGpxDtu8/7i69Qch
	 /QJjxJP0EyAnjLq1zs9GDt92X5kFZuKEK5qFIBfrbYwGusvi4ZojXSpwhb4mlBeC2A
	 qjskTrcaC5CfdHK5HPPAzkRIkavSr67IInYeQM8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17662F80171;
	Thu,  3 Feb 2022 13:52:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6814DF8027C; Thu,  3 Feb 2022 13:52:20 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F14C6F80082
 for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2022 13:52:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F14C6F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HYobC6OA"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8B576617C2;
 Thu,  3 Feb 2022 12:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8881C340EF;
 Thu,  3 Feb 2022 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643892735;
 bh=MX6s01rx/OdEQk4J2Dq8jkWD7sSlbsMea8gvpLM4cko=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HYobC6OAV25jU4TLHmN98rYtmMP+gXpealy44ooOuiTZcjhNsSmac8mlmHdw6tRq5
 XjOKsYb+f4mcf1E1sEhkrpxW5MjX/yqr7JFMIdTFg6Zrwv3TSGM29vc0gcYszfQqau
 iraoFNF+2Sm051YqSgxWIK9DXySP/j4IoQ8h9J0X5vYslNOfoLll40O4e88jk1Grco
 IYSVdOoRNEP6f3vTPGFnTmdWA3B2IRzpXZ2NsexB860Rm0QIXYLPoh+LaQtA/3EBzd
 AfTbxagjSBpbYsBMARh/OCvS6l5nYsLtr903wzDIEwRc72nIy2r0J7RSTjNhJJ1Pi8
 OAhTDiSD+ermw==
From: Mark Brown <broonie@kernel.org>
To: V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
References: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker
 amplifer in machine driver
Message-Id: <164389273260.1027470.16661556291810590077.b4-ty@kernel.org>
Date: Thu, 03 Feb 2022 12:52:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Basavaraj.Hiregoudar@amd.com,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Vijendar.Mukunda@amd.com
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

On Tue, 1 Feb 2022 02:02:15 +0530, V sujith kumar Reddy wrote:
> Maxim codec driver already enabling/disabling spk_en_gpio in form of sd_mode gpio
> hence remove such gpio access control from machine driver to avoid conflict
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker amplifer in machine driver
      commit: 7fa5c33d043160eba3be9fb8e21588dff2a467c7

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
