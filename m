Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2655C77B73
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 07:33:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C18A51F1;
	Mon, 22 May 2023 09:33:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C18A51F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684740833;
	bh=+mtRdSaVYScohMoZvnn2EcZ8Ar9NBmGDbGfgH3a1vTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bBrNg7D2siCcyLyDFPI8rs5+LFwRZdFCb+3MzM6uMTuiwLi1LmO/TD1cqwsF4JNdk
	 I6Qk2yQgPjtjEZaHeNktUSGDoBqTLGGI07GquceKPW2bigjZpXp6/J3KYjuDzhONL2
	 eleEcdmf7Mruy5ACee34IeAoIf/UGQkf+JphL4hs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11D5DF80249; Mon, 22 May 2023 09:32:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 738FDF8024E;
	Mon, 22 May 2023 09:32:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DF76F8024E; Mon, 22 May 2023 09:32:29 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0E73F8016A
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 09:32:23 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C4FFC1E3C;
	Mon, 22 May 2023 09:32:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C4FFC1E3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684740742; bh=YMJ/ZtR0fiKGFr3XfuUF0CoNeP/TWv2UdxOVuNCX3As=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5PWYoq5P8aa24G1Hyj5EKI6ANao+S804hrw4K0O5QTMxG4rNXcu9Ppe2zrEcZNYyx
	 I+qm5aIhENiUU9lg8nNbcVXVHWrLrvse76rDAxtU5S1+A5jIaX1RYCnlyFVoKHgT9G
	 ebvSYq1QHMkNAQiwQ5n1fa9vAfO2YjI8P8Nf1ByE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 09:32:20 +0200 (CEST)
Message-ID: <28f94a8c-ae3b-4ffb-d9e4-5196eb2b7881@perex.cz>
Date: Mon, 22 May 2023 09:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 23/36] ALSA: seq: Introduce SNDRV_SEQ_IOCTL_USER_PVERSION
 ioctl
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-24-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-24-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: P6Q4JQYDOA7GO7BFNQRIWSOB4C5FAJM4
X-Message-ID-Hash: P6Q4JQYDOA7GO7BFNQRIWSOB4C5FAJM4
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P6Q4JQYDOA7GO7BFNQRIWSOB4C5FAJM4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:31, Takashi Iwai wrote:
> For the future extension of ALSA sequencer ABI, introduce a new ioctl
> SNDRV_SEQ_IOCTL_USER_PVERSION.  This is similar like the ioctls used
> in PCM and other interfaces, for an application to specify its
> supporting ABI version.
> 
> The use of this ioctl will be mandatory for the upcoming UMP support.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

