Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A4CC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 09:10:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A907364E32
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 09:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A907364E32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C00516B4;
	Wed, 10 Feb 2021 10:09:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C00516B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612948215;
	bh=y1P2FsLQ8yirCtHF1Dy55fqKFVwlCZKIrBaw3W5ofkw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aq/yoBh4yBjx525awT2wc3QoL0SZWREWjaWQGdwozcW4CSJuCHD22PVx2C9Y212a9
	 6agWi51TOqXEGcnzXOteAAFVlzS4knZGhUugl3MRjr2exO5G0S7AyBoORtbWr9aXvV
	 VVXNlzLKl8wwVBnJldanFSXDWXlHw+DDaMFM8ASs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD17CF8010D;
	Wed, 10 Feb 2021 10:09:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22179F8022B; Wed, 10 Feb 2021 10:09:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC39BF8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 10:09:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC39BF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HCEh/5jx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A62CE64E42;
 Wed, 10 Feb 2021 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612948153;
 bh=y1P2FsLQ8yirCtHF1Dy55fqKFVwlCZKIrBaw3W5ofkw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HCEh/5jxG3+CFWmZ5OA92GFpdSGwLpnuivJCpT0WCj+95ZvR6hewYeBhmzmM6APTt
 mzsItxN+6gDTjjn905MVldvFBVL+xo1KXvugFvr2AfWNCcOO7GrIz/6f7n571f3QWp
 J7BTK9TVjfieB8hO9aXT5emoV0gveXf1n6FpBZJT4Xvz3+I3nnvb/L1RV2ZxA1+0qR
 Qa0RzE+ISqURSQLCHMy6Zd4AkHXPxZS9HRUvpqDGm1IcGsMLNRHEj1eePefKAZciUv
 gf0Z9WecKlQ1N6he2O9TU0f9RmvITkaCFo3q9gTr1TzNt8UnShxwUYwHxBxPtdl0go
 f9M+SQE84lyhA==
Date: Wed, 10 Feb 2021 14:39:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: core - add missing compress device type to
 /proc/asound/devices
Message-ID: <20210210090909.GB2774@vkoul-mobl.Dlink>
References: <20210210083713.1034201-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210083713.1034201-1-perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>
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

On 10-02-21, 09:37, Jaroslav Kysela wrote:
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Cc: Vinod Koul <vkoul@kernel.org>

Acked-By: Vinod Koul <vkoul@kernel.org>

> ---
>  sound/core/sound.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/core/sound.c b/sound/core/sound.c
> index b75f78f2c4b8..302b6d12ab2b 100644
> --- a/sound/core/sound.c
> +++ b/sound/core/sound.c
> @@ -337,6 +337,8 @@ static const char *snd_device_type_name(int type)
>  		return "sequencer";
>  	case SNDRV_DEVICE_TYPE_TIMER:
>  		return "timer";
> +	case SNDRV_DEVICE_TYPE_COMPRESS:
> +		return "compress";
>  	default:
>  		return "?";
>  	}
> -- 
> 2.29.2

-- 
~Vinod
