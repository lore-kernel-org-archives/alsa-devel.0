Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D593C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:36:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C822083E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q7hEjvRp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixsUV6i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C822083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EFEA1695;
	Mon, 22 Jun 2020 07:35:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EFEA1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592804165;
	bh=buogNVymtxZczQRvv8+g2nbdqd82HeUu7XS5fvcsNUM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q7hEjvRp+WQHtq9nmqX8ui2xXN8HPmobI1vh4cTQ53EaJnIuUza6lda5ND+M5jq5h
	 ENHUjBbR2z5zCoFCgFaQy9xmqOBYNCczYioqikZ1fdmH3sN7nLdT+6ln5TONLRWP6f
	 ip0dX5ew4WUQjYmkR6J71LbuwflJXByVWNpTcc1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F4FEF8015A;
	Mon, 22 Jun 2020 07:35:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B945F8015B; Mon, 22 Jun 2020 07:35:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 585FDF8010E
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 07:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 585FDF8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ixsUV6i0"
Received: from localhost (unknown [171.61.66.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6AB7A25403;
 Mon, 22 Jun 2020 05:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592804106;
 bh=buogNVymtxZczQRvv8+g2nbdqd82HeUu7XS5fvcsNUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ixsUV6i006rFSF+BM2wZPMzJv+W3L5HSubsSio34AulKk4MXs2Zb7H+/kNttBvXiM
 SwXB5XtJo87eWhierQ0slWFCy2kP5p+1akvFfW9tEqmefbq2Op1Q90NPSCEHM+tg0R
 vhlfcxdyuaD45ZqJCoRSPauOdqisrQDccUFivVuc=
Date: Mon, 22 Jun 2020 11:05:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/3] ALSA: compress: fix partial_drain completion state
Message-ID: <20200622053502.GF2324254@vkoul-mobl>
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-4-vkoul@kernel.org>
 <0a0fcd4c-40dd-621e-b0ad-51296178aa9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0fcd4c-40dd-621e-b0ad-51296178aa9e@linaro.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
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

On 19-06-20, 10:13, Srinivas Kandagatla wrote:
> 
> 
> On 19/06/2020 05:54, Vinod Koul wrote:
> > On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
> > state, so set that for partially draining streams in
> > snd_compr_drain_notify() and use a flag for partially draining streams
> > 
> > While at it, add locks for stream state change in
> > snd_compr_drain_notify() as well.
> > 
> > Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> > Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for testing Srini

-- 
~Vinod
