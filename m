Return-Path: <SRS0=pVe7=D7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD3C388F9
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:30:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37C12225E
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dlpEZyKS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbUBJFYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37C12225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE3E71812;
	Sat, 24 Oct 2020 02:29:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE3E71812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603499434;
	bh=wbJPAJGnIZsJEXKlHzCoaAaN7I7zayCEshFnAbys6bs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dlpEZyKSbdLuhEWbEbLwv5KPg4MMz5PxRwBeGpen/B7BsQjZVFu/cEWqTPFZHvKdH
	 E8MJKqIWZDUw4u3xy9I1tZ1d9FAV/ElhPcmJNF5/IXj2ryqmjouPu8CvnkQORBmBbh
	 4yr++6dz7Au40NctvOIpY4cARHClj2aitx/GzBpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B950F80272;
	Sat, 24 Oct 2020 02:28:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C9CFF80264; Sat, 24 Oct 2020 02:28:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE9E1F80245
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2020 02:28:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE9E1F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tbUBJFYs"
Received: from localhost (cpc102338-sgyl38-2-0-cust404.18-2.cable.virginm.net
 [77.102.33.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 094B12225E;
 Sat, 24 Oct 2020 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603499321;
 bh=wbJPAJGnIZsJEXKlHzCoaAaN7I7zayCEshFnAbys6bs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=tbUBJFYsdJN4fviiBE4YQtiWZram/rS6cSD2Iv+Phq90caDPgBAdisBcwZH1ZiEES
 cRrishWsRVedkcGBL5/XuB25US8cKlX0h5LanBUdij8kDxA1SZ7kQiRRRLXcT31t4T
 Cx2UiC6yhpGyPKQ6zVfyMEEURz1FcyhCFbU+QinU=
Date: Sat, 24 Oct 2020 01:28:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200930152026.3902186-1-kai.vehmanen@linux.intel.com>
References: <20200930152026.3902186-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: SOF: cleanups for 5.10
Message-Id: <160349931941.28438.4813950905753029653.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, daniel.baluta@nxp.com,
 lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com
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

On Wed, 30 Sep 2020 18:20:22 +0300, Kai Vehmanen wrote:
> Series with multiple code cleanups, plus one fix to remove
> unnecessary kernel warnings related to firmware loading.
> 
> Bard Liao (1):
>   ASoC: SOF: loader: handle all SOF_IPC_EXT types
> 
> Pierre-Louis Bossart (3):
>   ASoC: SOF: control: remove const in sizeof()
>   ASoC: SOF: topology: remove const in sizeof()
>   ASoC: SOF: sof-audio: remove goto used for force-nocodec support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: control: remove const in sizeof()
      (no commit info)
[2/4] ASoC: SOF: topology: remove const in sizeof()
      (no commit info)
[3/4] ASoC: SOF: sof-audio: remove goto used for force-nocodec support
      (no commit info)
[4/4] ASoC: SOF: loader: handle all SOF_IPC_EXT types
      commit: 6e5329c6e6032cd997400b43b8299f607a61883e

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
