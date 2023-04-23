Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB05C77B73
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Apr 2023 07:49:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD9D5F26;
	Sun, 23 Apr 2023 09:48:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD9D5F26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682236180;
	bh=5MC9i52X1tLXEqtNik1D8hEqIZbiSJMLq6OMwZidTMQ=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Yz3hhn7Uy+XKG+McANaex9MvPMOgIh6YG1E1+e6PzoXAG3sX3BTNifHuAzTpYgmST
	 +XVxw5JbxSVLUDXLjXaeUGkPgBDtmyfpDYpXMTGBXRd5u2oCm3PN2AjVJpM2WLLnK4
	 Oaiz71PejhQbYqPcWBm0vRx7aDcWqk1XYghfuVKc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 248B1F80236;
	Sun, 23 Apr 2023 09:48:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A7D5F80236; Sun, 23 Apr 2023 09:48:20 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8DE91F800F8
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2023 09:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DE91F800F8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 1FC0524212;
	Sun, 23 Apr 2023 03:48:15 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pqUSE-AiK-00; Sun, 23 Apr 2023 09:48:14 +0200
Date: Sun, 23 Apr 2023 09:48:14 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/2] ALSA: emu10k1: fix SNDRV_EMU10K1_IOCTL_SINGLE_STEP
Message-ID: <ZETivvAQCIDptxHi@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230422161021.1144004-1-oswald.buddenhagen@gmx.de>
 <871qkboxuo.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <871qkboxuo.wl-tiwai@suse.de>
Message-ID-Hash: PJEA627KX2N7K26QX7OBLT2BQD4P7LJB
X-Message-ID-Hash: PJEA627KX2N7K26QX7OBLT2BQD4P7LJB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJEA627KX2N7K26QX7OBLT2BQD4P7LJB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Apr 23, 2023 at 09:34:55AM +0200, Takashi Iwai wrote:
>Although 0-day bot caught some build error, I couldn't reproduce it,
>so took as is.  Let's see whether it's broken at some config combo.
>
undeclared logical dependency on the "fixup DSP defines" patch, i think.

but even without that mistake the bot would croak, because i made my 
tooling describe deps in a human-readable way rather than sha1 + 
patch-ids. i guess i'll have to include both to make it bot-friendly ...

regards
