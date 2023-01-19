Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180D0C004D4
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Jan 2023 15:34:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEE9E602C;
	Thu, 19 Jan 2023 16:34:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEE9E602C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674142491;
	bh=p6aXoNH+Xl7bz5o7hgp1e5JW4LIRZI9qnO1uIjevRYo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=u3zsXwCW1YbTNMNZcLbIrm/YuSfi03Wu5CcXWhtPkgyS8Zp/AICoGm++WrRDTsQJD
	 nR9t+uup/mESeI9voRNX0niZyGPmb/bV8nmWh0oFCedECn8tnoMw+SVa4wgVCAeaYl
	 Vvjzeegc/TMklaUlyS4sWNGQVzuklr7sf2TFVi7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A12FF804EC;
	Thu, 19 Jan 2023 16:33:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC966F80542; Thu, 19 Jan 2023 16:33:32 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06924F8025D
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2023 16:33:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06924F8025D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BjLQ8GU5
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 66F0BB82568;
 Thu, 19 Jan 2023 15:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7A8C433F0;
 Thu, 19 Jan 2023 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674142403;
 bh=p6aXoNH+Xl7bz5o7hgp1e5JW4LIRZI9qnO1uIjevRYo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=BjLQ8GU5EF1J+K+BfQgqv+w3LNBo/r3IhKeAfNTbiQm26VTI3I4cYw2eDK+LVkukq
 6HMZpBoOs5xmCyhhPUhZ/q1OoludQk+qIVcQaHRCkSV4OAEAq0YP6okqh6vZCQnmCv
 REpNLq8bEHtn8oOz6Jy+o+hiktYgQfXHqvbB4oZZbtYeE4OcIius/1U0372bY5iYFA
 9yma8nAfh19984urw7gQO0Y3IEp9FGe6fPqdS22PoJq0fQWDYujklevqhj31DEjQUc
 HLF1Ne6CW9qG1eJJfxPJUu6pTxfm7GN8aRa9cFt3UzGQTzXRlIW7skWBU+DhMsMt5i
 E2YIlE7cpUcPA==
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20230117122533.201708-1-daniel.baluta@oss.nxp.com>
References: <20230117122533.201708-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/4 v2] Add support to compress API to ipc_msg_data /
 set_stream_data_offset
Message-Id: <167414239956.1082520.13862629476632639710.b4-ty@kernel.org>
Date: Thu, 19 Jan 2023 15:33:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, Allen-KH.Cheng@mediatek.com,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.come,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 linux-imx@nxp.com, yc.hung@mediatek.com, Vsujithkumar.Reddy@amd.com,
 peter.ujfalusi@linux.intel.com, AjitKumar.Pandey@amd.com,
 angelogioacchino.delregno@collabora.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, 17 Jan 2023 14:25:29 +0200, Daniel Baluta wrote:
> This patch series adds compress API support to ipc_msg_data /
> set_stream_data_offset callbacks.
> 
> Changes since v1:
> 	- fixed reviewed-by list (+Peter, -Pierre). Since github had
> 	  some glitches I added the reviews received manually in the
>           commits.
> 	- Github PR link: https://github.com/thesofproject/linux/pull/4133
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: Prepare ipc_msg_data to be used with compress API
      commit: 1b905942d6cd182b7ef14e9f095178376d3847e6
[3/4] ASoC: SOF: Add support for compress API for stream data/offset
      commit: 090349a9feba3ceee3997d31d68ffe54e5b57acb
[4/4] ASoC: SOF: compress: Set compress data offset
      commit: a9737808b3e4e2313cc2aab2e807836a06576277

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

