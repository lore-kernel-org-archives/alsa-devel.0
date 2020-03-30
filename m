Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB842C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:54:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467FD20776
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O+bbk1DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467FD20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A17715F9;
	Mon, 30 Mar 2020 18:53:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A17715F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585587247;
	bh=3QJmFkLC8V4RxFdirNvjeH5MICNEQYuRNjKDaoRqMQw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+bbk1DKK2z2iUMb4y962E9x9470xpyiMVJG4x7oKCdQGB4eVlrXwacypMhW3nhKW
	 MHcmrz7EhPTYs0mPUSJ0AtKoznWp/lxKXyyAHuf87HYCS7RfGMUCZgbcIaG0/FEKOq
	 zNq87R/h16h999VxaABDGhzC+0THcVXjjr3wZsJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E921F80145;
	Mon, 30 Mar 2020 18:53:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59255F80148; Mon, 30 Mar 2020 18:53:16 +0200 (CEST)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by alsa1.perex.cz (Postfix) with ESMTP id 3B74FF800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 18:53:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B74FF800EB
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 036CF72CCED;
 Mon, 30 Mar 2020 19:53:12 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id D39317CCB1F; Mon, 30 Mar 2020 19:53:11 +0300 (MSK)
Date: Mon, 30 Mar 2020 19:53:11 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH 5/5] ALSA: uapi: Drop asound.h inclusion
 from asoc.h
Message-ID: <20200330165311.GA11372@altlinux.org>
References: <20191220153415.2740-1-tiwai@suse.de>
 <20191220153415.2740-6-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220153415.2740-6-tiwai@suse.de>
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

Hi,

On Fri, Dec 20, 2019 at 04:34:15PM +0100, Takashi Iwai wrote:
> The asound.h isn't always available while asoc.h itself is distributed
> in alsa-lib package.  So we need to avoid the unnecessary inclusion of
> asound.h from there.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/uapi/sound/asoc.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index a74ca232f1fc..6048553c119d 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -17,7 +17,6 @@
>  #define __LINUX_UAPI_SND_ASOC_H
>  
>  #include <linux/types.h>
> -#include <sound/asound.h>
>  
>  /*
>   * Maximum number of channels topology kcontrol can represent.

This has reached v5.6 and caused the following regression:

sound/asoc.h:214:14: error: 'SNDRV_CTL_ELEM_ID_NAME_MAXLEN' undeclared here (not in a function)
  214 |  char string[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];

Please revert or fix in some way to make the uapi header compileable again.

Thanks,


-- 
ldv
