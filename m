Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A43C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 00:03:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7153F86F;
	Tue, 23 Nov 2021 01:03:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7153F86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637625835;
	bh=LZaLYcPH4q5eCeBbmf9LnY8K3MrFIUVPYiAoLfcs24c=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6n65tHIT5XkO9QQCFJljv8QYuQT+jN1hlhSaUY5zRF9EPO/kIgtlteMPF6UIICka
	 5SlN6cMSHa2V7sY96jEwuKeU3ynfwT/kJNAgjIZMt61ipSqAp0Q6ximRBiBwCB03YW
	 Us2ZMtrhp9tvzBsCqEBfyi6P/dLOrSBi4Tfu51Uo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9889CF8051F;
	Tue, 23 Nov 2021 01:00:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42D7BF80520; Tue, 23 Nov 2021 01:00:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FC1AF804FE
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 01:00:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FC1AF804FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uSFoNUzh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35FC461004;
 Tue, 23 Nov 2021 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637625621;
 bh=LZaLYcPH4q5eCeBbmf9LnY8K3MrFIUVPYiAoLfcs24c=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=uSFoNUzhyTgV+0ccFNEtv0nP2ui6SlO9oicdu2kybFHg9UGPXWOREN4uoyShkPmv8
 9DY6Qj5kAX5JE4aidI744xHlNeJ++drOOr4eq3HjpCbzWOmSr2c+cpli5qxIWDIFq0
 +EZ/U5gwIYKkxEtl7+7JZsjmdwUip7jPaob/2j56g8w12XL6Ap2/oEvYTxLgHiIgsy
 KSUCrFcfRy7uzjq7vBiwk447vk+WeNFBei6fxb0jfio3pY+jXmf1J+3LP6dCduoVQ+
 BPYVVcbeBRqWrRJr2iEVJUkwVM3iV72zH4WD2ovxry4OFBXL0F2qBv5jaQsHudtcYR
 HCMFzwrUag8BA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
Subject: Re: [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
Message-Id: <163762561675.2471742.16439171676950432106.b4-ty@kernel.org>
Date: Tue, 23 Nov 2021 00:00:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: bkylerussell@gmail.com, kuninori.morimoto.gx@renesas.com,
 Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com, tiwai@suse.com,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, michael@amarulasolutions.com,
 festevam@gmail.com
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

On Fri, 19 Nov 2021 12:32:43 -0300, Ariel D'Alessandro wrote:
> The tlv320aic31xx codec allows using BCLK as the input clock for PLL,
> deriving all the frequencies through a set of divisors.
> 
> In this case, codec sysclk is determined by the hwparams sample
> rate/format. So its frequency must be updated from the codec itself when
> these are changed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: tlv320aic31xx: Fix typo in BCLK clock name
      commit: 7016fd940adf2f4d86032339b546c6ecd737062f
[2/5] ASoC: tlv320aic31xx: Add support for pll_r coefficient
      commit: 2664b24a8c51c21b24c2b37b7f10d6485c35b7c1
[3/5] ASoC: tlv320aic31xx: Add divs for bclk as clk_in
      commit: 6e6752a9c78738e27bde6da5cefa393b589276bb
[4/5] ASoC: tlv320aic31xx: Handle BCLK set as PLL input configuration
      commit: c5d22d5e12e776fee4e346dc098fe51d00c2f983
[5/5] ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec
      commit: 8c9b9cfb7724685ce705f511b882f30597596536

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
