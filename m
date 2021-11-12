Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E0C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:29:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A4B610FC
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6A4B610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 439381685;
	Fri, 12 Nov 2021 22:28:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 439381685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636752575;
	bh=eoAl5B/8h3ZtzbA9rB3nBcwncqWuJUxuT/UFumATqZQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YN/kgCLXXfKap6kIE38oGL5Do+BX4ZHaWQKlZrJhjt1SfNVczKN2FGyypzBXlN43l
	 pvtvvljk1dS/ezZ6puuhQ8zb5zKQCZU1Yy8E5RkojaGPuBTDpAcsd+gFqrYDbxnrQj
	 YITR1czjOtIfnWOHclVNqgR3sKST/C44LAB5IL5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D65D8F804B1;
	Fri, 12 Nov 2021 22:27:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2ED4F804EB; Fri, 12 Nov 2021 22:27:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26332F804C1
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 22:27:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26332F804C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PyDHCooH"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25BF0610FF;
 Fri, 12 Nov 2021 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636752446;
 bh=eoAl5B/8h3ZtzbA9rB3nBcwncqWuJUxuT/UFumATqZQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=PyDHCooH3k3+HIQuMCsauOX0epOaMV29t1rOZWKdBiawNsX7KVbHe0BZDf+VJwlvD
 3nCRB1RWAkUvTKWfOjJQ7k+Gic5ysfd64D7RTx1Iotg8FUvzvEKiKXxZiaI9OODWFk
 rJQXpWhFujB8vhG+H46Vpwcioq5p1II9amfUdXHq+yqiicVTulezO69s8llcFmmQIo
 tqQjP8G40R9SwbuQPcLVEMNoYRCAYEkPKmrJyk3O4TkHR0xk3SIA4EtHKJ84k/zW8G
 XZ8phQJ+dNfrJ6b37g79SH3cxZg+lTAQ7jS+sCr41cmfZ+YXLMSMJqdkHbCRKJOPKh
 mgpxORkd/4lUw==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 lgirdwood@gmail.com
In-Reply-To: <20211111161108.502344-1-angelogioacchino.delregno@collabora.com>
References: <20211111161108.502344-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Fix debugfs registration for
 components
Message-Id: <163675244389.742274.1874559646597511024.b4-ty@kernel.org>
Date: Fri, 12 Nov 2021 21:27:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel@collabora.com,
 dafna.hirschfeld@collabora.com, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 11 Nov 2021 17:11:08 +0100, AngeloGioacchino Del Regno wrote:
> When registering the mt8173-afe-pcm driver, we are also adding two
> components: one is for the PCM DAIs and one is for the HDMI DAIs, but
> when debugfs is enabled, we're getting the following issue:
> 
> [   17.279176] debugfs: Directory '11220000.audio-controller' with parent 'mtk-rt5650' already present!
> [   17.288345] debugfs: Directory '11220000.audio-controller' with parent 'mtk-rt5650' already present!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: mediatek: mt8173: Fix debugfs registration for components
      commit: 8c32984bc7da29828260ac514d5d4967f7e8f62d

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
