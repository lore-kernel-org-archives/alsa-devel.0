Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B50EC77B7A
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 09:30:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4E2A200;
	Thu, 18 May 2023 11:29:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4E2A200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684402223;
	bh=7kad5S8DbQwZW8oqySsplT++egGUiZY6pu8oDgI2kDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BZau8mI6HnCSrIs2o7jV7+xJjjMqx2Y2XVyh/nrdAwLBGEejmN091LpKBg0h0s9lZ
	 YPHSwDmOJYYepsRWZeFSF3yPrDDQuPJMoj35Hve5vwSZVzfpDoFs9wqzsrEtf7XnID
	 n+PtZzoKS8GAzgbhC5k/agGIW8urOKk/jKASz+GI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 844E3F802E8; Thu, 18 May 2023 11:29:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E08DFF80272;
	Thu, 18 May 2023 11:29:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67121F80272; Thu, 18 May 2023 11:29:07 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2623FF80087
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 11:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2623FF80087
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id D1EC1241CA;
	Thu, 18 May 2023 05:29:00 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzZwS-VxF-00; Thu, 18 May 2023 11:29:00 +0200
Date: Thu, 18 May 2023 11:29:00 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 9/9] ALSA: emu10k1: fix PCM playback buffer size
 constraints
Message-ID: <ZGXv3O1aCuDTrVz3@ugly>
Mail-Followup-To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
References: <20230518092224.3696958-1-oswald.buddenhagen@gmx.de>
 <20230518092224.3696958-9-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230518092224.3696958-9-oswald.buddenhagen@gmx.de>
Message-ID-Hash: VBYDBMOZDLU35N3OHIAHJW4PK54KWLIT
X-Message-ID-Hash: VBYDBMOZDLU35N3OHIAHJW4PK54KWLIT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VBYDBMOZDLU35N3OHIAHJW4PK54KWLIT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

sorry for the "flood", i forgot to adjust the declaration of the series 
in my tool. you can ignore the other patches; they didn't change from 
what you already applied.

regards
