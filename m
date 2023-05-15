Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1673DC77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 15:24:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E41D286F;
	Mon, 15 May 2023 17:23:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E41D286F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684164283;
	bh=+hOnNR3iwu1hE8EO/p0ljAKZ5bwnWHHmPXg/LRDZMlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PoD5IzNcRQ0yxPdobjaPgbafhPNHZX80pVUEfpnlPySygop35hU/ffnykWXKmiZw/
	 G8wTXenDidYsDyRXJFh831LPxUP0WE4RMXNQsU4VF1dIC43FIZysQaUO8PF9ym/7oO
	 qbc69XN0iqPxanNLhIzWeExI0REOxJ+fDpt88UOI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62CEBF805B2; Mon, 15 May 2023 17:22:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB71F805AD;
	Mon, 15 May 2023 17:22:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30025F8055B; Mon, 15 May 2023 17:22:11 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1CB3F80549
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 17:22:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1CB3F80549
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rxitXZg/
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6D50061EF9;
	Mon, 15 May 2023 15:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A8CC433D2;
	Mon, 15 May 2023 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684164126;
	bh=+hOnNR3iwu1hE8EO/p0ljAKZ5bwnWHHmPXg/LRDZMlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rxitXZg/cihuhIcSdGhw8g0pHS672Alx8WtUjFo6BpHwVg9rOAyzisheQtzkHEvYI
	 ifi3/Iqf9JBpawKX1/H9P30RBSt3BiOJOowDkefFG0S21djviCLhnambj+iHzBPdqC
	 dcw23RVcMpoZpApRbdGXglhik2IMkk2jXa8Qgq5MXe00OsZKrBg2i7m+hFguGnj4/I
	 vLL2+3/TyuUWZcKMnaeq8+VwldVsLb3MyATxNRWiNHQQDoGNYzqHDDUuXVwdpVoyJ3
	 wy5RctY4ksMn6HQR5vWi2/fYtJBP217B4q+ZYQ0qzJumgkM/HCdTBY4oDbN56Duy/x
	 Mev/HtOl5lQ0g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com
In-Reply-To: <20230515112022.30297-1-peter.ujfalusi@linux.intel.com>
References: <20230515112022.30297-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: Intel/ipc4: Do not reset BE DAI
 pipeline during stop/suspend
Message-Id: <168416412507.413889.488728082419993729.b4-ty@kernel.org>
Date: Tue, 16 May 2023 00:22:05 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: PH747LRULEAO4OLMZDNR3CDMGUDIYIEM
X-Message-ID-Hash: PH747LRULEAO4OLMZDNR3CDMGUDIYIEM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PH747LRULEAO4OLMZDNR3CDMGUDIYIEM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 15 May 2023 14:20:20 +0300, Peter Ujfalusi wrote:
> Do not reset pipelines during the stop/suspend triggers in the BE DAI
> ops as the BE DAI pipeline needs to be left in the PAUSED state. It should
> only be reset during hw_free. This simplification is already done for
> the FE pipelines and the DAI trigger only toggles the states between
> PAUSED and RUNNING.
> 
> Regards
> Peter
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: hda-dai-ops: Split the get_hext_stream() op for IPC4
      commit: 81a5d699217d1ae2853d6b022fc110aa95a2ff52
[2/2] ASoC: SOF: ipc4-pcm: reset all pipelines during FE DAI hw_free
      commit: 225f37b578a9f6462afd46c976e31977f765c38b

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

