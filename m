Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E75C77B71
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Apr 2023 08:31:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CA121069;
	Tue, 25 Apr 2023 10:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CA121069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682411486;
	bh=dL1LA6phiQGZPXPzuZzRIyjAE7d3t75nbnLFciXxo/M=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DrdjUIxo9cjXqNNParjGLQn1HPPwBbAQPJCtxV3qzv7/C6iySTMKoOIWeEn912ntD
	 upVRquS+k78ysR3xNHjJ5pEhE7KweV7LWAH/fBpcrfSAeoIBdUy5rO0ENxylPxkQF0
	 Y5g0/9UqKZbYnFNrUGNKWBt6LV3eQxmM/kvPwdg4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C88A6F80236;
	Tue, 25 Apr 2023 10:30:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCC6BF80236; Tue, 25 Apr 2023 10:30:07 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2FCECF800F8
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2023 10:30:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FCECF800F8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 55ACF24248;
	Tue, 25 Apr 2023 04:29:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1prE3i-xyq-00; Tue, 25 Apr 2023 10:29:58 +0200
Date: Tue, 25 Apr 2023 10:29:58 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: emu10k1: fix multi-channel playback device class
Message-ID: <ZEePhjS/s+8KGEsl@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230422161021.1143989-1-oswald.buddenhagen@gmx.de>
 <874jp7oy2k.wl-tiwai@suse.de>
 <ZEZa2oQV20IgqNvR@ugly>
 <ZEeIrTZeEDHxwwAZ@ugly>
 <87ildkv0lz.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ildkv0lz.wl-tiwai@suse.de>
Message-ID-Hash: HEQWF7YQ36ZJ26JFEJIJXA6SQRRXNLCX
X-Message-ID-Hash: HEQWF7YQ36ZJ26JFEJIJXA6SQRRXNLCX
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HEQWF7YQ36ZJ26JFEJIJXA6SQRRXNLCX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Apr 25, 2023 at 10:15:36AM +0200, Takashi Iwai wrote:
>On Tue, 25 Apr 2023 10:00:45 +0200,
>Oswald Buddenhagen wrote:
>> speaking of dead code, lots of drivers explicitly assign info_flags =
>> 0, dev_class = SNDRV_PCM_CLASS_GENERIC, and dev_subclass =
>> SNDRV_PCM_SUBCLASS_GENERIC_MIX, which are all technically pointless,
>> as the pcm struct is kzalloc'd anyway.
>
>The dev_class and info_flags initializations to zero aren't entirely
>pointless, IMO.  It explicitly shows that the default value is used.
>
that can be said about many other fields as well. but defaults are there 
for a reason, to reduce the noise. not even the example in the docu 
includes it. and if we were consistent about the "be explicit" approach, 
we should add it to a lot of drivers which lack it - which feels just 
wrong.

regards
