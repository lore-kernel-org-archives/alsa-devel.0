Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADADC25B08
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 13:10:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCE99163B;
	Wed, 17 Aug 2022 15:09:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCE99163B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660741832;
	bh=6mxl0UlXmn/Urxz4PY2fsLTMgZGiOV0yNNacP8ll6rA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPxcbTinKY1N9cNLOOjOPbsC8sO2EbtRYtTFtdc/rEupuuleHmBXV+FMQN1KpJns7
	 PhhY6bnKeeq3VlXI6NT0VwfO5BS4uTIWZVObo8YKw3Su58av+d4/RttpsjkisUL0aW
	 4SX+uGk6B7b4Ctj38AH7LgHMjaOqhVgxyXNdYj44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1563FF804BB;
	Wed, 17 Aug 2022 15:09:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64F96F80237; Wed, 17 Aug 2022 15:09:14 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA1A6F800DA
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 15:09:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA1A6F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eEkK9YlR"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C92B5B81AD4;
 Wed, 17 Aug 2022 13:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC5C433D6;
 Wed, 17 Aug 2022 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660741749;
 bh=6mxl0UlXmn/Urxz4PY2fsLTMgZGiOV0yNNacP8ll6rA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=eEkK9YlRU159rfalKUjWT9uAgaP2fS3t+iLB/jh6gJbe40M8m/w6WQD4zyQM8MAiD
 rLJlzCGWRtKOQKn/7Idm8zKe+n49jCIQELpUtWiK2otLeU/xiVcDSIru8nN1JzU+T1
 waKJAXDRS4EdaC2JarCoaj5jCdcmPl+BACQ2yMzldukrXFeIt9CKq+b7M8zPoD97U8
 vYY0Y2JH1cSrcMyFSn2OwZtkM7i1N1iTwWPQuFgW9TSq/Yx8gSH6y2CMSWW2hc+4c4
 uRGL7wvr7RXXuJ22TJ2T+/xV9e26FLQxp4TEQo4wHiSXI+hqPrHvGNV3OTZw+06XkM
 qJhujyFkqX83w==
From: Mark Brown <broonie@kernel.org>
To: Xin Gao <gaoxin@cdjrlc.com>, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20220816175105.8084-1-gaoxin@cdjrlc.com>
References: <20220816175105.8084-1-gaoxin@cdjrlc.com>
Subject: Re: [PATCH] ASoC: Variable type completion
Message-Id: <166074174811.88107.17955474893626943229.b4-ty@kernel.org>
Date: Wed, 17 Aug 2022 14:09:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org
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

On Wed, 17 Aug 2022 01:51:05 +0800, Xin Gao wrote:
> 'unsigned int' is better than 'unsigned'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Variable type completion
      commit: 1b5efeabf75a74043f1eb509ca3ac183b3ffaf89

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
