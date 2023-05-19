Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72D8C77B7A
	for <alsa-devel@archiver.kernel.org>; Fri, 19 May 2023 11:54:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 749E4200;
	Fri, 19 May 2023 13:53:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 749E4200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684497244;
	bh=wnJhg8z7HFde6eo8TCu9ohc+8eccx/x1BkjtM89lELE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ee89M2cfjbB+70o9Af+iSEOnXBlikJyfr74N2kwFQR25s5KgJeorBmf5F1lNoC1C9
	 9mEI0dsQZuAp8pR70KiKWHIob5eSh/lHZXnZ/ObvaM+w+3FbnLlPbAII8odg8fuZF1
	 qZlMs03PxCBdtPflo6ootC9z4Eq8BhXQZo5SO0SU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1DCFF802E8; Fri, 19 May 2023 13:53:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73054F80272;
	Fri, 19 May 2023 13:53:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27BB3F80272; Fri, 19 May 2023 13:53:08 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C384F8016D
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2023 13:53:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C384F8016D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 8B89223F0B;
	Fri, 19 May 2023 07:53:01 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzyfN-q2U-00; Fri, 19 May 2023 13:53:01 +0200
Date: Fri, 19 May 2023 13:53:01 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 5/7] ALSA: emu10k1: centralize freeing PCM voices
Message-ID: <ZGdjHROPsjZ9QpUe@ugly>
References: <20230518140947.3725394-1-oswald.buddenhagen@gmx.de>
 <20230518140947.3725394-6-oswald.buddenhagen@gmx.de>
 <87ttw9hesg.wl-tiwai@suse.de>
 <ZGdSzPTMbdRr/FhV@ugly>
 <87a5y01t1b.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87a5y01t1b.wl-tiwai@suse.de>
Message-ID-Hash: BXCUG6UIIQLIGHMR4FB4TQ72C2ZB53YZ
X-Message-ID-Hash: BXCUG6UIIQLIGHMR4FB4TQ72C2ZB53YZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BXCUG6UIIQLIGHMR4FB4TQ72C2ZB53YZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, May 19, 2023 at 01:04:32PM +0200, Takashi Iwai wrote:
>On Fri, 19 May 2023 12:43:24 +0200,
>Oswald Buddenhagen wrote:
>> 
>> On Thu, May 18, 2023 at 04:53:19PM +0200, Takashi Iwai wrote:
>> > On Thu, 18 May 2023 16:09:45 +0200,
>> > Oswald Buddenhagen wrote:
>> >> -static int snd_emu10k1_pcm_channel_alloc(struct snd_emu10k1_pcm * epcm, int voices)
>> >> +static void snd_emu10k1_pcm_free_voices(struct snd_emu10k1_pcm *epcm)
>> >>  {
>> >> -	int err, i;
>> >> -
>> >> -	for (i = 0; i < ARRAY_SIZE(epcm->voices); i++) {
>> >> +	for (unsigned i = 0; i < ARRAY_SIZE(epcm->voices); i++) {
>> > 
>I'm not super-strict about it, but

>as checkpatch complaints,
>
it doesn't, so from that side it's settled. it's really just about the 
alsa-local policy.

what it actually *does* complain about is the use of bare "unsigned". i 
don't like the excessively verbose "unsigned int", so i'll switch my 
uses over to "uint", which already has some use in alsa. ok?

regards,
ossi
