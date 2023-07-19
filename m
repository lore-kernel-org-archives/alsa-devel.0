Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F277EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 10:21:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2293C1FE;
	Wed, 19 Jul 2023 12:20:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2293C1FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689762107;
	bh=Sa1+syZ9f303yHLwcBtzSyRpMimgMRyotOUVMYOHEAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iUB1gueJAcKvnr3jdQSrKWYO7ZF5RQv3cD7ngEuwYsyE3rDSU0vxAlYq43bcTFvyn
	 CkwltLoQOwq7E7OYp8r2RcusyPvpnnDcsXEgoilXxeCS4+P/Xx4eTyvyymTG2Z28LW
	 3TKVzv1seHDR9k/FTuNRJIbSdb2mPzmqVT5HZQjk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F0DBF80520; Wed, 19 Jul 2023 12:20:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2639F8047D;
	Wed, 19 Jul 2023 12:20:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47657F8047D; Wed, 19 Jul 2023 12:20:25 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08717F80153
	for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2023 12:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08717F80153
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 71FDC242E1;
	Wed, 19 Jul 2023 06:20:18 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qM4I6-0Hq-00; Wed, 19 Jul 2023 12:20:18 +0200
Date: Wed, 19 Jul 2023 12:20:18 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH 10/11] ALSA: control: Take lock in snd_ctl_find_id() and
 snd_ctl_find_numid()
Message-ID: <ZLe44rMeMmIEnXsm@ugly>
References: <20230718141304.1032-1-tiwai@suse.de>
 <20230718141304.1032-11-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230718141304.1032-11-tiwai@suse.de>
Message-ID-Hash: TGUFYZJULJF45X7U4ADL3YSCOM4ZZCUY
X-Message-ID-Hash: TGUFYZJULJF45X7U4ADL3YSCOM4ZZCUY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TGUFYZJULJF45X7U4ADL3YSCOM4ZZCUY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jul 18, 2023 at 04:13:03PM +0200, Takashi Iwai wrote:
>Now all needed callers have been replaced with *_locked() versions,
>
i don't understand why you made that a separate patch, given that there 
is no separate conversion step in between. i'd just squash it into the 
parent, and also absorb the followup commit.

regards
