Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61088C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 11:34:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 997131741;
	Fri, 20 May 2022 13:33:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 997131741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653046475;
	bh=nxdRocMd7sYwbATMAOPqK2o9fOxq5M8mjypB0zLbSqE=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uty4ZHp2SNvlv6Y7RukgVyELWyJ+fWRLmoNaRYUuVfMTalJw4TqVZYs/oIQ1byDjZ
	 lFRLmhHyaIgpCHktHdlsLyumu2dZLxf2phLR/UmPumEKEbnYPQQrzPPIN8pOiwwWhk
	 OuBM5wATsHST2GABMyGL7HWqNG/h/CQQk5x/UrBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CDCDF804BD;
	Fri, 20 May 2022 13:33:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18170F802DB; Tue, 17 May 2022 18:40:20 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 996A2F800F0
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 18:40:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 996A2F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qep90F73"
Received: by mail-pg1-x533.google.com with SMTP id 31so17405398pgp.8
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=nxdRocMd7sYwbATMAOPqK2o9fOxq5M8mjypB0zLbSqE=;
 b=qep90F73cFGwd47eB7DhyCkptVp/gcTueqCt3hC2KhCGRTSQFvFu0lQEWZYmOBrzhH
 P8GEBiOaT/LaQABc7fDpBKsA7uvwMRWSfKdvzE1qnNXjf3gqwimJcx7Dppkb2nnRq3I8
 9xnskC9ZrwhqIIaaf/w+umJjZifJW3ZxDdnvVInI5PCAqqc2pcb7+0PCryRcXgjoHEL1
 BHKPTtaUm1zGPeZ7krFtdTo6tdzhUxA1Z0sZcMpQHmC5+PJuq0ohFQ9oRDWZqiqzK3ee
 KseO8YD9ERxDZLrlx+XuZuta2iL0G2HygtD1SBJD2OI20l0gmjHjkiVX9g0q94oqTZ8g
 N66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=nxdRocMd7sYwbATMAOPqK2o9fOxq5M8mjypB0zLbSqE=;
 b=RhZe0/5rKk+A/t28gQfYjbOp1k5Jgysd/uWb/udWi7O8FazM+vlHJcEYjO69M2juzf
 upxp+hKtxRVFWX5UQ/brjBnnhhVvvTnB8CKwNKjODZ9L6F2nnOLvrNX+OSuAKYweJ1U5
 8ZBes6zecayZ0e1jZDL9QmW+Ow2BtsqcA0HIGLIUeP78dbSMhWth2IYE/ra3CgMys+bh
 QuFHEK15n+8axT5m2gubJ0b5dby7pHR0h9Rjoe7nktvRy4lA1U5VWwXuwleIhefnMzJI
 SB4dnBpy8HPreaPtUpKpnuzBzX7euL4wbMQ0YxFo2GtrBo15GptKregkVXpSpMl5KR5Z
 oovA==
X-Gm-Message-State: AOAM5322yOUABWP+xyFCr5/aPkPbwK8kkug5xrWnIO/RgtDecmPAvqf9
 XzF2el3KJfltuIRd4DPQc+XTt/DPFtXHZWsV/S5KnJdHN/UhBA==
X-Google-Smtp-Source: ABdhPJztXCZRxiWSuVfckCkOSSXkUUu2XT4QaxF4OCyN36agnaGnovi/aflXnFloAjo74J+mYt+cNHZDoiXI8v98NWs=
X-Received: by 2002:a63:db11:0:b0:3c5:ecce:6d8a with SMTP id
 e17-20020a63db11000000b003c5ecce6d8amr19823277pgg.550.1652805614377; Tue, 17
 May 2022 09:40:14 -0700 (PDT)
MIME-Version: 1.0
From: popcorn mix <popcornmix@gmail.com>
Date: Tue, 17 May 2022 17:40:03 +0100
Message-ID: <CAEi1pCSev6CMThWnKk9tYNwEjcyvbq7Fc8Nwg9fdzYS-+8-15g@mail.gmail.com>
Subject: Re: Re: [PATCH] conf: vc4-hdmi: use a proper hdmi pcm, fix broken
 default pcm
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 May 2022 13:33:12 +0200
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

Matthias Reichl wrote:
> Userspace expects to see a HDMI pcm, so remove the somewhat broken
> front and iec958 pcms and add a proper hdmi pcm instead.
>
> The hdmi pcm supports HD/HBR audio passthrough and relays the IEC958
> status bits on to the kernel driver so it can switch to HBR audio
> packets if needed. The control hook is marked optional because kernels
> before 5.14 didn't expose the IEC958 controls.
>
> The default pcm never worked as dmix doesn't support the iec958 format.
> So drop dmix, only use plug and softvol, and use the hdmi pcm for
> iec958 formatting.

I can confirm the upstream cards/vc4-hdmi.conf is not usable,
and RPiOS ships a patched version (which was an earlier version of this patch).

I've tested this version with RPiOS bullseye and all seems good.
I could play stereo and multi-channel PCM from VLC.
I could also play DTS, DTS-HD and TrueHD formats as passthrough using kodi.

It would be good if we can switch from a custom version of vc4-hdmi.conf
to an upstream version in RPiOS when this is merged.

Tested-by: Dom Cobley <popcornmix@gmail.com>
