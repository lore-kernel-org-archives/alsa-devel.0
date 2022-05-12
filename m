Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A88C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 12 May 2022 14:15:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E99921AB5;
	Thu, 12 May 2022 16:14:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E99921AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652364914;
	bh=lG75f7u0FOqEgFZ07a5DYCoxWItDAZ8O3d88rmBiq6E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ATvQbxk7Wg121juGMbb7N5FCauly6fU9pQtVm0ivnHjQonzGt7PYP1nwTTFj7A9dz
	 ppK37jFHqXGL+xuM9remG8NKWOUQ7nqb5nDhXUXlMEtJnmGVHY3SDPfIoEQefCl2uu
	 FFUYkz6ARhzJrblrGrJpNsAWt41p8IRZkQeg9qHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F23F4F80528;
	Thu, 12 May 2022 16:13:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBD07F80526; Thu, 12 May 2022 16:12:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73794F8051A
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 16:12:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73794F8051A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b5kJwuzD"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 00FCB61AD5;
 Thu, 12 May 2022 14:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E693DC34117;
 Thu, 12 May 2022 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652364774;
 bh=lG75f7u0FOqEgFZ07a5DYCoxWItDAZ8O3d88rmBiq6E=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=b5kJwuzD1lOZhBAXIcqO8oOT9HXbyUpXcSwfFc89H4yP4l4hnclrC3gTybPcExclI
 t0KnaO48RSag9HkYSggtIEsjXjtCbVdZdPYevcRYqzWDhSPY0PlXrulVYce1rXw1o8
 zZ1mBU00sjYdFFsVcRU29zxC32jTiYXCjWcNXfkGMGybHod6e3l3nluSOWKqEl8Nch
 5M3YaGLOo5rbQIs0SHEswg73X7v0FQ2+OOSe53BNSZxHLFYhpAwZ3J9KVdqXT9ptrI
 q4fsKRWlFaJa+nBuSqF+h+m9KOiygo2iZ3a+Q38a8akrjAR7wjbkYh234QjiIRqiTH
 QBxQOD2IrYgug==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org, jiasheng@iscas.ac.cn,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-imx@nxp.com, linmq006@gmail.com,
 shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20220511133725.39039-1-linmq006@gmail.com>
References: <20220511133725.39039-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
Message-Id: <165236477165.1016627.13757710006354879246.b4-ty@kernel.org>
Date: Thu, 12 May 2022 15:12:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 11 May 2022 17:37:22 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
      commit: 2be84f73785fa9ed6443e3c5b158730266f1c2ee

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
