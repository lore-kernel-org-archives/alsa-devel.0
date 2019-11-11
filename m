Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFDC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:34:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D7E2184C
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j1fumbTs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="r/QsRtB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D7E2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 238431674;
	Mon, 11 Nov 2019 16:33:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 238431674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573486439;
	bh=WXRfI6hnaksuljzZCXIGCH2tCfxPV43XFl56eBz//NU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j1fumbTsI6ILYjyUNu6rutY0mGAl/yYKADEBgDhyMXokTuzq04E2cLE0hmYofKFFl
	 mofxzbZsUKNyPc5cvKFhV4jN/Yslh1I4EHt0b4NLICVU1I0QH3JZgsc+O7wGn6m6X8
	 1uNaQ/u8JqF7Isp8/Mz1RqJwgQCC9Jgkd72VPLyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B082FF8045D;
	Mon, 11 Nov 2019 16:33:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CFB7F804FF; Mon, 11 Nov 2019 16:33:08 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8421F802E0
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 16:33:05 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6AB37A0040;
 Mon, 11 Nov 2019 16:33:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6AB37A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573486385; bh=MbJHkNTE/4bV4aPrxmwCLkp6zvtFy7I2LvAPuZozN0U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=r/QsRtB4Z/xmtBWF779Eakdcm6VgDI8v74ly9ZQEPImvfbzLjcinjjJ0In6RJ213n
 4X55ZGWQ8LLL1pW9DIuHgkmeaP0bUxzV/XymyQB84GIjwksPNk2QcpcFFAg0f+Vm3b
 qgWpK0VbJ8gzgYPv59txjVgDuRGu+mWF2Kc1FDs0=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Nov 2019 16:33:02 +0100 (CET)
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-10-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <b46f661a-5363-e80e-fc1e-d4d984f198ef@perex.cz>
Date: Mon, 11 Nov 2019 16:33:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107015808.26844-10-cujomalainey@chromium.org>
Content-Language: en-US
Cc: broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 10/11] ucm: docs: Add SoftwareGain
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
> Add software gain ucm definition.
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>   include/use-case.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index e84f3f8f..ee6ee5e0 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
> @@ -344,6 +344,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>    *      - This is used on platform where reported buffer level is not accurate.
>    *        E.g. "512", which holds 512 samples in device buffer. Note: this will
>    *        increase latency.
> + *   - SoftwareGain
> + *      - Specify the software gain in 0.01dB. E.g. "20" means there will be
> + *        0.2 dB software gain on this node.
>    *   - DisableSoftwareVolume
>    *      - Set to "1" to force userspace to use hardware volume controls
>    */
> 

In other words, it's the recommended software gain control? The description 
should be improved then.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
