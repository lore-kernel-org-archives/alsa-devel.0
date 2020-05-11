Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D8C47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 17:22:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A27206D7
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="knzT+3vz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM/pMnS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A27206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA3149F6;
	Mon, 11 May 2020 19:21:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA3149F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589217766;
	bh=26/lzuyJSNJHTBq52yvxlizty5jVmHdqC8aFKJMIJ4A=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=knzT+3vzu4upm1wljPrvf1mLdBLX9+wbJ8FX3oeQgWXZy8viE6Y+XOrsphlcjZ+wS
	 F8UvncMXb0DuCjKbBanwRNG9AW1ujGRNS5Bo5hAjjZRWxUgoO6vPhZzxXrAg6SbFg3
	 sSsAh7QykWGTVvPtwyVz9HcB9ReZU8KtCRR8yaH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C69FF8014C;
	Mon, 11 May 2020 19:21:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81204F80157; Mon, 11 May 2020 19:21:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB92DF800B7
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 19:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB92DF800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fM/pMnS4"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 905E720714;
 Mon, 11 May 2020 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589217703;
 bh=26/lzuyJSNJHTBq52yvxlizty5jVmHdqC8aFKJMIJ4A=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=fM/pMnS4gzd9iZKxQkSoxVmuFQ0w1GVe84fQ5VXA08+KkLxlZ+dl5rhZW2jJ3xqPV
 vDFQ72HmdVqkUWVsEDPGJWw0AdyGSnxWNaj4RI8qIywnvnPvmMTpuOKA3e6SngyWGA
 SBuNa4sqlawQAdWF+BWYEfpFjxQAnGALv13+JeOg=
Date: Mon, 11 May 2020 18:21:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Yongbo Zhang <giraffesnn123@gmail.com>, lgirdwood@gmail.com
In-Reply-To: <20200511100415.12502-1-giraffesnn123@gmail.com>
References: <20200511100415.12502-1-giraffesnn123@gmail.com>
Subject: Re: [PATCH v1] ASoC: rsnd: add interrupt support for SSI BUSIF buffer
Message-Id: <158921769452.22432.14661061075576126965.b4-ty@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Chen Li <licheng0822@thundersoft.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Mon, 11 May 2020 18:04:15 +0800, Yongbo Zhang wrote:
> SSI BUSIF buffer is possible to overflow or underflow, especially in a
> hypervisor environment. If there is no interrupt support, it will eventually
> lead to errors in pcm data.
> This patch adds overflow and underflow interrupt support for SSI BUSIF buffer.
> 
> Reported-by: Chen Li <licheng0822@thundersoft.com>
> Signed-off-by: Yongbo Zhang <giraffesnn123@gmail.com>
> Tested-by: Chen Li <licheng0822@thundersoft.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> [...]

Applied to

   local tree spi/for-5.7

Thanks!

[1/1] ASoC: rsnd: add interrupt support for SSI BUSIF buffer
      (no commit info)

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
