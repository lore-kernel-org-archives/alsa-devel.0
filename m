Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9DCC43334
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jul 2022 15:22:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2D8B1652;
	Tue,  5 Jul 2022 17:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2D8B1652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657034560;
	bh=znZl6/ik79d0XgEU0bMz26oWVjPoIrCh4x/NmIs3v0o=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHH0/vN7WhHptcmDq45WaReFCEDSeEylZpz63QfERk5ARHvxEENwYASp7u970IieV
	 OAJ91GtNIRf8nyL+EuS5sEbeKRdkZrKHCWBOTsHuJMaqykhY6j7/m9C+i7ITIk3cLK
	 fIFMgQW3SIbmXPBHi2yIzgf7usZKNT8KglfzeS/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87EE9F80153;
	Tue,  5 Jul 2022 17:21:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 548ACF8015B; Tue,  5 Jul 2022 17:21:48 +0200 (CEST)
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15052F800CB
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2022 17:21:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15052F800CB
Received: by a3.inai.de (Postfix, from userid 25121)
 id CED62592E56A3; Tue,  5 Jul 2022 17:21:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by a3.inai.de (Postfix) with ESMTP id CE5E360BD5222;
 Tue,  5 Jul 2022 17:21:44 +0200 (CEST)
Date: Tue, 5 Jul 2022 17:21:44 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: snd_cs46xx regression, producing Oops
In-Reply-To: <875ykbvklj.wl-tiwai@suse.de>
Message-ID: <pprs942s-n3s9-9so5-191s-o6qqq9s31poo@vanv.qr>
References: <p2p1s96o-746-74p4-s95-61qo1p7782pn@vanv.qr>
 <875ykbvklj.wl-tiwai@suse.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Tuesday 2022-07-05 13:56, Takashi Iwai wrote:
>> 
>> Commit v5.14-rc1-39-g5bff69b3645d introduced a breakage into
>> snd_cs46xx.
>
>Could you try the patch below?
>Subject: [PATCH] ALSA: cs46xx: Fix missing snd_card_free() call at probe error

I confirm your patch cures the oops.

>Fixes: 5bff69b3645d ("ALSA: cs46xx: Allocate resources with device-managed APIs")
