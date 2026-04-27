Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1184FF8867
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:38:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99F10601A0;
	Tue, 28 Apr 2026 05:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99F10601A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777347494;
	bh=v+k0mxR7uS4QEobk6K87ilUPY+SsHJk1YDnSyP1LnG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Xt4nNOw4BJr4PEk51LkWsdIYKbWv4zZobeT77ujFKQwhkNK5fegkkJAt/S/qWIZqT
	 RGQpzjaesTZI8Sz9Se7qChrldaBUzytjlj2GN/Z9pWJE3N3HgtkvvYuWLBidrRU7oq
	 a41tygdHGux+vc7GtDnUXo8Vyp9kLROHijzrjcqk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C38D2F802BE; Tue, 28 Apr 2026 05:37:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA0B8F805C4;
	Tue, 28 Apr 2026 05:37:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46B1CF804CF; Tue, 28 Apr 2026 05:37:34 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC39CF80169
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2026 05:37:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC39CF80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fFGXpHhl
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5799D60128;
	Tue, 28 Apr 2026 03:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F49C2BCAF;
	Tue, 28 Apr 2026 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777347450;
	bh=v+k0mxR7uS4QEobk6K87ilUPY+SsHJk1YDnSyP1LnG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fFGXpHhl2G8N8StPnAWQ5Yg37pyImayNq8lCo8KbQl+pS9roJlPl9NAEIxjIiC+qv
	 uL8f9JH5sfgiLoyGzsgCrjm+cSdRM8UAdCGKIshSL5hovhK2+mt65RkgjfTIm2h/80
	 8Antrzm3sZvzBfNNFXwPVpGMhdoWeCVY9wipsSq1rLsJ+zOEJwzfeshqG19i35AURy
	 puw1aNs/kk+2yxI4/P4DSO/QRZLdF753iFLsccAjzC1Wpde4zuv3B3WgXJp8FvMPj3
	 in0emcyOrKo4iLe97izNHHfReTbbeOdiHfcUqfsrawe6IPzq3BLtM9GwCok7VFJxTt
	 X81ErnopVVCZQ==
From: Mark Brown <broonie@kernel.org>
To: Sachin Mokashi <sachin.mokashi@intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 tiwai@suse.com, pierre-louis.bossart@linux.dev, cezary.rojewski@intel.com
In-Reply-To: <20260427144619.1739971-1-sachin.mokashi@intel.com>
References: <20260427144619.1739971-1-sachin.mokashi@intel.com>
Subject: Re: [PATCH] ASoC: Intel: cht_bsw_rt5672: Simplify probe() with
 local 'dev' pointer
Message-Id: <177732988081.324244.9990584552671602789.b4-ty@b4>
Date: Tue, 28 Apr 2026 07:44:40 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v+k0mxR7uS4QEobk6K87ilUPY+SsHJk1YDnSyP1LnG4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8Ct3tTi0lTyXbNyTrU2X7fsHYas5WeO6GvHeV
 puE40ct75OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafArdwAKCRAk1otyXVSH
 0GZXB/9Kl9rYQ63LnO0JguojjfdizNTWW+iEIH7IN+Hfw0nkBoYvRGk9psfgs7WJG6+Nyym6Hpu
 i/yyusKfoXNas0uLfOz9j3nm9Mayj+T9JDhhiXN5vWXR4HgQgipVX0GoHHOY5TYELExQScuiCvO
 N0p6Cz7v+wReeqeNp3U9vBk3x6s6mGHlaDLwJ7MCU1cWO2ceQHKXzdYhy9MoUblpR17New5Zr6G
 lpw+RWCYo3H7GDG1tE82QeDJZGZOsQaOvqejtXvKVYcBb09K2qOEbOvJeusXUipFD8T+trMXuvH
 EoV5qf11IZ543L29MR/YohueE2CjSET+a4/kvuh3gHvoyJJX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: RDGVPIKYIUZUT77CNRR5466LQ5VAVH5M
X-Message-ID-Hash: RDGVPIKYIUZUT77CNRR5466LQ5VAVH5M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RDGVPIKYIUZUT77CNRR5466LQ5VAVH5M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 27 Apr 2026 10:46:19 -0400, Sachin Mokashi wrote:
> ASoC: Intel: cht_bsw_rt5672: Simplify probe() with local 'dev' pointer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: Intel: cht_bsw_rt5672: Simplify probe() with local 'dev' pointer
      https://git.kernel.org/broonie/sound/c/cda1cf0526f1

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

