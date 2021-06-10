Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CEC47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 10:13:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDFD613BD
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 10:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDFD613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5EEF1771;
	Thu, 10 Jun 2021 12:12:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5EEF1771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623320029;
	bh=QViT8rGUL/5Cac5M0ADUIlNS+rj6ji5Xl0fmYFe/2cI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+vg2HDZW4yuYKkB9G969dozGLkijPEELy1Q0cKUpwSDsM1y5kxkMYbladRhIUHb1
	 +S/SjnQjhs9H8X2xgkI5Ivphtkpj75P/Lq1Rm6bqzpxBeoz49xvT9MgpdR4oqBTK3/
	 D1fKfQgNONpywWQxuOVqjEmH7fNerxnY0oK880DM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E714F800FC;
	Thu, 10 Jun 2021 12:12:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B60E0F80218; Thu, 10 Jun 2021 12:12:57 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A108F800FC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 12:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A108F800FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="ruvosp9h"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="pvNobSpV"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 3517E5C0159;
 Thu, 10 Jun 2021 06:12:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 10 Jun 2021 06:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ncZNSxR1ppkI21OCP2HiLwhuTOM
 r8g4+09TQ+GQzeE4=; b=ruvosp9h50F2tCLtzHnOd0+b5cY0gmkydDNohXG4IMd
 8jPPlPJVt9aOgVxuyJdtZSyL9clP5DLbN9wXN6ayM35LdHmlVzlcNNWkpT2pQ92V
 MiK2EzUncZgWP7K95pTX8+ZtHcd8afn5zut9eJ3bZeyerlx6ZJDIwm6EEMYrPYpM
 uYSpA3zqw5WWwCIouaG2nymmvJ7dRCdIO88sGtVZ8+g9NSK06QrI4zulEtWirr7I
 imGWXQJZMvaGAooG9KDl+9GIHqkPCe9ER+P5sr5IdFI+nouqQupsbHf7I3Dvwdw6
 x42P6OIAMOsMRzeZYiVvgKJtgvmw9KW17LT75ruqxsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ncZNSx
 R1ppkI21OCP2HiLwhuTOMr8g4+09TQ+GQzeE4=; b=pvNobSpVc7CCXfrEYE7zWC
 h0/Zl3/T0yLrobUzgW6RFcq1oDuMdmbpzvKp/HnRABj5roSEHERq2Kc0pVNo3o2F
 ukDTfUftQImPM4HTiVvG1ukDUYhK3xNOT0qvc2YjVrXUf5di+Jzp+1DeDoRHhHIQ
 2Z9kjrZpej1ZCXXM/3BUefrfOfpgpqZFOFACgJOvTQSP/9ebF4sJJFijTw4KqFEp
 NpMuq9YZfw0Qqda/CM3winTTnwsDCFfxavWeYgNz+IF/ssVby4FT17/nu+1sEFQu
 MYVXUwdcKi4ql7NTWMLFNSj1hWwRs9KjPRuL/4lKEErZbHHCH/n587fZzK7rWpoA
 ==
X-ME-Sender: <xms:n-XBYD2kkitpWg2-S9a_rJFkrkrQqFv-oszbqiCoWZ9NvMHyAwecig>
 <xme:n-XBYCHYMOOQp2dXfyJ7TUy1K1x2L2OXBv5LLojZ96h5DN8vUY0b_Nl7bJ2sVU1Qu
 UPjlXF1tZ1qS4mAEkc>
X-ME-Received: <xmr:n-XBYD4ExnF5NjiCEgCejasoHLerACS-k0NDdtkB0jARUBqt1nXDkYXbkbdjzRHEMpgTGVEE8bSdDK-E-8ai5lF8btouM8EqFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
 tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:n-XBYI3uKkt58yAAUAx1NfY06USf2aKCUB8SLiWpyNLIDj74kR1prg>
 <xmx:n-XBYGEE2v_rokT0ursLlaq9L5mkn9KGd3DOz-vVvolJ7SK7NFdceA>
 <xmx:n-XBYJ-fFXjMYTAgYYjFrilRIS-6DUlxk5HIHroCwsirMqoFpIgPug>
 <xmx:oeXBYINeaoNilOQznRXHeDIG3WcYT3HzZSBJ9ivKEJtDPyjG_o8Mdg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 06:12:46 -0400 (EDT)
Date: Thu, 10 Jun 2021 19:12:43 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 1/3] ALSA: pcm: add snd_pcm_period_elapsed() variant
 without acquiring lock of PCM substream
Message-ID: <20210610101243.GA89949@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de,
 alsa-devel@alsa-project.org
References: <20210609143145.146680-1-o-takashi@sakamocchi.jp>
 <20210609143145.146680-2-o-takashi@sakamocchi.jp>
 <s5him2nawim.wl-tiwai@suse.de> <20210609231623.GA3207@workstation>
 <s5h1r9ab22u.wl-tiwai@suse.de> <20210610080521.GA84899@workstation>
 <s5hsg1q9m60.wl-tiwai@suse.de> <20210610082622.GA86308@workstation>
 <s5hpmwu9kuu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpmwu9kuu.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

On Thu, Jun 10, 2021 at 10:36:57AM +0200, Takashi Iwai wrote:
> On Thu, 10 Jun 2021 10:26:22 +0200,
> Takashi Sakamoto wrote:
> > 
> > On Thu, Jun 10, 2021 at 10:08:39AM +0200, Takashi Iwai wrote:
> > > On Thu, 10 Jun 2021 10:05:21 +0200,
> > > Takashi Sakamoto wrote:
> > > > 
> > > > On Thu, Jun 10, 2021 at 09:39:37AM +0200, Takashi Iwai wrote:
> > > > > On Thu, 10 Jun 2021 01:16:23 +0200,
> > > > > Takashi Sakamoto wrote:
> > > > > > 
> > > > > > On Wed, Jun 09, 2021 at 05:27:29PM +0200, Takashi Iwai wrote:
> > > > > > > On Wed, 09 Jun 2021 16:31:43 +0200,
> > > > > > > Takashi Sakamoto wrote:
> > > > > > > > diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> > > > > > > > index b7e3d8f44511..3488ec1e3674 100644
> > > > > > > > --- a/sound/core/pcm_lib.c
> > > > > > > > +++ b/sound/core/pcm_lib.c
> > > > > > > > @@ -1778,27 +1778,41 @@ int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
> > > > > > > >  EXPORT_SYMBOL(snd_pcm_lib_ioctl);
> > > > > > > >  
> > > > > > > >  /**
> > > > > > > > - * snd_pcm_period_elapsed - update the pcm status for the next period
> > > > > > > > - * @substream: the pcm substream instance
> > > > > > > > + * snd_pcm_period_elapsed_under_stream_lock() - update the status of runtime for the next period
> > > > > > > > + *						under acquired lock of PCM substream.
> > > > > > > > + * @substream: the instance of pcm substream.
> > > > > > > > + *
> > > > > > > > + * This function is called when the batch of audio data frames as the same size as the period of
> > > > > > > > + * buffer is already processed in audio data transmission.
> > > > > > > > + *
> > > > > > > > + * The call of function updates the status of runtime with the latest position of audio data
> > > > > > > > + * transmission, checks overrun and underrun over buffer, awaken user processes from waiting for
> > > > > > > > + * available audio data frames, sampling audio timestamp, and performs stop or drain the PCM
> > > > > > > > + * substream according to configured threshold.
> > > > > > > > + *
> > > > > > > > + * The function is intended to use for the case that PCM driver operates audio data frames under
> > > > > > > > + * acquired lock of PCM substream; e.g. in callback of any operation of &snd_pcm_ops in process
> > > > > > > > + * context. In any interrupt context, it's preferrable to use ``snd_pcm_period_elapsed()`` instead
> > > > > > > > + * since lock of PCM substream should be acquired in advance.
> > > > > > > >   *
> > > > > > > > - * This function is called from the interrupt handler when the
> > > > > > > > - * PCM has processed the period size.  It will update the current
> > > > > > > > - * pointer, wake up sleepers, etc.
> > > > > > > > + * Developer should pay enough attention that some callbacks in &snd_pcm_ops are done by the call of
> > > > > > > > + * function:
> > > > > > > >   *
> > > > > > > > - * Even if more than one periods have elapsed since the last call, you
> > > > > > > > - * have to call this only once.
> > > > > > > > + * - .pointer - to retrieve current position of audio data transmission by frame count or XRUN state.
> > > > > > > > + * - .trigger - with SNDRV_PCM_TRIGGER_STOP at XRUN or DRAINING state.
> > > > > > > > + * - .get_time_info - to retrieve audio time stamp if needed.
> > > > > > > > + *
> > > > > > > > + * Even if more than one periods have elapsed since the last call, you have to call this only once.
> > > > > > > > + *
> > > > > > > > + * Context: Any context in which lock of PCM substream is already acquired. This function may not
> > > > > > > > + * sleep.
> > > > > > > 
> > > > > > > Hm, this text still remains here.  Overlooked?
> > > > > > 
> > > > > > It's my intension for documentation of
> > > > > > snd_pcm_period_elapsed_under_stream_lock() since it's expected to call
> > > > > > it under acquired lock. Its implementation doesn't yield processor
> > > > > > voluntarily by itself. If it yielded, it would depend on implementation
> > > > > > of each driver for struct snd_pcm_ops.{pointer, trigger, get_time_info},
> > > > > > but it's not preferable implementation of driver, in my opinion.
> > > > > 
> > > > > My point is again about the sleep.  This function may sleep in the
> > > > > nonatomic mode.  The type of the PCM stream lock depends on it.
> > > > 
> > > > Would I simply request you to show how the added function yields except
> > > > for the driver implementation? The lock of stream is expected to be
> > > > acquired already.
> > > 
> > > In the nonatomic mode, the PCM stream lock is a mutex (no
> > > spin_lock_irqsave), hence it can sleep -- which contradicts with the
> > > added description above.
> > > 
> > > Or do I misunderstand your question...? 
> > 
> > Thanks to clarify the role of PCM stream lock, and I'm ease that we have
> > the same understanding about the lock.
> > 
> > Here, let us see deleted/added line again.
> > 
> > > diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> > > index b7e3d8f44511..3488ec1e3674 100644
> > > --- a/sound/core/pcm_lib.c
> > > +++ b/sound/core/pcm_lib.c
> > > @@ -1778,27 +1778,41 @@ int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
> > >  EXPORT_SYMBOL(snd_pcm_lib_ioctl);
> > >  
> > >  /**
> > > - * snd_pcm_period_elapsed - update the pcm status for the next period
> > > - * @substream: the pcm substream instance
> > > + * snd_pcm_period_elapsed_under_stream_lock() - update the status of runtime for the next period
> > > + *						under acquired lock of PCM substream.
> > > + ...
> > > + * Context: Any context in which lock of PCM substream is already acquired. This function may not
> > > + * sleep.
> > 
> > The issued documentation is for the new function. Inner the function, the
> > lock of PCM substream is not acquired again since it causes dead lock
> > (it's not nest-able lock) regardless of usage of mutex or spin_lock.
> > 
> > The well-known function, snd_pcm_period_elapsed(), is rewritten to call
> > the new function between lock/unlock operations:
> > 
> > ->snd_pcm_period_elapsed()
> >   ->snd_pcm_stream_lock_irqsave()
> >   ->snd_pcm_period_elapsed_under_stream_lock()
> >   ->snd_pcm_stream_unlock_irqrestore()
> > 
> > Or the new function can acquire the lock somewhere I overlook? However I
> > think it is unlikely since it necessarily causes dead lock or corruption
> > of irq context...
> 
> Again, my *only* point is about the sleep.  You addition was:
> 
> + * Context: Any context in which lock of PCM substream is already acquired. This function may not
> + * sleep.
> 
> where "This function may not sleep" is stated incorrectly.

Hm. Would I request you to show the detail case that the call of function
(snd_pcm_period_elapsed_under_stream_lock()) goes sleep except for
driver-side implementation of snd_pcm_ops.{pointer, trigger,
get_time_info}? At least, in callgraph I find no function call to
yield...


Regards

Takashi Sakamoto
