Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952A2C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:15:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29E0321A4;
	Mon,  1 Jul 2024 17:15:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29E0321A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719846944;
	bh=D+dqZWEYQrj6N5dhh+KIXd+1VWrn8ph2xtTWAgXfdLc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lBovxuAfiULBOFIihtNO0JAg8fOj1jzwTSUGCG7ml4vrXwfyv/AdOoowyNec8bWGB
	 Vr1YFFouWf52xhSu15KRvxQ42v3Z0JyP99HLt/MeCSa1yMRqhBfdT5ETO+uMR7wY2c
	 LeiQbTgnEOmt+LKf73fpbriPx7yD+hGCve2M9QDM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E45D6F805B2; Mon,  1 Jul 2024 17:15:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7149DF8013D;
	Mon,  1 Jul 2024 17:15:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE8BBF8028B; Mon,  1 Jul 2024 17:15:03 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FADEF8013D
	for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2024 17:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FADEF8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=M/bhFd5x
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6A6E7CE175F;
	Mon,  1 Jul 2024 15:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F46C32781;
	Mon,  1 Jul 2024 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846887;
	bh=D+dqZWEYQrj6N5dhh+KIXd+1VWrn8ph2xtTWAgXfdLc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=M/bhFd5xZ5iddEfYtFWXKCJHnYnW7vRiv1kIhHLhM8S2P1F2ALEZp3TK71Zx8eQsr
	 WCWLE2IT1rjREDCaT/b1TNMTMU5nJP7yzvcHVFnitjXVdvBvPKx75yA4Kfh0veEoeO
	 tX9Vru9TZU0n8lw36uI5wtCXLn7qC2oVRffPCDFEOJrGW91egpXUT6eIMSMYxQwIei
	 F4haOj2bPDs3FkW5pe1VsNA3jI/DkUqVATz+lGOVcLURgR2yO91W4jUMLfhyRvWV7k
	 Ge2SlJvy4AHT0ABeM1fN6PKVC91IOkaPfSj9EsM/bO4BE6myEHI0joz2G/K5WpaA3b
	 NNOZz8SlYEh1g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20240626071202.7149-1-chancel.liu@nxp.com>
References: <20240626071202.7149-1-chancel.liu@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible
 string for i.MX95
Message-Id: <171984688438.72817.17478121699254917987.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 16:14:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: QPPSXZBYOA275IRTYRKS6RGEF7OVDJAF
X-Message-ID-Hash: QPPSXZBYOA275IRTYRKS6RGEF7OVDJAF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QPPSXZBYOA275IRTYRKS6RGEF7OVDJAF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 26 Jun 2024 16:12:01 +0900, Chancel Liu wrote:
> Add compatible string for i.MX95 platform which supports audio
> function through rpmsg channel between Cortex-A and Cortex-M core.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX95
      commit: 8e5c11963c5ca4af90b36147cabb4835e59990aa
[2/2] ASoC: fsl_rpmsg: Add support for i.MX95 platform
      commit: 19dec6650e3fd02de8752c4e0ab1c4894ce7fcb7

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

