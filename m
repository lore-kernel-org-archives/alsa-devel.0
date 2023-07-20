Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BEAEB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 10:37:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CF251FC;
	Thu, 20 Jul 2023 12:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CF251FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689849417;
	bh=C797DpfHq5YCjhuRfxRmK+v/8E7YUkETrWn20rC71Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UNf6d4qAZRBcy5sXdYsv8/fC3x7iwuByzxUWSH8yD9+yroqTX53NFrH7CAgsVxMCn
	 D/hhLorh3OJ1fGSveW4FrfNAb2GiGfdwor5UFXg673a8yaIrykgvtFoM1j6CadcQ4K
	 rZItcP5h968/+Xqm/lzXrgAo1r2io8r7T/xcMaAs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 61D7BF80494; Thu, 20 Jul 2023 12:35:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ABE4DF8047D;
	Thu, 20 Jul 2023 12:35:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8ADFDF8047D; Thu, 20 Jul 2023 12:35:31 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7DA0F8027B
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 12:35:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7DA0F8027B
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 97F7F23FFF;
	Thu, 20 Jul 2023 06:35:22 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qMR0E-eJX-00; Thu, 20 Jul 2023 12:35:22 +0200
Date: Thu, 20 Jul 2023 12:35:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/4] ALSA: ac97: Use the standard snd_ctl_add_followers()
 helper
Message-ID: <ZLkN6jK5Gw19ZNqU@ugly>
References: <20230720082554.31891-1-tiwai@suse.de>
 <20230720082554.31891-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230720082554.31891-3-tiwai@suse.de>
Message-ID-Hash: 7OCDSWJWAZGTRSTMKETFWZI7ZNLNURPP
X-Message-ID-Hash: 7OCDSWJWAZGTRSTMKETFWZI7ZNLNURPP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7OCDSWJWAZGTRSTMKETFWZI7ZNLNURPP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jul 20, 2023 at 10:25:52AM +0200, Takashi Iwai wrote:
>+	err = snd_ctl_add_followers(ac97->bus->card, kctl, followers);
>+	if (err < 0)
>+		return err;
> 
> 	return 0;
>
this seems a bit pointless - you could just
   return snd_ctl_add_followers(...
directly.

(more instances may be affected, but i don't see it due to little diff 
context.)

> }

regards
