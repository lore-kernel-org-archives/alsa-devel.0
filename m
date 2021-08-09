Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBAC432BE
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 15:56:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44FA6101E
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 15:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D44FA6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A76B852;
	Mon,  9 Aug 2021 17:55:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A76B852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628524609;
	bh=/beiuNqmW6puIkcAFW4NOFWD2PbeHLQ7YuvfsAjXtmI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfgZ/PNoXcgAwH+b2ZDWsCXT1765LZIdmziZZjkxUUSc5y9xTOYxT2HCCwi8V5rwj
	 zwG30Hp4hzNoloJ8BPwzy9nDNFZ39BUsP4Cwz5zDbjnEnIsaj7ri3/OtBtgtu1G9HH
	 nppgjtO0Q3R2L8HiQSpJNQKCgvUX36VTVXPP/W8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF15DF804B0;
	Mon,  9 Aug 2021 17:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5E97F804B4; Mon,  9 Aug 2021 17:55:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E42DAF804B0
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 17:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E42DAF804B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V/d/GAou"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F4361051;
 Mon,  9 Aug 2021 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628524499;
 bh=/beiuNqmW6puIkcAFW4NOFWD2PbeHLQ7YuvfsAjXtmI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V/d/GAouFH4eCxPEAF6unNhKCz5jUCGKU8VmWNiWdJTXh6376Qn3PnHqQFZez0dP0
 grOHKphPtDGbmI6/hLKD/YXxzXsfUui+PuxPD1keH3hdydRF1D7gWgP0IqFc5HMrRU
 yKJwkvjRuzSxako/9uWbxrvqrxw0kdKo61W0Y71TyB6cVesUC/ZVA3a0IJCupN2Xvy
 MNJ91YCD5grxG8t9yQSOPMBYwQahFoF1RgoFmNCzTiUprTSk9de39NBPQ9JSLOk84e
 lwiCjsxe99IzuWT/Rvu5wiNqFFLn7Bn/U1WajpfNbSoelh+hS+TYZAt3/mTLHcIHcd
 KS8KBdm+RQf3g==
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com, geert@linux-m68k.org,
 Steve Lee <steves.lee@maximintegrated.com>, krzk@kernel.org,
 alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
 linux-kernel@vger.kernel.org, rf@opensource.wolfsonmicro.com,
 ckeepax@opensource.cirrus.com, dmurphy@ti.com, perex@perex.cz,
 nuno.sa@analog.com, shumingf@realtek.com, lgirdwood@gmail.com,
 tiwai@suse.com
Subject: Re: [PATCH v2] ASoC: max98390: Add support change dsm param name
Date: Mon,  9 Aug 2021 16:54:35 +0100
Message-Id: <162852418087.21716.3746148896944040139.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809142140.9293-1-steves.lee@maximintegrated.com>
References: <20210809142140.9293-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: ryan.lee.maxim@gmail.com, Mark Brown <broonie@kernel.org>,
 steves.lee.maxim@gmail.com
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

On Mon, 9 Aug 2021 23:21:40 +0900, Steve Lee wrote:
>   In case of using different type of speaker, support
>  using different dsm parameter bin file for each amp connected.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Add support change dsm param name
      commit: a10facb752535c078c914b1910dd72eb2e8d584b

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
