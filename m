Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A83C17445
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:40:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA99521872
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qz1awZ6p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="IpAn9blF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA99521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1145E167D;
	Mon, 11 Nov 2019 14:39:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1145E167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573479634;
	bh=/pGEy8Rm9a55hOeTZc+MDDkcWVPh2nDvu3O999lB2sU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qz1awZ6p5uE8XD8Lz6WBA0UV8PhGdOmPvxNWsttCENrbeAyX/SqLbBvDNc39aDlse
	 loD+L5okXoiVt89FVzlhbQcvyFnw0TWiAPLK2+1xEMQ8V34H/EIrnnrT0ZMB79Tn5W
	 mJvpdvyL40hIiLrR/6NT0Of1sFQ7+bCMqCPnHpjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE337F80275;
	Mon, 11 Nov 2019 14:39:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7947F804FF; Mon, 11 Nov 2019 14:39:40 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44C44F80275
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 14:39:37 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D8776A0040;
 Mon, 11 Nov 2019 14:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D8776A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573479576; bh=/caiL1VtB/CKQsUecjxQfff7Na6FOytDwuAykRaTCmE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=IpAn9blFFPL3AJxcFhJlxqx7nl39t3MQIzUasravsIRVWNvc2vlMW2vl0WoNExZeq
 T5pH9a8bbsbT+dbqN4OCqyKJLLgpZYotxfqs45Uxxhx2USOADoJEJYqGYIBA42H2kz
 Fu9b+W6fIovMQvZaUWGpmWRJ1p1rQ2GcbOwUh0vI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Nov 2019 14:39:33 +0100 (CET)
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-2-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <4b378b2c-fea2-5d77-26ff-0ff409d8e527@perex.cz>
Date: Mon, 11 Nov 2019 14:39:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107015808.26844-2-cujomalainey@chromium.org>
Content-Language: en-US
Cc: broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 02/11] ucm: docs: Add JackType value
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 07. 11. 19 v 2:57 Curtis Malainey napsal(a):
> Identifies the type of jack and how it should be accessed
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>   include/use-case.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index 2051bd40..3208cc30 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
> @@ -322,6 +322,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>    *        configuration that doesn't belong to UCM configuration files.
>    *   - JackName
>    *      - Input name is the input device name for the jack
> + *   - JackType
> + *      - Specifies whether the jack is accessed via hctl or gpio and therefore
> + *        only carries the possible values of "gpio" or "hctl"
>    */
>   int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
>                        const char *identifier,
> 

What is meant with the "gpio" type? The standard input device interface? I 
believe it should be "inputdev" and "ctl" (hctl is just interface on top of 
ctl and the application can access the jack through snd_ctl functions, too.

					Jaroslav



-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
