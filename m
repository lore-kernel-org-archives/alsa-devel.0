Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF7C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 09:51:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE2D60E52
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 09:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDE2D60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92F641612;
	Tue, 24 Aug 2021 11:50:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92F641612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629798697;
	bh=apx2Fa3T8UrQS7ghJ47hd0ZP0KThGl01D79MiE4pNAw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p88q6+QKm3NGw9FXpEX0lcA12nkytCEH3zryiWmpoF6sp+8gw+0ZXf+/h+DApBIiH
	 9te50r1FDcES91NcpDAWXViaqSnlbBL1uja9a9to7MTPviEv951/a4XBDZSNFi8/Jv
	 aA5WXO0HaffuJDCvIFVofmtiJgEIviBQCGHV1QF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C346F801D5;
	Tue, 24 Aug 2021 11:50:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 402F3F801D8; Tue, 24 Aug 2021 11:50:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45E1AF80087
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 11:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45E1AF80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="dmGnxtda"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="s3RxFW3d"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 19F07220CD;
 Tue, 24 Aug 2021 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629798642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDyzcaYbWUJWhdO6lr1mnzZ8oMkqPKz/d7Q23APMcL8=;
 b=dmGnxtdauPqAuzrSbu8Aq+WCSa+FodL+R2DqthPg8gr0bUU/riRd/nA2vu5OZW1bVx7O/6
 FJy7euov502b4qTBCQJSsXMFQwFm2Hwed2QW1pzwCCHVrwlHaVKVEaM1pGQ4Dceuex13VB
 MGObIySzc7r4AamyKBRD0eekhPQwVpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629798642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDyzcaYbWUJWhdO6lr1mnzZ8oMkqPKz/d7Q23APMcL8=;
 b=s3RxFW3d1WMiUdqhWNLXzGN6onJezJOjmzehPQIW9t5SwOjsy7ODDpp//M3TV9V82SiNuB
 ZfwfqIVpKIacx1Cw==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 110E1A3BC0;
 Tue, 24 Aug 2021 09:50:42 +0000 (UTC)
Date: Tue, 24 Aug 2021 11:50:42 +0200
Message-ID: <s5hzgt71899.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: sujith kumar reddy <sujithreddy6192@gmail.com>
Subject: Re: arecord is failing with -V stereo
In-Reply-To: <CAAd2w=ZEFrnwC0fdMKUUpaU1XhYztZD-RHECf88+u+H+MNU=hQ@mail.gmail.com>
References: <CAAd2w=btf3DZLbPuovAC9xo3rizmFeT4iAxJs6zNZwKxOnKT6A@mail.gmail.com>
 <20210819183450.GV890690@belle.intranet.vanheusden.com>
 <CAAd2w=YFhiJJ=4nqo7JfbrqdNWVxvSp06E=1XiHOXV8Kp2sgaQ@mail.gmail.com>
 <20210819190634.GW890690@belle.intranet.vanheusden.com>
 <CAAd2w=Z4rG1UwA6ELzqwr_0TXjQmD0T1izonAJk9-32TSzGchQ@mail.gmail.com>
 <20210823170332.GD890690@belle.intranet.vanheusden.com>
 <CAAd2w=ag-Hk6COSJt5rg-+faz8FKYxTPig9AGhFWUFzGw1Ynvw@mail.gmail.com>
 <20210823184727.GE890690@belle.intranet.vanheusden.com>
 <CAAd2w=adJ3+Rw16ZVbkq72O7D0Dgo1ukHF1DLK6aaN3sGKu3DQ@mail.gmail.com>
 <s5heeaj2rcr.wl-tiwai@suse.de>
 <CAAd2w=ZEFrnwC0fdMKUUpaU1XhYztZD-RHECf88+u+H+MNU=hQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, folkert <folkert@vanheusden.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, 24 Aug 2021 11:19:46 +0200,
sujith kumar reddy wrote:
> 
> Hi Takashi,
> 
> With the above patches -V stereo is working fine.

Good to hear.  The patches have been submitted and merged now.


thanks,

Takashi
