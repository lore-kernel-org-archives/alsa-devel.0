Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B98C7EE26
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 07:53:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB7BE822;
	Mon, 22 May 2023 09:52:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB7BE822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684741980;
	bh=PJUFLoEUcn4x+27qUQ7lt+CpBL8T0vBgNqM4uxYCgoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jYAENOaKDB0zhOKpwJvlUVnjA8u07iHVq8G1N80tbglxxXUpnzLQUiAm8Hd16OU9u
	 VpvRMGnX+KUz/RhmQE14yGNYeW2pIjCYNfneLJUX9tdO7NiRPyyRlsrut8gFeDnTPV
	 +y7F81aA5L3YyCTcxGsP7VtuMU3SaU4zvhvB94oM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B1EEF80549; Mon, 22 May 2023 09:52:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5CD3F8024E;
	Mon, 22 May 2023 09:52:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F314F8024E; Mon, 22 May 2023 09:52:07 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2BDB2F80053
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 09:52:04 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 38F971E2D;
	Mon, 22 May 2023 09:52:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 38F971E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684741923; bh=XTzLTJs6jndSmkA6ALf7+Cpl0UyiJLd2CFlNL08o34A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fuuzAnZYtHa7DPof+C5/uij8U9KVQ6KANmSi6RBnpfjjefGEImDRnkprszUat5WpU
	 8Hh6FfmYoa7U3zgMpQH6frsDSo/hJJjyEEAngl98voCjQwn3Kq72Sai/tp4vs2EGHF
	 bwPAd2W1Lqu+KEWRATUb/8fFm0nIaLTpMLw0Oc9g=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 09:52:01 +0200 (CEST)
Message-ID: <777d6657-b0eb-2162-a636-7ebbdcf052d5@perex.cz>
Date: Mon, 22 May 2023 09:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 31/36] ALSA: seq: Bind UMP device
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-32-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-32-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: IAA35FAHEH444FVJW4VENKZJLDFI5ZRJ
X-Message-ID-Hash: IAA35FAHEH444FVJW4VENKZJLDFI5ZRJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IAA35FAHEH444FVJW4VENKZJLDFI5ZRJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:31, Takashi Iwai wrote:
> This patch introduces a new ALSA sequencer client for the kernel UMP
> object, snd-seq-ump-client.  It's a UMP version of snd-seq-midi
> driver, while this driver creates a sequencer client per UMP endpoint
> which contains (fixed) 16 ports.
> 
> The UMP rawmidi device is opened in APPEND mode for output, so that
> multiple sequencer clients can share the same UMP endpoint, as well as
> the legacy UMP rawmidi devices that are opened in APPEND mode, too.
> For input, on the other hand, the incoming data is processed on the
> fly in the dedicated hook, hence it doesn't open a rawmidi device.
> 
> The UMP packet group is updated upon delivery depending on the target
> sequencer port (which corresponds to the actual UMP group).
> 
> Each sequencer port sets a new port type bit,
> SNDRV_SEQ_PORT_TYPE_MIDI_UMP, in addition to the other standard
> types for MIDI.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

