Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72FAC38142
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Jan 2023 14:33:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 506F11E8;
	Tue, 31 Jan 2023 15:32:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 506F11E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675175594;
	bh=rJ+uNOuQrzdunZzqcySeoXFaea1ZloJyPf+QawRvpS8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tR57f5S/sR9IHqY6ElaKIrsVVp2XH944S1H9W5N58MIU/szOtVZZLsad4R5O9WTsO
	 DhoqrVSlzIs/AHT2xPqd57N5Mu2hZNyru4jVcllNsdMgw9gYCjmN3OmJbSm1mkOX+5
	 71HDGnkskKZ9TUX1y9+ImBgq8utWprMqOZcNVP0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED633F80245;
	Tue, 31 Jan 2023 15:32:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC786F804C2; Tue, 31 Jan 2023 15:32:22 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18D0BF800A7
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2023 15:32:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18D0BF800A7
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=K1BDntP1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 77B96CE1ECD;
 Tue, 31 Jan 2023 14:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8E4C433D2;
 Tue, 31 Jan 2023 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675175527;
 bh=rJ+uNOuQrzdunZzqcySeoXFaea1ZloJyPf+QawRvpS8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K1BDntP1e+/ITz86MA+vF/8mJqQLw8gYMEbeXboVoQP7KreTjYv34jwJtXBAYByVz
 weuFvKByctTawkcq8KGpfgN7QX7v6hlrgmv5PwpNeUltUUWmnmxWY30tCOKV8Xf5T5
 C4bJg024EhzlgboHsfiNdZO+Wl5vLJ+Kg3Jtol6ioHZTSI1VHA4ezzTSMZVP4Dc7fl
 LVCN2kfnyiXPk64xpEfGgoMkPT/OyCVoeV0NPRVcxyKA7T5eht4/aRt1EYdPnIkZkJ
 Tm5R4D+yyqLi5IEeMdOc4EoXZ+xJrqTGQKs33BLZVx0VLFzyyPCDtzZjrx9wFUPtFf
 e0Kl9eG5HthAw==
Date: Tue, 31 Jan 2023 20:02:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/4] soundwire: better error handling in deferred
 transfers
Message-ID: <Y9kmYxjhoOxRVI+l@matsya>
References: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 19-01-23, 15:32, Bard Liao wrote:
> This is a generic cleanup series.

Applied, thanks

-- 
~Vinod
