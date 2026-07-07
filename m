Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA3C4451C
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:37:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F891601F0;
	Sat, 18 Jul 2026 11:36:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F891601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367428;
	bh=qWnQgyBnZDBHSwtoI0LfA2dP8RZtk8e+vVoTkj4+Jro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jOO3Gcn4NxR6MfY8uSi+ykF+WCHqFGyqxawiWAcwqRJyruqd9Mj0UkWQSJgL0xad+
	 h5boEPoGIVYEm/Fe/H1bsxmVp0svCIXs7B8y9bP8U4fuXFqYHSwBbDNg5q3/izfj2J
	 MUamOz9ja+6q4sUF3FsNGKqzAabuZF+FsKvLTi/g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA320F80600; Sat, 18 Jul 2026 11:36:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81912F80601;
	Sat, 18 Jul 2026 11:36:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7EBF2F8055A; Tue,  7 Jul 2026 19:49:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783446547;
	b=MEXmr77zW4zZ4gIsh+aI7u9KrWWJOOzAsHQba87IhRDWFrofzdq5MLhbBE5nr3ZRcabD
	 5GG3alLor0Xozw7g79xHJbaDbNhYdUmlMSyTFqG44Fpz9xaHdXXf+moFHkW1bKvgQ1Mfz
	 Ps8LLrVdr9E7C9lpKPy84PFJcwdA0MPQSQULJoaZKe3GiMJ85VweOXtYkIQX6AY/1xCAs
	 /l8oxPx96NkXjw0OBNG5YBnpcf/dKRn/qAlwM9ye+TuQrKYRo63NAWOhNaOEGnEvULlxl
	 HntKghcMjnSFtOdiJSydn9GgVzkCTfvshipbj7Y2jCmKwXVBCDtbW6WLZVxFTXfWXaA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783446547;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=qWnQgyBnZDBHSwtoI0LfA2dP8RZtk8e+vVoTkj4+Jro=;
	b=OW9nPini8P31/cm5kqV4lMGzDyV0wLHbDYu47e8KmljaFXwA075uuS2BkvSq1p0arXv6
	 zhgIo2b4JNVMvLM6S2Fe5MUN9bic9wxydUysBbPwpNXQEYfYfHlaJGz7Oj/jZ/7muQEc6
	 xE9zPSEe7kX2A+nB6LUbCom03qzqARmTrK+yFoyurYcIZt/bJYu2xfDSHKMcTRAhaVFpG
	 KuJoGWalUSjyGebyTixFAD0jSFD+hJcPvBFf6NB9+FdZv794llLpaoG2vBqjrk60AF6bm
	 530GbjOapdAKdUnHM6w1r263p+iVTEdnqbHALTcJUV9YsdmhpCzjQOpZXX9ugrbHIVw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=U+vV0D1D;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 013E7F8010B
	for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2026 19:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 013E7F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=U+vV0D1D
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE91B402F1;
	Tue,  7 Jul 2026 17:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7171F000E9;
	Tue,  7 Jul 2026 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783446542;
	bh=ZLYjcTt9DoOST5WxM8wszRJzNwSbozG9PunZC26e8Rw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U+vV0D1D6iWyROSyJ/81LeTr6as+BY5+OPNe/v1402JeIkYRTr/tOKiWlVaOMZRPo
	 hxWFSqwOvMaSNydjeQcGNW5msqvYExwo+rsfwzGQizCwViYuRahjpEZodVm7Rvzsze
	 6NXFumZ1Y/6M9PRb9cpGbEI9JVB2TPzzcizSqYBihs+bEKbtLs2ivlO26MBaejh4qq
	 iHvT2Gr2GKIbO/hNl27Xjf9koVZtAbdwKNNoRy4BtY3TS77/AcXe2IkXrFoOzQd1hx
	 7SrdegEPBhfaOvRzX/muS7lApCcof6qW1up3wCku8tQmpowZcPjfSs+YjdSi1abfLz
	 XkqyXJ4zzqqvA==
Message-ID: <22b0795c-64d0-4a39-8f21-c24ee5a5853e@kernel.org>
Date: Tue, 7 Jul 2026 12:49:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: amd: ps: replace bitwise OR with logical OR in
 IRQ return check
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 syed.sabakareem@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
 <20260707060130.2514138-4-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260707060130.2514138-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MBT7UAOT5MDDOR5PBANCVH7LVB5K5KTS
X-Message-ID-Hash: MBT7UAOT5MDDOR5PBANCVH7LVB5K5KTS
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:36:28 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MBT7UAOT5MDDOR5PBANCVH7LVB5K5KTS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/7/26 00:59, Vijendar Mukunda wrote:
> The condition 'irq_flag | wake_irq_flag' uses bitwise OR to combine two
> integer flags that are used as booleans. Replace with logical OR '||' to
> correctly express the intended boolean check.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Fixes: 7f91f012c1df0 ("ASoC: amd: ps: fix for irq handler return status")
> ---
>   sound/soc/amd/ps/pci-ps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 1162d13d8505..729f9aaba69e 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -248,7 +248,7 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>   	if (sdw_dma_irq_flag)
>   		return IRQ_WAKE_THREAD;
>   
> -	if (irq_flag | wake_irq_flag)
> +	if (irq_flag || wake_irq_flag)
>   		return IRQ_HANDLED;
>   	else
>   		return IRQ_NONE;

