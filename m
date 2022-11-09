Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF15C43217
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Nov 2022 04:31:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F17B53E8;
	Wed,  9 Nov 2022 05:30:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F17B53E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667968260;
	bh=Y+wsi+hfHTwgv/jg3RZnAaB0QuEulD67yzWdyluHBfQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M/GPJZ99x6z4Rua+G5Zdc3WPKLvKeCNCpYubMcQKpocpz0rWDoW0W93+8uyOE2wm+
	 76YTiIN4Sn7DogWNVXdxm2k65E75VIOxFRcYaiKPfIeQGc30PQTd1E9kv72LIeTdUh
	 sHXNh4xTfa4BDMSNW/r4TSo3iB0jKbsrQYmb/O/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94AC9F800EC;
	Wed,  9 Nov 2022 05:30:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80C36F8023B; Wed,  9 Nov 2022 05:30:05 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3932FF80121
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2022 05:30:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3932FF80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FHp4fncY"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7E427617E1;
 Wed,  9 Nov 2022 04:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E48C433D6;
 Wed,  9 Nov 2022 04:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667968198;
 bh=Y+wsi+hfHTwgv/jg3RZnAaB0QuEulD67yzWdyluHBfQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FHp4fncYj/791czgAy7Zhx63V4mczDfCQWyPLPgCNVPnFGyUziNBdraBtGZnqT2jA
 x1BYpiHDh2hjMVd5HK6hyoq6bYlqc05HK1jlOnR4r+iRQ8XLUjQNPzhVURR4LS16yb
 Q7YPyvR7urHFnNXDVP8lWGYbEA65Z3MDyXj4DCM0BiG6UPXPtvh4dmZJPP9/tHJcaG
 euc2L3hSxKtQiO3zYnG9jjybTla2vxYlTLQ/YfKaa90jsRQFqE12ZAwG3HhSUX3D++
 GBWlUBlV3DywOpR98WKA84TSwhmJC8Z/z7Yeeq5MgYQMe7p4zoMuNpxqSWSXPCNudn
 Pm/M7F8IYF/qg==
Date: Wed, 9 Nov 2022 09:59:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/2] soundwire: cadence: remove dma_data
Message-ID: <Y2sswmYa4cBBCuwV@matsya>
References: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com
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

On 01-11-22, 10:35, Bard Liao wrote:
> The use of dma_data is problematic for two reasons for the Cadence IP.
> a) the dai runtime data has nothing to do with DMAs in existing solutions
> b) we will use the dma_data for DMA-management in the future. We cannot
> share two separate pieces of information with the same dma_data pointer.

Applied, thanks

-- 
~Vinod
