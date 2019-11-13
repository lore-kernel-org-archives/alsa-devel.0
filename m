Return-Path: <SRS0=Rgv7=ZF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275BEC43331
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:10:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A185F2246A
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qKEYR4P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A185F2246A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CECC91612;
	Wed, 13 Nov 2019 16:09:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CECC91612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573657834;
	bh=bshF7URyOw7mPO3OaKu+wAeGXrqiI8pH+G6oISmC6xo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qKEYR4P5EGpTD/bT1Fqvu0e/S/+FaDavF5HVeSLF8oEEB9kMfPP5HTosypMS7sSCS
	 VKDiAFimFoW433++MU+YU8TQWJixgvMvt/NaT/iZdBwJYCNiANr6CaUxyLNNnR5IaL
	 /mhTrBmgY5exlA3kb6gXiC+E4Lk3mcGGMrO2pqXo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7C60F80084;
	Wed, 13 Nov 2019 16:09:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E23E2F80086; Wed, 13 Nov 2019 16:09:41 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7ABC0F80084
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 16:09:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7ABC0F80084
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3sRi-1hn9LE13WS-00zpyl for <alsa-devel@alsa-project.org>; Wed, 13 Nov
 2019 16:09:36 +0100
Received: by mail-qk1-f178.google.com with SMTP id e187so2006630qkf.4
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 07:09:35 -0800 (PST)
X-Gm-Message-State: APjAAAXyWMypKtTmc3LUrKpm8HGRfUKqOI9W83jazZOEa59OgCsjMV/c
 fo2dlpQ4k1ChdiwsRI6rbuqblF9W2HLQkUYeGHg=
X-Google-Smtp-Source: APXvYqzQ08oWGBtIBKfGwjyYF/iVEHvO+TappMGnZDNXcHZ/2ulhuHUZC/UgZA1ht67tDy6BsfjyTBfPL3Z6pLWgoTA=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr2794772qkb.138.1573657774816; 
 Wed, 13 Nov 2019 07:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de>
 <20191112151642.680072-3-arnd@arndb.de>
 <s5hblthp0di.wl-tiwai@suse.de>
 <CAK8P3a1fsC+05i-i77g2aR3bkzprnhbhROLkMPcy=UFfsV3GMw@mail.gmail.com>
 <s5hlfsk7sbt.wl-tiwai@suse.de>
In-Reply-To: <s5hlfsk7sbt.wl-tiwai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Nov 2019 16:09:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3EKr4-ygUJ453Fv9DdW0YTHMcTuMu5TmbZ=aLxsWzU0g@mail.gmail.com>
Message-ID: <CAK8P3a3EKr4-ygUJ453Fv9DdW0YTHMcTuMu5TmbZ=aLxsWzU0g@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
X-Provags-ID: V03:K1:8wp+yztJ+fom5VgvUbHXYsEW5koYXSWvBnTA638gI39dB/pA2+D
 kXKM6e/5iDMIq/z8w3KZQMCo3tEKUPI+OFIvczrLXMk/DnAn+Kb8wNdZDDd1XhR3lzf9RoU
 oIcHqQ61Lr10VJVa1e+WwN5C5/Cy2rIupYwEXIRkEtLcgqKZVqBhnTxSmGDC1R/1PIW5EfC
 mZcenJzHYG8YECLUKnfSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iP3xpHaVnbs=:TStn7yf4S6b8WqSvkJvBUp
 tk6JR99voRstr4hMV5rBDp4nrWbiGUDh8gU52tQ6glnKLigA4wFGDQDZccXPX2ktN1SXPxq5e
 4q2Yba/HE6ZZyF32V8JbXItQzZJOk60iahIjXfR2A+HgBwBNvL5hZBSAWdrw0pqTjZJ02bbvd
 a/RUqpGiM60+Qi8fUXc9Jla0Bhqe733pxgjzWbPvGp8LQpxz7wR3Ui4+l5xNAIwbXaMylTRf7
 dRV1fGzxBINuDR55LihrEYSkpdZP+9tTlHS3NxNk87Ud7/jUj5EVE005J0nOzZdw5OEfL5ndF
 jVFgsu1T6kOP7PEgt4TE9K+aXfPA5Lm14+P42SysC1V54ZQ7/Q9/AHgpzgteq/1OFLcEgyEUP
 DJXgNvPm37s34tAqT5HPON07caezFme77OZFsIGyIGMulFd7/20ju2wDHj1aL2kHv7RjW36vj
 e6kVqh1STukz+Kx/V0bkNLtLlXnBKNv+CLjj0IYmRm6rYiEhXn17GDTey17UQLQk2ps0K+Tli
 S5EpKKKyrg0K67xS+UcAgCkKo5wYQXQKV1Pcl2OzxjO/GrsuV/NHI03DQ0/yBQr/L3WFWw6cs
 o7t6U3TrCyeftAY3wYaG8TeKbVtJ63tDyGP3ygk6CmN37BkoLTGCW4fBMQkUNbY2TC/nUWcEP
 KLan/4w3Gt4VBKsYbPF20kSNpA4Eiqq6C+Fs47n1NmsKclPnK3TFHYuhxG3qn/dD5ZxugA/nY
 7Vm6NyuOm8smbOn1y+y+EZrV2B/afnwM3DyWOFHm1bBxIOjPjp2H+xWxKdYPnbBXyTSEatOxx
 NJmip/DGmq7Lsm29BfqAlOamE2jWrwIv5tUf3PeuHurJ25bzt+g45xhiwdfEpOZXb1/fa/AcW
 U8PJfRLea8JQDqSuaxwQ==
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Baolin Wang <baolin.wang@linaro.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 2/8] ALSA: Avoid using timespec for
	struct snd_timer_status
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Nov 12, 2019 at 9:28 PM Takashi Iwai <tiwai@suse.de> wrote:

> > Well spotted, this is indeed a very recent change I did to the patch.
> > The idea here is to hide any use of 'time_t', 'timespec' and 'timeval'
> > from kernel compilation. These types are now defined in an incompatible
> > way by libc, so we have to remove them from the kernel's uapi headers.
> > I would prefer to remove them completely from the kernel (rather than
> > moving them from uapi to internal headers) to make it harder to write
> > y2038-incompatible code, and with the 90 patches I sent this week,
> > all users are gone from the kernel (this series was the last part).
>
> Could you put this trick in the changelog, too?

Done.

      Arnd
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
