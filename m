Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC51C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 22:24:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64FA7185B;
	Mon, 28 Feb 2022 23:24:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64FA7185B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646087093;
	bh=kmmO+RzqRGfoiBuIIpliqpBCDbphzDc2IaMtK0kWQck=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/BJZw5d12orAMaVEYBe1pw8fl18M6/1HxZTRh110UxVVLVzcvv6BW21INrEaKFjX
	 ME26YLYGuBRYnAJH2/iyAQd+UC9NoLWTYz8XsiQYU/+XOjFRdC4+eZ4w1bOPR+BCNt
	 KwtAI8zeLBbRxp122/1NwAofe6H8f2WksOxjMNNE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D88FCF8013C;
	Mon, 28 Feb 2022 23:24:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EA3CF80154; Mon, 28 Feb 2022 23:24:01 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8A7FF80054
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 23:23:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8A7FF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bi3YjKzx"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95D89B81696;
 Mon, 28 Feb 2022 22:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B637BC340EE;
 Mon, 28 Feb 2022 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646087034;
 bh=kmmO+RzqRGfoiBuIIpliqpBCDbphzDc2IaMtK0kWQck=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bi3YjKzx+OWycH2I+7UzWSMgXJIQNyAdTLV1/+Jp8YfJLfGON6ffAlpIzMwoq/4fs
 V41+A/NfE8U35LEGEgfIE6w+4qjysElj3nfOJZc6xPYUe4zDOCGgNeq5LpKZyJJdSX
 XqJa0uIVWdOBFXij7bAwEUmkxJThQqcP7G/vhBb/V9XXvw3CaAbwOamoVCBKdfL+kF
 iioHbxfqe7ZhTpfZaR2Vc0N7nkVh1gPiVTgJXwcKV31w/intcyG+4ziQa+Hq/o/UHW
 MmfV/tXTHFBJu571PKT0O2iF7EAPE845Zoa/tceIxCb/k4uk0GhsiVq0lbk9tPaFZP
 FB838omNDlorg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
References: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3] ASoC: codecs: wsa881x: add runtime pm support
Message-Id: <164608703245.3143764.4501147946855964018.b4-ty@kernel.org>
Date: Mon, 28 Feb 2022 22:23:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 quic_srivasam@quicinc.com
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

On Fri, 25 Feb 2022 18:07:16 +0000, Srinivas Kandagatla wrote:
> WSA SoundWire Controller does not support Clock stop and performs a soft reset
> on suspend  resume path. Its recommended that WSA881x codecs connected to this
> are also reset using a hard reset during suspend resume.
> 
> So this codec driver performs a hard reset during suspend resume cycle.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa881x: add runtime pm support
      commit: 8dd55245836119ee3636543b6c2597efd78e643d

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
