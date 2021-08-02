Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97632C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 03:51:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488E761050
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 03:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 488E761050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 321D71773;
	Mon,  2 Aug 2021 05:50:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 321D71773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627876287;
	bh=opJ5gu9x7UciOeMeynSO0qidOZojcFELh0cNar5tv/I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X+MMKwhvi6ZrDGzbVeOnnSh0FtUqcP3A4BBLgRT5u6ELYrrT5QqIJf8uGr28mvMV/
	 8Wap9JlvqZiXJ4Ol4WCNRk+CRkw0aTKRWfoD/a+cEDXjHFoSOP3VFH04qUqFRecsYg
	 dMscGbMAfJ62n7Yku1l+IeEq7VR73j2aT5iobA+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FE3BF8025F;
	Mon,  2 Aug 2021 05:50:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4963F80268; Mon,  2 Aug 2021 05:50:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5378FF800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 05:50:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5378FF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qFeaS362"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B740660EE3;
 Mon,  2 Aug 2021 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627876224;
 bh=opJ5gu9x7UciOeMeynSO0qidOZojcFELh0cNar5tv/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qFeaS362ZUS5m316imhTVo9z0CVK3McRy3h1KCr5ib7dNnMJ2ZgJ6DJ9JpjBxbfKA
 4dLLQbE1ZpKI2jSDO7JJPwsE76z7S26pPC+qymP3LL2nRd6lPpW5dIBbUthBwf7cA2
 wMDYdRvKXjavH1q46GhJPh+8gqQjGMLt2uMh4JKzxMZbaYiSFlhTLx99NJvUj98Ndm
 vzCf13gejtK7uVlvrrvjoqXojN7GpK5+COrBhPrMXvQCqqTM3rVYU+hIm7naXuKAfe
 DEPuJ2roU2G13Gq26YU2XLc9HoogMVb1quU0z39nKCayDl6m2t4gOj05hWAWSnQv9X
 DKOWLO7AmyH3g==
Date: Mon, 2 Aug 2021 09:20:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: cadence: add paranoid check on self-clearing
 bits
Message-ID: <YQdrfNA08UITBjvB@matsya>
References: <20210714051349.13064-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714051349.13064-1-yung-chuan.liao@linux.intel.com>
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

On 14-07-21, 13:13, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The Cadence IP exposes a small number of self-clearing bits in
> the MCP_CONTROL and MCP_CONFIG_UPDATE registers.
> 
> We currently do not check that those bits are indeed cleared,
> e.g. during resume operations. That could lead to resuming peripheral
> devices too early.
> 
> In addition, if we happen to read these registers, update one of the
> fields and write the register back, we may be writing stale data that
> might have been cleared in hardware. These sort of race conditions
> could lead to e.g. doing a hw_reset twice or stopping a clock that
> just restarted. There is no clear way of avoiding these potential race
> conditions other than making sure that these registers fields are
> cleared before any read-modify-write sequence. If we detect this sort
> of errors, we only log them since there is no clear recovery
> possible. The only way out is likely to restart the IP with a
> suspend/resume cycle.
> 
> Note that the checks are performed before updating the registers, as
> well as after the Intel 'sync go' sequence in multi-link mode. That
> should cover both the start and end of suspend/resume hardware
> configurations. The Multi-Master mode gates the configuration updates
> until the 'sync go' signal is asserted, so we only check on init and
> after the end of the 'sync go' sequence.
> 
> The duration of the usleep_range() was defined by the GSYNC frequency
> used in multi-master mode. With a 4kHz frequency, any configuration
> change might be deferred by up to 250us. Extending the range to
> 1000-1500us should guarantee that the configuration change is
> completed without any significant impact on the overall resume
> time.

There were some checkpatch warns, but I think code will looks worse if
we split lines up, so applied now

-- 
~Vinod
