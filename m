Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6AEC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:08:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C4823772
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C4823772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B71B183B;
	Thu, 21 Jan 2021 01:08:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B71B183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611187731;
	bh=HEKEkHysRBuy+PeeILPFJYalzK0RmedOTwrVoRREE8c=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DuHD6YDYiZkiYVuaGx6TiMwtXUw/tJ6KhPtPQT+RhP6qhW5m5p9gfGHw4kH9lOpUN
	 71lCCYa/lolKr6afLwUnZMVJPAlDg1JEwnh2wdYNTSFRTMrgRdYIPg/khgIxeKdQH4
	 oFH0bigc7lNye2VU9vLUysS3becNYEFheYg45zxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E08B4F804CA;
	Thu, 21 Jan 2021 01:06:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57AD6F804CB; Thu, 21 Jan 2021 01:06:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F9EAF804BD
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 01:06:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F9EAF804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="upMOudlv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D695023718;
 Thu, 21 Jan 2021 00:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611187598;
 bh=HEKEkHysRBuy+PeeILPFJYalzK0RmedOTwrVoRREE8c=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=upMOudlv+WUULDlia6UY3uV0AGbhzfW5mDLZBDMntNTjVU95pZwKM8bjAObC29O+O
 xpJ1P1Dngb8ln6ypxdl5SZsS1L4PcCFWPx8UoxZYZtPcJg+m3ieY8VfpQN8eKAf3bQ
 f9wzRtahsTu29rCOce2Mgz0zyZTJKl2e9ShJdJimgbrrCp8LaJrbn6bgQOHuQlL2nT
 7584sXJd3iDkRtLOusahYXP/crpSupz2Vz09naxrKWNZFbRlRBTaKs0bEmenw3OVLu
 JPnhM1aoPxzxxq1NPWju2JBxlh65lS28aKpDe0zWjRspndpki0xpVFJEk11zoMxY0P
 RYtQ9sBu3pTvg==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@ti.com, lgirdwood@gmail.com, tony@atomide.com,
 Pavel Machek <pavel@ucw.cz>, perex@perex.cz, linux-kernel@vger.kernel.org,
 tiwai@suse.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
In-Reply-To: <20210112174704.GA13496@duo.ucw.cz>
References: <20210112174704.GA13496@duo.ucw.cz>
Subject: Re: ASoC: cpcap: Implement set_tdm_slot for voice call support
Message-Id: <161118753482.45718.9232559568095752872.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Merlijn Wajer <merlijn@wizzup.org>, "Arthur D." <spinal.by@gmail.com>,
 Sebastian Reichel <sre@kernel.org>
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

On Tue, 12 Jan 2021 18:47:04 +0100, Pavel Machek wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> ASoC: cpcap: Implement set_tdm_slot for voice call support
> 
> For using cpcap for voice calls, we need to route audio directly from
> the modem to cpcap for TDM (Time Division Multiplexing). The voice call
> is direct data between the modem and cpcap with no CPU involvment. In
> this mode, the cpcap related audio mixer controls work for the speaker
> selection and volume though.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cpcap: Implement set_tdm_slot for voice call support
      commit: 0dedbde5062dbc3cf71ab1ba40792c04a68008e9

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
