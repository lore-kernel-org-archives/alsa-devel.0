Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549FC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 16:57:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54699613DA
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 16:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54699613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38F4216DF;
	Wed, 29 Sep 2021 18:56:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38F4216DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632934656;
	bh=khRc8t29JpaApOGVCM52z56kbLRj7uDWN7B5djXr+8c=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NP/gjNEadKK4qQCsdJONXUqQRRjJyo2+yTJmuwVSWbowFyvF7WotFvXmD1grLG1t3
	 TgmbBgHcOcLvkLgyslT8x1GN+YbLkUGT6SRfq0waWPtBVI4cV1yvTdiMe4Il3enb4v
	 lhKyLV8V9xUPnMUrQugnDGJ9nWHkt25oku9bHqf8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABF69F801F7;
	Wed, 29 Sep 2021 18:56:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11504F80227; Wed, 29 Sep 2021 18:56:44 +0200 (CEST)
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B057F80105
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 18:56:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B057F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metanate.com header.i=@metanate.com
 header.b="cAt/13l1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
 :Content-Description; bh=ysDSBYfH+9lnSZYNya7VTHwC5qwPkWB2y4lW2wuez0U=; b=cAt/
 13l1UFAw8RgU6FSzt4+Cz85KwL81LYREyzxwZImjp+4LKn6cd9RKlhgP7dHY8btPe1OvMZ2U4rPlV
 IAdgZ5N4BqTDFA5PgmJ3DRvLPmDlkapvVrUzsIGgMejzGLXDDCw89CapH0tghCM5i4gSVZSd4Hoo8
 m88hzHtZBTviFSMA5TfVQxgzycF7LcKuDxDlQKxlqyFma8UUbb+0c/jNAhKoXKi4GhdRJBckGwZeR
 Z6uwk0hceUleiobObKqmog/J2IwNk1h4R4Yxjwsfv+H+639BjID8Hz4F1V7IkEWw7IR3Z06MGyn0I
 tTXpUOiPPL4N5G4Ws+drad9vtZof8Q==;
Received: from [81.174.171.191] (helo=donbot)
 by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93) (envelope-from <john@metanate.com>)
 id 1mVcsi-000733-P6; Wed, 29 Sep 2021 17:56:32 +0100
Date: Wed, 29 Sep 2021 17:56:32 +0100
From: John Keeping <john@metanate.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: rawmidi: Fix potential UAF from sequencer
 destruction
Message-ID: <20210929175632.50b78be8.john@metanate.com>
In-Reply-To: <s5hv92jl7t2.wl-tiwai@suse.de>
References: <20210929113620.2194847-1-john@metanate.com>
 <s5hzgrvl9j0.wl-tiwai@suse.de>
 <20210929161758.49ce947f.john@metanate.com>
 <s5hv92jl7t2.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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

On Wed, 29 Sep 2021 17:28:57 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 29 Sep 2021 17:17:58 +0200,
> John Keeping wrote:
> > 
> > On Wed, 29 Sep 2021 16:51:47 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> >   
> > > On Wed, 29 Sep 2021 13:36:20 +0200,
> > > John Keeping wrote:  
> > > > 
> > > > If the sequencer device outlives the rawmidi device, then
> > > > snd_rawmidi_dev_seq_free() will run after release_rawmidi_device() has
> > > > freed the snd_rawmidi structure.
> > > > 
> > > > This can easily be reproduced with CONFIG_DEBUG_KOBJECT_RELEASE.
> > > > 
> > > > Keep a reference to the rawmidi device until the sequencer has been
> > > > destroyed in order to avoid this.
> > > > 
> > > > Signed-off-by: John Keeping <john@metanate.com>    
> > > 
> > > Thanks for the patch.  I wonder, though, how this could be triggered.
> > > Is this the case where the connected sequencer device is being used
> > > while the sound card gets released?  Or is it something else?  
> > 
> > I'm not sure if it's possible to trigger via the ALSA API; I haven't
> > found a route that can trigger it, but that doesn't mean there isn't
> > one :-)
> > 
> > Mostly this is useful to make CONFIG_DEBUG_KOBJECT_RELEASE cleaner.  
> 
> Hm, then could you check whether the patch below papers over it
> instead?

No, this patch doesn't solve it.  The issue is that the effect of the
final device_put() is delayed from the time it is called and there is no
way to guarantee the ordering without ensuring the sequencer has been
destroyed before the final reference to the rawmidi device is put.

Both of the functions involved are called from the core
device::release() hook.

I'm using the patch below to easily check that the sequencer has been
freed before the rawmidi data.  This can easily be triggered by
unplugging a USB MIDI device (it's not 100% since the kobject release
delays are random).

-- >8 --
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1571,7 +1571,10 @@ static int snd_rawmidi_alloc_substreams(struct snd_rawmidi *rmidi,
 
 static void release_rawmidi_device(struct device *dev)
 {
-       kfree(container_of(dev, struct snd_rawmidi, dev));
+       struct snd_rawmidi *rmidi = container_of(dev, struct snd_rawmidi, dev);
+
+       WARN_ON(rmidi->seq_dev);
+       kfree(rmidi);
 }
 
 /**
-- 8< --

> --- a/sound/core/seq/seq_ports.c
> +++ b/sound/core/seq/seq_ports.c
> @@ -415,11 +415,16 @@ static int subscribe_port(struct snd_seq_client *client,
>  			grp->count--;
>  		}
>  	}
> -	if (err >= 0 && send_ack && client->type == USER_CLIENT)
> +	if (err < 0)
> +		return err;
> +
> +	if (send_ack && client->type == USER_CLIENT)
>  		snd_seq_client_notify_subscription(port->addr.client, port->addr.port,
>  						   info, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
> +	else if (client->type == KERNEL_CLIENT)
> +		get_device(&client->data.kernel.card->card_dev);
>  
> -	return err;
> +	return 0;
>  }
>  
>  static int unsubscribe_port(struct snd_seq_client *client,
> @@ -439,6 +444,8 @@ static int unsubscribe_port(struct snd_seq_client *client,
>  		snd_seq_client_notify_subscription(port->addr.client, port->addr.port,
>  						   info, SNDRV_SEQ_EVENT_PORT_UNSUBSCRIBED);
>  	module_put(port->owner);
> +	if (client->type == KERNEL_CLIENT)
> +		snd_card_unref(client->data.kernel.card);
>  	return err;
>  }
>  

