Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8352EC77B7C
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 17:13:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 838BC1019;
	Wed, 10 May 2023 19:13:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 838BC1019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683738834;
	bh=ipxlx3b9cnnxcE6cG1diEss35YH2JZEjePRBO9K1EW8=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dOhiC91yAG9kC76hml1C01HylAwoZDK0JguVjw4Ig3mcuCAZ6oH6K2iJZ2LKWmRtP
	 vCoNmVKJ6fIvKe7zhXIZ4BtXrlGY/x0T2+pEe/u0HqPcnPWWFyrzddVTZ1ajkeN+DK
	 yq/pMjRywWeaNIKkOyUWbNU2qsfW6MJhZoSVAaVc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6022F8032D;
	Wed, 10 May 2023 19:12:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85A64F8032D; Wed, 10 May 2023 19:12:33 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BEC9F80087
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 19:12:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BEC9F80087
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 6E46D2408D;
	Wed, 10 May 2023 13:12:20 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pwnMS-sbr-00; Wed, 10 May 2023 19:12:20 +0200
Date: Wed, 10 May 2023 19:12:20 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v3] ALSA: pcm: auto-fill buffer with silence when
 draining playback
Message-ID: <ZFvQdJ2/d1muNQPO@ugly>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
References: <20230510162924.3063817-1-oswald.buddenhagen@gmx.de>
 <24e60af6-9585-289c-05e5-5b34370c6dba@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <24e60af6-9585-289c-05e5-5b34370c6dba@perex.cz>
Message-ID-Hash: TP2ZITWHOWCDN4VTBWOJPDKA6FPUQMZE
X-Message-ID-Hash: TP2ZITWHOWCDN4VTBWOJPDKA6FPUQMZE
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TP2ZITWHOWCDN4VTBWOJPDKA6FPUQMZE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, May 10, 2023 at 06:54:57PM +0200, Jaroslav Kysela wrote:
>NAK. Already implemented in alsa-lib which is enough for the first 
>implementation.
>
did you read the part below the cut-off line? ;-)

>> you are NOT expected to apply this. i just needed it for my testing
>> (it's easier to deploy as i'm hacking on the kernel anyway) and wanted
>> to post it for posterity.

this patch should serve as a template for fixing the bug in the 
user-space implementation i reported a few days back. i'll post a patch 
sometimes soon if you don't beat me to it.

also, i think the drain_silence config should be re-interpreted as 
overriding the default 1/10th sec "overshoot", rather than nonsensically 
the total delay irrespective of period size.

regards
