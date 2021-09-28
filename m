Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B479C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 16:27:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E2060F5B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 16:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97E2060F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 315131694;
	Tue, 28 Sep 2021 18:26:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 315131694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632846455;
	bh=/5ZRMWJBCLjBcb1qm26DEO0HpSzhNQxjHWuWet1AwB8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K00vR027uGPYsjfPJ/u3HhaKzZQNwiQyptC6Ivkm2EcZqPd/tCKJtbONN/vfGFhiV
	 DbuHwLXxIWMxvfUht3Mlx7P3QyKbUJF5vwABlBAMbO2idmqnUPCXam5geT/QP2X7ok
	 BIA/K03JCl3gDBmEKYKj8tphTDOY23Vtblc05RPg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1FA2F80516;
	Tue, 28 Sep 2021 18:24:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1F48F804FC; Tue, 28 Sep 2021 18:24:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 014C0F804F1
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 18:24:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 014C0F804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N20J+MrQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19FFD6124B;
 Tue, 28 Sep 2021 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632846255;
 bh=/5ZRMWJBCLjBcb1qm26DEO0HpSzhNQxjHWuWet1AwB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N20J+MrQp74gy/myVM1RZwcF947THk9vvhPRhelxr+cT8jNJJ9jzZLe9/D/195UxW
 bp1y4poZUPd4lzuxawWjspnwhIw/PvptP7dnQ9uOvtDqdOEE0bLs7p9S5m5vdRDsxe
 P8eI/hODezUrW8AeY7x6OkwA22M/BfyckmCISAitoWdteHwwACKqCsvOqyMVvyil1Z
 GF6pm3tAHPdJrrlQv8ISrkGjd1m9YQVkbMpmkKwPPfP4Ht5qeK2QrWUFrccaXAJvn4
 YzkbYX93umHF+s+80i0yv3el/ngYXDsPNTaJtvuiV9tAaDlVNSuwg2Y/lxPjKtwo0x
 Zr9/3FoXJ3t+g==
From: Mark Brown <broonie@kernel.org>
To: daniel.baluta@nxp.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 lgirdwood@gmail.com, guennadi.liakhovetski@linux.intel.com,
 pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF: add error handling to snd_sof_ipc_msg_data()
Date: Tue, 28 Sep 2021 17:23:06 +0100
Message-Id: <163284573552.17390.2365820093695901040.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210928103516.8066-1-peter.ujfalusi@linux.intel.com>
References: <20210928103516.8066-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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

On Tue, 28 Sep 2021 13:35:16 +0300, Peter Ujfalusi wrote:
> From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> 
> If an invalid stream is passed to snd_sof_ipc_msg_data() it won't
> fill the provided object with data. The caller has to be able to
> recognise such cases to avoid handling invalid data. Make the
> function return an error when failing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: add error handling to snd_sof_ipc_msg_data()
      commit: 6a0ba071b71c44bc905522b77e96afad464e8aac

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
