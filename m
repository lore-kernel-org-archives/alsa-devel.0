Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA43C32771
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE9F214AF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CxPnMiQu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="1dg0322C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE9F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFC761612;
	Mon, 27 Jan 2020 09:07:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFC761612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580112520;
	bh=f5ZSLbqBhXj70Kp2vTyF48rAyPBHArs4HOREB4tQOqY=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxPnMiQuxLZj9OgSfpxFINs03+EVU+SgbUPr4VWjpyYL703SjfmYktya6JT1D9yS6
	 bNvyjTApZ76gnEo5qtlIrs0Kt436IYJR7p+p0Ikot5MkgbXKYRJhsOdAmhfuxGlWUZ
	 indkmoC5Qc+dbziUv0JnvrV7WdoJJ3QBn52oxdY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C0A3F80218;
	Mon, 27 Jan 2020 09:07:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63009F8021E; Mon, 27 Jan 2020 09:07:46 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 120B2F80082
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 09:07:41 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 890BFA003F;
 Mon, 27 Jan 2020 09:07:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 890BFA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1580112460; bh=+F/YbJqvDSiGk1p8FtJRxmsOp1Ga/N+sqveeimRdrfA=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=1dg0322CCMEUdL84wHXJudW7w5j7GPz2Eg3lmjZ/PgZtIDcZWCArDnm9uJAvUdVX3
 aVdWU04Ite/uWaTgD0TB1xghoEGV8LB+II781p2J6TjHt7E1kz77vt8RjaXQWPGlB/
 jYh3IC/34DSRI/zOga2n5DrRZe/D00AUQFnxoeMI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 27 Jan 2020 09:07:37 +0100 (CET)
To: Tanu Kaskinen <tanuk@iki.fi>, alsa-devel <alsa-devel@alsa-project.org>
References: <1b39817bef4a6531d303c171aea1c757046cb4d8.camel@iki.fi>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <684a3597-0a5d-bc31-3fc2-b2f1f4d4eaed@perex.cz>
Date: Mon, 27 Jan 2020 09:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1b39817bef4a6531d303c171aea1c757046cb4d8.camel@iki.fi>
Content-Language: en-US
Subject: Re: [alsa-devel] UCM file lookup logic
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

Dne 27. 01. 20 v 4:38 Tanu Kaskinen napsal(a):
> Hi all,
> 
> I was looking at the UCM files, and most paths have the following
> structure:
> 
>      <cardname>/<cardname>.conf
> 
> I noticed that the "HDA Intel PCH" configuration uses some other
> scheme:
> 
>      HDA Intel PCH/HDAudio-DualCodecs.conf
>      HDA Intel PCH/HDAudio-Gigabyte-ALC1220DualCodecs.conf
>      HDA Intel PCH/HDAudio-Lenovo-DualCodecs.conf
> 
> How are the directory and file names determined? If I write
> configuration for some random sound card that I don't have myself,
> where do I find the various identifiers in the alsa-info output? I
> don't even really know for sure what the <cardname> in the first
> example is, I've been assuming it's the name that appears in the square
> brackets in /proc/asound/cards.

The ucm has scheme <longname>/<longname>.conf and 
<drivername>/<drivername>.conf (fallback).

The ucm2 has scheme <drivername>/<longname>.conf and
<drivername>/<drivername>.conf (fallback).

Example proc output:

  2 [device         ]: USB-Audio - USB Video device
                       317GAWCM001LON3BC1AZ USB Video device at 
usb-0000:00:14.0-4.2.4, high speed

The driver name is 'USB-Audio' here. The longname is '317GAWCM001LON3BC1AZ USB 
Video device at usb-0000:00:14.0-4.2.4, high speed' here. The name in brackets 
is the user selectable identifier for the card (card id). It can be used 
instead the sound card number.

> I think the lookup logic should be explained in the ucm2/README.md
> file. I can write a patch if someone expains the logic to me, but
> probably it's easier if you just write the patch yourself.

Yes, a better documentation for the internals is missing. Unfortunately, I hit 
other real problems with the current UCM logic and trying to resolve them. 
Unfortunately, I am interrupted with other things so things are going slowly 
than I want.

Actually, I am working on a UCM configuration verification tool.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
