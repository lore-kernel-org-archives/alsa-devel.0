Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E36C352A1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 17:40:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8383E18A2;
	Wed,  7 Dec 2022 18:39:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8383E18A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670434819;
	bh=8QWEQn+zKzCFj1WRsl+nO7lAaKxvMO0yYD7CsBPujQE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Av8pzVEEtcy0E9OEIW8pZQ0xg62ev9YDeV3I4HNbdRHwpzHThEI5+AvUszO/Og8EB
	 OxqOdRBa16nTrOktA73SVaqBRgvxsUiFRjNaG7SHCMEQhZi1iDJKyT038lUNFZ0G1v
	 pEhxSY54jXkk+eKJO1dnAZUMs8ezhtwpSay+yzFM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71076F8057E;
	Wed,  7 Dec 2022 18:37:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F949F80578; Wed,  7 Dec 2022 18:37:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7E02F80566
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 18:37:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7E02F80566
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ReRQ0peI"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4921DB81FE8;
 Wed,  7 Dec 2022 17:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B249C433B5;
 Wed,  7 Dec 2022 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670434672;
 bh=8QWEQn+zKzCFj1WRsl+nO7lAaKxvMO0yYD7CsBPujQE=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=ReRQ0peILFdvUb8wufK8d2EnzPSJhzPn9TjYRfXAlEmvz+GrhL+OS7HXX6vFXij9a
 LoJyUsn/96/R9fXkV/lAepwqPPba0NV1yuVxu65XqZHrp3AN4K3kiWiqEA5HV4ICPT
 FkCj5+/6Wfo3GCkm7fq2mAsJkH6wUm/TcihgceKxr2Pz365hJcKK5xQsjGpAo3LNMi
 nA6owA7Jek2ygIlmYp+dMVncFFwZLtGzh37gPcDW+a/XrK0PBRa9qLZyDsu8yjgm9S
 Cinon+hXXL4+wb/jtNz1Aiv/Q2cXqlZX8G2CIKcdUuymTB7ZME0xs7ob+DtTnvq9H9
 m66xmZctzNnSQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de,
 sugar.zhang@rock-chips.com, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Wang Jingjin <wangjingjin1@huawei.com>
In-Reply-To: <20221205032802.2422983-1-wangjingjin1@huawei.com>
References: <20221205032802.2422983-1-wangjingjin1@huawei.com>
Subject: Re: [PATCH] ASoC: rockchip: pdm: Add missing clk_disable_unprepare()
 in rockchip_pdm_runtime_resume()
Message-Id: <167043466982.393374.17030767228632271968.b4-ty@kernel.org>
Date: Wed, 07 Dec 2022 17:37:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
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

On Mon, 05 Dec 2022 11:28:02 +0800, Wang Jingjin wrote:
> The clk_disable_unprepare() should be called in the error handling of
> rockchip_pdm_runtime_resume().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: pdm: Add missing clk_disable_unprepare() in rockchip_pdm_runtime_resume()
      commit: ef0a098efb36660326c133af9b5a04a96a00e3ca

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
