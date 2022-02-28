Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1A1C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 05:21:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62DBE1716;
	Mon, 28 Feb 2022 06:21:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62DBE1716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646025714;
	bh=kF9K0Ea03SE1nhuRp7mQDB0qhxl5bpnKO3HTPaLL5Dg=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PbA8R91kHDvlPjl2/Oj1oRbHTi3fbTuaqQCArnIrOivSWUX9kHVZdzLWBVVLXAzow
	 UdWnkVBidIqDz5F/6kssLgr4/ZwjroQcHc/e5glKes0y5yLHzBIi+4YP/ARtDXM8hD
	 LCOvmGTnN2TBDSXmaFGNC/vkpaC+e9f3rvuIRBJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E637BF80128;
	Mon, 28 Feb 2022 06:21:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFE3DF80128; Mon, 28 Feb 2022 06:21:01 +0100 (CET)
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94F26F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 06:20:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94F26F80125
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay10.hostedemail.com (Postfix) with ESMTP id F2F3FE15;
 Mon, 28 Feb 2022 05:20:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf03.hostedemail.com (Postfix) with ESMTPA id BECCA60010; 
 Mon, 28 Feb 2022 05:20:13 +0000 (UTC)
Message-ID: <e5c1ba2f7db29b78066d12dab812b7a1c0a37a81.camel@perches.com>
Subject: Re: [PATCH v4 2/2] ALSA: core: Remove redundant variable and return
 the last statement
From: Joe Perches <joe@perches.com>
To: Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Date: Sun, 27 Feb 2022 21:20:45 -0800
In-Reply-To: <20220228050253.1649-2-tangmeng@uniontech.com>
References: <20220228050253.1649-1-tangmeng@uniontech.com>
 <20220228050253.1649-2-tangmeng@uniontech.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BECCA60010
X-Stat-Signature: hruc7nct77mkwtg4ah8jw8qrpgawattj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19B4PH4dJJF2uojux2T7euYun9bMLaYrIU=
X-HE-Tag: 1646025613-188090
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

On Mon, 2022-02-28 at 13:02 +0800, Meng Tang wrote:
> Return the result from file->f_op->open() directly instead of
> taking this in another redundant variable. Make the typical
> return the last statement, return early and reduce the indentation
> too.
> 
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> Signed-off-by: Joe Perches <joe@perches.com>

Hi Meng Tang.

For the next time: it's not necessary (or even good) to add a sign-off
for another person unless they specifically authorize one.

You wrote and are submitting these changes, I merely gave you simple
suggestions as to how you could improve them.

cheers, Joe

> ---
>  sound/sound_core.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/sound_core.c b/sound/sound_core.c
> index aa4a57e488e5..3332fe321737 100644
> --- a/sound/sound_core.c
> +++ b/sound/sound_core.c
> @@ -577,20 +577,20 @@ static int soundcore_open(struct inode *inode, struct file *file)
>  			new_fops = fops_get(s->unit_fops);
>  	}
>  	spin_unlock(&sound_loader_lock);
> -	if (new_fops) {
> -		/*
> -		 * We rely upon the fact that we can't be unloaded while the
> -		 * subdriver is there.
> -		 */
> -		int err = 0;
> -		replace_fops(file, new_fops);
>  
> -		if (file->f_op->open)
> -			err = file->f_op->open(inode,file);
> +	if (!new_fops)
> +		return -ENODEV;
>  
> -		return err;
> -	}
> -	return -ENODEV;
> +	/*
> +	 * We rely upon the fact that we can't be unloaded while the
> +	 * subdriver is there.
> +	 */
> +	replace_fops(file, new_fops);
> +
> +	if (!file->f_op->open)
> +		return -ENODEV;
> +
> +	return file->f_op->open(inode, file);
>  }
>  
>  MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);


