Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75659C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 19:09:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010286103C
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 19:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 010286103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57B611737;
	Tue, 26 Oct 2021 21:08:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57B611737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635275348;
	bh=rkTbdhJreJu+/Dt15/a4V/IUMovkjM8fHEWaaAzawEs=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R4Lm4A0vBsQlwEBsGx4Bhi+Lw6Paq9DGIllx+/T+6CBYF6HoWzK13uvxMtOp/qKUE
	 cruQ7Ms9Yz+B2c6R+YXQhbgaHtuGxeig2QvT4EOSgcR8d9DYVfe9BFr0Dfx32iCDRR
	 jzUPodCxyvrUF3bHPz8SC3w4wbcimmUoNti2Vyhw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5BB8F80506;
	Tue, 26 Oct 2021 21:07:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00E41F80507; Tue, 26 Oct 2021 21:07:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 543A4F804F1
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 21:07:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 543A4F804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="g03LVhSk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4D716103C;
 Tue, 26 Oct 2021 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635275218;
 bh=rkTbdhJreJu+/Dt15/a4V/IUMovkjM8fHEWaaAzawEs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=g03LVhSkOLB1KkIYNHJUOmyzOY30+NPAZLdiPxvN+7SsfZLG8VF8rRQmnuE1HkMbR
 bMuuOPwrZNm3vzdl8njx68uqEbUCzEpmvvaoyC2IfWObnJyZ4mo45DOGNKFj3OsBTh
 pz9ntNrG1eyLo8AdjqRJk915YVoES7dKDZqDWCsE35WGxuX14w2bTxLDXgtfN8pw6a
 X8SJDxBswYUjwDIgTdZXfzryKjftAFdKXV3y4mgs1WWpRf/ysAOkPR5ELgwH/YuSkQ
 rgr3ZNxoko1GYPHk7X2btX+NkSXEtJ8TlN8tpdpci6tm3Grkvbv0JsJ1s3rGAI+xJp
 IKoyDq6iR4bXg==
From: Mark Brown <broonie@kernel.org>
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <cover.1635260849.git.geert+renesas@glider.be>
References: <cover.1635260849.git.geert+renesas@glider.be>
Subject: Re: [PATCH 0/3] ASoC: amd: acp: Dependency cleanup
Message-Id: <163527521660.2033755.18271571479627858811.b4-ty@kernel.org>
Date: Tue, 26 Oct 2021 20:06:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 26 Oct 2021 17:11:20 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series cleans up the dependencies of the various
> configuration symbols related to AMD Audio-Coprocessor support.
> 
> Feel free to squash into a single patch if you prefer that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: Wrap AMD Audio ACP components in SND_SOC_AMD_ACP_COMMON
      commit: f41d2ece95e1b40a708d2f1d5170ebc594df6ca2
[2/3] ASoC: amd: acp: SND_SOC_AMD_{LEGACY_MACH,SOF_MACH} should depend on X86 && PCI && I2C
      commit: f31c9399738870d0ae8081a65f264f5d103fd180
[3/3] ASoC: amd: acp: SND_SOC_AMD_ACP_COMMON should depend on X86 && PCI
      commit: 4bf74f8e56054cf3521f646313301d19c331ba54

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
