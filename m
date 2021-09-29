Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB780C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 13:19:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28E5613A7
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 13:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C28E5613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3784416B8;
	Wed, 29 Sep 2021 15:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3784416B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632921566;
	bh=xtLbCRh5xCE2yUqi9k04cLpvo/QHop+ckgKyYeoYq+M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j84GNQ0WaCgOtd2zJQsUnqwBREdvVUsRbI0iEXdzD7mEzmGmkIiAsz/RmQcMp7+eF
	 XnlMee1Fi1vChVPfznVPivRnfEDAQMetsrnDZ6FBf6VcS6VGWrJH4aI0/0pl+nazuZ
	 1PDFfoG5lQGhtu2auSrMApDd1qplfA4Cl6jYULjM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9CD3F804E2;
	Wed, 29 Sep 2021 15:17:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F147EF804E4; Wed, 29 Sep 2021 15:17:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C189F8026D
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 15:17:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C189F8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Eob3QP+u"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07DFC613A7;
 Wed, 29 Sep 2021 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632921458;
 bh=xtLbCRh5xCE2yUqi9k04cLpvo/QHop+ckgKyYeoYq+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Eob3QP+uHfk3A+Jw8yHyVsOYzF+aKRaJg1nmwZoY4CUmfe9/LVP/XcTYxqqkBVGzJ
 SZ+NYhmsl3Ok2VHV93g4Cz1SNsHrogp4XGZH39DjhAIvBK7B4Jmdm/JKWZWX6fS35b
 B9qM/MDxH2hUFsRUqwCPLB1IzhVnlMtDmHU7k99T4cFiE0Z3q7XMCSg7MEXHb/Rbn8
 RcIB2AWuWcAlYUdy+J5T6XCvtJOo+LSfYGpKDbuHvYtTVotNn+VRa+HUJxIfoJYV7l
 +wTnsrm+8Xq0NFfYL/BX9BCeDUoJgerBMyEWB51Huezm9+r1G3V62A6s3kqRQZdwqr
 WkVM7y1fylMUw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: ux500: mop500: Constify static snd_soc_ops
Date: Wed, 29 Sep 2021 14:16:45 +0100
Message-Id: <163292102842.46827.6744851030638549550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929094401.28086-1-rikard.falkeborn@gmail.com>
References: <20210929094401.28086-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
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

On Wed, 29 Sep 2021 11:44:01 +0200, Rikard Falkeborn wrote:
> The struct mop500_ab8500_ops is only assigned to the ops field in the
> snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
> Make it const to allow the compiler to put it in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ux500: mop500: Constify static snd_soc_ops
      commit: 2831b71917264d7000855657acb1953003d3fd2d

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
