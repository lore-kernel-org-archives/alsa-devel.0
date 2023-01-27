Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56D5C61D97
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jan 2023 08:28:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B409583B;
	Fri, 27 Jan 2023 09:27:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B409583B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674808094;
	bh=RErM03IW//HfZaeJ01FoiMSUgaL2isHa9E4NESwtMjg=;
	h=Date:From:To:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=r0MN6C9ta/r8ZJbVByBTEMTLzBMqvrk98XhiN1fJ1X5tGagbL4rQDrkENe/WJ3WWm
	 Oi+slDhbCD/q9l6vwS9j3xUURoWePtI7aqPF9HWH1F3X6Dy1SNVlB4Oj7TxIR4Knoc
	 w2PfxMgtfuarPnWUwtf4CxQ1kaMYliN/eRBvfp78=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39AF5F802E8;
	Fri, 27 Jan 2023 09:27:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19310F80424; Fri, 27 Jan 2023 09:27:21 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FF63F80238
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 09:27:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FF63F80238
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=kz/9gVbM
Received: from booty (unknown [77.244.183.192])
 (Authenticated sender: luca.ceresoli@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPSA id 35C3440012;
 Fri, 27 Jan 2023 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1674808033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lv7ewrCAvVErHpI7gEVltoemr6ftqALjKTyaA7BAA5M=;
 b=kz/9gVbMcBfzuF5NuB1JYn52NbhQxvOpuk40tZWkVTEp4NsySfuSzWFlpCej5onQD8DtzC
 TSvDRXO2FoUtFg58DJ+T4Kp1A05artpCbwJyzPxAMu6aT5J42TUKlP2Ahl3F2bbzOLAFfT
 yq/L+/a1ISoDaJ5c7t87knlCgdcMZlbaeXYZsBy4HfnltPkZbHI7O7j5PTxWBOC6Tb3pgT
 WhR7dR81Hy0quUooSXLcpK65PjfzBuPzCmkykN6yAFeCf29yx85clMRykicEWo7UhPBsoY
 EIGWH9Zi7KpFFM9Uhti1pxW/C65tfZpOf0z/mu++BuZh75AMGo3iDewPiLBsUA==
Date: Fri, 27 Jan 2023 09:27:08 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] scripts/spelling.txt: add "exsits" pattern and fix typo
 instances
Message-ID: <20230127092708.43247f7e@booty>
In-Reply-To: <20230126155526.3247785a@kernel.org>
References: <20230126152205.959277-1-luca.ceresoli@bootlin.com>
 <20230126155526.3247785a@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: dev@openvswitch.org, alsa-devel@alsa-project.org,
 Leon Romanovsky <leon@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Fabio Estevam <festevam@gmail.com>,
 Colin Ian King <colin.i.king@gmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello Jakub,

thanks for our review.

On Thu, 26 Jan 2023 15:55:26 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 26 Jan 2023 16:22:05 +0100 Luca Ceresoli wrote:
> > Fix typos and add the following to the scripts/spelling.txt:
> > 
> >   exsits||exists
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> 
> You need to split this up per subsystem, I reckon :(

Ironically, it was the case initially but I have squashed my commits
based on several prior commits that do it together. Now I rechecked
and it seems like this happened only until July 2019, so apparently the
policy has changed. Will split.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
