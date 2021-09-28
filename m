Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFAFC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 16:26:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D6960EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 16:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3D6960EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73F7216BD;
	Tue, 28 Sep 2021 18:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73F7216BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632846400;
	bh=NARFtHeqyRbAbSEFSnqZt8yx8JZc2xoc5EO9W5fLgL4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VLKRkaG4A2TkACPualnveWiGwhzkitqg8rHEsqexUv24J+Z3yyP/5CeXDOsJhzXlv
	 RVG8vi9ck7EZBkEaGkAU2MnCaXEZuUV8l/+3ornNaSWyK/wXWjfyU/VZn+zEFB5b+v
	 9x683arxwmMMMkh7gmp+t1D4E/CYx9Tr9yfMYKyI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1438FF804F2;
	Tue, 28 Sep 2021 18:24:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80829F804E4; Tue, 28 Sep 2021 18:24:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C528FF804E2
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 18:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C528FF804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="E7wIT0DY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E250D60F5B;
 Tue, 28 Sep 2021 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632846250;
 bh=NARFtHeqyRbAbSEFSnqZt8yx8JZc2xoc5EO9W5fLgL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E7wIT0DYG1goVQMsotXBiZEpTm0YD1dAGPTcw8EF/g2zSddmskJDlB4/fLkwJXYCY
 apWIW10YC0SVQvIp0/zoncJRGWK4YK9AZ/7WAlW8kc7bbwsbQZBicXcYb6lOpcbD/O
 vkfrxEAQqH2d2oKUr1xdDdXLtCuDiK8peF2s6vieVHBwq/l23Ukpj601wLCzWdUdWS
 mVfK8SeeuJTvXaFTjeeTh40t3LOnFWwzOIQHKhnIpsSHjVxd7H8aiWSbTtoR3b4fhQ
 3AohWufsbDa1w+DM+OouZS40gsjLRYTYTtaaKftmOg8TDdrLLaa1GBCwzEL4GgVQC0
 pFfEHYuIOFWnA==
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: intel: sof_rt5682: update platform device name for
 Maxim amplifier
Date: Tue, 28 Sep 2021 17:23:04 +0100
Message-Id: <163284573551.17390.4087071777524402599.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927143249.439129-1-brent.lu@intel.com>
References: <20210927143249.439129-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Gongjun Song <gongjun.song@intel.com>, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Rander Wang <rander.wang@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>, Yong Zhi <yong.zhi@intel.com>
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

On Mon, 27 Sep 2021 22:32:49 +0800, Brent Lu wrote:
> To follow 20-character length limitation of platform device name, we
> have only 7 character space for amplifier. Therefore, the last
> character of mx98357a and mx98360a is removed to save space.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: sof_rt5682: update platform device name for Maxim amplifier
      commit: 3c561a090c7920624b83005a279a66cc8a7bed2b

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
