Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CFDCD1284
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:09:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8D642BD7;
	Tue,  9 Apr 2024 15:08:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8D642BD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712668143;
	bh=ouy2Y6x2V5/uoESyJnNA235PE5cU8gwdY/QEcC9jK9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=t+1BdYu0yuquoynsxeviGfTPjqZ2S3ZHvwdo6CtMtlVHfSYFVRz6Z0DQx+nqyzOt+
	 s0ojIzpEtWgRYp8c4XORw0macNnB+AKxy1Zn95AqhDxzEhsXJnLpXKnKQCSa3Ls/cu
	 hVE+hIE4Tu8p2cGG/1JrYHcbu3Syt3SZWOkMrAPQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43BC3F805C2; Tue,  9 Apr 2024 15:08:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 353EAF805C2;
	Tue,  9 Apr 2024 15:08:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C7D7F80423; Tue,  9 Apr 2024 15:08:05 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1DBC2F80238
	for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2024 15:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DBC2F80238
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jEUwV5u/
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DDC3DCE18ED;
	Tue,  9 Apr 2024 13:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E36BC433F1;
	Tue,  9 Apr 2024 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668073;
	bh=ouy2Y6x2V5/uoESyJnNA235PE5cU8gwdY/QEcC9jK9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jEUwV5u/RKtUi7ai+UUBmn1fKwYn+9jGR2SXBlyansUuEsQgR8HXXtm31IPJtost4
	 QfA5GafyjBNcPOXqu+NrYi77jpsDrC+ZuPMcgFZjTNJ+6ARc7lsuGc+VDs3KHokycl
	 sjHX+BV6Xn0IZ6E58P/whNgejKdwbqyK/FHtL0JhYcEYQJ/ZPhUYN/Mag1ER44pINz
	 iYhCsEWtBBeCdWMpB+Ps65LDRILWcvdXg+bv4ZuENQJ92eGqXeL8GqUGSixfQTnUGJ
	 oERhOfzi6CyWML3nUoZ3EoWjnwuaFCYcfFNquEqpZiDWcaCVocaTD01T/liOD92UYh
	 ejo3unZrpJgIg==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 Sameer Pujar <spujar@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
 mkumard@nvidia.com, stable@vger.kernel.org
In-Reply-To: <20240405104306.551036-1-spujar@nvidia.com>
References: <20240405104306.551036-1-spujar@nvidia.com>
Subject: Re: [RESEND PATCH v2] ASoC: tegra: Fix DSPK 16-bit playback
Message-Id: <171266807089.28088.2212378797581391571.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 14:07:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: B23G4VZLGY3MYGOELNF3DDVTE6JZCB3E
X-Message-ID-Hash: B23G4VZLGY3MYGOELNF3DDVTE6JZCB3E
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 05 Apr 2024 10:43:06 +0000, Sameer Pujar wrote:
> DSPK configuration is wrong for 16-bit playback and this happens because
> the client config is always fixed at 24-bit in hw_params(). Fix this by
> updating the client config to 16-bit for the respective playback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix DSPK 16-bit playback
      commit: 2e93a29b48a017c777d4fcbfcc51aba4e6a90d38

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

