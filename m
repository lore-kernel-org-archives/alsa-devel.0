Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48132C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:18:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9B42077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tAdbRfRP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GSLGYrEN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yrBDTuXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9B42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 106C214E;
	Mon,  9 Dec 2019 16:17:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 106C214E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575904683;
	bh=y16Bm0hsg3VVq9sQ5CFn+liUcYtzmVpsdsfT9rtz+1E=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAdbRfRPLlXz/HpTfKUHo51QbPCf/rpo0bFLchsiEmOp4X5hMkXOoCgebK6S6YVAh
	 9+j7zlfgASfevMwHF/cJcy/f7pAnnw10fF31I4qrXskVSpvt6b/3YffJ04Gm309FOI
	 LxThPRucqQOTVeDhdyklB/7G1U7BlycYZ/eVtmsc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6769DF801F4;
	Mon,  9 Dec 2019 16:17:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EF34F80234; Mon,  9 Dec 2019 16:17:11 +0100 (CET)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5528F800E1
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 16:17:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5528F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="GSLGYrEN"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="yrBDTuXJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A0A4122AB0;
 Mon,  9 Dec 2019 10:17:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 09 Dec 2019 10:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=4F1NDFK0WHCoFZy9Tpk4+x4hS0e
 gxbP2DlfQTkOR9vw=; b=GSLGYrENOJAoh6Z2qmt2FU94rsKx+vYaGyDekjc6S1g
 XUjPJDnRgwKDsmLb7gDtzz557bMFVAT99Hw61UvZx8idTpBZvuGfftpUUS+Zp458
 9zcsPN9rIKQZYxZN3i/e3GXquLPfFlmwZs9RAzbpV6xQ+5hS84lV8ZodJhkHse/A
 OkJ/JTGuaKFBKagRluozfg2J+mwbpbgic1komv7YiwwCmp3aamZu2yeDCFOy1hV6
 jBrxIiIUWI3ha7+AayyE9rQN7d5Zwh7smiQ82lSeGBMIj4+BkBBilsaXi4yukWlF
 2WhJlK6ReldAJXQnA5BUxN6poIdbIHcSbRil5FoLYSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4F1NDF
 K0WHCoFZy9Tpk4+x4hS0egxbP2DlfQTkOR9vw=; b=yrBDTuXJuOFL0SR1xBq7ig
 i/pDuyNVguZfETyYh7FsmF37vDFAi1aySdlx73IYH7bTSgKj9j3856pJK48fMrLz
 z/psDPtGbWTDknA6KbKtcIe4UT7ExkcGxCAhBDeoVQhADX24Aa+EcitWPpucxxUX
 XNIEdH+QJq12k8YHLXG0IVVuWFKuz7Yt9VTofhQnxK+X/57Dm0hjtepxT+MHqKM1
 5LJ9tG9oXK9Dea75i0+Gy9SR+lENvrZvMcv+axfZLy1QizHRpKivwoD8ziUv33dw
 8T4gtvU1ZjVAs7f91h5qH1EaxYaGRoxz2D7H4tCpnNGw0d/dGTfFY3z5fh1yK+Bg
 ==
X-ME-Sender: <xms:bGXuXXPjf4Kyzj1cU3qnzmsYeUacklcxp6hVt2zMS0iOfhqnBT2r-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecukfhppedugedrfedrjeehrddukedunecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpnecuvehluhhsthgvrhfuih
 iivgeptd
X-ME-Proxy: <xmx:bGXuXeQWfKDwcsTIh6eGFZ7u9ms8YilIaT65x9FcAE_T1eh7iiUE6w>
 <xmx:bGXuXZCglbKzR4Chjx1-bTcCTcY0vRlwmZoOSOxZSFy85ljKO1Tmiw>
 <xmx:bGXuXdhcSjV8sngi5rC0sBlTX503XODJVKxjCXjJoanROP0np-mDTA>
 <xmx:bWXuXYD_wwbCYuGFspqtbzzzp4OkzRX5CQqGBarBmrKpjxUW2cujgA>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 76E8A80063;
 Mon,  9 Dec 2019 10:16:59 -0500 (EST)
Date: Tue, 10 Dec 2019 00:16:56 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191209151655.GA8090@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20191209094943.14984-1-tiwai@suse.de>
 <20191209094943.14984-10-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209094943.14984-10-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 5.6 09/71] ALSA: firewire: Use managed
	buffer allocation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

I'm not opposed to this patchset. The direction is preferable.

However changes in this patchset brings bugs in error path of
each implementation for pcm.hw_params.

On Mon, Dec 09, 2019 at 10:48:41AM +0100, Takashi Iwai wrote:
> diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
> index d4edd06d32cf..2ee91ff6891e 100644
> --- a/sound/firewire/bebob/bebob_pcm.c
> +++ b/sound/firewire/bebob/bebob_pcm.c
> @@ -214,10 +214,6 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_bebob *bebob = substream->private_data;
>  	int err;
>  
> -	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
> -	if (err < 0)
> -		return err;
> -
>  	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
>  		unsigned int rate = params_rate(hw_params);
>  		unsigned int frames_per_period = params_period_size(hw_params);
> @@ -231,7 +227,7 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
>  		mutex_unlock(&bebob->mutex);
>  	}
>  
> -	return err;
> +	return 0;
>  }
  
This should return the err variable to report failure of isochronous
resources reservation.

However I found that ALSA oxfw/fireface drivers returns 0 even if it
fails. This is bug since v5.3 kernel.

Would you please apply below two patches into your three, then modify
your patch for all firewire drivers to return error correctly?

======== 8< --------

From a2cddad1c74e8e825739db63c17c0efabed1c93d Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 10 Dec 2019 00:03:04 +0900
Subject: [PATCH 1/2] ALSA: oxfw: fix return value in error path of isochronous
 resources reservation

Even if isochronous resources reservation fails, error code doesn't return
in pcm.hw_params callback.

Cc: <stable@vger.kernel.org> #5.3+
Fixes: 4f380d007052 ("ALSA: oxfw: configure packet format in pcm.hw_params callback")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 9124603edabe..67fd3e844dd6 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -285,7 +285,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
-- 
2.20.1

======== 8< --------

From cde8560eddc0e1f276865fa7f9bbccd27714d286 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 10 Dec 2019 00:05:41 +0900
Subject: [PATCH 2/2] ALSA: fireface: fix return value in error path of isochronous
 resources reservation

Even if isochronous resources reservation fails, error code doesn't return
in pcm.hw_params callback.

Cc: <stable@vger.kernel.org> #5.3+
Fixes: 55162d2bb0e8 ("ALSA: fireface: reserve/release isochronous resources in pcm.hw_params/hw_free callbacks")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index 4e3bd9a2bec0..bd91c6ecb112 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -247,7 +247,7 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&ff->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_hw_free(struct snd_pcm_substream *substream)
-- 
2.20.1

======== 8< --------


Thanks

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
