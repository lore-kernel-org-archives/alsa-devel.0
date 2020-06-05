Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF45C433E1
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:57:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B096207DF
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bXKmlTTV";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="o7AScL6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B096207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F41A1661;
	Fri,  5 Jun 2020 11:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F41A1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591351076;
	bh=904MPemjIvsnAFTo4hwHkvzIzTQriCR+HGaY+yM3JXQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXKmlTTVjCu+y5hPZkzP3hOTxTal6ksGYGmxfizOUuiMwoFZibkx1lNJR3+n/+ykS
	 iCXiBToYPliPqzfkYdYTbqkik+00bigpA6VEMOMfsckdn8081zpVdNLSL1wmslsykS
	 kh3/m1fRvXnW+4GlKgEjouYWidg2laS+O53TY+rY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B97E0F80212;
	Fri,  5 Jun 2020 11:56:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13AFFF80279; Fri,  5 Jun 2020 11:56:43 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA2B9F801F5
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 11:56:33 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6F70FA0040;
 Fri,  5 Jun 2020 11:56:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6F70FA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591350989; bh=Opc5kD9kxOcL+p5IfA0xy9cjOerQRXf8H5rOavJnE94=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=o7AScL6HhRWRxS1Kek0hHLwAZAiaAHiXq5I8BMo+DpP83yqfkG6w6Ad6uJUCjwzmf
 6xXv1hIVvsTJ/x73HcqzwdAnIhnk6gloAmMjssl6ZeaajlsjcE3xoks7R0t50Jm0AN
 +ACSyH3XZr2FiDrTfOAiqy7WO56U3wOJMy9goEYY=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  5 Jun 2020 11:56:27 +0200 (CEST)
Subject: Re: [PATCH 0/2] alsa-lib: -ENODATA documentation
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
References: <20200529122817.1198-1-kai.vehmanen@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <b2399166-a3dc-1c9b-c5fb-d75dbd34b833@perex.cz>
Date: Fri, 5 Jun 2020 11:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529122817.1198-1-kai.vehmanen@linux.intel.com>
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

Dne 29. 05. 20 v 14:28 Kai Vehmanen napsal(a):
> Hello all,
> 
> here's patch to document -ENODATA error as a PCM error code.
> We have recently merged patches to SOF firmware to use
> this error code:
>    https://github.com/thesofproject/sof/pull/2918
> 
> Some additional background on the use-case:
>    https://github.com/thesofproject/sof/issues/2564
> 
> In thread "Functionality of pcm_notify in snd-aloop?"
> https://mailman.alsa-project.org/pipermail/alsa-devel/2020-April/166974.html
> 
> .. we discussed the possibility for ALSA to provide a mechanism
> for application to wait for the condition to change, but at least
> for the currently known usages, the synchronization responsibility
> will be in user-space (UCM file will describe the PCM dependencies).
> Anyways, this is orthogonal to documenting -ENODATA, so sending
> this now.
> 
> Kai Vehmanen (2):
>    pcm: add documentation for -ENODATA error code
>    pcm: fix spelling in documentation for -EBADFD
> 
>   src/pcm/pcm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 

I applied those two patches, and added a short description that there is
no recovery mechanism and an event mechanism to notify the link availability 
at the moment.

https://github.com/alsa-project/alsa-lib/commit/f3597737defe495f9c618b12507c9528c0ade1ee

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
