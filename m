Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B9606A31B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ItV0ZGjW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVgbubw7
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 428E36022B;
	Wed,  4 Nov 2026 00:18:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 428E36022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793747910;
	bh=CDX6Fuc9P7pYJEpQIcjCPJIH9WOKQPKlv7/smLOIYbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ItV0ZGjW+7Y5iMGnzG3LvKdiQwMOtM/lIWuKhVn80IPD8EM9uP2+urlDp9zT5ul6x
	 JVOjuKqf249vr3vJRvUWzO66pdSIrOsCx/6U5t4OG18w3oviXahNCL3+rROZKAzujL
	 Cli3xQiHm23M23vyGCvXQddMDIaffRmhlCG+f7QM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A54B3F805FE; Wed,  4 Nov 2026 00:17:57 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DDA7F80600;
	Wed,  4 Nov 2026 00:17:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 341ADF805AA; Wed,  4 Nov 2026 00:17:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793747869;
	b=gYnD5iAr0kelClHLaWS0vGptSDBFEZGPV/S5LLCbV5Bd4dZ6t6kbIsGn7hOszmj78V3j
	 PnvXOUZdc09IjrdtR3pPMRULPw4QcGqVnGvaC2/OpYlh1aVZh1RdYRoe36EC88C2ytEZy
	 thjnVaOPpPmoTDMYweGV/0OXTxqKr+qj2EfJqSLqBzrjJ0tw915EWl5+yw4FrgmevdnCu
	 xodRg5L4oG1n17RofGa97BDeArSx9+ZpMNLAvZy45yOzDuNK3+r3zDYykFUEeCYLgbjO7
	 +0IdGEZPQJeXB6JH9GtD/1Z02FfmLEuyjBfQLdhC2LPjRLItZm8zLsxSoc96heSF6BQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793747869;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=CDX6Fuc9P7pYJEpQIcjCPJIH9WOKQPKlv7/smLOIYbM=;
	b=rLx2TOmWTaavUFEoVhAxXNoEca2gk9xPei16+TdYFypRTdsYPiU4mEOqFMvTzUMxUfgs
	 zU0LAWcwzB/NyNzNkYdYS6cjHqXqR/Qhsd7yAY4ylnUsWLWyHDfCl5w+WQBPi6RvM1Nx/
	 xJ6+boM9uskq+9+orWLWFDPviE26tfyU2VHYD6So6ehcYiffnYD7Gp0cV8guEdG9o/kfj
	 hwkof6tSIP0AgiD1HTzDGV5GGtcRBHGb9IpdMLa1p6cfbOEViL33lx52p66Z+ESZ56DXr
	 0lDcTDG879iO5nUvhBmDUp/EjPuoD7ZIVdtIP1XJjZhpeQOoFXW+S9CQKo2GIW/gXEg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AVgbubw7;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1104F800E4
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 00:17:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1104F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AVgbubw7
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D036A60D82;
	Tue,  3 Nov 2026 23:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA491F000C1;
	Tue,  3 Nov 2026 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793747864;
	bh=cTRxgqB3j0rUHFGARJLABy1S/kakTChhAy0kJQKCjqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AVgbubw7svOXEVBxux+Dhz+y37Ms4+FQgqiM8ABE6Pm5Sa/ecZNGFphoQEqUKsqY6
	 +O1BZp6pBFxwblWR4AqqKdot7SN8PGa1p33SwK09KleQMJccK4ayq+OUODesnJ0Frg
	 Ab2lEBWVAX3hpWoWbfAVnG5g/U81yzce74MsvPosYZixJv51G6sO2vu4e1nKV0mlBS
	 SJx3y3n4ztDkEfblZbC0/GPhNGJa3eNv+K1H2YrZ554FcvdT6HncAeMI7WDc5TWXId
	 WdoeYRxOU0YDt+R3WHzxC8UZewnnzVqRH3iAkgaxhiQIhNTbffFlM/Yl1xGpYZpQ4R
	 UgWS2K/6qkt2w==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 726EB25BE13B;
	Tue, 03 Nov 2026 23:17:42 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com, pin-hao.huang@hp.com,
 Syed.SabaKareem@amd.com
In-Reply-To: <20261103131755.1558-1-baojun.xu@ti.com>
References: <20261103131755.1558-1-baojun.xu@ti.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: Add support for more projects on
 ACP7.0
Message-Id: <179372713592.2270148.14622565162095930987.b4-ty@b4>
Date: Tue, 03 Nov 2026 17:32:15 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CDX6Fuc9P7pYJEpQIcjCPJIH9WOKQPKlv7/smLOIYbM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeZU+z05N8LL6QeZmBnIzLLOsbQfeitT5feWbS7OTEw
 XFA7IZKRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACayl5mR4fpMt9jWtv4kcZmJ
 yzLUtm3OsLZlfeyQuzDHq2fy2b++powMDWGGVybU/Ln4fW2hgcH7nHMfjm9efuDtrXi5J5NFHD+
 fYwUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: D72Y5XYQERMYKXDKWO7EM2KINFKNHAQB
X-Message-ID-Hash: D72Y5XYQERMYKXDKWO7EM2KINFKNHAQB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D72Y5XYQERMYKXDKWO7EM2KINFKNHAQB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 03 Nov 2026 21:17:55 +0800, Baojun Xu wrote:
> ASoC: amd: acp: Add support for more projects on ACP7.0

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: acp: Add support for more projects on ACP7.0
      https://git.kernel.org/broonie/sound/c/a08578200344

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

