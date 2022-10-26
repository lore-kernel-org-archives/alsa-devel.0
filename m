Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C44C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Oct 2022 18:09:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D50D53A83;
	Wed, 26 Oct 2022 20:08:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D50D53A83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666807761;
	bh=bSo26Llx1fbl5wLv1UFcjm3Lvzzw5v5SWbVf/ZjrYPY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b7LQ7S539pO36E9menAQe2PODdy6NNTJ49bEFw+goEMY3koWG37tM66b1zIQ/CsFc
	 8EkzFdMG9SN3kgSsK/8G6u51TCvKgd8RCKeNgm0nuJoq+kQNGGro7ztZ/jIxz68KZa
	 Q7MBlFHSRkoJyso6lVymOX50VquelLFCqQuxpuE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3E88F80551;
	Wed, 26 Oct 2022 20:07:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBBC6F80552; Wed, 26 Oct 2022 20:07:40 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 317C7F800BB
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2022 20:07:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 317C7F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VzHAi8rH"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 612E0B82404;
 Wed, 26 Oct 2022 18:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3405BC433D6;
 Wed, 26 Oct 2022 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666807653;
 bh=bSo26Llx1fbl5wLv1UFcjm3Lvzzw5v5SWbVf/ZjrYPY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VzHAi8rHieHqARk4Hqy9TRV7By1GPHUHLKwn+aidb71ANfYEG7rTOChBrBmtr4mZn
 sFrxMj4HFwz38wyFJ1u/4kBzOHVFAqtY//mdjb8c5ggsY9iU8XM49wQt2I/7cTSH6x
 qU8JUdFRugw3SYFHRTL3oULQRkYgSUR4fb/A9id3x+b6SXFLtCDkIxRRdFIZyhUq03
 I8/u5DgXooF/xAaAEKGoI7FOkxVgjc4sI/hwpnKglpCkEQxKR96WJUAiLil5lEXaFh
 7IzsDCh+HGeGO9jiH9ROMmPGwNrurRgaW/jhStw6+8Tzk04Rhhe1ew4pSrdRF+BD+A
 eWR/f1ePGiRQA==
From: Mark Brown <broonie@kernel.org>
To: Brent Mendelsohn <mendiebm@gmail.com>, alsa-devel@alsa-project.org
In-Reply-To: <20221024174227.4160-1-mendiebm@gmail.com>
References: <20221024174227.4160-1-mendiebm@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add Alienware m17 R5 AMD into DMI table
Message-Id: <166680765193.867857.14376010081173805529.b4-ty@kernel.org>
Date: Wed, 26 Oct 2022 19:07:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: mario.limonciello@amd.com, Syed.SabaKareem@amd.com
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

On Mon, 24 Oct 2022 18:42:27 +0100, Brent Mendelsohn wrote:
> This model requires an additional detection quirk to enable the
> internal microphone - BIOS doesn't seem to support AcpDmicConnected
> (nothing in acpidump output).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Alienware m17 R5 AMD into DMI table
      commit: d40b6529c6269cd5afddb1116a383cab9f126694

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
