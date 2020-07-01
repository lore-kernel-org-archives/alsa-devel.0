Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83968C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:00:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A3320702
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PiNqUgD7";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="zCfEXAY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A3320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95246167A;
	Wed,  1 Jul 2020 17:00:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95246167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593615656;
	bh=Gce+JZ/VP/h7PUqZUfULwbk1d/xPBTFpEuxQlDw0t54=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PiNqUgD7E1ougOG28w6EN6NWCgxPYQRN2Bwb0Kym6TVifY30t3kD8CIPql68MVMzB
	 C0tyU5bOjTknGuI1qYZJPaHpIHkljSUxGsntwQmcXxz6QRanfRYeL1lXTKDRtEq73d
	 FUQOU3++sKAOC10T7ynLKZ5Ce7e/KnwciHIUp2bk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 189E0F8020C;
	Wed,  1 Jul 2020 17:00:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52ED8F80217; Wed,  1 Jul 2020 17:00:01 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5250CF800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 16:59:52 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5B584A003F;
 Wed,  1 Jul 2020 16:59:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5B584A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1593615591; bh=xgS5T6PJMHWeWU1UIjIZqI7AINN7zXfdmNmgg9xlzg0=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=zCfEXAY9HFe52/pRp5j3lTuZpdgdF+djXju6hrhBuo/HEgyebTaPwDJQbL042Wlvl
 gTBjQeVfMa8OhKwK3NlYXDqVdG72YdoY8YOGRk1zJG094rXE1RhWpUupyQQ1f0PezL
 lVBHjbL4jB3glBaGoeXYRltV1SvlImEyFiIzgUgw=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  1 Jul 2020 16:59:49 +0200 (CEST)
Subject: Re: [PATCH alsa-lib v2 0/2] Make dmix lockless operation optional
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20200623154931.27755-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <2211b9f9-fdf0-80dd-0742-f5b91b9f3ccd@perex.cz>
Date: Wed, 1 Jul 2020 16:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623154931.27755-1-tiwai@suse.de>
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

Dne 23. 06. 20 v 17:49 Takashi Iwai napsal(a):
> Hi,
> 
> this is a revised patch set for the PCM dmix, to make the lockless
> operation optional and fix the semaphore usage in the lockless mode.
> 
> Unfortunately I got a server problem in the last week and lost many
> posts during the weekend, so I couldn't follow up to the thread (I
> just read from the lore archive).
> 
> In this patch set, to make my intention clearer, I swapped the
> patches: the first to disable the lockless operation as default and
> the second to fix the semaphore usage in the lockless mode.
> 
> In the first patch, the magic number is changed as Jaroslav suggested,
> and the description has been updated.  The second patch is equivalent
> with the previous one.

All looks good now, thanks:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

				Jaroslav

> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (2):
>    pcm: dmix: make lockless operation optional
>    pcm: dmix: Fix semaphore usage with lockless operation
> 
>   configure.ac               | 13 +++++++++++++
>   src/pcm/pcm_direct.c       | 16 +++++++++++++---
>   src/pcm/pcm_direct.h       |  1 +
>   src/pcm/pcm_dmix.c         | 18 +++++++++++-------
>   src/pcm/pcm_dmix_generic.c |  2 +-
>   src/pcm/pcm_dmix_i386.c    |  1 +
>   src/pcm/pcm_dmix_x86_64.c  |  1 +
>   7 files changed, 41 insertions(+), 11 deletions(-)
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
