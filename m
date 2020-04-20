Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D3C3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:19:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E199206D9
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lxDTyKKB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2uPBVK41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E199206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 946AE1677;
	Mon, 20 Apr 2020 14:18:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 946AE1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587385139;
	bh=GD6yKftMiFUcgIV6wTVwHE7yEFYw9iJR2KXH1JFWqIo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lxDTyKKB0FFxpTkv/UobcThA1cEnwDZ0Psj8ll6Bb3WrJX/mYEsG2av6SPE7c4xB0
	 GdV5yjo5zHDpCd5pAPkh3OEyJQLxSiBPNqzEq1s1KA7QUFl7kXEEfcQTaijzpm1D6/
	 t8X5FLetfr1hxWRHgdPwGO+62R/iDYrToMY6UefA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B2BCF800C8;
	Mon, 20 Apr 2020 14:18:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 134E5F801D9; Mon, 20 Apr 2020 14:18:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44530F800C8
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 14:18:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44530F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2uPBVK41"
Received: from localhost (unknown [171.61.106.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B69EC206B9;
 Mon, 20 Apr 2020 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587385081;
 bh=GD6yKftMiFUcgIV6wTVwHE7yEFYw9iJR2KXH1JFWqIo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2uPBVK41YVu/dXIrss/tCWROOew4ZD1hUthru4+AxfzYQwR1g4lhcy9WiA0hXdSW9
 Z7tDa5Q/wN4FSL4cjaRYUunfcsIDyIQSgXP/Gs9pYGtFG0e7O1jKtNEe7j3BlJiBYo
 Ph6UcHZLSqRdwGrixHNA032YLFoWHzzMS7r871uw=
Date: Mon, 20 Apr 2020 17:47:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420121752.GY72691@vkoul-mobl>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
 <20200420070816.GU72691@vkoul-mobl>
 <20200420120348.GA6507@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420120348.GA6507@sirena.org.uk>
Cc: linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 20-04-20, 13:03, Mark Brown wrote:
> On Mon, Apr 20, 2020 at 12:38:16PM +0530, Vinod Koul wrote:
> > On 20-04-20, 16:01, Kuninori Morimoto wrote:
> 
> > > Now ALSA SoC needs to use asoc_rtd_to_codec(),
> > > otherwise, it will be compile error.
> 
> > Applied, thanks
> 
> This fix is needed in the ASoC tree - are you OK with me applying it
> there?

Sure..

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
