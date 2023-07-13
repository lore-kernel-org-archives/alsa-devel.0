Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C9EC001DC
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jul 2023 09:08:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC4A2206;
	Thu, 13 Jul 2023 11:07:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC4A2206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689239323;
	bh=PWerSzF9uAVcHFsdE2Gb4cUgeaRRpUJVjkbkFVniNII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kFvstm6c4BOawfC6/7OS7BzDBfDTP64MGdNMdTdaHRMMz0KQtU2LVRatu+US5v37V
	 RwMFlxq5oiGQ3mLERBF9SYW6ZyIp/rkR/om33IgDuWcPKiKGBEe1PWiPqQ2dka7rPP
	 6qexXwhX6ewYsFFn/Xgz/0Gp3il8aUgR4MXWZadg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A43ACF80535; Thu, 13 Jul 2023 11:07:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DFB2CF80093;
	Thu, 13 Jul 2023 11:07:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28E03F80236; Thu, 13 Jul 2023 11:07:20 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4DE21F80093
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 11:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DE21F80093
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 150DA24290;
	Thu, 13 Jul 2023 05:07:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qJsI4-iL0-00; Thu, 13 Jul 2023 11:07:12 +0200
Date: Thu, 13 Jul 2023 11:07:12 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 3/3] ALSA: emu10k1: (re-)add mixer locking
Message-ID: <ZK++wAP6zYFFWvq6@ugly>
References: <20230712145750.125086-1-oswald.buddenhagen@gmx.de>
 <20230712145750.125086-3-oswald.buddenhagen@gmx.de>
 <87jzv4fbxl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87jzv4fbxl.wl-tiwai@suse.de>
Message-ID-Hash: K7NQOUMPOQFB6PG427YCSFA7BZECB5FG
X-Message-ID-Hash: K7NQOUMPOQFB6PG427YCSFA7BZECB5FG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K7NQOUMPOQFB6PG427YCSFA7BZECB5FG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jul 13, 2023 at 10:33:26AM +0200, Takashi Iwai wrote:
>We may optimize out the whole locking conditionally for the known-good 
>drivers,
>
well, that would work, though obviously someone would still have to 
check the drivers and set the flag. also, this kind of technically 
unnecessary fragmentation doesn't really help.

>instead of relying on a (hackish) big iron lock that wasn't considered 
>to be used originally at all.
>
i think you're focusing on the wrong thing here.
the fact that the lock was originally meant to do something else is 
meaningless. you could just as well create a dedicated lock specifically 
for that task - the important thing is that the core would provide a 
guarantee to the drivers that mixer callbacks are locked, just like it 
does for some pcm callbacks unless the driver opts out. given that mixer 
operations are rare in the big picture, fine-grained locking in the 
drivers is unnecessary (except where not mixer-only data is accessed).  
given the amount of code this saves, this seems like a rather worthwhile 
trade-off with the formal cleanness of drivers having self-contained 
locking.

regards
