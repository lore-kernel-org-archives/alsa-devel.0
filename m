Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9FC433E9
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:03:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222BB6512E
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222BB6512E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A94FB1934;
	Tue, 16 Mar 2021 19:02:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A94FB1934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615917798;
	bh=zCkCxox1OLwnderDRZkFV/XZY0rZMifulX6TMpnOfVE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ohUVQ3JezWXxwcuT/HLixoKvCOM6DFBnaeKFj5rXZCL899hLSf4FPJpfC7vZP5RyG
	 oQ/Tm1GrISOPUf4RpMQKHX7bCGweanQUlHBiC7titeLYv62FEMLVDEhDE1U+M7GP+C
	 9IW84Dg84maB/noWjYC4GqKj83Uy2TDa6A5lBlK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC435F804AC;
	Tue, 16 Mar 2021 19:00:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65534F80425; Tue, 16 Mar 2021 19:00:19 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F358F80137
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 19:00:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F358F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jCoQowma"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C136513F;
 Tue, 16 Mar 2021 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615917614;
 bh=zCkCxox1OLwnderDRZkFV/XZY0rZMifulX6TMpnOfVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jCoQowmadMlIKMs+WjcPUNyaWB5eP8tFGI5dVLJcYjQUisc3vt8hUiCkLEw+CsfUc
 CDjeasuFdJcGnQpblAZ5XZSnKnPkhdQ0vWx7cqaIRJq7oo1OW/1ThEDALIXr1jMJBv
 WBFDppUXneOrl+Y+kdmYy84ON3+5JFuGkHhvYH+rzrncBTiL3zE6IU9ZJILIH/ZJo0
 miEf64uHbn0suazLJTXu2xcrcTBFsXBm8pOkGvMjNJ8q3XD6WG4ycsIAXPniz/nQPw
 CaRmZaOj+hlE2mWljwjfkqr4HO5oA+urwooHaLPaZ/AO7McHDvsi7Verv9UVIIKl7W
 z3wdIDPMiHXSg==
From: Mark Brown <broonie@kernel.org>
To: ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
 peter.ujfalusi@ti.com, perex@perex.cz,
 Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, lgirdwood@gmail.com,
 gustavoars@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH] ASoC: wm8962: Relax bit clock divider searching
Date: Tue, 16 Mar 2021 17:59:46 +0000
Message-Id: <161591744696.13544.17150512683547354902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Wed, 3 Mar 2021 19:21:28 +0800, Shengjiu Wang wrote:
> With S20_3LE format case, the sysclk = rate * 384,
> the bclk = rate * 20 * 2, there is no proper bclk divider
> for 384 / 40, because current condition needs exact match.
> So driver fails to configure the clocking:
> 
> wm8962 3-001a: Unsupported BCLK ratio 9
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Relax bit clock divider searching
      commit: aa4890f673f9d54d3cb0ea156acfe41958ea7f08

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
