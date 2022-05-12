Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF446C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 12 May 2022 14:13:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A95801AB5;
	Thu, 12 May 2022 16:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A95801AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652364820;
	bh=MzRMdy8E89Q9LhenGGBwHCK3EXb+c+A7ZNlc7Me5Nm8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKCG63KnNsOe2GH+8955MOxYZ9AIGyEinBT/j6X6qVWoXFJzdebWSYR77+0G5WAhm
	 Eq5Nt3RcNcifI8w7TlrAtDvOfBaHBjV6c86Zs2tCoxCpMY7JcI9VKorIsBLlD8nnB9
	 10/mKe27TLyoQf/W9IRj7UdMvc320RuT7qyg+0Js=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51785F80254;
	Thu, 12 May 2022 16:12:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50F94F80249; Thu, 12 May 2022 16:12:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB008F8010B
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 16:12:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB008F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="svjw17Mv"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 24045B8284C;
 Thu, 12 May 2022 14:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D636EC385B8;
 Thu, 12 May 2022 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652364760;
 bh=MzRMdy8E89Q9LhenGGBwHCK3EXb+c+A7ZNlc7Me5Nm8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=svjw17MvxqNc5V356vKOxOj8HsHsSKRfyzVv66MuPZWuhgMpbcmMNe6TBANhuZdLA
 pCmPPkan5RPfb+7/54p9TtVpBGf0AaS4ug0HfXSuM2DT7kch1J+JtfZ0Z0MNJLx/Bg
 gGc9iXO0/J0nylZ+hWTZZebYLk2DGbg/JIGJXLAx7z5TjbDQ0ye43fFRSgcnSEq8Eu
 pAxYG4DlWnzSOd8J1l9BfT/wawdszuFQ+B5JArRWzqtqlq6OqlaZrikgzTrn2/uNrq
 BK8ko4DYXG6uDY5Grx16bdZFJsHDH1EUWzSRoCOM42Fht1nLby/5bsxXWY3PPEWcE+
 ToY2R63RNzzDQ==
From: Mark Brown <broonie@kernel.org>
To: ckeepax@opensource.cirrus.com
In-Reply-To: <20220510153843.1029540-1-ckeepax@opensource.cirrus.com>
References: <20220510153843.1029540-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: wm2000: Remove redundant endianness flag
Message-Id: <165236475959.1016627.2821653473768599607.b4-ty@kernel.org>
Date: Thu, 12 May 2022 15:12:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Tue, 10 May 2022 16:38:42 +0100, Charles Keepax wrote:
> The endianness flag is used on the CODEC side to specify an
> ambivalence to endian, typically because it is lost over the hardware
> link. This device has no DAI links and as such the flag would have
> no effect, remove the redundant flag.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm2000: Remove redundant endianness flag
      commit: 69b53a097d9984d93448b021e0d422f2803310bd
[2/2] ASoC: wm9090: Remove redundant endianness flag
      commit: de2427207d13d7fe1882cd1772d66e33debf999e

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
