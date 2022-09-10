Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAF3ECAAD5
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Sep 2022 11:55:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96A86E12;
	Sat, 10 Sep 2022 13:54:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96A86E12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662810932;
	bh=3dQR1WVCaO9HFtI1vBDjT6MtqBEEhaRnSW3jf9SuijU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jW0IN/0pPFHTUEyJsIYcRG2KxiadfvjHOA+jkT6UZNvQyum2ed22g0wHWdoIjI+hk
	 zfYJQrnpLWBCLP5vL3uJBC9F7h6yOl0lOHKuHADpf3SbN1RULaAE8uEWB/AKBEK55N
	 5v4E69Vqo3x4ANQ7z2LrWPB0jUQw0L09jQTaEGtc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30086F8016C;
	Sat, 10 Sep 2022 13:54:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EF74F8011C; Sat, 10 Sep 2022 13:54:41 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97CD6F8011C
 for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2022 13:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97CD6F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="R/0z5tTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662810875; x=1694346875;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3dQR1WVCaO9HFtI1vBDjT6MtqBEEhaRnSW3jf9SuijU=;
 b=R/0z5tTmpfHDnXdihVn2lCEIXSvS61yjd758oPpZJVF6uT+xrf4NWpWS
 P2B3U5eVtmV5b46+m4CR8+kIKJmnJ64j5av+911sRJ3qt6bW2RSEQCL4j
 G2uCSL0fdkHectlDGeohV7pQHVZZphMPIUF17GNG1HTuDu3JeDmXYo2RY
 vk9QBGVmZ/T7HzeGWjE2bBihIQoex5FLDhKeKCa48XduViKLi2zt9h3/r
 HA5uyykm1poQucFvEjtwT2o00Hjv/lL2tDZJ4mzTyY9CC0cfrHLPU2liC
 a/fF3J/hnBAANE6xWym9VjXfTQwX9uQ9CRcSZ+xFjK25NDcJo1dEzjam8 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="383933164"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; d="scan'208";a="383933164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2022 04:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; d="scan'208";a="648732026"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
 by orsmga001.jf.intel.com with SMTP; 10 Sep 2022 04:54:12 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Sat, 10 Sep 2022 14:54:11 +0300
Date: Sat, 10 Sep 2022 14:54:11 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: hda codec unbind refcount hang
Message-ID: <Yxx64xTn0WDcKkWa@intel.com>
References: <YxtflWQnslMHVlU7@intel.com> <87fsh0czd8.wl-tiwai@suse.de>
 <YxuWZ/4+bKYChcge@intel.com> <8735czcywj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735czcywj.wl-tiwai@suse.de>
X-Patchwork-Hint: comment
Cc: alsa-devel@alsa-project.org
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

On Sat, Sep 10, 2022 at 12:22:04PM +0200, Takashi Iwai wrote:
> On Fri, 09 Sep 2022 21:39:19 +0200,
> Ville Syrjälä wrote:
> > 
> > On Fri, Sep 09, 2022 at 05:59:47PM +0200, Takashi Iwai wrote:
> > > On Fri, 09 Sep 2022 17:45:25 +0200,
> > > Ville Syrjälä wrote:
> > > > 
> > > > Hi Takashi,
> > > > 
> > > > commit 7206998f578d ("ALSA: hda: Fix potential deadlock at codec
> > > > unbinding") introduced a problem on at least one of my older machines.
> > > > 
> > > > The problem happens when hda_codec_driver_remove() encounters a
> > > > codec without any pcms (and thus the refcount is 1) and tries to
> > > > call refcount_dec(). Turns out refcount_dec() doesn't like to be
> > > > used for dropping the refcount to 0, and instead if spews a warning
> > > > and does its saturate thing. The subsequent wait_event() is then
> > > > permanently stuck waiting on the saturated refcount.
> > > > 
> > > > I've definitely seen the same kind of pattern used elsewhere
> > > > in the kernel as well, so the fact that refcount_t can't be used
> > > > to implement it is a bit of surprise to me. I guess most other
> > > > places still use atomic_t instead.
> > > 
> > > Does the patch below work around it?  It seem to be a subtle
> > > difference between refcount_dec() and refcount_dec_and_test().
> > 
> > Aye, this works.
> > 
> > Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Good to hear.
> 
> I think the below is slightly safer, assuring the other *_disconnect()
> calls.
> 
> Could you give it a try again?  Once after confirming it works, I'll
> re-submit and merge to my tree.

This works too. Thanks

Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda: Fix hang at HD-audio codec unbinding due to refcount saturation
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> We fixed the potential deadlock at dynamic unbinding the HD-audio
> codec at the commit 7206998f578d ("ALSA: hda: Fix potential deadlock
> at codec unbinding"), but ironically, this caused another potential
> deadlock.  The current code uses refcount_dec() and waits for the
> pending task with wait_event for dropping the refcount to 0.  This
> works fine when PCMs are assigned and actually waiting for the
> refcount drop.
> 
> Meanwhile, when there was no PCM assigned, the refcount_dec() call
> itself was supposed to drop to zero -- alas, it doesn't in reality;
> refcount_dec() complains, spews kernel warning and it saturates
> instead of dropping to 0, due to the nature of refcount_dec()
> implementation.  This eventually blocks the wait_event() wakeup and
> the code get stuck there.
> 
> For avoiding the problem, we call refcount_dec_and_test() and skips
> the sync-wait if it already reaches to zero.
> 
> The patch does a slight code reshuffling to make sure to invoke other
> disconnect calls before the sync-wait, too.
> 
> Fixes: 7206998f578d ("ALSA: hda: Fix potential deadlock at codec unbinding")
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/YxtflWQnslMHVlU7@intel.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_bind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
> index cae9a975cbcc..1a868dd9dc4b 100644
> --- a/sound/pci/hda/hda_bind.c
> +++ b/sound/pci/hda/hda_bind.c
> @@ -157,10 +157,10 @@ static int hda_codec_driver_remove(struct device *dev)
>  		return codec->bus->core.ext_ops->hdev_detach(&codec->core);
>  	}
>  
> -	refcount_dec(&codec->pcm_ref);
>  	snd_hda_codec_disconnect_pcms(codec);
>  	snd_hda_jack_tbl_disconnect(codec);
> -	wait_event(codec->remove_sleep, !refcount_read(&codec->pcm_ref));
> +	if (!refcount_dec_and_test(&codec->pcm_ref))
> +		wait_event(codec->remove_sleep, !refcount_read(&codec->pcm_ref));
>  	snd_power_sync_ref(codec->bus->card);
>  
>  	if (codec->patch_ops.free)
> -- 
> 2.35.3

-- 
Ville Syrjälä
Intel
