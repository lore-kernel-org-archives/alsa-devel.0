Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4B1EB64DA
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jun 2023 13:16:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0077CDF8;
	Mon, 26 Jun 2023 15:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0077CDF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687785389;
	bh=MpQMx3MfyrvnZ8hk3RK88klCQosnx1Rb27lCzpLW26Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sSQVgiEv7Y3dJ/aN5wSEx4FivdF2pOynzgepwZ1QtMw4PvwLz80/opWF9QExU/OC8
	 96XLGEVc5IZ68Aap8KcL/cC/72SNMHrc6s+yDsdInjOP+roV59uRC/QYrCbjlsX4fJ
	 hXpovQwYP131aJ1rywAhZOupzO0J5caJkfaZkIAE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51A23F80093; Mon, 26 Jun 2023 15:15:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA005F80246;
	Mon, 26 Jun 2023 15:15:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BEBEF80246; Mon, 26 Jun 2023 15:15:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D854CF80093
	for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2023 15:15:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D854CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fzZFAPE0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=RIxn85ty
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48CFC2186C;
	Mon, 26 Jun 2023 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1687785325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qcdlrRe7UNQ3MoyAvsaAyy1Z+/jbolyeeT23DgRd4g=;
	b=fzZFAPE09sPo7Jfzczkugqdvrwvi69PlDLdEEHlMk6ePa2D7tbb0aa99sAxnakFSkdxgkn
	44Yc5KFD7CEelcPtfK2gUH9Lg2qDQnGdWtDBbKATNoOPMO0utA4hI0wrgiK8LiSr4vSYOY
	B5bNHk7XYlhzon/Gchx3/iDLskfVMV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687785325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qcdlrRe7UNQ3MoyAvsaAyy1Z+/jbolyeeT23DgRd4g=;
	b=RIxn85tyyPk5Oy2URnHvbhkXbGJQG/l+78cUA5jfJXbXULX0a8kIb1OXuL9MBrGwBoDPRZ
	40rfR93ujIiRV8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17E7613483;
	Mon, 26 Jun 2023 13:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ls88BG2PmWQhYQAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 26 Jun 2023 13:15:25 +0000
Date: Mon, 26 Jun 2023 15:15:24 +0200
Message-ID: <87jzvquzyr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Tuo Li <islituo@gmail.com>,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	baijiaju1990@outlook.com
Subject: Re: [BUG] ALSA: core: pcm_memory: a possible data race in
 do_alloc_pages()
In-Reply-To: <87ttuuv5m6.wl-tiwai@suse.de>
References: 
 <CADm8Tek6t0WedK+3Y6rbE5YEt19tML8BUL45N2ji4ZAz1KcN_A@mail.gmail.com>
	<877crqwvi1.wl-tiwai@suse.de>
	<CADm8Tenfy8joto5WLCqQWjfT8WimsbJgOss0hJe-ciyDRMrSXw@mail.gmail.com>
	<871qhywucj.wl-tiwai@suse.de>
	<4d0931bf-b356-6969-5aaf-b663d7f2b21a@perex.cz>
	<87wmzqv64o.wl-tiwai@suse.de>
	<45445f57-0a73-59e6-6f3d-3983ce93a324@perex.cz>
	<87ttuuv5m6.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: UKPDE6HTFTRAB5BWZTAFGGSUKRG7LX65
X-Message-ID-Hash: UKPDE6HTFTRAB5BWZTAFGGSUKRG7LX65
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UKPDE6HTFTRAB5BWZTAFGGSUKRG7LX65/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 26 Jun 2023 13:13:21 +0200,
Takashi Iwai wrote:
> 
> On Mon, 26 Jun 2023 13:09:00 +0200,
> Jaroslav Kysela wrote:
> > 
> > On 26. 06. 23 13:02, Takashi Iwai wrote:
> > > On Mon, 26 Jun 2023 09:56:47 +0200,
> > > Jaroslav Kysela wrote:
> > >> 
> > >> On 26. 06. 23 9:33, Takashi Iwai wrote:
> > >>> On Mon, 26 Jun 2023 09:31:18 +0200,
> > >>> Tuo Li wrote:
> > >>>> 
> > >>>> 
> > >>>> Hello,
> > >>>> 
> > >>>> Thank you for your reply!
> > >>> 
> > >>> FWIW, the simplest fix would be something like below, just extending
> > >>> the mutex coverage.  But it'll serialize the all calls, so it might
> > >>> influence on the performance, while it's the safest way.
> > >> 
> > >> It may be better to update total_pcm_alloc_bytes before
> > >> snd_dma_alloc_dir_pages() call and decrease this value when allocation
> > >> fails to allow parallel allocations. Then the mutex can be held only
> > >> for the total_pcm_alloc_bytes variable update.
> > > 
> > > Yes, it'd work.  But a tricky part is that the actual allocation size
> > > can be bigger, and we need to correct the total_pcm_alloc_bytes after
> > > the allocation result.  So the end result would be a patch like below,
> > > which is a bit more complex than the previous simpler approach.  But
> > > it might be OK.
> > 
> > The patch looks good, but it may be better to move the "post" variable
> > updates to an inline function (mutex lock - update - mutex unlock) for
> > a better readability.
> 
> Sounds like a good idea.  Let me cook later.

... and here it is.

If that looks OK, I'll submit a proper fix patch.


thanks,

Takashi

--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -31,15 +31,41 @@ static unsigned long max_alloc_per_card = 32UL * 1024UL * 1024UL;
 module_param(max_alloc_per_card, ulong, 0644);
 MODULE_PARM_DESC(max_alloc_per_card, "Max total allocation bytes per card.");
 
+static void __update_allocated_size(struct snd_card *card, ssize_t bytes)
+{
+	card->total_pcm_alloc_bytes += bytes;
+}
+
+static void update_allocated_size(struct snd_card *card, ssize_t bytes)
+{
+	mutex_lock(&card->memory_mutex);
+	__update_allocated_size(card, bytes);
+	mutex_unlock(&card->memory_mutex);
+}
+
+static void decrease_allocated_size(struct snd_card *card, size_t bytes)
+{
+	mutex_lock(&card->memory_mutex);
+	WARN_ON(card->total_pcm_alloc_bytes < bytes);
+	__update_allocated_size(card, -(ssize_t)bytes);
+	mutex_unlock(&card->memory_mutex);
+}
+
 static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 			  int str, size_t size, struct snd_dma_buffer *dmab)
 {
 	enum dma_data_direction dir;
 	int err;
 
+	/* check and reserve the requested size */
+	mutex_lock(&card->memory_mutex);
 	if (max_alloc_per_card &&
-	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
+	    card->total_pcm_alloc_bytes + size > max_alloc_per_card) {
+		mutex_unlock(&card->memory_mutex);
 		return -ENOMEM;
+	}
+	__update_allocated_size(card, size);
+	mutex_unlock(&card->memory_mutex);
 
 	if (str == SNDRV_PCM_STREAM_PLAYBACK)
 		dir = DMA_TO_DEVICE;
@@ -47,9 +73,14 @@ static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 		dir = DMA_FROM_DEVICE;
 	err = snd_dma_alloc_dir_pages(type, dev, dir, size, dmab);
 	if (!err) {
-		mutex_lock(&card->memory_mutex);
-		card->total_pcm_alloc_bytes += dmab->bytes;
-		mutex_unlock(&card->memory_mutex);
+		/* the actual allocation size might be bigger than requested,
+		 * and we need to correct the account
+		 */
+		if (dmab->bytes != size)
+			update_allocated_size(card, dmab->bytes - size);
+	} else {
+		/* take back on allocation failure */
+		decrease_allocated_size(card, size);
 	}
 	return err;
 }
@@ -58,10 +89,7 @@ static void do_free_pages(struct snd_card *card, struct snd_dma_buffer *dmab)
 {
 	if (!dmab->area)
 		return;
-	mutex_lock(&card->memory_mutex);
-	WARN_ON(card->total_pcm_alloc_bytes < dmab->bytes);
-	card->total_pcm_alloc_bytes -= dmab->bytes;
-	mutex_unlock(&card->memory_mutex);
+	decrease_allocated_size(card, dmab->bytes);
 	snd_dma_free_pages(dmab);
 	dmab->area = NULL;
 }
