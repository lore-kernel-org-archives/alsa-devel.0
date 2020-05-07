Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E8C38A24
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 06:51:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B73C207DD
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 06:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d5ZBwxVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B73C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A87B616CD;
	Thu,  7 May 2020 08:50:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A87B616CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588834260;
	bh=77qSUYCM+3iENrJTafQWQ68ZThzBUhdoBDElgwNBMGM=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d5ZBwxVEaIiwZehRMhyVjpkqa9jeX3yYcAEb7MEtzTsAFpYdS5hSnr0Nt8nEmx4CX
	 iFvZBg0qjtcn2SUoWAhfO+D83GRGQyWAEsOfDJS8eIpOFkIGPws5uaphZabAhT8jQs
	 AaHq9SMGoW0Jy5gqlCA9BZaq7nwxzvMkodm9w6ZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38518F8015B;
	Thu,  7 May 2020 08:50:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FE86F8015F; Thu,  7 May 2020 08:50:06 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0244.hostedemail.com
 [216.40.44.244])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3D3AF800AD
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 08:49:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3D3AF800AD
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 427BF1803950B;
 Thu,  7 May 2020 06:49:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: burst17_1bd6e369c792e
X-Filterd-Recvd-Size: 1816
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf18.hostedemail.com (Postfix) with ESMTPA;
 Thu,  7 May 2020 06:49:51 +0000 (UTC)
Message-ID: <5f2d179c35de8e7705f82a8c9a540dbd204bb978.camel@perches.com>
Subject: Re: [PATCH -next] ALSA: portman2x4: Use bitwise instead of
 arithmetic operator for flags
From: Joe Perches <joe@perches.com>
To: Samuel Zou <zou_wei@huawei.com>, perex@perex.cz, tiwai@suse.com
Date: Wed, 06 May 2020 23:49:50 -0700
In-Reply-To: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
References: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Thu, 2020-05-07 at 14:48 +0800, Samuel Zou wrote:
> Fix the following coccinelle warning:
> 
> sound/drivers/portman2x4.c:460:34-35: WARNING: sum of probable bitmasks, consider |

This one is reasonable.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  sound/drivers/portman2x4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
> index ecefa7c..38603cb 100644
> --- a/sound/drivers/portman2x4.c
> +++ b/sound/drivers/portman2x4.c
> @@ -457,7 +457,7 @@ static int portman_probe(struct parport *p)
>  
>  	/* Set for RXDATA0 where no damage will be done. */
>  	/* 5 */
> -	parport_write_control(p, RXDATA0 + STROBE);	/* Write Strobe=1 to command reg. */
> +	parport_write_control(p, RXDATA0 | STROBE);	/* Write Strobe=1 to command reg. */
>  
>  	/* 6 */
>  	if ((parport_read_status(p) & ESTB) != ESTB)

