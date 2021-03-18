Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57331C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 18:35:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C029B6023B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 18:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C029B6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EED961695;
	Thu, 18 Mar 2021 19:34:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EED961695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616092533;
	bh=INUFglOg/4NcYEYdVHMwtMT3NNATeYQ4j3gJCSWjojA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qV0drRQMaG1LWs5rp+rfMaCqLhBjM9E5ZOr3D9oBoEjq/PAfCVdafArFolNein6ae
	 Y4cR/5h8BqQvAmJ4nxGLi0+ebKekU6xJP0gjh22En1qbp6HtdXGhC4E3f6L2G5h882
	 ng7bDBPTSJIlJIF/EugH5NZuS/7cLZB9REXD/5Ro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77341F80218;
	Thu, 18 Mar 2021 19:33:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89486F80224; Thu, 18 Mar 2021 19:33:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0FCDF80163
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 19:33:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0FCDF80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W3R990pp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B61C64F04;
 Thu, 18 Mar 2021 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616092426;
 bh=INUFglOg/4NcYEYdVHMwtMT3NNATeYQ4j3gJCSWjojA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W3R990ppNuoRbWXVfdPAWYN7kFdyxisgukohmfd44/69zUv0fBG/E+KdswzEABoG9
 Pzp8UIas+g17K7ENA5aVBRKddCb1YW/kcSa9pFX2OFVw/KWqIz+RAClAByhetIPi6v
 vQXf9+XVPnyeJTUO/KeTkaveljtbiH52P1eonULRyCmE/XMWr4eEDvbKU3l3ZhGzbG
 Rumw4PqjX2ZzeUg208w/WhzmkG0EusavX+HAEVM9tzT/UvGGJO+D6Z9OCqbhOsdhOI
 0r90O8grcLG1If5sCnqjxixDeTjFV++ZOc+BE8N67EWrxkT3tODSNqdZz3cRyb5lYv
 U8OarjWKvwcXA==
From: Mark Brown <broonie@kernel.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: skl-topology: fix
 -frame-larger-than
Date: Thu, 18 Mar 2021 18:33:30 +0000
Message-Id: <161609213720.41838.16025137962653847892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315013908.217219-1-nick.desaulniers@gmail.com>
References: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com>
 <20210315013908.217219-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, amadeuszx.slawinski@linux.intel.com,
 yang.jie@linux.intel.com, pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
 Julia.Lawall@inria.fr, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Mark Brown <broonie@kernel.org>, mateusz.gorski@linux.intel.com,
 andriy.shevchenko@linux.intel.com
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

On Sun, 14 Mar 2021 18:39:08 -0700, Nick Desaulniers wrote:
> Fixes:
> sound/soc/intel/skylake/skl-topology.c:3613:13: warning: stack frame
> size of 1304 bytes in function 'skl_tplg_complete'
> [-Wframe-larger-than=]
> 
> struct snd_ctl_elem_value is 1224 bytes in my configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
      commit: bef2897d31b97852d80b38e9376ed5ef3a90b309

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
