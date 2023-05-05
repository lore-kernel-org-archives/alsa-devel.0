Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06768C77B7C
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 07:18:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D31AE2BBC;
	Fri,  5 May 2023 09:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D31AE2BBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683271109;
	bh=ps514G99IITuLrNiNw8mJQnaqO/7F2oAHVRjvuWhcHs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OBi5EiuuOicpZ2lgazFeU+byABmwInuWO0u7x6ATH8XZv5xnnBaAcyfBeE8cRnU1q
	 cwh9pBkw1liKcIlxZjgJW2EaxCcakw7lUPgrKK0+quPUfcn8mDiUceOkXdeJAoTmB5
	 2Tclyl9nTAkxWLsnz5/V57CZ5zVzPe5dDZgpJXmg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6332EF8052D;
	Fri,  5 May 2023 09:17:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38124F8052D; Fri,  5 May 2023 09:17:08 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 280BAF80087
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 09:17:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 280BAF80087
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id D0DCB202CD;
	Fri,  5 May 2023 03:17:02 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pupgc-T6A-00; Fri, 05 May 2023 09:17:02 +0200
Date: Fri, 5 May 2023 09:17:02 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: pcm: fix snd_pcm_playback_silence() with
 free-running mode
Message-ID: <ZFStbtMYPwhiUEMB@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
References: <20230504130007.2208916-1-oswald.buddenhagen@gmx.de>
 <87cz3gkyz9.wl-tiwai@suse.de>
 <c2e501b7-68bc-947b-645e-e425dcd20c65@perex.cz>
 <ZFO5B+1+HaIz4B4X@ugly>
 <877ctokv6x.wl-tiwai@suse.de>
 <ZFPQ68qLr2fy1qRs@ugly>
 <87ttwsjbrx.wl-tiwai@suse.de>
 <ZFPxK7tgMEa0Gi1y@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZFPxK7tgMEa0Gi1y@ugly>
Message-ID-Hash: MFRRMQ6ONDMSVFJDLIEPK25HVBO5LY6W
X-Message-ID-Hash: MFRRMQ6ONDMSVFJDLIEPK25HVBO5LY6W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MFRRMQ6ONDMSVFJDLIEPK25HVBO5LY6W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, May 04, 2023 at 07:53:47PM +0200, Oswald Buddenhagen wrote:
>i'm not going to try to prove to you that this is the case here. i just 
>know that i failed at atomizing this _properly_ the first time around.
>
as it goes, my brain won't go to rest over this and has already done 
half the work, so expect a new series RSN. i'm sure you'll enjoy the 
churn ...

