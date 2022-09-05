Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACF0ECAAD5
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Sep 2022 07:03:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E15ADE0E;
	Mon,  5 Sep 2022 09:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E15ADE0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662361381;
	bh=lwGzRo+ndZ3DXiH9i5tad3kv0eeFqzt5Sdvur0UmCY4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XZlDhonKcOesWz8XjAFG867iwxbtA5JE2BlMYOVR34YvaRVKPAviQBufL8werAB7c
	 kMQGzoqwPDmyuTRUMtbIB8GGlQyzmfC0rCBxTm8blCmZpqa1RetQCYoaIUD5s3jPQk
	 aWq7mYsDTfhy+AHAVjkkOMDqUqO1AqqYHMwUBXJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55907F80165;
	Mon,  5 Sep 2022 09:02:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 436FCF80238; Mon,  5 Sep 2022 09:02:08 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C039DF800CC
 for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2022 09:02:00 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id AFB2BA003F;
 Mon,  5 Sep 2022 09:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz AFB2BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1662361319; bh=SaoIvZp/AoMRwCC1c4OX4PRklR1T5pA4zjEwA12hdLo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IgXq8V8UbYclfvy8xm2kOhXfzgIfJlK5XA2ROsUMw1Opk4l/s9LNuNDX67AJJL4AW
 fbVhP1Uh3gET2tVeqE59D8cY34sLrAPr5gjuUmFpXbz4DZjuLHesKmBAR5J7/zbk/N
 l4RHSZBBUeyKIX8H5F4WF2sGoosNssHQcxc9yZyA=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  5 Sep 2022 09:01:56 +0200 (CEST)
Message-ID: <4f35253c-f6f4-076a-c408-9441068a2442@perex.cz>
Date: Mon, 5 Sep 2022 09:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20220905060714.22549-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220905060714.22549-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: butt3rflyh4ck <butterflyhuangxx@gmail.com>
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

On 05. 09. 22 8:07, Takashi Iwai wrote:
> There is a small race window at snd_pcm_oss_sync() that is called from
> OSS PCM SNDCTL_DSP_SYNC ioctl; namely the function calls
> snd_pcm_oss_make_ready() at first, then takes the params_lock mutex
> for the rest.  When the stream is set up again by another thread
> between them, it leads to inconsistency, and may result in unexpected
> results such as NULL dereference of OSS buffer as a fuzzer spotted
> recently.
> 
> The fix is simply to cover snd_pcm_oss_make_ready() call into the same
> params_lock mutex with snd_pcm_oss_make_ready_locked() variant.
> 
> Reported-and-tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/CAFcO6XN7JDM4xSXGhtusQfS2mSBcx50VJKwQpCq=WeLt57aaZA@mail.gmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
