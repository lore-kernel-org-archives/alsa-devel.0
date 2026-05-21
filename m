Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A65CD5BCF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 08:28:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D46E160208;
	Mon, 25 May 2026 10:28:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D46E160208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779697729;
	bh=7YTj92kNqvTxGEe1cNNLW3RP34iYfpF+DoJGWlj3xwM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Tw2KDyK2WRFfbSCEdym69yubeCu5RWV5/o//m1U30+khGcLfrEhXOa27Ulxw48Hyo
	 coJ9B8BjYGCmEbWIDRcNyf+tTqAQEN+AqFS0ShKdxN6Bm2P90Fp8cqRF1JLdKYWsRI
	 VXGyOAOuHcUPIFYKbLVHNPhatLrJo6Sx+bBCbgO4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 976ABF805F7; Mon, 25 May 2026 10:28:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5D70F80557;
	Mon, 25 May 2026 10:28:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB07DF80557; Mon, 25 May 2026 10:28:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00E37F8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:28:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00E37F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kYux4OQi
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1656640BF8;
	Fri, 22 May 2026 10:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A7A1F00A3E;
	Fri, 22 May 2026 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445299;
	bh=7gK2VR5gTI+UcAjSIhHUDW5Ykd1zlLoCN9jWLoSHkKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kYux4OQix/CpCPxP9dEwfqnQNKXaifyZl0h50jWsUy1ysSEkJeSh3SPepKhOB9zGc
	 r0P4TYvILY6aT2MPkNHwlwTCes7dl7Xl6HnoIuoVlcfWpZOTOlRQsI53BAYh5xJgP1
	 5MUrc3VDUIFYsiDxXDDv1RtKObhh3HT6NgzQjBZkGZX4nVEQeo1NwOQB3ZwytCRC+S
	 bGy8H/YUU6VqtMZPs796782c5RBm8bPiBIoh+kGvI6bP2MrZD69fBUSQnMz7cL21ct
	 QF0mT0ScagCvZF3mhfS0zI/qNvnWrTP1mhU3WcVNUFx0rvg7UESqyid6hWWDPxz+t+
	 1NofCVM88rxtg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/5] ASoC: AMD: ACP7.x initial PCI driver bring-up
Message-Id: <177940532272.58022.17604355383917647171.b4-ty@b4>
Date: Fri, 22 May 2026 00:15:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7YTj92kNqvTxGEe1cNNLW3RP34iYfpF+DoJGWlj3xwM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEC4wMmoGSf2XUHjqPOumZ4DBeXxztDrvpEhDN
 lJKGEQtE8eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahAuMAAKCRAk1otyXVSH
 0KIfB/98mpoWQjqPO8MFh0MMVef4sPG35/sZJwa+V6AATwLOP7N12NZGz3i7OMFwYRg1RWt/d+w
 07401ZoTslhaTd+8fx0it2DZezQyY3RjGmXjquCX8M4/YWiAmXpDCBPo7Q2mEq4i4yrNuY7ghJ3
 t4/ra5QpVQEBw7QEe1cHrR8pJ5tNjeHCGl3kRTh8jJafJQcXM7uqT0+lzWTtdNQ41SSAPOZeoiB
 DYtyjP77/Bdzg6KZNuff6dlZ41GAr/sgvj7C3exv3Gpsv5xk/V/t3x0oH9An0kEdRvOP4qq7oy9
 RcKtAHARQVPz3+r5Hfc+IOqTBqtucmVMINUv568qfZFEuY48
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: XHWEX2NCMZLXRQ2OPCU25AP6OTGGGGP3
X-Message-ID-Hash: XHWEX2NCMZLXRQ2OPCU25AP6OTGGGGP3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XHWEX2NCMZLXRQ2OPCU25AP6OTGGGGP3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 07 May 2026 23:41:28 +0530, Vijendar Mukunda wrote:
> ASoC: AMD: ACP7.x initial PCI driver bring-up
> 
> This series adds initial AMD ACP 7.x support for ACP7.D / 7.E / 7.F
> platforms.
> 
> Compared to earlier ACP generations, ACP7.x includes substantial design
> changes, including an updated register set/layout. For that reason,
> the ACP7.x implementation is placed under a separate sound/soc/amd/acp7x/
> directory instead of extending older-generation code paths,
> keeping ACP7.x-specific logic and register definitions cleanly separated
> and easier to maintain.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/5] include: sound: add register header file for acp7.x series
      https://git.kernel.org/broonie/sound/c/44d16948af55
[2/5] ASoC: amd: acp7x: add ACP PCI driver probe/remove sequence
      https://git.kernel.org/broonie/sound/c/1da6f798eda8
[3/5] ASoC: amd: acp7x: add helper functions and hw ops
      https://git.kernel.org/broonie/sound/c/b5a2fdc5e7d2
[4/5] ASoC: amd: enable acp7.x drivers build
      https://git.kernel.org/broonie/sound/c/533308171bf2
[5/5] ASoC: amd: acp7x: add system and runtime PM ops
      https://git.kernel.org/broonie/sound/c/07d56a83ba70

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

