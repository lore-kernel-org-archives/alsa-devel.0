Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B13C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 17:15:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DF558BCC;
	Wed, 19 Oct 2022 19:14:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DF558BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666199702;
	bh=i3IFe9Dp6l/D420+8OJkSHWipA4PgNu7QAMi3ng4M/M=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKYriMxqtsMFSLmW2XCiuBWk+kjRD6ajfAMRa4+PZLxmTAck7P/ZG9Dv7KU2AK9dH
	 qn+rMUprMs7AmJlg9LhsFdf022+sHP0/RYZ/fViBXzm030wvXzFskIvFQtJFl+QmaT
	 23qHfmrmImQdEeVvm52uCFCVrye+vV47L46JUURw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B989FF804E0;
	Wed, 19 Oct 2022 19:13:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD35EF80137; Wed, 19 Oct 2022 19:13:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8542BF80137
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 19:13:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8542BF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SrsYFKlC"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 02D02B8256D;
 Wed, 19 Oct 2022 17:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697BEC433D6;
 Wed, 19 Oct 2022 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666199623;
 bh=i3IFe9Dp6l/D420+8OJkSHWipA4PgNu7QAMi3ng4M/M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=SrsYFKlC/RbxJ7Or6yL4/7szHV9ILz72+XAa0dyZJr217Bl5TmsBuTTcVNK0wt97D
 2q2EQT0FigVG2b4dxl7XJJ4L6DqUKPNrpv96eId9zEWP+6L/RAoRZsrKyVj7TDXoQ1
 ANq7MiIl6m+UI4uxw74HexLYN2bSISmph7KN16T/WKEhIZC2I1OnfsXfYsGydSd6jE
 D2cccJbUAgdUr//egmJjeZZRSQ622L8UnrcQHx3Tz39SjDEZ+N7ZBxINLGVqHz6WXY
 dvLSfgQQC/QjsU5VZnPOjuRjxh/86ZccRCxNM1PbJdEVVlMUSCBvF+HHiMJ1qZG0xj
 dPEi7uBxLX78g==
From: Mark Brown <broonie@kernel.org>
To: linkt <xazrael@hotmail.com>, lgirdwood@gmail.com, tiwai@suse.com,
 mario.limonciello@amd.com, perex@perex.cz
In-Reply-To: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
References: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
Subject: Re: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+
 ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Message-Id: <166619962215.1416660.1802527696570911480.b4-ty@kernel.org>
Date: Wed, 19 Oct 2022 18:13:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Tue, 11 Oct 2022 10:51:36 +0800, linkt wrote:
> Lenovo ThinkBook 14 Gen 4+ ARA and ThinkBook 16 Gen 4+ ARA
> need to be added to the list of quirks for the microphone to work properly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
      commit: a450b5c8739248069e11f72129fca61a56125577

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
