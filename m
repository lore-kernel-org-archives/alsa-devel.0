Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF371C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 11:37:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 040E841;
	Thu, 10 Mar 2022 12:36:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 040E841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646912230;
	bh=0eGKtf5QxFR+fYR/+A2fttoRe6+ZO1K8LwywqIlX6k4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KAztpOEujPOG9utrqGxOQvzy7V3wpXwRNTNYE8vAFO8pAC/aEw2+XB5xX2hHTIgrm
	 HRuf9jzF22+Sn50f6KvoyApaMyHSo2AF8OIfA6r/gyJNmH6buC+0ZD+H6gayKiKH/z
	 6fB/sYCBpnqP83PXK8doKOT0Anzvg4KOU7uOX8mM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87DB7F80518;
	Thu, 10 Mar 2022 12:35:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4CD3F80515; Thu, 10 Mar 2022 12:35:21 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 690C5F80137
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 12:35:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 690C5F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Kzwlgr4b"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 57536B823C3;
 Thu, 10 Mar 2022 11:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FADDC340E8;
 Thu, 10 Mar 2022 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646912115;
 bh=0eGKtf5QxFR+fYR/+A2fttoRe6+ZO1K8LwywqIlX6k4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Kzwlgr4bAGZpPClXJ6fcmnMUzGK9oqI85r6q7npLZ+O1OxcTgeFXXv7iaqiPU7ZKs
 NY46cp3Vqg1he1G2/vh3l3pI/Ngcw5lEcbYUCjCH4Q0C4neIeXYoI6+h6ma9jt6ZoU
 RTI84SfygjkMIevEBrlgu1FOnxgc4ybEJm+4G+y929TLZdCKmHHlxN80B3+SEIMQr4
 BmYnZv1eBVVo/aCmzYeReBt4gViwy9UZULEpid07YH1BLLuVrG9tCNMR2OHyaqap93
 qyRSRMReZTl/bNsb8js6gY1uPhGq2M79smZkyWxfLNG3iLPckht0DbJfLibaBAUY07
 Z2q7s3GMs5wAA==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com
In-Reply-To: <20220309110104.18370-1-peter.ujfalusi@linux.intel.com>
References: <20220309110104.18370-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc-msg-injector: Use devm_kzalloc() for the
 rx_buffer
Message-Id: <164691211330.13798.8286339188682394001.b4-ty@kernel.org>
Date: Thu, 10 Mar 2022 11:35:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 9 Mar 2022 13:01:04 +0200, Peter Ujfalusi wrote:
> The rx_buffer is cleared before sending an IPC to make sure that when the
> /sys/kernel/debug/sof/ipc_msg_inject file is read we will have correct
> information in the buffer (no random or stale data).
> 
> But if the user reads the file before sending any message the buffer might
> contain garbage which should not be interpreted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc-msg-injector: Use devm_kzalloc() for the rx_buffer
      commit: 81acac8c2c88764c773811d1ec858852f81eb88a

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
