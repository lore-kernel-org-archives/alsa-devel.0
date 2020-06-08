Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380DBC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:47:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DF92072F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JI/dqSX6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvoyh0Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DF92072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28BB915E4;
	Mon,  8 Jun 2020 14:46:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28BB915E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591620431;
	bh=FCAvqfmKFayKCxPdwRtAqVx7sG8HLE4jjh4Q6F84pqk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JI/dqSX6dB5FyeH2S7AFl1vdva7nyXbc1eSNpvs2dmMBe6Xo4yXTBjska2ebpIyFk
	 g/qBNXjYZPqMZhvgSwEOxGg6Kj69qaDSP1sj/TegJl5uvg0xB3Rto43jeTUN3XdC8t
	 Scp+SRWa9r88uGVpOddSoRM0hrFUVq8wpsr48+Fs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F67BF8021C;
	Mon,  8 Jun 2020 14:46:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 725C1F8021C; Mon,  8 Jun 2020 14:46:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3428FF801EB
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 14:46:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3428FF801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pvoyh0Wm"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 213622072F;
 Mon,  8 Jun 2020 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591620371;
 bh=FCAvqfmKFayKCxPdwRtAqVx7sG8HLE4jjh4Q6F84pqk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=pvoyh0Wmbo79Pc12rA2pIrsB8hDaGNNVxeCDJUrDxMXEg53yWzsj/jpoCMVRQ/D+k
 iS4q0ZxJQwdYgnH5S5bPje7+IJARN2szNwFq7POidTzoZLNpDR/H7bW51LWAzgk6YT
 GT/iYSpw5umoi75sI57tbGb1OzSZk8hx6Qd8TspE=
Date: Mon, 08 Jun 2020 13:46:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Colin King <colin.king@canonical.com>, linux-arm-kernel@lists.infradead.org,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200604171216.60043-1-colin.king@canonical.com>
References: <20200604171216.60043-1-colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: meson: fix memory leak of links if allocation of
 ldata fails
Message-Id: <159162036934.23368.2440967052610831030.b4-ty@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 4 Jun 2020 18:12:16 +0100, Colin King wrote:
> Currently if the allocation of ldata fails the error return path
> does not kfree the allocated links object.  Fix this by adding
> an error exit return path that performs the necessary kfree'ing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: fix memory leak of links if allocation of ldata fails
      commit: 6e801dc411329aff592fbd48fb116183d0acdb00

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
