Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD43EB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jul 2023 10:17:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71A0783A;
	Tue, 11 Jul 2023 12:16:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71A0783A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689070619;
	bh=FJG2k0NYPSJYB8LB2sBaii1frO5HeJtxsA8C7HVxtsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V7lxCe8YQHppFW33J0QrtfVvLNjFRSWiAxlzU7r96OSrRWLB3gPBqvQSL+fOp10wi
	 ssDBAMDRe2PnD1LnC0c383nU7NX3U/lKViY2M39hiCHs6JN+sSytmH7WhjcCNG103w
	 hqZdheuBP1r+5rWqHGNfUXCeW1DPDMdijrUPudlw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63810F8053B; Tue, 11 Jul 2023 12:15:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C19A1F80093;
	Tue, 11 Jul 2023 12:15:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA667F80093; Tue, 11 Jul 2023 12:15:38 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 897A9F80093
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2023 12:15:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 897A9F80093
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 2164924264;
	Tue, 11 Jul 2023 06:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qJAP5-WLf-00; Tue, 11 Jul 2023 12:15:31 +0200
Date: Tue, 11 Jul 2023 12:15:31 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 0/8] ALSA: emu10k1: add support for high-bitrate modes
 of E-MU cards
Message-ID: <ZK0rw5j5BbyppXZ/@ugly>
References: <20230630144542.664190-1-oswald.buddenhagen@gmx.de>
 <87sf9vyfer.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87sf9vyfer.wl-tiwai@suse.de>
Message-ID-Hash: J4NKRCLWJ4W6OMQF54B5U5D2HBVJESAG
X-Message-ID-Hash: J4NKRCLWJ4W6OMQF54B5U5D2HBVJESAG
X-MailFrom: ossi@kde.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J4NKRCLWJ4W6OMQF54B5U5D2HBVJESAG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Jul 10, 2023 at 05:06:36PM +0200, Takashi Iwai wrote:
>On Fri, 30 Jun 2023 16:45:34 +0200,
>Oswald Buddenhagen wrote:
>> 
>> This series is what all the work was about: support the "dual-/quad-pumped"
>> modes of the E-MU cards.
>> 
>> Oswald Buddenhagen (8):
>>   ALSA: emu10k1: introduce alternative E-MU D.A.S. mode
>>   ALSA: emu10k1: improve mixer control naming in E-MU D.A.S. mode
>>   ALSA: emu10k1: set the "no filtering" bits on PCM voices
>>   ALSA: emu10k1: make playback in E-MU D.A.S. mode 32-bit
>>   ALSA: add snd_ctl_add_locked()
>>   ALSA: emu10k1: add support for 2x/4x word clocks in E-MU D.A.S. mode
>>   ALSA: emu10k1: add high-rate capture in E-MU D.A.S. mode
>>   ALSA: emu10k1: add high-rate playback in E-MU D.A.S. mode
>
>I still can't agree with the basic design using the dynamic kctl
>addition / deletion in kcontrol's put action.
>
you are not being constructive. please provide specific, actionable 
responses to _all_ challenges/questions.

regards
