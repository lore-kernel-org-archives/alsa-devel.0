Return-Path: <SRS0=Rgv7=ZF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC01C17442
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:34:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275912245D
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PzOMhsuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275912245D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F246111C;
	Wed, 13 Nov 2019 15:33:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F246111C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573655639;
	bh=dtHw/tLEsXUYK5WTYJ9hAdr+1A7eJ0mQ+Y3qyN+PQGU=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PzOMhsuNhamlCL9CRnk+fE8Iq++QudRxjbvlGLXbemArXMyM81hL93GBC05Sz/qd1
	 fB+AHN70kU+3wzW8fzYFglkvmghtgyzLCe2qiD3vvTcc3kFaDB686sPSHyxN30KE0b
	 i/AMo1LyZHNfyl7ap5B6axUrOVvMD8XFM/xUQ1pE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03841F80085;
	Wed, 13 Nov 2019 15:33:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FF21F80086; Wed, 13 Nov 2019 15:33:06 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 337E8F8007E
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 15:33:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 337E8F8007E
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnaTt-1i3qMC3PUL-00jbn3 for <alsa-devel@alsa-project.org>; Wed, 13 Nov
 2019 15:33:02 +0100
Received: by mail-qt1-f181.google.com with SMTP id y10so2794343qto.3
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 06:33:01 -0800 (PST)
X-Gm-Message-State: APjAAAWRrg2SfJdjfGOvVHKQj+l34p58xqMbQ33PD2qGyDBVW/1MqSGC
 3IQEZOpt4LafTkGpILlvbFJfrgkK3azLFybWS7o=
X-Google-Smtp-Source: APXvYqz+NQ3szRq7ultpigH8h2DRxd7RVxK5NJkwffgwZnkBYVjsay5MymzE3H4vFL1qe/jNlYuVA1/LMaohhg43P3E=
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr2862709qta.204.1573655580605; 
 Wed, 13 Nov 2019 06:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de>
 <s5hk1847rvm.wl-tiwai@suse.de>
In-Reply-To: <s5hk1847rvm.wl-tiwai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Nov 2019 15:32:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
Message-ID: <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
X-Provags-ID: V03:K1:bJAxPsMtCsG6VxzhzgeqibhAWiBXXJ9v6ayk/WnCcMYEWHCDxrp
 b4KKDjim9s4qd9nE4Jx1yWS8K3aQcSFC3C2peuQscyeB9fnwwHw2YLUnrK2VRWCSOtz8AIE
 ifhIEokU70cdaAwqKG6buv639Nc2peEvWCriK0z4IWWYIzN/tojVo004gV5qQ83L+BCj1g7
 ZdXwON2cnD8a4GhiLKgxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vHogxCfG1+4=:J9uTggScgG0u8zOK2B6nYe
 WO2fv6XSnhkoCZC496vUPuWSABpOAatsnvVQhyVMhJ+NyUzSdlItv9JecXWBd2JHhXh6hfGeD
 fZdN+h5V+OItv6l6Duqb/maseaEwvyTzjKykbpaI/uciOw8NGrPWo0u4UQ/GN5OyGQMPF0yZe
 nFkaqWzhL4w9RsJfHt+pmpo2PVy4HnKIIpx041kulDK1PtOcJYxj30kjTz2QZ4rGdEwSMmzue
 jq3RF56SXx9GjhfI9He7ARBOUuuz/2+coxiAc4Wy0R3bY/098m+jBWcFm+lylo/PS+yY4JWMB
 G31sVdA/DR3BwJzmbwaTJfHLiXnhueMOCJWciiGGhcXzIyQ7yVuIq2XbW1LxMWnqHCkQdYN57
 ubWK3IMpHmpXcD2crdvYGJVtcw+sHpgyA8ypmHV8S0AyB4ZBnVDbJCWciQvXZ+t9uFJW/5hUc
 IBWsyVQRSJgYEG8fFAMNStlIVzzQOaaofEVb27uk9Ep14CQgNefMPQSTh0Z0ZPXiIcO+VopUW
 uPMVBFf0tVI///UpqrQQSaVokWL4VaI5esxdHT9lB6vEe1aXifSLxnqZmbZU89dcxhtJcNwiW
 7083A9AX8D2d/m27pE/8gSzhOw1ai9LC+lArrxoba+IzUyPnFV/PVGhrK1YmoIJuImW4nGAI1
 IZ0I1whpkMeVQfF4ULHW4T/0iABcQ9qbrsaCmVMU9/624XTIUp41lsM0avLFHPicKAa4PE0ej
 Z8JdtCjoISuViuDVlaoabbEkHqxNSgJmjiobTZy0hI6XVO9xeXr0LDUYWf+4w2I8/IjCDXDRl
 2O+EIOJ1O5a53YXU1dbUXnXFzhquIVlD5DKtD8yCWeD66izXZQoAZX7Kn5E2BWY54VIOY/nQS
 IKgNXgQ5mZDdV8XSex9Q==
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 0/8] Fix year 2038 issue for sound
	subsystem
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

On Tue, Nov 12, 2019 at 9:37 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 12 Nov 2019 16:16:34 +0100, Arnd Bergmann wrote:
> > I would like to propose merging this into the alsa tree after
> > the v5.5 merge window for inclusion into v5.6, to allow a good
> > amount of testing, in particular for the header changes that
> > may cause problems for user space applications.
>
> Agreed, it's still no urgent problem.

I actually do think it's getting urgent, anything that touches
the ABI must be done carefully and not rushed.

The urgency at the moment is that developers are starting to
deploy systems with 64-bit time_t with musl-libc making this
the default now, and 32-bit risc-v not offering 32-bit time_t at all.

At the moment, this means that audio support is broken for
them, and that needs to be fixed.

The other reason why lots of people care about moving all user
space to 64-bit time_t is that 32-bit hardware is slowly starting
to become less common. We know there will still be many
32-bit ARM systems operational in 2038, but most of them will
be on (then) 10+ year old hardware, running even older software
that already being worked on today. The longer it takes us to
stop using 32-bit time_t in user space, the more systems will
end up having to be thrown away rather than fixed.

> So now taking a quick look through the series, I find this approach is
> the way to go.  Although one might get a bit more optimization after
> squeeze, it's already a good compromise between the readability and
> the efficiency.

Thanks!

> A slight uncertain implementation is the timer tread stuff, especially
> the conditional definition of SNDRV_TIMER_IOCTL_TREAD (IIRC, I already
> complained it in the past, too).  But I have no other idea as well, so
> unless someone else gives a better option, we can live with that.

We had discussed alternatives for this one last time, and decided
to go with the solution I posted here. The main alternative would
be to change the 'timespec' in snd_timer_tread to a fixed-length
structure based on two 'long' members. This would avoid the
need to match the command with the time_t type, but the cost would
be requiring CLOCK_MONOTONIC timestamps to avoid the
overflow, and changing all application source code that requires
the type to be compatible with 'timespec'.

     Arnd
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
