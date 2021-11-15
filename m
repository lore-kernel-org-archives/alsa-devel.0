Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A58C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:37:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A7161AFF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56A7161AFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEDC816A2;
	Tue, 16 Nov 2021 00:36:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEDC816A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019458;
	bh=xw6CZxpP/GbyDNELCAndD/UsFGm9K4T5/E9P95cg9JQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ae72NO+q4gNi0L1MiyyzdK9ozv6CTssM0m9E1ktklC7u/Y5LT3+WUuZNwTdAAg58t
	 qdT70cvcIJWNHe0nqk0Fv1WEJ9jMJ1JvDz8MoZfsevy8awGbgQB/V3NEjEYYV05HKD
	 52mc3KdGdgFONRLcysMJ9rUo63EeeMsBZ4BTWy1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74415F80134;
	Tue, 16 Nov 2021 00:35:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6043EF804E7; Tue, 16 Nov 2021 00:35:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DD7FF804BD
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:35:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DD7FF804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SQXhwZ9p"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C7F861B49;
 Mon, 15 Nov 2021 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019300;
 bh=xw6CZxpP/GbyDNELCAndD/UsFGm9K4T5/E9P95cg9JQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=SQXhwZ9pWJRuEeNnIl4vY+Wrippeyb9D+n5A/iozZvgSUEs7XuFzY9che9kNN8TBN
 TlBCYCK5wM5CXK1tKprQ1JNXk0ESdihcPGJ3IEXelwHhH1tvTliFqMEDdJe3wNVmoN
 3FPe4rnj0VtLOrB2fH4nNPN9yj0u1t0mxKyCEBwLIhjrJvdoDvOSPQpGFfBC93I1eS
 nsfAk+LvU9KJfPCsIfD/yZxXXlD6W+PN2pjAVHthJPj2c0HwmH1wdpnzZc3CoVgYcI
 T/m9CxUar8ZaWgqLWDQH+qV+IxSY9vM0nfbLr/3hoyxPFMpvbgNd73y7hj3OkA5NU9
 hK8jx1v09hE+g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20211102094756.9317-1-peter.ujfalusi@linux.intel.com>
References: <20211102094756.9317-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: core: Unregister machine driver before IPC and
 debugfs
Message-Id: <163701929885.675370.12389807799805041465.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:34:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com
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

On Tue, 2 Nov 2021 11:47:56 +0200, Peter Ujfalusi wrote:
> To ensure clean unload of the machine driver, components and topology, do
> the unregister before we free IPC and debugfs.
> 
> It is a possibility that part of the unregister we would have IPC
> communication with the firmware.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: core: Unregister machine driver before IPC and debugfs
      commit: 5b59289bfdbe287d0756e5ccadf039329147de67

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
