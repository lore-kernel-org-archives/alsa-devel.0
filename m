Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D28EC77B7A
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jun 2023 11:16:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8FCC1FE;
	Tue,  6 Jun 2023 13:15:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8FCC1FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686050204;
	bh=Ded9/Ky+ytxCo5yLJY2tZBoFtsScFVRyhOZqAiowIjg=;
	h=Date:To:References:From:Subject:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HEcD3YDbXPlONfoXqxs8T7uGC2VRL2cvwZNhJuv+Fohcqs/JuXvKxbZqo1LNSFn6D
	 AUlka03AFJNTuMc0zeXICVQxaCWqoWqCoPdfj/c22UVJCm3q13QZRDIzqQLsJgG5UO
	 iynZPyxmhRDR7SFllASvhZ7Ftzmvm4wcjxvSfLhc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F75EF80548; Tue,  6 Jun 2023 13:15:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DD458F80494;
	Tue,  6 Jun 2023 13:15:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18B5FF80199; Tue,  6 Jun 2023 13:15:27 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 49A4DF80155
	for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2023 13:15:24 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1209F1E3B;
	Tue,  6 Jun 2023 13:15:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1209F1E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1686050123; bh=AR+8DthPhq9YBvT+MUVUkICy6y4kBJd7rVpk9LdoONk=;
	h=Date:To:References:From:Subject:In-Reply-To:From;
	b=XML3NPQRDzx2cvT2vXds+9EoBTDc+tIWH/ix4LqXEt87I5t3S28GM3YBEJZqCW7Uf
	 Ez7dMZCnPfksFEVM4pU4pGOPlYTnsW96hBxLEw3kQ++QoO231YAKCAoxU2Kmmwlkx/
	 2ukVOlR5+QVrvHMEGaqayB7op4OnLZnlEgF0qlFE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue,  6 Jun 2023 13:15:21 +0200 (CEST)
Message-ID: <82b3dc7a-16f7-6c8d-766c-acd219e60f5b@perex.cz>
Date: Tue, 6 Jun 2023 13:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20230606094035.14808-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: control: Keep the previous numid at
 snd_ctl_rename_id()
In-Reply-To: <20230606094035.14808-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: NHGHJHGZKN6U56TPS25CECTSWTISOUMN
X-Message-ID-Hash: NHGHJHGZKN6U56TPS25CECTSWTISOUMN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NHGHJHGZKN6U56TPS25CECTSWTISOUMN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 06. 06. 23 11:40, Takashi Iwai wrote:
> We don't need to change the numid at each time snd_ctl_rename_id() is
> called, as the control element size itself doesn't change.  Let's keep
> the previous numid value.

I would also highlight in the comment that snd_ctl_rename_id() should be used 
only in the card initialization phase. It may cause issues with the user space 
(persistent numid) for the dynamic controls.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

