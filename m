Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B250EEDE9A5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 11:21:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE0FC852;
	Thu, 14 Sep 2023 13:20:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE0FC852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694690476;
	bh=O3CIa31gYoOF4a1uQIEH6AoTOjXHQf3zX/6sb/ewrxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gWJN0xA96x7eZG3LNzQtrezNCny0zbW2SWSuYnT6RLChQ0w/asbyBTxfjaoWJZ6lw
	 DbSSlDb4gydxm06NcCROLvZmJ6n1U1RQbfwaCbYakxFUvQIBhgMmPB043+lGtQ6nva
	 QsHawb2LH17ai9cd/C6xz6IWEqlwcAK27YWXMBEQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED7B4F80425; Thu, 14 Sep 2023 13:19:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38521F80425;
	Thu, 14 Sep 2023 13:19:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33432F80549; Thu, 14 Sep 2023 13:19:52 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5F52F801F5
	for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2023 13:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5F52F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rFHctGm9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id E8630CE2697;
	Thu, 14 Sep 2023 11:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E8C433C7;
	Thu, 14 Sep 2023 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694690379;
	bh=O3CIa31gYoOF4a1uQIEH6AoTOjXHQf3zX/6sb/ewrxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rFHctGm94GQQptUu4nkbO7IPXbQDLt8ya/Sd/f8crD5NSHTBHsz5SB04rtxEWGikl
	 wkOGGwIgCCJayBetITKzU7Opxd8jpLTCEB2n8GJN0cY4auaEKiLWLK1tfYUP24C2vW
	 UAbORmaP1y/3eqgGfvL9rHikI7Jw4fnKwbM//aozKcVyJUz1qJkB55OUciSbPwe8XH
	 6BLPKEJPmapi61bUHWxBJnNIJ8PragwRqUP5WT+o4JZv9dNCOrIaGY+Z6fv0VBP6DG
	 FwQEZa9ZwPdrU/F6EaFI5zgYj+vQTJKgJLVuPTpL16DK+DOl9xvywQRPoJqkiFyO5r
	 ZfcAYerC75JMw==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230912163207.3498161-1-rf@opensource.cirrus.com>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] ASoC: cs35l56: Use PCI SSID to select specific
 firmware
Message-Id: <169469037763.23670.11361040315224579897.b4-ty@kernel.org>
Date: Thu, 14 Sep 2023 12:19:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: JLFMEJO24TBE4VKYMDQWI4XQV72VW576
X-Message-ID-Hash: JLFMEJO24TBE4VKYMDQWI4XQV72VW576
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 12 Sep 2023 17:32:03 +0100, Richard Fitzgerald wrote:
> The PCI device registers contain a subsystem ID (SSID), that is
> separate from the silicon ID. The PCI specification defines it thus:
> 
> "They provide a mechanism for board vendors to distiguish their
>  boards from one another even thought the boards may have the same
>  PCI controller on them."
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: soc-card: Add storage for PCI SSID
      commit: 47f56e38a199bd45514b8e0142399cba4feeaf1a
[2/4] ASoC: SOF: Pass PCI SSID to machine driver
      commit: ba2de401d32625fe538d3f2c00ca73740dd2d516
[3/4] ASoC: Intel: sof_sdw: Copy PCI SSID to struct snd_soc_card
      commit: d8b387544ff4d02eda1d1839a0c601de4b037c33
[4/4] ASoC: cs35l56: Use PCI SSID as the firmware UID
      commit: 1a1c3d794ef65ef2978c5e65e1aed3fe6f014e90

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

