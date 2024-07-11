Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4075FC3DA42
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jul 2024 01:19:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73893850;
	Thu, 11 Jul 2024 03:19:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73893850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720660780;
	bh=Z9aIB8pJH2qeFtWfaUtf4EZPQw2VoEaVqsMNNYoG7Mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H9dec5N9TBodwhWnxuuvThJLacGzivsj/jFGpCxReeMLl6yZBMQcVn6VPSifxK02e
	 t43oE+fcIswzQXB+UaV1ShUQNqTH/fta1LYM7ysD0aad1j4GeLB/hSkhUnkAJj+TF6
	 qhhC6tHejy0/mlGorCYeNYVCFx3wyXmSKo3N19Fo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B73E3F805DA; Thu, 11 Jul 2024 03:19:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE800F805B6;
	Thu, 11 Jul 2024 03:19:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3482F801F5; Thu, 11 Jul 2024 03:12:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5D87F8013D
	for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2024 03:10:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5D87F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Z4Z10GMy
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 70D2C61B71;
	Thu, 11 Jul 2024 01:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F365FC32781;
	Thu, 11 Jul 2024 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720660242;
	bh=Z9aIB8pJH2qeFtWfaUtf4EZPQw2VoEaVqsMNNYoG7Mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z4Z10GMyYjQCy6mZcfRyAWLb6MFxNbfIP8BVr74nh37DVVgc7IxdwTxR3Z2XBMYTK
	 dif7lT800XF+c3EpL9cuCGOEQQOyc/QC1w0hgkYO6nyqDdOowCDeHyDZDajzlmKbE0
	 r+YUOmafSdXc2teSs033EoaYbyVCPaxsHNusX32TaijKS5ffCYpJrB65UfWTZ30Chh
	 JxB3q8M4HoyMNnpBR/DorQByL9L77aMTYwwGS21FNrZ4iVV8TnTTt/4uf/Ohn2Pe8u
	 +0rcnB8HgI0KIeMr9CUDLYLPwKJcGIQb0jDeROryxZF0dfrQRZv3LnfDmeTJ6QY2uf
	 W4aMQVZz3aWYg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240710103640.78197-1-rf@opensource.cirrus.com>
References: <20240710103640.78197-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/4] firmware: cs_dsp: Some small coding
 improvements
Message-Id: <172066024060.393700.15835907433889376478.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 02:10:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45
Message-ID-Hash: VAUZMOJYHCP5C6NYCCFUGRYUJ4JBRLGK
X-Message-ID-Hash: VAUZMOJYHCP5C6NYCCFUGRYUJ4JBRLGK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VAUZMOJYHCP5C6NYCCFUGRYUJ4JBRLGK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 10 Jul 2024 11:36:36 +0100, Richard Fitzgerald wrote:
> Commit series that makes some small improvements to code and the
> kernel log messages.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] firmware: cs_dsp: Don't allocate temporary buffer for info text
      commit: bff92858dfb9897e4c06c11aab0322e1aab822f7
[2/4] firmware: cs_dsp: Make wmfw and bin filename arguments const char *
      commit: 584e86e14c59d36688633002613792923620d8c0
[3/4] firmware: cs_dsp: Clarify wmfw format version log message
      commit: a4939119055d5c97aff2cea040f1af8c4606bfa1
[4/4] firmware: cs_dsp: Rename fw_ver to wmfw_ver
      commit: dc0e5ca8856dc6a97e3b117879dfb2b52bda06b6

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

