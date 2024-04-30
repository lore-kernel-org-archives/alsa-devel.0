Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F43C4345F
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:32:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8AF1EB6;
	Tue, 30 Apr 2024 16:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8AF1EB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714487574;
	bh=cLtJvPoRgeDtZpSAoRESSDQfbwZXgGEP7vWUT65npxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I5+MTpAJvmOLnc0XbNF6DLyy7sgnXPEvi9lvXDshfy3DwAkxxess1snrLUecMtood
	 VGHjPa5HRvQE6TsTOVxTtOkQE7qkrrv2EOO0oDNQXyveoJ+sYzx0ZH0avINgIK79sX
	 SD6yCWBgijNlPxnvThnhE6uqYtnX1T5QPBG+ju0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B1FCF805EB; Tue, 30 Apr 2024 16:31:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BFFCF805EA;
	Tue, 30 Apr 2024 16:31:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E2E7F80269; Tue, 30 Apr 2024 16:31:46 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 66C4BF8003C
	for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2024 16:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66C4BF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U7cKHnDe
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5CCB9CE0EDE;
	Tue, 30 Apr 2024 14:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C23C4AF18;
	Tue, 30 Apr 2024 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714487492;
	bh=cLtJvPoRgeDtZpSAoRESSDQfbwZXgGEP7vWUT65npxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U7cKHnDeCCK/PsdBuYIsiSlRvfEnVj7/Zs7tdw0BpW43ujRp/+cmLA25FAMyszFny
	 W1igVbFGg/xcYuZ33k/4IVYTI6a2av5bjU9lGYk0oXfon9RLWL+l6+4OaQWiVvCDzd
	 x85qMUoyycXZuyzKpb1Ukr3AiXHZXwoIPjjQV4pmMd6ZLJ93cbz8NNJxIcBepXboxy
	 NkqXhW2AOaZxdCii41SWbTkt0YYR7G5IGbVfspXAk1PGw4ITEzDm3BtIqwex4hGO5w
	 ceXJn1Tur39Z94eEuyOYK/OLBR/OM1AwGKfozxWc+oKT9HPdB/f3Jx6BjMswYiFGca
	 bqf1j++UMy4aQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240426152939.38471-1-pierre-louis.bossart@linux.intel.com>
References: <20240426152939.38471-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: cs35l56: fix usages of
 device_get_named_child_node()
Message-Id: <171448749098.1870439.10765372758539415064.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 23:31:30 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: EZ773YEYK3I7M5LKTMYT4EX3T3NASY2X
X-Message-ID-Hash: EZ773YEYK3I7M5LKTMYT4EX3T3NASY2X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EZ773YEYK3I7M5LKTMYT4EX3T3NASY2X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 26 Apr 2024 10:29:39 -0500, Pierre-Louis Bossart wrote:
> The documentation for device_get_named_child_node() mentions this
> important point:
> 
> "
> The caller is responsible for calling fwnode_handle_put() on the
> returned fwnode pointer.
> "
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: fix usages of device_get_named_child_node()
      commit: fbd741f0993203d07b2b6562d68d1e5e4745b59b

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

