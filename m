Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D61C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:14:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EE520848
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vt0Lyddn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="jx/wPlvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EE520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D2DE83E;
	Tue, 11 Feb 2020 12:13:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D2DE83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581419678;
	bh=9mQ9U3rokZN36ydw1KPxowGw0tuPSDrVOcPKSw8K4sw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vt0Lyddnn5HYNqTEiDWzZls3B4y0vUboe+5z9ewvEW87J5VXCRaBoGj1GXiCUgN1X
	 lx7HQLvGXPxX6pheOeT7cq6WeDqWrdJea0x+5DtwM1v8xz8OAvSvRI2Tumliz4Sobm
	 g9dJgBpYo0GAlNV4s2cELVFUDsBV2weV9c7gKQLA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D96FF8013E;
	Tue, 11 Feb 2020 12:13:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AAF3F80145; Tue, 11 Feb 2020 12:13:46 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C125F800F0;
 Tue, 11 Feb 2020 12:13:42 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A714FA003F;
 Tue, 11 Feb 2020 12:13:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A714FA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1581419621; bh=93dcy1ASdaTdET66E6qZ9A3eYuEmk2RSdjK8T7ZE4XM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jx/wPlvuIq3S6l+m4dQpb5NZ+YkmKGrwpk3XJnwYaPwRdKp67fPPvkWmx0z3pVG10
 JX02iOEjT6vooCnkL6BqnEWb1j/0QHEBSnzw3Frkqdt3FyI0OQbEpXwD4Ly9h9Pbv+
 mvm+0sh+mhrrc2zJgVjuFIvdkLUDN2AACiXhY9zo=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 11 Feb 2020 12:13:38 +0100 (CET)
To: Rolf Eike Beer <eb@emlix.com>, patch@alsa-project.org
References: <5948808.FfnTCzJfH2@devpool35>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <fce7bfe6-428f-77bd-2bce-96f28e287ded@perex.cz>
Date: Tue, 11 Feb 2020 12:13:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5948808.FfnTCzJfH2@devpool35>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] do not set close-on-exec flag on
 descriptor if it was already set
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 11. 02. 20 v 11:22 Rolf Eike Beer napsal(a):
> There is no need to set this again if O_CLOEXEC is supported.

Thanks. Applied.

				Jroslav

> 
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> ---
>   include/local.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/local.h b/include/local.h
> index ea0ec32d..ed6ba936 100644
> --- a/include/local.h
> +++ b/include/local.h
> @@ -320,8 +320,10 @@ static inline int snd_open_device(const char *filename, int fmode)
>   			fd = rsm_open_device(filename, fmode);
>   	}
>   #endif
> +#ifndef O_CLOEXEC
>   	if (fd >= 0)
>   		fcntl(fd, F_SETFD, FD_CLOEXEC);
> +#endif
>   	return fd;
>   }
>   
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
