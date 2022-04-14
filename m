Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC86C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Apr 2022 11:55:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17DA216E1;
	Thu, 14 Apr 2022 13:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17DA216E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649937334;
	bh=b1Qs+7yt5i52Y0vqCOXaUWCnj9gXnqVJSriesALO6dU=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LxXCLIcuS5D/qArR6KZ2/5HSgIoI5GlSzjXxB8k98VDF7/S/wQFNiIQgwe8bDLACg
	 i5R68Fk2ixB0IQDXudeebVH7u9+qwfGBCnQw0KdeYaLXvLLyDRWlmxGkHZsGmULwfq
	 r8VN6oTm4DKxXdWCcRdxTtn0/cOwETcIYkvkl5Ec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A5CAF8012E;
	Thu, 14 Apr 2022 13:54:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4165F80162; Thu, 14 Apr 2022 13:54:41 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7A07F80114
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2022 13:54:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7A07F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="BVo9/App"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B009C1F479A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1649937272;
 bh=b1Qs+7yt5i52Y0vqCOXaUWCnj9gXnqVJSriesALO6dU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BVo9/App19AXDvXABST6TIBcWiKh16uI6AF2q698a+uy8uLiJItQWXBgQf7+vVD0p
 xWtH3pmTQia4xYUp4WNnEp87B3gAH7Lvc6c4PAd7VgeDigmKlNjz8ZXX759Xy/C+E+
 hdI6fLFHxfcC6D5hvAG9H8WMk0ZF7KD/6orE8w5Kwk5Qh2S+s7f52MFrg8G4E4eBzb
 PRefpTpEJqcfnADQI2Kg2SDxDLkRLTP+0rnQ3EYV+cOeorjfR/AmX5PKXlahNZUYE7
 dbAvPxUBwRHMKIet4tXusWPoGt9fJ4z+rdlPuts0D3EfXVBKQvcZBUF1LxkktjqbRm
 i7UUWaUnSD9fw==
Message-ID: <d7234c71-f5c4-d623-16c4-e16c34b6de35@collabora.com>
Date: Thu, 14 Apr 2022 13:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] sound/oss/dmasound: fix 'dmasound_setup' defined
 but not used
Content-Language: en-US
To: Miles Chen <miles.chen@mediatek.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220414081119.30851-1-miles.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220414081119.30851-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Il 14/04/22 10:11, Miles Chen ha scritto:
> We observed: 'dmasound_setup' defined but not used error with
> COMPILER=gcc ARCH=m68k DEFCONFIG=allmodconfig build.
> 
> __setup() does not work if MODULE is defined.
> Fix it by warpping dmasound_setup with #ifndef MODULES.
> 
> Error(s):
> sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used [-Werror=unused-function]
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   sound/oss/dmasound/dmasound_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
> index 9c48f3a9e3d1..a1b3e71beadf 100644
> --- a/sound/oss/dmasound/dmasound_core.c
> +++ b/sound/oss/dmasound/dmasound_core.c
> @@ -1428,6 +1428,7 @@ void dmasound_deinit(void)
>   		unregister_sound_dsp(sq_unit);
>   }
>   
> +#ifndef MODULE
>   static int dmasound_setup(char *str)

Hello Miles,
I agree with Takashi, __maybe_unused looks way better.

Regards,
Angelo
