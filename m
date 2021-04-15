Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C29C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 11:29:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB4F61027
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 11:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB4F61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 470A0165E;
	Thu, 15 Apr 2021 13:28:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 470A0165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618486171;
	bh=t/w7GgvrONgwvQVvN95hnRwaU0t1JJrMD0AxY9Np46U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIYYKDjZ9V6gnxN4DOa2CuedSumG0VpsprcTaheiHWRodm2kqNeeW/zHFbsSBa3Xw
	 y6s034aFiNnbHk0+1DWQsTx5ZZDiy+i9THef8zPtaL0Mt3V62VF+br/tcGQHqT5dbd
	 1PUXJzsT5K+NLTg8ETC34X6sFF4d4UB+tz32K+rA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD259F8021D;
	Thu, 15 Apr 2021 13:28:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F597F8022B; Thu, 15 Apr 2021 13:28:36 +0200 (CEST)
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9D82F800ED
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 13:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9D82F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.b="taWd7haY"
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 28873A1BD7;
 Thu, 15 Apr 2021 13:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=81cfrwKyk1g4
 YvKpu+6SDuRsAjmGLhY0/Dw8H276Oys=; b=taWd7haYyNaObn8OcPAQl5IKK4PR
 JGYiK21bgYczqSr/5ZfIRTXbyNFiSpUcxWxXcxIP+kFLMigUKzxIz3iDVUlCJT2/
 RsYznnc20WhhFG/G3K/L3vPeBX0px+mnxPZAkAzAt3uqbQ1yVf3NrJf6GmYMFaOj
 MGuDAxpg33TKiWZkjLdreyPN/wBFhd2bJaIq+yApxQGwEk+3BHoeKgCXgBD0LFYe
 NY3VJ5ozWwfNWWj6wdo9vu2OCUPQa8muBFK4jHu5U67ae4nuvSDLO3/wS+Ct4ySx
 VBhzeCoNNL6qik4cHfFLs08YJW8lJGYcu5JHQLSEXZweKhSXYwsGxurjMw==
Subject: Re: [PATCH] sound: virtio: correct the function name in kernel-doc
 comment
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210415052645.14465-1-rdunlap@infradead.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <f63f2698-991f-409a-0d00-009059f0588d@opensynergy.com>
Date: Thu, 15 Apr 2021 13:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210415052645.14465-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On 15.04.2021 07:26, Randy Dunlap wrote:
> 
> Fix kernel-doc warning that the wrong function name is used in a
> kernel-doc comment:
> 
> ../sound/virtio/virtio_ctl_msg.c:70: warning: expecting prototype for virtsnd_ctl_msg_request(). Prototype was for virtsnd_ctl_msg_response() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: alsa-devel@alsa-project.org

Thanks for fixing the copy/paste mistake. :)

Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

> ---
>   sound/virtio/virtio_ctl_msg.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210414.orig/sound/virtio/virtio_ctl_msg.c
> +++ linux-next-20210414/sound/virtio/virtio_ctl_msg.c
> @@ -61,7 +61,7 @@ void *virtsnd_ctl_msg_request(struct vir
>   }
> 
>   /**
> - * virtsnd_ctl_msg_request() - Get a pointer to the response header.
> + * virtsnd_ctl_msg_response() - Get a pointer to the response header.
>    * @msg: Control message.
>    *
>    * Context: Any context.
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

