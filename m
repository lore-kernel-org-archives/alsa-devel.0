Return-Path: <SRS0=flyq=3Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC2C35247
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:52:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872C420702
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xia/ky9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C420702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD2F0167A;
	Wed,  5 Feb 2020 16:51:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD2F0167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580917922;
	bh=CvC3HNSp9uUjQ+DrMZVLQ5rXOo8eOGtDz+TeUxRieNc=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xia/ky9eq35ARfdpEVg8UmEMBLraOtrgVVw1+CemxQryso/spmZe/yXpCkCcJDwth
	 7EpEAtmVJXdDdoZYcKSBWS7xycyc3CSL3ltuebK1UWcSysr4XygbaZdAGMOJgycQZz
	 MWgjfxmCnBt/jcd7yJcYdy147McAtv49XDxJiK8Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3B32F80150;
	Wed,  5 Feb 2020 16:50:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84701F8019B; Wed,  5 Feb 2020 16:50:49 +0100 (CET)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA13AF8014C
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 16:50:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA13AF8014C
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 32F3A56277ED
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 16:50:44 +0100 (CET)
To: alsa-devel@alsa-project.org
References: <20200205081221.18665-1-mforney@mforney.org>
 <20200205081221.18665-2-mforney@mforney.org>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <cefeff1a-a35d-7d00-1f49-7c0dfa746ad1@ladisch.de>
Date: Wed, 5 Feb 2020 16:50:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205081221.18665-2-mforney@mforney.org>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.101.4 at webclient5
X-Virus-Status: Clean
Subject: Re: [alsa-devel] [PATCH alsa-utils 2/4] Avoid pointer arithmetic on
 `void *`
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Michael Forney wrote:
> The pointer operand to the binary `+` operator must be to a complete
> object type.

Why are you making this change?  Are you trying to compile alsa-utils
with MSVC?


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
