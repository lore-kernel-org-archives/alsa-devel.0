Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0185C432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:21:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD782063A
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TS5ZWDqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD782063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 836F31697;
	Mon, 18 Nov 2019 19:21:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 836F31697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574101315;
	bh=7jQcsoTJHM+P+phTX9P82ydxSiGITXiYpjbteR28BTA=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TS5ZWDqbLaJO+uhj1tvQinPdOH27iT0Re3SVwfeFBXLOmvLMJ9NAu54ysAyJ6Hvlf
	 WobdABDEZTcxyudzFEHYWnSELJu5iZXU77eDXqOBMOiEylMHGDm++VN94g8gKYBY5I
	 wuhHDTXocTfwzTu7KfG/N16gk1gIbuX6JRyWBplk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE938F80148;
	Mon, 18 Nov 2019 19:19:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 413C1F8013E; Mon, 18 Nov 2019 19:19:24 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42552F8013B
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 19:19:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42552F8013B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2019 10:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; d="scan'208";a="407480025"
Received: from asimomai-mobl1.amr.corp.intel.com (HELO [10.251.156.191])
 ([10.251.156.191])
 by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2019 10:19:16 -0800
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <20191117085308.23915-1-tiwai@suse.de>
 <20191117085308.23915-8-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3b407a02-b791-52a4-2335-e21d8ab732dd@linux.intel.com>
Date: Mon, 18 Nov 2019 10:38:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191117085308.23915-8-tiwai@suse.de>
Content-Language: en-US
Subject: Re: [alsa-devel] [PATCH 7/8] ALSA: pcm: Add card sync_irq field
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



On 11/17/19 2:53 AM, Takashi Iwai wrote:
> Many PCI and other drivers performs snd_pcm_period_elapsed() simply in
> its interrupt handler, so the sync_stop operation is just to call
> synchronize_irq().  Instead of putting this call multiple times,
> introduce the common card->sync_irq field.  When this field is set,
> PCM core performs synchronize_irq() for sync-stop operation.  Each
> driver just needs to copy its local IRQ number to card->sync_irq, and
> that's all we need.

Maybe a red-herring or complete non-sense, but I wonder if this is going 
to get in the way of Ranjani's multi-client work, where we could have 
multiple cards created but with a single IRQ handled by the parent PCI 
device?

Ranjani, you may want to double-check this and chime in, thanks!

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   include/sound/core.h    | 1 +
>   sound/core/init.c       | 1 +
>   sound/core/pcm_native.c | 2 ++
>   3 files changed, 4 insertions(+)
> 
> diff --git a/include/sound/core.h b/include/sound/core.h
> index ee238f100f73..af3dce956c17 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -117,6 +117,7 @@ struct snd_card {
>   	struct device card_dev;		/* cardX object for sysfs */
>   	const struct attribute_group *dev_groups[4]; /* assigned sysfs attr */
>   	bool registered;		/* card_dev is registered? */
> +	int sync_irq;			/* assigned irq, used for PCM sync */
>   	wait_queue_head_t remove_sleep;
>   
>   #ifdef CONFIG_PM
> diff --git a/sound/core/init.c b/sound/core/init.c
> index db99b7fad6ad..faa9f03c01ca 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -215,6 +215,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
>   	init_waitqueue_head(&card->power_sleep);
>   #endif
>   	init_waitqueue_head(&card->remove_sleep);
> +	card->sync_irq = -1;
>   
>   	device_initialize(&card->card_dev);
>   	card->card_dev.parent = parent;
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 163d621ff238..1fe581167b7b 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -574,6 +574,8 @@ static void snd_pcm_sync_stop(struct snd_pcm_substream *substream)
>   		substream->runtime->stop_operating = false;
>   		if (substream->ops->sync_stop)
>   			substream->ops->sync_stop(substream);
> +		else if (substream->pcm->card->sync_irq > 0)
> +			synchronize_irq(substream->pcm->card->sync_irq);
>   	}
>   }
>   
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
