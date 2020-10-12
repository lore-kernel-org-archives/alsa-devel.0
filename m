Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D8EC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:25:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B853520708
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oQVkYiwR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzaxedCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B853520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E505826;
	Mon, 12 Oct 2020 14:24:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E505826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602505525;
	bh=2uW/a1bAZmOFte2yiclcX856UkECJSRwuCm8p3dbzZ8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQVkYiwRVU6vBiyy1NzlUhux/15W15lYY9RQykiclhLeqniwmNYQU6p3hI8yif0LI
	 FgfZP6ViG3AHhVUJ8w9o+4IGVVGoKo7unBHGHLNBvcijSsl6l+ukvYCmegwFQqnPst
	 rfO482I5zvFAFPIOY4TpAxFvbqjeUNDOsTkocltY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98456F8020D;
	Mon, 12 Oct 2020 14:24:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED756F80217; Mon, 12 Oct 2020 14:24:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B931F80141
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 14:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B931F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FzaxedCZ"
Received: from localhost (unknown [122.182.245.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1110720708;
 Mon, 12 Oct 2020 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602505467;
 bh=2uW/a1bAZmOFte2yiclcX856UkECJSRwuCm8p3dbzZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FzaxedCZyQF/MVvRVIb9o3BVdXaq8NLgx2laAVROs7ZOE0slJ/j8wjbSa3Xm4zAIe
 c9//qSbOnjlQWJ5yS1y+XoaG7YalQpVIUevkeP/gm+a3U2e10JS/UWBF5ckwlVJLaw
 UHi4aoTY5TzS6HufMaXQt0UIO01kqCPn9tW+dNcc=
Date: Mon, 12 Oct 2020 17:54:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: compress: allow pause and resume during draining
Message-ID: <20201012122423.GJ2968@vkoul-mobl>
References: <20201001102938.GU2968@vkoul-mobl>
 <2bf52360-bd11-b4cd-b255-8a5610b4aa5f@linux.intel.com>
 <20201006062105.GQ2968@vkoul-mobl>
 <4bbc385b-d35a-8766-7981-034455287225@linux.intel.com>
 <000d01d69d58$4e2db6f0$ea8924d0$@samsung.com>
 <s5hr1q7sa9f.wl-tiwai@suse.de>
 <831bbfcf-9720-9100-8633-65932b415cab@perex.cz>
 <s5ha6wusb2l.wl-tiwai@suse.de> <20201012052525.GH2968@vkoul-mobl>
 <s5hk0vwq65o.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk0vwq65o.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, pilsun.jang@samsung.com,
 khw0178.kim@samsung.com, lgirdwood@gmail.com, kimty@samsung.com,
 s47.kang@samsung.com, tiwai@suse.com,
 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>,
 hmseo@samsung.com, Gyeongtaek Lee <gt82.lee@samsung.com>, tkjung@samsung.com
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

On 12-10-20, 09:01, Takashi Iwai wrote:
> On Mon, 12 Oct 2020 07:25:25 +0200,

> > So what if we add another state but keep it in kernel (hidden from
> > userspace)...?
> 
> That's fine, then it's just a kernel's business, and it should be
> determined which one makes the code better.
> 
> But, there are things to be considered, though:
> 
> - SNDRV_PCM_STATE_* is defined as snd_pcm_state_t with __bitwise.
>   This indicates that the type has to be defined in that way
>   explicitly.
> 
> - Having a value over SNDRV_PCM_STATE_LAST internally is hackish.
> 
> > Right now tinycompress does not make use of PCM streams, kernel handles
> > these. I am not aware of any other implementation.
> > 
> > So if the scope if within compress then it might work...
> 
> Yes.  But currently the API uses SND_PCM_* even for the compress
> stuff.  Changing this value means to have influence on PCM, even if
> PCM stuff doesn't use it yet.  (At least you'd need to increase
> SND_PCM_STATE_LAST, for example.)
> 
> That said, if we want to change only for compress API by assuming that
> the impact must be negligible, the first step would be to move from
> SND_PCM_STATE_* to the own state, SND_COMPRESS_STATE_*.  The values
> should be compatible, but this has to be changed at first.  Then you
> can introduce a new value there.

I think that sounds reasonable to me, we should not have used
SNDRV_PCM_STATE_* in the first place and long term fix for this should
be SNDRV_COMPRESS_STATE_

I will cook a patch for this

Thanks
-- 
~Vinod
