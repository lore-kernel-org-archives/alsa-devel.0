Return-Path: <SRS0=rado=64=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB6C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 13:53:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3CD20671
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 13:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iZpxnPd7";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="XmkxWmGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3CD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BFF3166F;
	Thu, 14 May 2020 15:52:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BFF3166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589464407;
	bh=LdzoFEso+TapptamUxMzNbnmn6IYMfk5AfBQtqE88Nw=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iZpxnPd783nWgLSp26W8c3evMmU+VMDndW8zAYYS9GmAaCPPsLaFltVBxT0Leuj6Z
	 swYRPqi4L3uSKjW2L9uhXgF9qOtxijWfTirPhyossbkSx1aYTfoEs+azYFOpb/q87J
	 /+90umn6S2oqpZrgsycNXMetKy2MZXvWF3x/VNRA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C427F8014C;
	Thu, 14 May 2020 15:52:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAC28F80158; Thu, 14 May 2020 15:52:35 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59873F800E3
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 15:52:27 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 632DAA003F;
 Thu, 14 May 2020 15:52:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 632DAA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1589464347; bh=Ti/g5dI+CLB/vM/oNK0m/BmkyRAOaaI2HkP+1q2EO60=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=XmkxWmGjLOTpYR0RBH+Ck9VMUwJ7XF3clHQ16WZKt2S/uM0PmwMvi1pVdAubGfMt9
 UgGi0YXceT8dHI7aQmPeXYh4lut8LFFsWMPdO8LLbn/6qt+4XozN6OYhlPcE1mIFh2
 clB65CfkFf7xjEyq3EkeQsgAvPxJxTP/d1ub5RsY=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 14 May 2020 15:52:25 +0200 (CEST)
Subject: Re: [PATCH] fix snd_pcm_drain() excluding SETUP state from valid
 states
To: sylvain.bertrand@gmail.com, alsa-devel@alsa-project.org
References: <20200502193311.GA19340@freedom>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <47281cd6-2ae5-309e-f1a9-8906ff50c9cc@perex.cz>
Date: Thu, 14 May 2020 15:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502193311.GA19340@freedom>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 02. 05. 20 v 21:33 sylvain.bertrand@gmail.com napsal(a):
> once draining is done, the pcm enters the SETUP state, which ought to
> be valid for snd_pcm_drain()
> 
> signed-off-by: Sylvain BERTRAND <sylvain.bertrand@legeek.net>
> ---
> 
> I missed this one in my previous patch because exiting with or without
> an error once draining is done was producing the same result.

NAK: You should not call drain when the PCM handle is in the SETUP field. It's 
an obvious caller problem. The streaming should be active somehow.

						Jaroslav

> 
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -1329,7 +1329,7 @@ int snd_pcm_drain(snd_pcm_t *pcm)
>   		SNDMSG("PCM not set up");
>   		return -EIO;
>   	}
> -	err = bad_pcm_state(pcm, P_STATE_RUNNABLE);
> +	err = bad_pcm_state(pcm, P_STATE_RUNNABLE | P_STATE(SETUP));
>   	if (err < 0)
>   		return err;
>   	/* lock handled in the callback */
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
