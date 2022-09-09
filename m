Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3315DECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 19:40:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 733C916A0;
	Fri,  9 Sep 2022 21:39:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 733C916A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662752425;
	bh=/KEf0a4IB8JrZkmOBfNnd5Ddb0g+tabTRqTn5t2pujA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VuOMyPFRiFsZhTZzL8Lv45hL4Et0GE1kApKRHKWi/iDi9p4kQf5vlUD1ZI+XTRhuK
	 fngQzEGYvhfFZaMb1wrWyyjxNZwUi+dY+/qRb8gNJ9Ad+w/VWL1+aoehdZn+uOwBMo
	 czz2AI0fXGtEzbz4Ll8gXl4BDhESn+JhHhUhmDXM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E198CF8016D;
	Fri,  9 Sep 2022 21:39:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92012F8023A; Fri,  9 Sep 2022 21:39:33 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C7E0F80105
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 21:39:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C7E0F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Fh0G/yca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662752367; x=1694288367;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/KEf0a4IB8JrZkmOBfNnd5Ddb0g+tabTRqTn5t2pujA=;
 b=Fh0G/ycaAcLjOGs0ZA829fh2rDBs0f6OjwWSLT6/txDzBxAg2oiaiaxH
 Xr40LAv10DRRw8IQjGoiND3Z8//YhKkp6tI3hzoVO7J4+TpZlB4k+LZbq
 DUlp7cwOIWNZ0is9u1b2Pa2JUaor1ye6BOH76UoxtYedB9MRe2m1d2Rm+
 jjZasRdk7Yo209a/0sidcJLqwHuwUVrI3inY3ndD0Dkoq5P47oCXxiQod
 V3rs8QpQZmupjXPOBRhv1xorlO7e0kX/tNEJFKwsdQOZla99J8W7FgaoM
 s0nhHIuHYPyT5tvEDZyEvmjpjOkWBzSF8KRi8rQfrbnji1TKdDBU/LXml w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280577060"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; d="scan'208";a="280577060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2022 12:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; d="scan'208";a="617933200"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
 by fmsmga007.fm.intel.com with SMTP; 09 Sep 2022 12:39:19 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 09 Sep 2022 22:39:19 +0300
Date: Fri, 9 Sep 2022 22:39:19 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: hda codec unbind refcount hang
Message-ID: <YxuWZ/4+bKYChcge@intel.com>
References: <YxtflWQnslMHVlU7@intel.com>
 <87fsh0czd8.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsh0czd8.wl-tiwai@suse.de>
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

On Fri, Sep 09, 2022 at 05:59:47PM +0200, Takashi Iwai wrote:
> On Fri, 09 Sep 2022 17:45:25 +0200,
> Ville Syrjälä wrote:
> > 
> > Hi Takashi,
> > 
> > commit 7206998f578d ("ALSA: hda: Fix potential deadlock at codec
> > unbinding") introduced a problem on at least one of my older machines.
> > 
> > The problem happens when hda_codec_driver_remove() encounters a
> > codec without any pcms (and thus the refcount is 1) and tries to
> > call refcount_dec(). Turns out refcount_dec() doesn't like to be
> > used for dropping the refcount to 0, and instead if spews a warning
> > and does its saturate thing. The subsequent wait_event() is then
> > permanently stuck waiting on the saturated refcount.
> > 
> > I've definitely seen the same kind of pattern used elsewhere
> > in the kernel as well, so the fact that refcount_t can't be used
> > to implement it is a bit of surprise to me. I guess most other
> > places still use atomic_t instead.
> 
> Does the patch below work around it?  It seem to be a subtle
> difference between refcount_dec() and refcount_dec_and_test().

Aye, this works.

Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> --- a/sound/pci/hda/hda_bind.c
> +++ b/sound/pci/hda/hda_bind.c
> @@ -157,10 +157,11 @@ static int hda_codec_driver_remove(struct device *dev)
>  		return codec->bus->core.ext_ops->hdev_detach(&codec->core);
>  	}
>  
> -	refcount_dec(&codec->pcm_ref);
> -	snd_hda_codec_disconnect_pcms(codec);
> -	snd_hda_jack_tbl_disconnect(codec);
> -	wait_event(codec->remove_sleep, !refcount_read(&codec->pcm_ref));
> +	if (!refcount_dec_and_test(&codec->pcm_ref)) {
> +		snd_hda_codec_disconnect_pcms(codec);
> +		snd_hda_jack_tbl_disconnect(codec);
> +		wait_event(codec->remove_sleep, !refcount_read(&codec->pcm_ref));
> +	}
>  	snd_power_sync_ref(codec->bus->card);
>  
>  	if (codec->patch_ops.free)

-- 
Ville Syrjälä
Intel
