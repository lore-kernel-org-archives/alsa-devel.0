Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FAC4743D
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 06:49:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6A961374
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 06:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6A961374
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DBCD17A1;
	Fri, 11 Jun 2021 08:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DBCD17A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623394158;
	bh=JbOwT8LMQziPSHMqDTawRVuxGRMEJKAyfUBxHuUCvSY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buqlAgrxA+Ha4paaw584Cig3+2GE++4E5O8JVExIZFLMe9A1rQSurQ8A0tocs6PEk
	 P9KQjeDxElcIq9uRN3pf1RslNjw1jjFtZYk18l+7LTaHI1akEFBY8Q8Tkjwe5jxtd+
	 l2IHVJ5YK7QPk0iKm4n/9s2caSdxba67AKSCF+/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE242F800FB;
	Fri, 11 Jun 2021 08:48:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D59B2F8026C; Fri, 11 Jun 2021 08:48:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDDE4F800FC
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 08:48:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDDE4F800FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="z9frLaQ3"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="UB/fFA18"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0DC3F1FD3F;
 Fri, 11 Jun 2021 06:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623394080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajZRp2smLZPTkQAgBc6eh7NL/Sx+YI9eZM26vSgJG18=;
 b=z9frLaQ3NavfDj+hTaG7mvWjciaPXyb2MLsDCBCekJW6f8RHcFRiuGAc88FAs+ebjU0AA9
 AW1kQKz2bpAIyKrEbeNdHSpiFUk1AIS7fReGM9NLjDOkdvixR5NhPh1gDUCvKgooa551FT
 1RrsGb7j8SU87fXses6FibhHoUuroEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623394080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajZRp2smLZPTkQAgBc6eh7NL/Sx+YI9eZM26vSgJG18=;
 b=UB/fFA18KNqr/CvlZ82e5MasMr1TA91Kn6UH1Yn+qR349jIiJcnarg6nuYJGOmaT8fP3Xx
 s4+lM/RT0rv0jADA==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 06FBFA3B84;
 Fri, 11 Jun 2021 06:47:59 +0000 (UTC)
Date: Fri, 11 Jun 2021 08:47:59 +0200
Message-ID: <s5him2k99sw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 1/3] ALSA: pcm: add snd_pcm_period_elapsed() variant
 without acquiring lock of PCM substream
In-Reply-To: <20210611033816.GA10978@workstation>
References: <20210609143145.146680-2-o-takashi@sakamocchi.jp>
 <s5him2nawim.wl-tiwai@suse.de> <20210609231623.GA3207@workstation>
 <s5h1r9ab22u.wl-tiwai@suse.de> <20210610080521.GA84899@workstation>
 <s5hsg1q9m60.wl-tiwai@suse.de> <20210610082622.GA86308@workstation>
 <s5hpmwu9kuu.wl-tiwai@suse.de> <20210610101243.GA89949@workstation>
 <s5hfsxq9e2w.wl-tiwai@suse.de> <20210611033816.GA10978@workstation>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 11 Jun 2021 05:38:16 +0200,
Takashi Sakamoto wrote:
> 
> Hi,
> 
> On Thu, Jun 10, 2021 at 01:03:19PM +0200, Takashi Iwai wrote:
> > On Thu, 10 Jun 2021 12:12:43 +0200, Takashi Sakamoto wrote:
> > > 
> > > On Thu, Jun 10, 2021 at 10:36:57AM +0200, Takashi Iwai wrote:
> > > > Again, my *only* point is about the sleep.  You addition was:
> > > > 
> > > > + * Context: Any context in which lock of PCM substream is already acquired. This function may not
> > > > + * sleep.
> > > > 
> > > > where "This function may not sleep" is stated incorrectly.
> > > 
> > > Hm. Would I request you to show the detail case that the call of function
> > > (snd_pcm_period_elapsed_under_stream_lock()) goes sleep except for
> > > driver-side implementation of snd_pcm_ops.{pointer, trigger,
> > > get_time_info}? At least, in callgraph I find no function call to
> > > yield...
> > 
> > True.  But the fact that those callbacks may sleep means that the
> > function would go sleeping after all.
> 
> Thanks. After all, our discussion comes from the ambiguity that what
> has responsibility at yielding processor under the lock. I think it helpful
> to describe devide responsibilities about the yielding. I'm glad for you
> to review patch below:

Well, I don't think it's worth to mention "ALSA core may not sleep".
It's just casually so for now, but it doesn't mean that this will be
guaranteed in future.  After all, this function call may sleep in
the nonatomic mode (that's the very reason for that mode!), and the
caller has to be prepared for that, no matter whether you do sleep in
the callbacks or not.


thanks,

Takashi

> 
> ======== 8< --------
> 
> >From 98e1b8332a95935ae875c637d3ddc27e68689aa0 Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Fri, 11 Jun 2021 11:03:46 +0900
> Subject: [PATCH] ALSA: pcm: add context section for documentation about
>  period-elapsed kernel APIs
> 
> This commit fulfils documentation of period-elapsed kernel APIs with their
> context section.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/core/pcm_lib.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 7d5883432085..5d28d63a3216 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -1803,6 +1803,10 @@ EXPORT_SYMBOL(snd_pcm_lib_ioctl);
>   * - .get_time_info - to retrieve audio time stamp if needed.
>   *
>   * Even if more than one periods have elapsed since the last call, you have to call this only once.
> + *
> + * Context: Any context in which lock of PCM substream is already acquired. The function may not
> + * sleep by ALSA PCM core. The function may sleep in the above callbacks by driver which should
> + * configures PCM device for it (@snd_pcm.nonatomic).
>   */
>  void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substream)
>  {
> @@ -1836,6 +1840,10 @@ EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
>   * It's typically called by any type of IRQ handler when hardware IRQ occurs to notify event that
>   * the batch of audio data frames as the same size as the period of buffer is already processed in
>   * audio data transmission.
> + *
> + * Context: Any context in which lock of PCM substream is not acquired yet. It depends on
> + * configuration of PCM device (@snd_pcm.nonatomic) by driver whether the function may or may not
> + * sleep by operating lock of PCM substream.
>   */
>  void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
>  {
> -- 
> 2.27.0
> 
> ======== 8< --------
> 
> Thanks
> 
> Takashi Sakamoto
> 
