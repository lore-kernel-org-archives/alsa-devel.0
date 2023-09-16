Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB719CD37B0
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Sep 2023 01:14:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9688DF6;
	Sat, 16 Sep 2023 03:13:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9688DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694826852;
	bh=3bfpoTTBraLH1Jzf2Rr5UWezhNvJDhXcEz0iPF8bH6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YqgXyRQGJHaKQkvgMubMZOd14HUGXxipoyphBpTIdArK471mXQRGDxE/Vbr+AYYTE
	 znuakEkCo2/OyU7bnkcd/lAub0o4fXf2/gX91c2kMswrjJCo4MiLrgmXhPUVAYfDEN
	 epMJuFxlohbrjU3I1MdzstnFuVUANXi/6996xLYM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CEF2F805B2; Sat, 16 Sep 2023 03:11:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C919FF805AF;
	Sat, 16 Sep 2023 03:11:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3554F80571; Sat, 16 Sep 2023 03:11:45 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA6AFF80141
	for <alsa-devel@alsa-project.org>; Sat, 16 Sep 2023 03:11:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA6AFF80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AOYH9ucZ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 45684B80CA1;
	Sat, 16 Sep 2023 01:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81B6C433CB;
	Sat, 16 Sep 2023 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694826698;
	bh=3bfpoTTBraLH1Jzf2Rr5UWezhNvJDhXcEz0iPF8bH6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AOYH9ucZD3FnF6teZmF2UkdIkk+SrbvMaMWVaMVwRobYeRzAgzVH34NGioJN2xfwP
	 pFtf7L+z1nPUcfhJhGHSLMJbuyPOPcwtF+LmBcf30f0rBoFZNQBp6EYJHEHJIn9rEw
	 Oe9A+ZvhgQcs8GQT7jpcZsb02/mv1wzO3fR3oJUhaMbkTF4hEDfKB7/ncsfLFiuCgx
	 QChs+Oo5ffkfRMlQVWJbX3HG/7X5ap/PSubh/4HXpEvy/XNv1iSTbc62byR7XBiUcw
	 gev9bzb98BfPNbYjlNLj+D5tTNAxynVR4N7T+RPVwcbRSiJy1PRZBeUgaIslgWBLFk
	 Hx9OyVfteLqqg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, chao.song@linux.intel.com
In-Reply-To: <20230915114018.1701-1-peter.ujfalusi@linux.intel.com>
References: <20230915114018.1701-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: SOF: ipc4/Intel: Implement split fw library
 loading
Message-Id: <169482669660.606223.8992641407768095448.b4-ty@kernel.org>
Date: Sat, 16 Sep 2023 02:11:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: CDH67GWD7ZXTIAZQFRO3T7UBMPHXIZAK
X-Message-ID-Hash: CDH67GWD7ZXTIAZQFRO3T7UBMPHXIZAK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CDH67GWD7ZXTIAZQFRO3T7UBMPHXIZAK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 15 Sep 2023 14:40:14 +0300, Peter Ujfalusi wrote:
> This series implements support for split library loading to comply with the HDA
> DMA programming sequence recommendation, which is:
> 1. DSP side DMA programming and GEN bit set to 1
> 2. host side DMA programming and RUN bit set to 1
> 
> The SOF support for library loading is based on this sequence, backwards
> compatibility with older reference firmware is supported (where only the
> LOAD_LIBRARY message is supported).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: ipc4: Convert status code 2 and 15 to -EOPNOTSUPP
      commit: c2d8f17ed0c70816737cbf8f530d2178ee6affbb
[2/4] ASoC: SOF: Intel: hda: Add definition for SDxFIFOS.FIFOS mask
      commit: 369ea9f82c279e88a52217b56dc1f973de57ac56
[3/4] ASoC: SOF: ipc4: Add new message type: SOF_IPC4_GLB_LOAD_LIBRARY_PREPARE
      commit: 4f0f3c774947fdd3c4236cef9372b329c276845c
[4/4] ASoC: SOF: Intel: hda-loader: Add support for split library loading
      commit: 5a8a9d70ecac3acbd49e70ad8f85153c0315643e

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

