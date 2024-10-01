Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE95CEACF1
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2024 17:54:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 859D4832;
	Tue,  1 Oct 2024 19:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 859D4832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727805284;
	bh=HajVRT1qJkY83lZWNDbgpsphq9/WKmRFlBgKT+gdSxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GZ9I6wbYuCnpER+mR80lpLbkbfrJTQvwKNcbQDWmsG3+8QsTO2nWfCH0ujpcDFGR3
	 eeR2KvGTKDK9xYJlQlOyUdGy9sJn8Eiok84JYVFY0Jkr+NLAts9wskilmlJIGlnR/Q
	 IfH61/Xv/nz79ArcmQLOyYyxhVY3PMKgN4ZbYJNE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6DA1F80618; Tue,  1 Oct 2024 19:53:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9025F8061F;
	Tue,  1 Oct 2024 19:53:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 607BDF805C6; Tue,  1 Oct 2024 19:53:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9495F80528
	for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2024 19:53:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9495F80528
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o1xTd1ib
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B6B8B5C551A;
	Tue,  1 Oct 2024 17:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC9C4CECD;
	Tue,  1 Oct 2024 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805195;
	bh=HajVRT1qJkY83lZWNDbgpsphq9/WKmRFlBgKT+gdSxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o1xTd1ibw2UDEd4hQFTVfuCvVovARuC4r77wPuw1OmOWcB/k3ChWsOdEUtjcaJBTJ
	 okcRT6GSJJtpde86xpTFLfpYzLCrhJ1NR+w34vov+y57UtFLMBs3j/LlRX9t/ijg1E
	 m1EM8wxkk5qyhhkfwQsxZeJeUxxcRBU30IzCcZWpt5RUtPgi2MxhjZ/CPLE/haCnlw
	 7pNXLI4jN/WCeejBZVv50OCVtyq7DX+kb/q6HOc8S2Z3g9KRCeHU9lP8I7sv/Vma5i
	 8sCqFkG2Klr705kCoFE/uPIGKf+3yuN0FBk5seqpT+TQrTuU+emx9vSLxipbTyHwNu
	 PmJCtc+hvRNMw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
References: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2 0/9] ASoC: amd: acp: refactor acp version
 differentiation logic
Message-Id: <172780519249.2298697.15015301099797029707.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12
Message-ID-Hash: 6REDFK7AXNJDQNOPSBGQTYX7GUZICAFQ
X-Message-ID-Hash: 6REDFK7AXNJDQNOPSBGQTYX7GUZICAFQ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6REDFK7AXNJDQNOPSBGQTYX7GUZICAFQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 24 Sep 2024 11:48:12 +0530, Vijendar Mukunda wrote:
> Currently different logics being used in the code for acp version
> differentiation. This patch series refactors the code to use acp pci
> revision id for handling acp version specific code.
> 
> Changes since v1:
> 	- Add patch to update mach_params subsystem_rev field in
> 	  machine select logic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: amd: acp: simplify platform conditional checks code
      commit: 839a8b18dbd2e2345a261169fb68d950a1071862
[2/9] ASoC: amd: acp: use acp_rev for platform specific conditional checks
      commit: fca471b5d094dabd65f6d8777096e9ed1df1bef7
[3/9] ASoC: amd: acp: use acp pci revision id for platform differntiation
      commit: 5dbf8a19fe5d5a4c764ba88d171b06704354296a
[4/9] ASoC: amd: acp: store acp pci rev id in platform driver private structure
      commit: 40412a298c77eaa4a22a1aa7030bcc0b2e02c618
[5/9] ASoC: amd: acp: pass acp pci revision id as platform data
      commit: 0eae2c96b49d85b31ab635b9dc6f09b09d3c54de
[6/9] ASoC: amd: acp: update mach_params subsystem_rev field
      commit: 0a374a2dd0afa7ba431fab2749197374cf95fb67
[7/9] ASoC: amd: acp: remove unused variable from acp_card_drvdata structure
      commit: 2e609185e174a9ffd462ab125085ddfcbe9e2f4d
[8/9] ASoC: amd: acp: replace adata->platform conditional check
      commit: b33d93990e3774a24575517c6fcc2167036672d1
[9/9] ASoC: amd: acp: remove unused variable from acp platform driver
      commit: 9864c8af89eb14a2e5334f8e24bb82086182e894

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

