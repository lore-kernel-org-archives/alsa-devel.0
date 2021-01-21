Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA6C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 20:43:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E6F2389F
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 20:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E6F2389F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDF76192D;
	Thu, 21 Jan 2021 21:42:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDF76192D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611261785;
	bh=DUArAgxsmT/3b8aTJ7Gp2qGLLkOgOxtiSaRSqHxpthc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AWwC+Mwb3qTvQO66CdbqhVVcXdtW9WIeuBtnxdn65dR/U8XgZclaZPLFjS/Q3ZQcW
	 L9sdG7Iop955106xsCn/4kXEu5lZZnIxFdt7vmRJWxTTj8G/CsADw/wcQtGXQJmfFk
	 /bWhansH2+folw6SybOG5dKY0CgS+ro5vqOqImCQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20615F80255;
	Thu, 21 Jan 2021 21:42:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A03EF80257; Thu, 21 Jan 2021 21:42:13 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75F87F80162
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 21:42:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75F87F80162
Received: from [192.168.1.41] ([92.131.99.25]) by mwinf5d31 with ME
 id KYi4240010Ys01Y03Yi4JV; Thu, 21 Jan 2021 21:42:06 +0100
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 21 Jan 2021 21:42:06 +0100
X-ME-IP: 92.131.99.25
Subject: Re: [PATCH] ALSA: fireface: fix info leak in hwdep_read()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Clemens Ladisch <clemens@ladisch.de>
References: <YAka5xudQNQgRkuC@mwanda>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <3ef5f7f4-efeb-8a92-1886-d92e14211287@wanadoo.fr>
Date: Thu, 21 Jan 2021 21:42:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAka5xudQNQgRkuC@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
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

Hi Dan,

Le 21/01/2021 à 07:10, Dan Carpenter a écrit :
> If "ff->dev_lock_changed" has not changed

According to the "while (!ff->dev_lock_changed) { ... }" just above and 
the lock in place, can this ever happen?

In other word, I wonder if the "if (ff->dev_lock_changed)" test makes 
sense and if it could be removed.


(same for your other patch against sound/firewire/oxfw/oxfw-hwdep.c)

CJ


> and "count" is too large then
> this will copy data beyond the end of the struct to user space.
> 
> Fixes: f656edd5fb33 ("ALSA: fireface: add hwdep interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   sound/firewire/fireface/ff-hwdep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/fireface/ff-hwdep.c b/sound/firewire/fireface/ff-hwdep.c
> index 4b2e0dff5ddb..b84dde609a03 100644
> --- a/sound/firewire/fireface/ff-hwdep.c
> +++ b/sound/firewire/fireface/ff-hwdep.c
> @@ -35,12 +35,12 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
>   	}
>   
>   	memset(&event, 0, sizeof(event));
> +	count = min_t(long, count, sizeof(event.lock_status));
>   	if (ff->dev_lock_changed) {
>   		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
>   		event.lock_status.status = (ff->dev_lock_count > 0);
>   		ff->dev_lock_changed = false;
>   
> -		count = min_t(long, count, sizeof(event.lock_status));
>   	}
>   
>   	spin_unlock_irq(&ff->lock);
> 

