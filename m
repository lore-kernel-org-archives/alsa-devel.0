Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9133EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 19:55:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE29364F51
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 19:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE29364F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCC201657;
	Thu,  4 Feb 2021 20:54:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCC201657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612468538;
	bh=kDTNwURjXa+HbA3VIp6+/0PYSmTxLywhEjY+tj3zJDA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WGD3bc4KGHOB9Z/L3pK1mei9rYRFdzHW9dtBtmFBUeB5w3SylXuzuIKnfemi3OdJp
	 otx+/d8VFbmhy0pFkJqVr9IwJgoMBs3TdioZpHLXWiA7I1x/lBVheZhZTdori51B0D
	 CgaQ8g1aC4xSzDjCjQMx6BPy0pCsf1rfDNk3CDAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65B56F80155;
	Thu,  4 Feb 2021 20:54:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14B15F80171; Thu,  4 Feb 2021 20:54:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98015F80154
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 20:54:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98015F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OQb+pLUS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C1164F53;
 Thu,  4 Feb 2021 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612468481;
 bh=kDTNwURjXa+HbA3VIp6+/0PYSmTxLywhEjY+tj3zJDA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=OQb+pLUS6MMf+ML/spK7AkKa5EOFof76snhOORIBeOMV6UmIPXPShpUn6pJ2Qw4s3
 TLJDgScLQXNMTnLzSoMoPlJlsPlCWkzq1SsuQZP2H5VA7rSHKxBvCpPHbvNDZq4bTF
 WDlgmMOiWJPpi3lYnzaPH/qFcFx9RIICDWmzoZ4bd7weaa+ABnR47b+J98KYSkvkcB
 h3Qg9Mdjyf26zsOwAjD7EX5YCOqIZIM9IfuL+gduvVVmy97wiC/p2Hw50KUmqh+riO
 N2XwkPNXS4AVuRYg/wnUYSt4QtPLg7ffMpcbs7iEluuVEr9PqB+8ZZvAvDNQKbAiRx
 NTgBHGh8TFLIQ==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20210203032201.2882158-1-tzungbi@google.com>
References: <20210203032201.2882158-1-tzungbi@google.com>
Subject: Re: [PATCH v3 0/3] ASoC: mediatek: mt8192: apply some cleanup
Message-Id: <161246842661.26209.3136480726887018002.b4-ty@kernel.org>
Date: Thu, 04 Feb 2021 19:53:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Wed, 3 Feb 2021 11:21:58 +0800, Tzung-Bi Shih wrote:
> The 1st and 2nd patch refactor to use asoc_substream_to_rtd().
> 
> The 3rd patch simplifies ops of Capture1 DAI link.
> 
> Changes from v2[1]:
> - Fix typo in 3rd patch's title, s/simply/simplify/.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: mediatek: mt8192-mt6359: use asoc_substream_to_rtd()
      commit: 8e59cf943fa7402f008de4b444beb0c5280317bc
[2/3] ASoC: mediatek: mt8192: use asoc_substream_to_rtd()
      commit: 0840706d6c61658e51f42762c5b4f211b7596535
[3/3] ASoC: mediatek: mt8192-mt6359: simplify ops for Capture1 DAI link
      commit: 4cceb42f4f401463b70d9e69c4771212707c51a8

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
