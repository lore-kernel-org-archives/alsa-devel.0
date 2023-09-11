Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C2CA0EC6
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Sep 2023 00:04:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8723DEE8;
	Tue, 12 Sep 2023 02:03:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8723DEE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694477044;
	bh=pou2z7nAab+CNoh4C4r/YVeK04dc5SYkmgaSpz+6kRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S9pQKfHw00VHlN1hk+Eoy6KTuTEDYbxQe7oPGfrs1UK2hfbMRq5NXyGO9bo4UYYba
	 RND0cQcKAUTEWxqwDXtInqB8NXMTyuNp/X41TmIDWZ6Em4g49Tajk7XAn2rI8GGelZ
	 7j0M4hF+XtIAxOe+bfWoZu8zLVYjg5l5XwQSBBUM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2CCDF805AE; Tue, 12 Sep 2023 01:57:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DC7E2F805AA;
	Tue, 12 Sep 2023 01:57:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9345F8057F; Tue, 12 Sep 2023 01:57:23 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36D7EF8055B
	for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2023 01:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36D7EF8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ccv6XsdX
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 0F6FCCE19B7;
	Mon, 11 Sep 2023 23:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7139CC116D2;
	Mon, 11 Sep 2023 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694476638;
	bh=pou2z7nAab+CNoh4C4r/YVeK04dc5SYkmgaSpz+6kRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ccv6XsdXFfOWlx01Asz4v+bVRnbmfwMPO0qsJk2OuXF5iZuN4IunompKL+WQ+83bx
	 2ZbJNVkwvgiD2xY310WCFi6TcVX/kI3IVAdL1PehJZwU+T4Hg0vw3bBIMU4Lxt1h9W
	 jedWLJc1K5Iy7movTs5iqQTh16eP1LfcV8qIKjb8KOUe+x2chS4l+81txrsAJ2ph2b
	 7gmvNlO0lfrD6fzLo8z3AQ4v6Pa1VS+8L2KNuWzQ/XkTeA/1EAcRlAPCv1zfQ7j/Zh
	 +v2tLMlkN02xdwaWiIZGHejM4/O9ZS+033iRV1Tjtl5AuQ58NzbQ1+Sbqwrl2f6oTx
	 8iD5IAYN30YlA==
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20230827080931.34524-1-biju.das.jz@bp.renesas.com>
References: <20230827080931.34524-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] ASoC: cs42xx8-i2c: Simplify probe()
Message-Id: <169447663509.2387538.11279382377590731249.b4-ty@kernel.org>
Date: Tue, 12 Sep 2023 00:57:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: OGYTA5C5ZU7GXCAQYHADB32NVE4JN7AB
X-Message-ID-Hash: OGYTA5C5ZU7GXCAQYHADB32NVE4JN7AB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OGYTA5C5ZU7GXCAQYHADB32NVE4JN7AB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 27 Aug 2023 09:09:31 +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_device->i2c_get_match_data() and
> extend matching support for ID table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42xx8-i2c: Simplify probe()
      commit: ad191992330cfeb80ba341d1e75d9fe2719ced68

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

