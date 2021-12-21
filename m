Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F029C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 02:54:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94808176B;
	Tue, 21 Dec 2021 03:53:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94808176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640055284;
	bh=Fhuf2bqC66bUEidwQH3UzUgFbxEW2XnM6iI70FqfJVI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qKw5RAZVlyKVXcg1qFMy6GKTeWPCCCO9AaSvK1O6FWlp0LuKBKSr0BpaFcKOyAGWZ
	 xXJtBfbsyZ+6ZxWzEN8c45LTNUOUaPiom2L27qNrmthx/2UmFP+3sbvZb0RS6GVJeC
	 U+a4IBuLCXsyKqBA0VqYqvBXGh8haMsLKO5uPYtw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11A79F80539;
	Tue, 21 Dec 2021 03:51:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAC1AF8051F; Tue, 21 Dec 2021 03:51:00 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86C3AF80516
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 03:50:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86C3AF80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="InUTiCl8"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A296CB81120;
 Tue, 21 Dec 2021 02:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B740C36AEB;
 Tue, 21 Dec 2021 02:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640055055;
 bh=Fhuf2bqC66bUEidwQH3UzUgFbxEW2XnM6iI70FqfJVI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=InUTiCl8v+Z5Sm1v5DDrrtxAWE1ZTfNENab03Hn7ozhfJNoQZQyraXW5D5q7dj1s4
 31xghjOLOm6/xoJYTF4zrjm+v76K3YEY3OHP9YlG4e2zR7llGhsGXeeLnLGTb5vTCT
 CtQSYud2pYe5e5fHtamHlSq69VBaSk62YSqSn+9VLIsJNYw1nbxiR1hQWBZgErco7t
 VTHifti2+N/HWWfjA2Pl/mpHf/+OUV9JHA1hAm4QTYAqnV9+G5eNCNf/4G0n/gepzj
 Xb6qcNriF/zZ/9PB9cxqK6iHyJ/BuTw3mXjh3LjU5b3MouqzIqrMGvx5zyGlNpjZLl
 1RRDx5qoteUdg==
From: Mark Brown <broonie@kernel.org>
To: Ricard Wanderlof <ricardw@axis.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2112151759170.27889@lap5cg0092dnk.se.axis.com>
References: <alpine.DEB.2.21.2112151759170.27889@lap5cg0092dnk.se.axis.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: sound: tlv320adc3xxx: New codec driver
Message-Id: <164005505377.2647792.3979001225457179227.b4-ty@kernel.org>
Date: Tue, 21 Dec 2021 02:50:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>
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

On Wed, 15 Dec 2021 18:01:24 +0100, Ricard Wanderlof wrote:
> DT bindings for Texas Instruments TLV320ADC3001 and TLV320ADC3101
> audio ADCs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: tlv320adc3xxx: New codec driver
      commit: e047d0372689f5d4231eefb731b60ac64720bbf0

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
