Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE59FC4332F
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Nov 2022 15:25:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC176210;
	Tue,  8 Nov 2022 16:24:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC176210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667921099;
	bh=2sNOy9ulPORYB52wRvqD0fPlkyq4EYoVkq0/22yT/SM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6moZtzadwnOt6w7nxBNp0oUCFR2jwhQv9NSvHAKkytcshXJWzG/K+BX4N92C9bHd
	 JqCTR5/N4+Lt6qWUu1WRUWYEtp6ER92/66ARqIYBPp94nDdgs2S5EadN+kWKYg32j1
	 eosUvjoGIkuFMC/hu4dw7GeU479OD4KN3gm/3DQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52BFDF8016E;
	Tue,  8 Nov 2022 16:24:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBD2DF801D8; Tue,  8 Nov 2022 16:24:06 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D9A6F8016A
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2022 16:23:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D9A6F8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="JwVG6yPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667921037; x=1699457037;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2sNOy9ulPORYB52wRvqD0fPlkyq4EYoVkq0/22yT/SM=;
 b=JwVG6yPV5QyBQJfU2V1BRKhS8Gwh8RxNrV5tICq4ab0RLn9VKvqC7M5P
 cnFY6yvsyBqgpipi6+tZx/f0d91smlFfqsq+ozalgHkpqUruq0DkdwHs3
 xklBQB97yBhbddCnxCD4JJoMK8Cqe6Y5SxJf/Iy0XF1slQj83fpv/JZR9
 7tik6MnCEi5KzTLQ45KyEnJdwwHWs07+OjvWiOqeME9aw7yfGvEI2YIXh
 HG+Sty7LBRmpnvhzrJ3ClIDz/oRTUtJogt82RAqVQ28v7B4tgUpOMBePC
 lJYeZ3FJ9XuD0GYVk9zf5EtkgJhW0iYtn/4HbDD2OSzePO3ULoLHe5E9d w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310719437"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; d="scan'208";a="310719437"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2022 07:21:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="811274538"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; d="scan'208";a="811274538"
Received: from aavneri-mobl1.amr.corp.intel.com (HELO [10.212.24.169])
 ([10.212.24.169])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2022 07:21:15 -0800
Message-ID: <7996e8b5-9783-29c3-0027-f7bf933d75a0@linux.intel.com>
Date: Tue, 8 Nov 2022 09:21:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH linux-next] ASoC: SOF: remove duplicated included
 sof-audio.h
Content-Language: en-US
To: yang.yang29@zte.com.cn, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <202211081931524521356@zte.com.cn>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202211081931524521356@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: xu.panda668@gmail.com, peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
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

You need to CC: maintainers and the alsa-devel mailing list in a v2

On 11/8/22 05:31, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The sof-audio.h is included more than once.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/amd/acp-common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
> index 27b95187356e..348e70dfe2a5 100644
> --- a/sound/soc/sof/amd/acp-common.c
> +++ b/sound/soc/sof/amd/acp-common.c
> @@ -13,7 +13,6 @@
>  #include "../sof-priv.h"
>  #include "../sof-audio.h"
>  #include "../ops.h"
> -#include "../sof-audio.h"
>  #include "acp.h"
>  #include "acp-dsp-offset.h"
> 
