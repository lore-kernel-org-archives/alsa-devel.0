Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE23CC43217
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Nov 2022 16:43:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 842DE167D;
	Tue, 15 Nov 2022 17:42:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 842DE167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668530609;
	bh=LNHlirObCpIamiHi9qypUAFL9NzP+pKUa7A+X+ZOUOU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhkVi1t9hzNfiV/IK3iNW0cg/kKlt8WwzOWtL6U7TmAUXpwR2pDhBEuyKIXeG3SvA
	 jpQxuerSpQVrUWqNfSOjo8XAcomTl/qhDWuAKRUu/XCG4NVjB1K27pYcUpjXIvupCi
	 PFzl21pRGBRWvGKTsZCC1a9uJIpI6vbCZRnq3Y1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00267F804C2;
	Tue, 15 Nov 2022 17:42:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 295DDF804C2; Tue, 15 Nov 2022 17:42:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E3B9F800AA
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2022 17:42:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E3B9F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="if+8LcdZ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F307E618F3;
 Tue, 15 Nov 2022 16:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73785C4314D;
 Tue, 15 Nov 2022 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668530531;
 bh=LNHlirObCpIamiHi9qypUAFL9NzP+pKUa7A+X+ZOUOU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=if+8LcdZ9DIbe+56rjY2IIv+yE91gFSlSJ1DOOlZv3gZMw8bY/e0WwCA6QKD22STf
 c6p/tgl8JcjjRr4SmBgHImVrSOqTSNJoNKapBsOTztoZLJP+pCTNDDXopROMaK3i6Q
 BlagDP3ZBehy83Sxf4yhWc+y4k4wmPedpZ9yQWBAwW2mEfrV46S10FXjTCWT6lmnEi
 4KVmH3WAX8kkrI4J58690z37Ei5wHr/ccvBBH0LPgqvpvNerPDDHTgAfQvO5ME5IcZ
 80rC6mJdbxnHFDgtTvnvFeHhl7HPi907vHOEgB1yPEUIEpbDERZDs2tUpwhZs9c06R
 ixJHM+VSXNigg==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, lishqchn <lishqchn@qq.com>, perex@perex.cz
In-Reply-To: <tencent_59850BB028662B6F2D49D7F3624AB84CCF05@qq.com>
References: <tencent_59850BB028662B6F2D49D7F3624AB84CCF05@qq.com>
Subject: Re: [PATCH] Asoc: core: fix wrong size kzalloc for rtd's components
 member
Message-Id: <166853052864.230692.17624573785284559319.b4-ty@kernel.org>
Date: Tue, 15 Nov 2022 16:42:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com
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

On Tue, 8 Nov 2022 12:24:56 +0800, lishqchn wrote:
> The actual space for struct snd_soc_component has been allocated by
> snd_soc_register_component, here rtd's components are pointers to
> components, I replace the base size from *component to component.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] Asoc: core: fix wrong size kzalloc for rtd's components member
      commit: 66a796c04b639e2658b4d820dd5fbc842c8c3aae

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
