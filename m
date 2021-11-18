Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDDCC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 19:08:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE6861179
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 19:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEE6861179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E82D1832;
	Thu, 18 Nov 2021 20:07:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E82D1832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637262481;
	bh=lrQXLGoucITfjQn5uVEsfBONwOxznfVVuvtAaJyD/90=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D04iwx9N64JKpuPIvpn1C51GlEGD9FuT2I6pbkrK0WHtBcUVl9TnmodywP7FBqubP
	 +CnhO/IehRkPdLXMp4KjLSGSMYYmGVDcft2956yRlxpZXKgv0S/FOEdiy38G6rpuZF
	 j4See/tLMck40YwG/SsunBOAe7jsAG7HkIRD8Pcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D183FF804C3;
	Thu, 18 Nov 2021 20:06:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A516EF804C1; Thu, 18 Nov 2021 20:06:22 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28033F800FA
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 20:06:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28033F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P1ePkJJC"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3EC161B04;
 Thu, 18 Nov 2021 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637262377;
 bh=lrQXLGoucITfjQn5uVEsfBONwOxznfVVuvtAaJyD/90=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=P1ePkJJCikKeYrGJ/a8zd/euNU1R/RZLpiajZIAyjotJoWtkIoEdFyqz3rt43uffd
 Q94vWeDzVpGL5xCu6Ky5XjPgP25JVVOWVRl6PoXr++vTyogK6zdIhACbwnDU24e+pP
 VXrobUniflyQIx3ZFqiWrmEU5KrETj/5QkpgPRvO93+JoNCB2DSb4scGTqE/l0XPwS
 nfsKCZ5W3QMyUGWB+31MFpzwgCQ/hhBA+RVMM4ZIptWBJRhiAfDQIQZx1zaNV9cqUh
 hBEMejqNHtDnRuh9FnySLY4J5PMRyj+WhtIc1Xa0Y6kR9pAP6txJGVq+Xa+m3kgw/u
 NqUcbYf+bCGLg==
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, lgirdwood@gmail.com,
 linux-arm-msm@vger.kernel.org, rohitkr@codeaurora.org,
 alsa-devel@alsa-project.org, perex@perex.cz, agross@kernel.org,
 srinivas.kandagatla@linaro.org, swboyd@chromium.org, plai@codeaurora.org,
 judyhsiao@chromium.org, robh+dt@kernel.org, bgoswami@codeaurora.org,
 bjorn.andersson@linaro.org, tiwai@suse.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <1637234411-554-1-git-send-email-srivasam@codeaurora.org>
References: <1637234411-554-1-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH] ASoC: codecs: MBHC: Remove useless condition check
Message-Id: <163726237329.96213.5010626132541741636.b4-ty@kernel.org>
Date: Thu, 18 Nov 2021 19:06:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>
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

On Thu, 18 Nov 2021 16:50:11 +0530, Srinivasa Rao Mandadapu wrote:
> Remove redundant conditional check and clean code in special
> headset support functions.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: MBHC: Remove useless condition check
      commit: b38892b5b85ae54b7b867313996f967122ede42e

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
