Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E0010F995C
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:06:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43CCB60218;
	Wed,  8 Apr 2026 20:06:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43CCB60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775671609;
	bh=1YyUQKrS6Jgi2V2vsvvvkZ/uJw01Zbzn31qRiqouNX4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AU72fL6KpD4fHUuf5CHG8BJL5XUVIirlCkYijIMm3EBhA3vUNKhcgorHY0aoPe2ht
	 o7ut/TVWfZ7oAjmlIbFn33tAOPyPC0Dm9JY7PBk2cN1y08uDdNiRj5y+6Tfg6CFvIw
	 UMqcDRPeED1f71M1QM+R+nWbeE25O799E8cCzyRE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 560E8F80600; Wed,  8 Apr 2026 20:06:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E52DF8060F;
	Wed,  8 Apr 2026 20:06:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08FF6F804CF; Wed,  8 Apr 2026 20:05:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D28FEF80154
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 20:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D28FEF80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sFckpQpY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C1D143C99;
	Wed,  8 Apr 2026 18:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3B6C2BC87;
	Wed,  8 Apr 2026 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671553;
	bh=1YyUQKrS6Jgi2V2vsvvvkZ/uJw01Zbzn31qRiqouNX4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sFckpQpYSP1WzxKA1MGyU9kovarxHIhC9KiBiWm7kcB+6892fEF2XLVIe1Nqw7c59
	 Sn5r94/QJi1JO2olGQtGqsy3TQJyt53sJ+T72X/SPOMx1bUrZC0B4yf5e9p37EQOD3
	 d2fGIPnXSbFuQmLxZoD9roGhQmt+4Iu83r4PvMO5Hxv4WQJP7g3HrRp89NII3TBcex
	 ObcF6Ej+3Kp0QZURogDhtweIdNwG2+i8yidt1e0l/WbFVakm+MXqR69mEGxV1AbSoX
	 qKKlR3n2tKF/7xRahGluvW1ErEI32k7nsGU4+ss+8N5rfbGuKOADTt+h1x3hhUMmwM
	 t17fhMiU5TEGQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 Neo Chang <YLCHANG2@nuvoton.com>
Cc: perex@perex.cz, tiwai@suse.com, krzysztof.kozlowski@oss.qualcomm.com,
 dan.carpenter@linaro.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com
In-Reply-To: <20260408052639.187149-1-YLCHANG2@nuvoton.com>
References: <20260408052639.187149-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8325: Add software reset during probe
Message-Id: <177564972157.101848.7395395479165358647.b4-ty@b4>
Date: Wed, 08 Apr 2026 13:02:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1YyUQKrS6Jgi2V2vsvvvkZ/uJw01Zbzn31qRiqouNX4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1pj+5ndOXsMXYrF3K4p5svBnjTZsvpys8bcK9
 uN5xoNdsriJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadaY/gAKCRAk1otyXVSH
 0HtHB/9MAqdQ6+uJoGwlJ+w850rb+zj/Fd7JKPBTylmIew0DAeHjRNt2ipxODfDkJeTywm49Ve4
 x8dPcM6oVpooEhfltgWfMJM0ImXSZHEcRl48W0phcHrSFtD6AIu+pFnHKrJoEc3Wo7dpAFEUUTA
 U7vbdaG/InK/+H9YpzulOXHWfIZegDcJpknP3qkfLpZM5XxzdRtVBccF7NtjT2oKXdIkFEbErSq
 /d6AyD33bK4wzzuE+xu7DFcYFleO+AQ+JPvzLF1wZW2HMErnBv43BVM+xkwy+OiNr//j0HX3kwM
 ZbMBU++z4ZRyWthAlufP085xmY/XUMpVBvenf/zIVfPv32GO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: CYAY7RLIJLJJONLVPV77BP75KFEX5VZU
X-Message-ID-Hash: CYAY7RLIJLJJONLVPV77BP75KFEX5VZU
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CYAY7RLIJLJJONLVPV77BP75KFEX5VZU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Apr 2026 13:26:39 +0800, Neo Chang wrote:
> ASoC: nau8325: Add software reset during probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.0

Thanks!

[1/1] ASoC: nau8325: Add software reset during probe
      https://git.kernel.org/broonie/sound/c/f4c90fb761f6

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

