Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB70EC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 17:26:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44A6018D0;
	Tue,  8 Mar 2022 18:25:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44A6018D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646760361;
	bh=HBG0QEqFPkobnElfezVfJiP5rXTwhi4PFEhGZ7aJJ9M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYFeCY0c8n3hX05C2/EurpIE3KX1qXnZJI7bnTkaUf1HphNg0HneAmn1meyLx80g9
	 0YRVwh7fmmhc6aC3oYBaLvP/zSGpUbXZcmCoeLQzoxEUuEocol1T+1ynCP67XeF8ls
	 wIXAIW0W4pGc+B9VTfJ83XXhi10knG2YvvX3cu4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E08B4F8053A;
	Tue,  8 Mar 2022 18:21:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5E4CF80539; Tue,  8 Mar 2022 18:21:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32F5FF8053A;
 Tue,  8 Mar 2022 18:21:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32F5FF8053A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="of6u8aJi"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ECC4261266;
 Tue,  8 Mar 2022 17:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D218DC340EF;
 Tue,  8 Mar 2022 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646760067;
 bh=HBG0QEqFPkobnElfezVfJiP5rXTwhi4PFEhGZ7aJJ9M=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=of6u8aJiy+Ddm/KXOLGXRkf4D4/NEXnkDfsrYRCX1tA1hAg4M8YILKSlnNhX+9Ivv
 3g0ftwuMlkoJ+lgvUuOUU5tLuJ50DLlgTJEV/MieiWQJEd9tyStksVONO7E14uwFWz
 JeKFi2aU8hn1IbThJJdnaNNdJTHH4ERUFo6CKQS8xI75WsqtASMwuidI5rMpza5q+d
 oFGzh2SmtZCtv6F6H2DZMoogsqSkgzTAB6kYHVD5tOgni/XcVm3Wf5L/F9t5Z6M6Q7
 jrA8TClViMalNOFpCtmW7I6RHoZg1QKOQO8wrmCl8Lh36uifyeBdbyOuEqK9K/Bh9N
 6RFwn6CtrnZAw==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Miaoqian Lin <linmq006@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Viorel Suman <viorel.suman@nxp.com>, sound-open-firmware@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
In-Reply-To: <20220308023325.31702-1-linmq006@gmail.com>
References: <20220308023325.31702-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Add missing of_node_put() in imx8m_probe
Message-Id: <164676006354.54315.10445621693654106619.b4-ty@kernel.org>
Date: Tue, 08 Mar 2022 17:21:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 8 Mar 2022 02:33:23 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Add missing of_node_put() in imx8m_probe
      commit: 5575f7f49134c7386a684335c9007737c606d3b5

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
