Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E62C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:29:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE33160E9B
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE33160E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92DD41F3B;
	Thu, 29 Jul 2021 01:28:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92DD41F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627514967;
	bh=V3zJBaFzTHNYxbidYGufcLlftR+KGFH0ek4HfHUjcBo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=erS1K8TIeFvjvPJRdHmm3ldbaaqGka65mvmNiVVOwJZbGfheNNfZQCRb+UyvquoFi
	 57nKyKdI3dN3dHsnMXKTlVusCT4jbQ8VRFKjBx2ZGeCQPy4SLQOs17VDcVMndpBzXa
	 TkhhzBfRjFRJ4yBOxKEL/RHIgE5J8OPJWEQBgdyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BA94F80253;
	Thu, 29 Jul 2021 01:28:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F117FF8028B; Thu, 29 Jul 2021 01:28:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89B68F80212
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 01:28:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89B68F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qZ6UI2Ev"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA21B60E9B;
 Wed, 28 Jul 2021 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627514893;
 bh=V3zJBaFzTHNYxbidYGufcLlftR+KGFH0ek4HfHUjcBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qZ6UI2Evos2kGn60ionklymKHYjP60FqjpzLBozWzosPm661HOFUczbRptFkB0R1p
 LxPDdVLgpp9zbVGqRFGjkCQKTs4qS0+Vq5eFAYe8rkuniVqhDnmFwEKUdcXRCsdDxu
 kkRTFkh5JNr9oDp8+PyvXYAFjLy/2oTv1m7qEYgjbwjGr+8RfFznKvzwJIQZOUxeZF
 AFUjESw7E6H9T4DP3uICBQgaCtCZ5DweBkQp3GcQ8dHtIT6GQ3JQi0N2lNQmUDp/5R
 bcwQ8h6EZR1MEtEU16FlEcqP9GFhUes4I6OXoCjGXyi3SOIYY3S7Sq6G0Q7fc7Jpis
 M0udWRm9exdDw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, sbranden@broadcom.com,
 Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz, rjui@broadcom.com,
 lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: bcm: cygnus-pcm: Fix unused assignment about 'rc'
Date: Thu, 29 Jul 2021 00:27:53 +0100
Message-Id: <162751391069.10122.16132233496782994388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728124411.3168-1-tangbin@cmss.chinamobile.com>
References: <20210728124411.3168-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, 28 Jul 2021 20:44:11 +0800, Tang Bin wrote:
> Delete unused initialized value of 'rc', because it will
> be assigned by the function devm_request_irq().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm: cygnus-pcm: Fix unused assignment about 'rc'
      commit: 14db5499d583e0952606fbca3eb37a0f28008d30

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
