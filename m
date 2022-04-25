Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46413C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Apr 2022 17:27:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FE561813;
	Mon, 25 Apr 2022 19:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FE561813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650907648;
	bh=oYA/5qwVt2no/9pKCd4CNdLbo4ChI1dy6z3kzNC4xfw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sijF9CrjPIIB5EKZYjU14rfYb1dTmxZjpS7tACSjg3hFThuo4B3YI7q7u+gfXYuVx
	 E2eZjCmsyYCcMVCy9ZwX1bjuy/wKzAM5BvhYKOBm70IE5HJqk5P8P8rEcDlMnukMa7
	 FmAh4u41ngr10eunAZpbkGMPlQWXrelBXpGi1Hg4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 542A9F8053C;
	Mon, 25 Apr 2022 19:24:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86E90F80519; Mon, 25 Apr 2022 19:24:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07218F80510
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2022 19:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07218F80510
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kAy0HdU/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CDF1861501;
 Mon, 25 Apr 2022 17:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F472C385A7;
 Mon, 25 Apr 2022 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650907467;
 bh=oYA/5qwVt2no/9pKCd4CNdLbo4ChI1dy6z3kzNC4xfw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kAy0HdU/w0/d/I4tT+cLgSLNN16EMTMF2gTydmhfp+DmBu90/3CqAD2u/zHySvuwo
 6FMSAX1O/mYTprgb6Yb6kF5VtTU/fpaLDZnfv9RPxzs1SFBxSXbwzWfzOlP8rRlqI1
 0jGfpp+2MIcguiIX/CXyJK591EHuW7l2hYFO7iQjhgKP2XZCtAyA4/d5iXhKEVScqD
 /jEQV7OUaenrGgxKr4OA6zRiw5VgoNw1S5YypqDKEaR9ow5h3f6vw7K7gshzKcA3X+
 tnBmUe5bJnF4TsaFyPAckzEMQoQo+I+hk1pz19BE9OjjSfkUr784MBEwL3BIJUWkmY
 uSo62ManH0Cmw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, perex@perex.cz, biju.das.jz@bp.renesas.com
In-Reply-To: <20220423164443.146299-1-biju.das.jz@bp.renesas.com>
References: <20220423164443.146299-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] ASoC: sh: Make SND_SOC_RZ depend on ARCH_RZG2L
Message-Id: <165090746497.583823.16541884820378976603.b4-ty@kernel.org>
Date: Mon, 25 Apr 2022 18:24:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, geert+renesas@glider.be,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
 linux-renesas-soc@vger.kernel.org, Chris.Paterson2@renesas.com,
 biju.das@bp.renesas.com
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

On Sat, 23 Apr 2022 17:44:43 +0100, Biju Das wrote:
> The SSI block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L SoC's, so
> instead of adding dependency for each SoC's add dependency on ARCH_RZG2L.
> The ARCH_RZG2L config option is already selected by ARCH_R9A07G043,
> ARCH_R9A07G044 and ARCH_R9A07G054.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: Make SND_SOC_RZ depend on ARCH_RZG2L
      commit: cc691ba94cf8d6c586076ed489bb9d385a2650ad

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
