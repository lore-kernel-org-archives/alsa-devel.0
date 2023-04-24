Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008AEC7618E
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Apr 2023 16:44:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46605F9C;
	Mon, 24 Apr 2023 18:43:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46605F9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682354653;
	bh=W2mljrhDyi0TjhyfKA4bzziotNkJvHbnNApJePLVD18=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Sy+0Re8X0CnyIcbzxWE2x+TT2nARGQLFc9xIcJ5AutH2Sdbd8zxoS7/oi0JBWLYcC
	 bKRAzZJC0//8CmP7Dac+2SKPQt3OSZiJLwPCsMv9SM98mLmoB4uwgiUDvpoBySDbbd
	 l6rHy7tnPk2lATpCR3y+01WxCIJ7XIg3DR1WQewk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92892F80137;
	Mon, 24 Apr 2023 18:42:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BB29F80236; Mon, 24 Apr 2023 18:42:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07D89F80104
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2023 18:42:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07D89F80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WZnp9zxe
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 39C7D626F1;
	Mon, 24 Apr 2023 16:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D68C4339B;
	Mon, 24 Apr 2023 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682354565;
	bh=W2mljrhDyi0TjhyfKA4bzziotNkJvHbnNApJePLVD18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WZnp9zxeR241ec5nA8XyduEMDp4SDUbQ/cyRCT9t6UJVb0sS/9Cek3RDZHQvPuqbW
	 Cs8HLc88f9PV4dtoilg42YFC5a9zys/4on9ghVktGc4kYf17uN1G4t+ZxpBNUwYH5k
	 uU7HfdfA6lfPDuHqNglQEgqXf7dWxST6ytREfDTySc/aki9xNn2Lt1yMlAkZ561O6Q
	 r3lmE5kz+K5yD02gRZMYJgCh+7xvD2/wtM62Tx1/O+6NlDYzZANh/s6vU1I0tc6iwX
	 1j/pIDbxijCIPT8DxxDNubFkDFwWbu9fWKWzsZ9dsjOBavh+zgkldd3jnqWDFO0vb5
	 TN2Mc0aL6LQ4w==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230421183714.35186-1-hdegoede@redhat.com>
References: <20230421183714.35186-1-hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: soc-acpi-byt: Fix "WM510205" match no
 longer working
Message-Id: <168235456414.139006.15008700677407548488.b4-ty@kernel.org>
Date: Mon, 24 Apr 2023 17:42:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
Message-ID-Hash: OMAFCEFRWGGGXC7JINN4DGVRJBPYXJLH
X-Message-ID-Hash: OMAFCEFRWGGGXC7JINN4DGVRJBPYXJLH
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OMAFCEFRWGGGXC7JINN4DGVRJBPYXJLH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 21 Apr 2023 20:37:14 +0200, Hans de Goede wrote:
> Commit 7e1d728a94ca ("ASoC: Intel: soc-acpi-byt: Add new WM5102 ACPI HID")
> added an extra HID to wm5102_comp_ids.codecs, but it forgot to bump
> wm5102_comp_ids.num_codecs, causing the last codec HID in the codecs list
> to no longer work.
> 
> Bump wm5102_comp_ids.num_codecs to fix this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi-byt: Fix "WM510205" match no longer working
      commit: c963e2ec095cb3f855890be53f56f5a6c6fbe371

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

