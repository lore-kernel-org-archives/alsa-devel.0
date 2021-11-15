Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E181C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:37:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA8861A40
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAA8861A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0195B169A;
	Tue, 16 Nov 2021 00:37:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0195B169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019470;
	bh=phk22W087gGn63frwTpAzHA3cZd3qLIpMBGvdYs0Xec=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KY+bfoKwfnASlfjTb62QJV+fKBGR+j/0aAXMic1tajR9YcATa3RLKfVZyU7HSN8gh
	 i6I6vLG2PtJ55gFM2QzVSNhQQjQgE+/0C0JxaWdmkzHHC+WnpmqCai8cRaDIgtKetD
	 JOcEpI884OSisDoiYSPH/hteu+pPR7daelTw4mUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE4B5F804FE;
	Tue, 16 Nov 2021 00:35:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D58ABF804CF; Tue, 16 Nov 2021 00:35:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2608F80134
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:35:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2608F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RhO4m2JE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9E3F6325A;
 Mon, 15 Nov 2021 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019307;
 bh=phk22W087gGn63frwTpAzHA3cZd3qLIpMBGvdYs0Xec=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RhO4m2JEy6bXBHq5uUN+RwQr5vrJhwnjrRDXpp5yE2Q95vvP7n//PUXdiLZk/D8ho
 z58WraBiVj55cuW9nYycADs6GRvtTGOxiGYzCL0DLYU5RqqVU+PlIGlostQ5h1uMD9
 zAilJNmVzw/ZT8DIKE0CLQC1zflbB5dabJEM0RDbrRYbz6p4VFotOvNcggyYiLM+br
 VIPrJ11Tizw+OkLsKmdDwmmv+LliwLWNF2aZZmSoTNtUZdScQQ8B82AxQmHhkobsKI
 PgmtqvgLakhMWJyiywfnjJkkLJlO6115no0Y+4ZTzes4lnATDmlRIoW3AUDTegWpj3
 /yfEu9C3u1dfA==
From: Mark Brown <broonie@kernel.org>
To: yang.lee@linux.alibaba.com, perex@perex.cz, lgirdwood@gmail.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, tiwai@suse.com,
 srinivas.kandagatla@linaro.org
In-Reply-To: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
References: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: codecs: Axe some dead code in
 'wcd_mbhc_adc_hs_rem_irq()'
Message-Id: <163701930557.675370.6905108518323377395.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:35:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
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

On Wed, 3 Nov 2021 20:19:27 +0100, Christophe JAILLET wrote:
> 'hphpa_on' is know to be false, so this is just dead code that should be
> removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Axe some dead code in 'wcd_mbhc_adc_hs_rem_irq()'
      commit: 95cead06866a95baf0f8355bba81a8142d5908cf

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
