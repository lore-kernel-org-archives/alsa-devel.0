Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B63C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 21:40:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1299560F22
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 21:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1299560F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3503E16C7;
	Mon, 25 Oct 2021 23:39:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3503E16C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635198015;
	bh=P5P55FijK727UA6F5ONMA2rpeTYp2UxNoaQwbIlQjBU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iOiVd/8dCICycPoOTnnouJ/4XoD9U/MMzrt0DkefBDs24EK5o7E7HZxN3FEU8VfQy
	 NTkhwbEYdBZxpRrSpcGlWwaEnnioWgDf9tnxiq+PrHGh/IaR6KydyKI3OoKHxjabwK
	 onzdHunGvrtkaAfxaSJQhGfS38X7WO58iJboG1XE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A586F80166;
	Mon, 25 Oct 2021 23:39:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D999BF8025A; Mon, 25 Oct 2021 23:39:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4938AF8010A
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 23:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4938AF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Au8bFpTq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B013D60F22;
 Mon, 25 Oct 2021 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635197954;
 bh=P5P55FijK727UA6F5ONMA2rpeTYp2UxNoaQwbIlQjBU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Au8bFpTqg1XyGJYgsAd+NVW9soa9kG4hLjJ1tZ7nEX9SzyGXZWHXwg6UQ/cEMahUZ
 AZnp8WfHosZW6JUSmJrGKn202PsKC4VGoNRgj2jG6LNKAw+SAWJ+ZIAObzgeq1FTa+
 7m5mM9x/carvdqMxO+NddO/vHMDSEmgrlHrGJv659/XOFpuiA2ro9MytZSoVtJypHn
 LLInUff1rS02dM5BbV+9u3mmAAwho1mjnALshT3CrYnH0vZ4ENcORT4jNj27W73wuB
 EB1/6/GoLxQDyIGipfEUUv7Unkqd5Hc+B6WBHlfE78GIzRP58zR7Pp6GiRPVtZAH1R
 w+JUR5D5MCLZw==
From: Mark Brown <broonie@kernel.org>
To: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Fix stub for
 snd_soc_tplg_component_remove()
Date: Mon, 25 Oct 2021 22:39:10 +0100
Message-ID: <163519067113.407220.298262625715409113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025154844.2342120-1-broonie@kernel.org>
References: <20211025154844.2342120-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Message-ID: <20211025213910.24gNcySAMogtqmx6ShJREYf5h3jDj5V3Fa-Quj3n6g0@z>

On Mon, 25 Oct 2021 16:48:44 +0100, Mark Brown wrote:
> When removing the index argument from snd_soc_topology_component_remove()
> commit a5b8f71c5477f (ASoC: topology: Remove multistep topology loading)
> forgot to update the stub for !SND_SOC_TOPOLOGY use, causing build failures
> for anything that tries to make use of it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Fix stub for snd_soc_tplg_component_remove()
      commit: 1198ff12cbdd5f42c032cba1d96ebc7af8024cf9

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
