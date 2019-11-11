Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D4C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:56:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BF5206BA
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F7KXGKEb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Js5dv8bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BF5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A6CF166C;
	Mon, 11 Nov 2019 15:56:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A6CF166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573484210;
	bh=0qEQVqquY316aKt+5H3tgu9lHkLVjwZ9MX/xbbKUECQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7KXGKEb5fv8AZZdRbw2XceMswQltNpor4PQhUgNWig7MyFhqlXhTFGdMCttx1fa7
	 0+lnX51f6ZqVxXFRBb+8C3ItEu9sh4aEtrIEOg1P+G834Fuu128/RJDA7lcJVGGyak
	 el8DhqbV7j7PXEbDt+ylkYIthOzn0IYewJRE1Xpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C30B8F80518;
	Mon, 11 Nov 2019 15:55:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EBC0F80519; Mon, 11 Nov 2019 15:55:36 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA880F804FF
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 15:55:33 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id AFDE7A0040;
 Mon, 11 Nov 2019 15:55:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz AFDE7A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573484132; bh=LB1jm3vQW+W65nX7aT6B8X8CyjmVWo1rmYWXZ6YwzBU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Js5dv8bZ1pH6X2w+dF10oNFAf+jYu0FfMg/Yr7bWvSfbc6LL9/lihNS26os2xwl5s
 nNg1M6x6C72PgbhKrRFSuyeai298SuRgPpYAhMwIK8mkFMNAXvFwjIMqV94FQrKKu0
 +1fIgOQm9OiJC1oSv3cAL+l65RDiOf6J33DmwSg4=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Nov 2019 15:55:28 +0100 (CET)
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-5-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <fdc86ef0-6a7d-1789-a198-906d13c982f1@perex.cz>
Date: Mon, 11 Nov 2019 15:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107015808.26844-5-cujomalainey@chromium.org>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 05/11] ucm: docs: Add MinBufferLevel value
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

Dne 07. 11. 19 v 2:58 Curtis Malainey napsal(a):
> Allows ucm to override minimum buffer level for platforms that
> incorrectly report their buffer level.
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>   include/use-case.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index 28e92d17..05628303 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
> @@ -330,6 +330,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>    *   - JackType
>    *      - Specifies whether the jack is accessed via hctl or gpio and therefore
>    *        only carries the possible values of "gpio" or "hctl"
> + *   - MinBufferLevel
> + *      - This is used on platform where reported buffer level is not accurate.
> + *        E.g. "512", which holds 512 samples in device buffer. Note: this will
> + *        increase latency.
>    */
>   int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
>                        const char *identifier,
> 

This is something like the BATCH flag we have in the PCM API. It would be 
probably nice to add this to the PCM API, too. Takashi?

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
