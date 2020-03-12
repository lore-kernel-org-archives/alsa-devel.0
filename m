Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70545C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:42:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0241D20724
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gZuxFi+S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+o9Yp89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0241D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 439B916C7;
	Thu, 12 Mar 2020 11:41:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 439B916C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584009744;
	bh=OV9ZiHrPuC+tMP2co9RjC2LJmT+2Cle0WN5ef7t/bs4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZuxFi+S9UWGLCAT8PglcQKIMZLJcXgpiSKGmJX13Yd7TkWG82Pq2EG3B1nAW+qbe
	 bxWdeZyfd6B8gmAayQ98N39yCJnl0AW1dglFAk3amHPtHQStt4p+VkvT6ED1Ez9rnt
	 vszeU+tWCUgec83DyUeIxpkUPRePToFxSkXZ38A0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4932F800BE;
	Thu, 12 Mar 2020 11:41:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 551F0F8020C; Thu, 12 Mar 2020 11:41:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94CAEF800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 11:41:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94CAEF800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S+o9Yp89"
Received: from localhost (unknown [122.167.115.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37DC6206BE;
 Thu, 12 Mar 2020 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584009685;
 bh=OV9ZiHrPuC+tMP2co9RjC2LJmT+2Cle0WN5ef7t/bs4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S+o9Yp89aj42+rMhtTb/NJQMwnFcv7UMm7a48wtgdXxUaFTZAQuGgsPiXxJWeiWw7
 kQDA5SRdy5TNWAWQwhvPw6QSejgdJexIZhB/rZr8QMNne+l1HATCPo7D17mKqrmrRF
 nlgzfaLYKIZHGri6ZgyxyZHNe8g9H0R4CAY1v8M8=
Date: Thu, 12 Mar 2020 16:11:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix default FE dais and routings.
Message-ID: <20200312104117.GY4885@vkoul-mobl>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

On 11-03-20, 18:04, Srinivas Kandagatla wrote:
> QDSP6 Frontend dais can be configured to work in rx or tx or both rx/tx mode,
> however the default routing do not honour this DT configuration making sound
> card fail to probe. FE dais are also not fully honouring device tree configuration.
> Fix both of them.
> 
> Originally  issue was reported by Vinod Koul

Thanks Srini for the these :) I have tested on DB845c. And they work
just fine after adding the DTS bits.

Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
