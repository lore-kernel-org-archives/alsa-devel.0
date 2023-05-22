Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2780EC7EE26
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 07:53:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2B66836;
	Mon, 22 May 2023 09:53:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2B66836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684742035;
	bh=iWa5vm4QuTaTgDcF+yd3LGh0V+C6URv+0zOHZSKXGu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=si66ZO8836IIuvg0g8Ba352/A/FcnkAddm9tlP9XhSABAiz67Qyh8rNJL3t4xixjJ
	 KzDJ3Pv0DKmo4bAMWzTnXQxxBCRB7hUDouAUQAL3x93VsFYmhpiog/RVvSaeBcnFIm
	 06rSCc/CKMDxRYnuYd7J9WGJZWo1AOV8d/KOAHak=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8712AF80548; Mon, 22 May 2023 09:53:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EF9CF80425;
	Mon, 22 May 2023 09:53:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9703F80548; Mon, 22 May 2023 09:53:00 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99D22F80053
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 09:52:58 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BCD9C1E35;
	Mon, 22 May 2023 09:52:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BCD9C1E35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684741977; bh=Vlc2tvvPZb0aTNhhbnx7lF2hVn0jr/Ql1h/J7uEAnIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V8HP4B56+qXBX2202j5DN3K52AlKh9KUnQzr7dpenLG184XcfN1a5mj9Y2G7p+zNJ
	 lOM0H5egakVL5jpgG38VgRyKoHqk4hWAj8+Mp7eGTeIBtjwIVewmppKkRqFWuvgfuk
	 MHuCYUZMMAyf2CraIq6QqbQyeejX3a42rmzZyaqU=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 09:52:55 +0200 (CEST)
Message-ID: <bfd0f97f-f887-2b21-642d-92c1744c8cbd@perex.cz>
Date: Mon, 22 May 2023 09:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 32/36] ALSA: seq: ump: Create UMP Endpoint port for
 broadcast
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-33-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-33-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: YFSGXELSEQGT23VKIHCADWDBORFTW5G7
X-Message-ID-Hash: YFSGXELSEQGT23VKIHCADWDBORFTW5G7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YFSGXELSEQGT23VKIHCADWDBORFTW5G7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:31, Takashi Iwai wrote:
> Create a sequencer port for broadcasting the all group inputs at the
> port number 0.  This corresponds to a UMP Endpoint connection;
> application can read all UMP events from this port no matter which
> group the UMP packet belongs to.
> 
> Unlike seq ports for other UMP groups, a UMP Endpoint port has no
> SND_SEQ_PORT_TYPE_MIDI_GENERIC bit, so that it won't be treated as a
> normal MIDI 1.0 device from legacy applications.
> 
> The port is named as "MIDI 2.0" to align with representations on other
> operation systems.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

