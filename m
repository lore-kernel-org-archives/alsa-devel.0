Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B53C33CB1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:24:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CC324658
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="ZoM2tRqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CC324658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFE07170D;
	Mon, 13 Jan 2020 13:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFE07170D
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3603AF80149;
	Mon, 13 Jan 2020 13:39:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA97DF801EB; Mon, 13 Jan 2020 13:39:17 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD34BF80149
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 13:39:14 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B629DA003F;
 Mon, 13 Jan 2020 13:39:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B629DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1578919153; bh=1CxLvVRSdSf/MKE/Xwmi0zoBNBaBOwE7p9w8W9cTY34=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=ZoM2tRqkNnEkfTbXAFJJvVK1IseAk7LrXqO7RfsgOw5VD3AbkhLuNxcRMODKSgJRp
 ykLsbgwijKyMHeSuMhyrB6mu71eFbnGxNApzVYVcX275k5KEkG66kmorsKznfrQSH4
 GRXdhWMhBy2QZ/rOq7n2YwWiq+IuONHVgS8NLUDc=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 13 Jan 2020 13:39:11 +0100 (CET)
To: alsa-devel@alsa-project.org
References: <20200109221032.GA74081@impa>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <7294fce2-716e-00c2-665f-587424b96eb0@perex.cz>
Date: Mon, 13 Jan 2020 13:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109221032.GA74081@impa>
Content-Language: en-US
Cc: Tim Schumacher <tim@timakro.de>
Subject: Re: [alsa-devel] Bug report for changes in ucm2 with chtrt5645 card
 on Lenovo Miix 320
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 09. 01. 20 v 23:10 Tim Schumacher napsal(a):
> Hi alsa devs,
> 
> I'm on Arch Linux on a rather uncommon laptop (Lenovo Miix 320) and my sound
> stopped working on the upgrade from alsa-lib 1.1.9 to 1.2.1. wabbits on
> IRC helped me track down the problem to a change in the
> /usr/share/alsa/ucm (now /usr/share/alsa/ucm2) files. It seems like
> /usr/share/alsa/ucm2/chtrt5645/HiFi-dmic2.conf and a symlink at
> /usr/share/alsa/ucm2/chtrt5645/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216.conf
> were specifically added for this laptop but in the contrary they break the
> sound for me.
> 
> After the upgrade to alsa-lib 1.2.1 the sound is not working. The commands play no sound:
> 
>      pasuspender -- speaker-test --nloops=1 --channels=2 --test=wav --device=hw:0,0
>      pasuspender -- speaker-test --nloops=1 --channels=2 --test=wav --device=hw:0,1
> 
> And this is the alsa-info.sh output http://alsa-project.org/db/?f=f883910a5c5101b4b1ea4202d1fe84ccd139f796
> 
> After deleting the /usr/share/alsa/ucm2/chtrt5645/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216.conf
> symlink both commands from above play sound and this is the alsa-info.sh
> output http://alsa-project.org/db/?f=e759eb9118a191b6c3b8c021fed58abc9cf95076

Thanks. I forgot to fix the file path in chtrt5645/chtrt5645-dmic2.conf . 
Could you test this patch?

https://github.com/alsa-project/alsa-ucm-conf/commit/74f2a0f0884df7b9f2d08d07456a3bc37d1a512e

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
