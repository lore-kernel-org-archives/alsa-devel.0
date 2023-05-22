Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F10C77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 06:55:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 658F4825;
	Mon, 22 May 2023 08:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 658F4825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684738524;
	bh=OFlCiCYqty312QwazQAlhfVBEi4sCbB+3aL01EMCuKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M1AMeHfaIZsQE44pJiMpUsbpGRi+G5PUHuCzcv8xP5YR8tfjBnaL8AzYYrrznbHiH
	 K/b8kg1BL0JSS5SChWWqa2XSJ8D9EPoSb6w/TqlCDTXEf53oDWZeH4RyVCV6NgyHhS
	 qQoeAYGlYxQQIT+jA18yfdWrGYtCZbPJMuHm4tqY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17C85F80249; Mon, 22 May 2023 08:54:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D1A2F8024E;
	Mon, 22 May 2023 08:54:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8EB2F8024E; Mon, 22 May 2023 08:54:07 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 937CEF80086
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 08:54:05 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 756631E2D;
	Mon, 22 May 2023 08:54:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 756631E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684738444; bh=lUHIC8S/riy79DuiPCfL1ZFPUvOSaaW/NBm/7xDAvhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2j0qIF+wcyzxJq2m5vVuEYYMeJav2i2CmN5vYTTjxNm63G/Ifx1uY6wgelWbiq/sR
	 bVY0roCgvooObf2W3ELkFOzCoBzHV/LJJRfoBDDQYu+pF0rAcbkrxDp9w6cYIE2fIC
	 ifOZt4XH+v3VCSlJzzZkLFVfQue5NhVTHJ9hYbuw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 08:54:02 +0200 (CEST)
Message-ID: <5a188794-2def-cc55-6083-dcff824d0dd6@perex.cz>
Date: Mon, 22 May 2023 08:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 12/36] ALSA: ump: Redirect rawmidi substream access via
 own helpers
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-13-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-13-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: C6IOFEWX4P6YW2IQ3JUXM7VTGFW5UYET
X-Message-ID-Hash: C6IOFEWX4P6YW2IQ3JUXM7VTGFW5UYET
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C6IOFEWX4P6YW2IQ3JUXM7VTGFW5UYET/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:30, Takashi Iwai wrote:
> This is a code refactoring for abstracting the rawmidi access to the
> UMP's own helpers.  It's a preliminary work for the later code
> refactoring of the UMP layer.
> 
> Until now, we access to the rawmidi substream directly from the
> driver via rawmidi access helpers, but after this change, the driver
> is supposed to access via the newly introduced snd_ump_ops and
> receive/transmit via snd_ump_receive() and snd_ump_transmit() helpers.
> As of this commit, those are merely wrappers for the rawmidi
> substream, and no much function change is seen here.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

