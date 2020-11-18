Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F0C5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 21:02:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14652467A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 21:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bi2BJig9";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGNVT6Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14652467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2126A1745;
	Wed, 18 Nov 2020 22:01:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2126A1745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605733327;
	bh=a7U2C6v9GVw424t93GzLhDnAmyo5rTt0U8ggDVQHPNc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bi2BJig9zfvbCis/LFl4UpHs5Jq1TmT7EpP6K0Md6SKhe6A498MMBkEh8+VoKnUCS
	 XJQQs+QqQlsKOEl03/olmmjCjzLJIP+l5jhONKjTiE+X8t/HWSAL/e4SXYa7cxSfiC
	 o/u+OSwMd8hTkOvnu16Be0fEAX8NThNeLfKZcWDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3704F804D6;
	Wed, 18 Nov 2020 21:59:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C35F5F804C2; Wed, 18 Nov 2020 21:59:40 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F02ECF80276
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 21:59:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F02ECF80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VGNVT6Pb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60F61246CA;
 Wed, 18 Nov 2020 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605733176;
 bh=a7U2C6v9GVw424t93GzLhDnAmyo5rTt0U8ggDVQHPNc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=VGNVT6PbRD5ZSvhWK+DD132RQ8L6fi0PAchfARO199l2reE5tjWIt/dnVBWKk7DOf
 t6onpdmbau6n1JopMwyLRO/ZLRv3WPhx0oUInSCbY8Qrqegdu6Gsm+/MffFvZBUeQ4
 nyDuGE4bRylQuz3C07pwPv8qYi6bw7IZgwCvt1c0=
Date: Wed, 18 Nov 2020 20:59:15 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 tzungbi@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mediatek: mt8192: revert "add audio afe
 document"
Message-Id: <160573314459.46437.12225896346683178113.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: shane.chien@mediatek.com, Trevor.Wu@mediatek.com
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

On Wed, 11 Nov 2020 16:05:20 +0800, Jiaxin Yu wrote:
> This reverts commit 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt8192: revert "add audio afe document"
      commit: 7d94ca3c8acd0117200f34523536ee01615e7dc3

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
