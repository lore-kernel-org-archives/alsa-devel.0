Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F6C63797
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:18:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81836128D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81836128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 826DC16D4;
	Thu, 22 Jul 2021 16:17:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 826DC16D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626963485;
	bh=EMz3MoIH6oilj/w4Eak46dXF6qgmQ7i1PkMKQ+PtdmU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZsEEmStoD4cEw03e4dZjoULAM7FtfqW8ykE/cYCHg29hXHinffNDgviBPkwlNNnI
	 3+tgze6zL0c5icCnbzvufZa5o3Wo/9/RARmgjh2vYVDJBeFkMn8iwgelIk86XqB15s
	 foy60GopIfMzexSCcsDGXp+oZCz+pNks6qMdQ7NI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24F71F80218;
	Thu, 22 Jul 2021 16:17:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD5BDF80227; Thu, 22 Jul 2021 16:17:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79C11F800DA
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 16:17:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79C11F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Iagwb3SP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED06A6128D;
 Thu, 22 Jul 2021 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626963425;
 bh=EMz3MoIH6oilj/w4Eak46dXF6qgmQ7i1PkMKQ+PtdmU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iagwb3SPOUuPeZ+DkZCOSQzpxLQevduQVSPZAJuRQnQYSRtZypPuiW5mLsdpAHUPJ
 z/Xb1keQTvNLQZs1e5yF0Gu+yJfyZ8e8I9uaJGxCvC9MhbJKLGMx3j7BPv9h3tDDE3
 6W1B2QPN5tD33EBnZj1LqENFW9i7f+LTUpQqDAqLZwSKpSKAsLae9wt3U8DI+s/E9M
 HJQjG3h9FNAFIwZ/bjMdDwd5qVq47apMTlRXF0RCwJ5bh8UiSOxIbJpH225Ptqf/Cm
 EmyRjjhuaBhcW4XP778U4wmm8JemIVU9H2m2yZH9ztOD8x1a9dlqk9k0XVY3iPNOBZ
 CTAYrhYo29PXQ==
Date: Thu, 22 Jul 2021 19:47:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus: filter out more -EDATA errors on clock
 stop
Message-ID: <YPl93hm715Nm6ZEe@matsya>
References: <20210714014209.17357-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714014209.17357-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 14-07-21, 09:42, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We've added quite a few filters to avoid throwing errors if a Device
> does not respond to commands during the clock stop sequences, but we
> missed one.
> 
> This will lead to an isolated message
> [ 6115.294412] soundwire sdw-master-1: SDW_SCP_STAT bread failed:-61
> 
> The callers already filter this error code, so there's no point in
> keeping it at the lower level.
> 
> Since this is a recoverable error, make this dev_err() conditional and
> only log cases with Command Failed.

Applied, thanks

-- 
~Vinod
