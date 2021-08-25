Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996E1C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:28:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796FD61052
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 796FD61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31555166C;
	Wed, 25 Aug 2021 17:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31555166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629905303;
	bh=xX3sPL8wVgj4gfbIYo+gq9+nKEagcBN77P42+6QE7yw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZ30PYxZi60pQn04PbU49RjPDISUx16CnizlK3tCNoeMSqZ+zlMupOsHDv1je2dxb
	 eSW7InI5eTYlxJWOwJbJC5ZDpnxJT9oHf7g1fcOODvVSfhNI6ck71FGGN/rZthxofj
	 lRphunC74fWsDGOK8t9S5vRCwpLqSs73+jXR0JFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4151F80171;
	Wed, 25 Aug 2021 17:27:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D531F8020D; Wed, 25 Aug 2021 17:27:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06297F800AE
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 17:27:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06297F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eZcH/c2t"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B1D461052;
 Wed, 25 Aug 2021 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629905243;
 bh=xX3sPL8wVgj4gfbIYo+gq9+nKEagcBN77P42+6QE7yw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=eZcH/c2t6WudeFRWe3BUtuTM2zU4VFwWjgQkOuWzKjGhOkI7CALQghxbDMbM1NMqu
 Q5RwQkd4z3Bz7whfRXtqh2s/w+yXQI4wh3HC4YosSir0CxNyBih2FmSYOnWfXFxm8S
 o19GvbyJTTEOmM52uLb+rOLsiHWlJk5WUYaPpIBNm450dlYT+u/eJVX5pQO/IsdrAx
 hWZB3Y0sPM5jaHxwPrONPQ4hN9lG9IKAJJIplpEernQ5dAzbDCm6R8K1OGOlWikVfg
 JxKu1UasX/imy5ACKysWsMbw83i1CSGCtHbnHpW86RXdJG9aAiIHagP92zmC1D528v
 AEtlg9cHNYgLg==
From: Mark Brown <broonie@kernel.org>
To: yang.jie@linux.intel.com, hdegoede@redhat.com,
 pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 liam.r.girdwood@linux.intel.com
In-Reply-To: <20210825122519.3364-1-peter.ujfalusi@linux.intel.com>
References: <20210825122519.3364-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Make
 rt5640_jack_gpio/rt5640_jack2_gpio static
Message-ID: <162990401497.56501.11105326993788990504.b4-ty@kernel.org>
Date: Wed, 25 Aug 2021 16:06:54 +0100
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
Message-ID: <20210825150654.Ep2C3pAVSpL0imJwHViPZxHKlr0rQ_xHXhGTrdY6S6Y@z>

On Wed, 25 Aug 2021 15:25:19 +0300, Peter Ujfalusi wrote:
> Marking the two jack gpio as static fixes the following Sparse errors:
> sound/soc/intel/boards/bytcr_rt5640.c:468:26: error: symbol 'rt5640_jack_gpio' was not declared. Should it be static?
> sound/soc/intel/boards/bytcr_rt5640.c:475:26: error: symbol 'rt5640_jack2_gpio' was not declared. Should it be static?
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Make rt5640_jack_gpio/rt5640_jack2_gpio static
      commit: dc2d01c754c378a4748ac72c5516d45da7640123

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
