Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0113DC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:38:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8422C20724
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oszQ+8SW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2ag2hnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8422C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9ED417EF;
	Fri, 13 Mar 2020 13:37:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9ED417EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584103111;
	bh=w8p6PegwkaiexLvGM8j+H10uPvnpcBYb5kISfOONg3k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oszQ+8SWQXfhyLUDhuq1h1EYgLh9XqXXXVZi6OjaTzNwKRyrsHpRsSIcFZboOVpVH
	 0x3VyreZDkuOZOqRqfzG/3rVrsIdPs3ShSm2X9DtVYkQD4Gnm7mcJzc1gtNmQ1nZCr
	 e93KhDTyyIBfOQEPfGWsLMkdTn3WlzAdvpOznLro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF72AF80086;
	Fri, 13 Mar 2020 13:37:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1D0EF8013E; Fri, 13 Mar 2020 13:37:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA451F8013E
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 13:37:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA451F8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="L2ag2hnx"
Received: from localhost (unknown [171.76.107.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 858A020724;
 Fri, 13 Mar 2020 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584103030;
 bh=w8p6PegwkaiexLvGM8j+H10uPvnpcBYb5kISfOONg3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L2ag2hnxG8xh2WxxVoB1IhUhlMl1LBPWP2kHHkdWY0XvkpYi/hIArEpxgjM/vF4Q8
 0UXPhYtAW/nS+gaZaBfNShrr8+DVvZesS9uNoVQJhA32//kuOhsys8q5RciplTgqS4
 WM2XGt+a060gPSiCXjN5OSZyB7C4u49AX/AYrhT0=
Date: Fri, 13 Mar 2020 18:07:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: stream: use sdw_write instead of update
Message-ID: <20200313123705.GI4885@vkoul-mobl>
References: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 linux-kernel@vger.kernel.org
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

On 12-03-20, 10:01, Srinivas Kandagatla wrote:
> There is no point in using update for registers with write mask
> as 0xFF, this adds unecessary traffic on the bus.
s/unecessary/unnecessary

> Just use sdw_write directly.

Applied with typo fixed, thanks
-- 
~Vinod
