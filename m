Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5ACC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Feb 2022 16:23:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1519C18D3;
	Thu, 17 Feb 2022 17:22:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1519C18D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645115018;
	bh=wVvGcJR4l3gt7jdAyEG+jd928oSBFZz7g56i8F4aG9Y=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ObAjJm7/35MHbGKn2tby6y/q4RZAlkFi1z0d9T6QGs4Y6Y1YLf0FZV3/YylUp6YVL
	 jI7IHu/zuvAcu3vnPW+BFLAUU5D0pboEDgUUjZ883nSVcxNR3WD7pnzlqYWRdohpCY
	 oveaktEiDGz2q9h2a/Uo6B8oISui9rtbj//nOyqg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A385EF8023B;
	Thu, 17 Feb 2022 17:22:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 221A5F80246; Thu, 17 Feb 2022 17:22:45 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7986BF800CE
 for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2022 17:22:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7986BF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j16fSdpS"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5DA4CB8236D;
 Thu, 17 Feb 2022 16:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61194C340E9;
 Thu, 17 Feb 2022 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645114956;
 bh=wVvGcJR4l3gt7jdAyEG+jd928oSBFZz7g56i8F4aG9Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=j16fSdpSMjjHy8XkFnCr0a1GZiXYg4O8hyycv/1TbWR5V/1Hri+nd4MOq8QGeeoN8
 gO5NsGLEs4WaqM5iPkBaadtA7HrasRZeqvZB2RY9Xw3ru3dR5TLWO6nNapYDefi0GE
 9zCAaouf6ZYc2Toi9H1EDxMYfCG4sqc9dbXM0aR/qQY2ptk/uYhktwBRdKfTd/Kyoj
 wq034nZhpQJlGSCY0ki1T+2/433xJJJN/j2UqczDa/Jv1DCtoJHaqlX069xwC3k6AD
 ak7BCSnm1KnYGwNDH7oxJICR0fd0p2zpUKb9lfo/akW5Vj9+wKQ2x/NtkSB2HFYxit
 mmwtD7WT8sP/g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, swboyd@chromium.org,
 linux-arm-msm@vger.kernel.org, tiwai@suse.com, bgoswami@codeaurora.org,
 judyhsiao@chromium.org, bjorn.andersson@linaro.org, perex@perex.cz,
 rohitkr@codeaurora.org, Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
 agross@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
 srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <1645017892-12522-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645017892-12522-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: codec: wcd938x: Update CTIA/OMTP switch control
Message-Id: <164511495209.1843697.14605850089293661207.b4-ty@kernel.org>
Date: Thu, 17 Feb 2022 16:22:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Venkata Prasad Potturu <quic_potturu@quicinc.com>
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

On Wed, 16 Feb 2022 18:54:52 +0530, Srinivasa Rao Mandadapu wrote:
> Convert gpio api's to gpio descriptor api's in CTIA/OMTP switch control.
> Remove redundant NULL checks in swap_gnd_mic function.
> 
> Fixes: 013cc2aea0f6 ("ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: wcd938x: Update CTIA/OMTP switch control
      commit: db0b4aedfab396a6fe631f5c3bb34319770f0581

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
