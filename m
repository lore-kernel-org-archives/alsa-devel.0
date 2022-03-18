Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12ECC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Mar 2022 20:58:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A3A317E7;
	Fri, 18 Mar 2022 21:57:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A3A317E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647637127;
	bh=V4OSHyfOu4o/KO9DW2GDd6OSr61IpFYVtU6AC8qxpzg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fjEkCkf2X1wVMaeYg/ZqrAY6PEzn3l3iHErRcoF/zDEc/MyriMhk+Z9WKICgf/vnV
	 HkK2H+047we8x+EXeh2tC7chWyr8tSDX5AxEgoxiGfdQubfj5Y89exSTksQBoeTjW2
	 kyv+g5lMSgF9Jk5ZFUvMF/uZDbuxCvYQxWKOU4sU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A746F80125;
	Fri, 18 Mar 2022 21:57:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01C04F80271; Fri, 18 Mar 2022 21:57:54 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DC07F80118
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2022 21:57:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DC07F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="R8KnqL3l"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A2C2160EE8;
 Fri, 18 Mar 2022 20:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831B0C340ED;
 Fri, 18 Mar 2022 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647637070;
 bh=V4OSHyfOu4o/KO9DW2GDd6OSr61IpFYVtU6AC8qxpzg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=R8KnqL3lbzAbRqVEnAHgMUVQOda4ULxu+k1FJvxSsXabvOwm66pKUCgUmViWEHRZh
 oi3K0ZZetJfEW+Ab7gYQLicXP0EaV0i/mJ3FxtvPlKf8xKVDcQN4EpGmwNfLFPQ+7V
 fzNg/2xtdSy9ImA12olArM85adR2w1/cEtVCUxjT3lh/VUE2S8v+tA23CkfqqGl8pC
 4oSCbWMSkplPhM6S8Mer1rE2wLJ04oCZWyG+EbhJe3KFlxXjQ867u3NfCWkXDryUEN
 8tEWR5QRtJytUhH75xrl8Nr5MGPQwAcjzTDJr5e1Pb7DZVjb7YWpzK4tc4ilAIS7bA
 /0TD+qFDyRKGA==
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>, shengjiu.wang@nxp.com
In-Reply-To: <20220317041806.28230-1-nicoleotsuka@gmail.com>
References: <20220317041806.28230-1-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to maintainer list of
 sound/soc/fsl
Message-Id: <164763706824.2336370.5050558733573751779.b4-ty@kernel.org>
Date: Fri, 18 Mar 2022 20:57:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
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

On Wed, 16 Mar 2022 21:18:06 -0700, Nicolin Chen wrote:
> Shengjiu has been actively working on latest FSL platforms and
> keeping upstream effort as well, while I have been working on
> other subsystem lately and cannot guarantee audio patch review
> in the near term. So replacing with him in the maintainer list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add Shengjiu to maintainer list of sound/soc/fsl
      commit: d1129bbe141bf08c19d44a701869ac0780754e86

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
