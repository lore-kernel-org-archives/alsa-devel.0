Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1AAC2BA2B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:27:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107D2206D9
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jMGH1RrU";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTj1dGhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107D2206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 524851672;
	Wed, 15 Apr 2020 08:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 524851672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586932054;
	bh=6KgOr5J2RQR3glfpgd97gjh7IxHGYgHcTe8c+V2zwdw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jMGH1RrUdWxrlmGvPXGdci2swnJki8trqd1B43jNO8OoSOcAbTE+GBjhwyHfthKO4
	 5rwovEi4r6cgzS6Nbfren70vyxDb/0R11Q5CqNAo8iryzcDeFwS2RwYMVBf8zc9M+s
	 BBQAeAfqb1aQBkPr0qm+DkiVn85wJuAnLgyevZwY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0D62F80229;
	Wed, 15 Apr 2020 08:26:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1A96F80245; Wed, 15 Apr 2020 08:26:37 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53218F80115
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 08:26:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53218F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qTj1dGhM"
Received: by mail-io1-xd43.google.com with SMTP id i3so15919625ioo.13
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5l5JZLE5+uy1cy5YoDuTEWvq3otbXGKSc72rAbmY9yo=;
 b=qTj1dGhMKWVJU2k9fV3qPU3crGlkZGJ/NPBWg0Wqtlb22Bbc+Z/YHElH4bgQaMGo7v
 Otbx/htJMft4FOcjSPDhI4kAOv3lVlvOxytE6nemx0c9n7NINiToI12C2bbyk92HFRiR
 bBXd0VGSBLVDmG8AUKr6f0PXcjrpTl09UUgl/Rragd81eVKFkrNM6W3P2dFCGnE1wZS8
 yJmLC3+jA93WPZZn811Uy8WTYl1vQN1uy20Rh+Y6/VXIloEAVDgzzcQJpjjiq5GFkaj8
 iuzKe9TeYzy9IqO2oyTDqyHq5cLHNhv4mhurzQzGRgPCnGdocopI5VgN4CxSVpYV2h2q
 C6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5l5JZLE5+uy1cy5YoDuTEWvq3otbXGKSc72rAbmY9yo=;
 b=ooIQ0Ur13GO3m//zbaJ0pvVWmKsS3GK9LyJEOvSdDw03pCB6HaG42JdIbbtT7xx3KU
 puQ9jZ3264UcEaL96wKKP2+16UAEWyMVkrH0AmjWFKrU6Go0sLPGUWZEDTTZBCXEpbZ/
 9jNZ1z432LBEMl/FQfigF6xaydVby8hT5U52NWPVsJA7YnF//gB6r0vhgG62nkJDR8aK
 bjyA+COx9rYqs/Q+nwQs2dJIBzdmuCFw/8+AF0Vz1JkUDd5mXPcnrgXo8yQRPIkPeZ5M
 KqY+gciC5JI8BD0J/OXIAjWJ6O7O8YFmKIsrE6sZVV8fmXZPwm40HLt9XioGwhKLXOx2
 GqtA==
X-Gm-Message-State: AGi0PuYxIZWenhXAVwepH3fPFEXwEgFlnHM/bmrLWXLoCXIy/EHDOw+f
 DxkT8jIcGiJQgNjKxZbT+K4DlTPob5Nmn1lITqo=
X-Google-Smtp-Source: APiQypJv9wD8HTW5QAylmZbsVJCz67yelRiep1Hyar//oLyUvgS2v/l+NpZlR5QBwMHje+NnZJN2R/9H3Y2JA3b1KBA=
X-Received: by 2002:a6b:b547:: with SMTP id e68mr21774789iof.173.1586931987615; 
 Tue, 14 Apr 2020 23:26:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a58b:0:0:0:0:0 with HTTP; Tue, 14 Apr 2020 23:26:27
 -0700 (PDT)
In-Reply-To: <d6146d62-a20a-f6a0-64f0-65cea7253948@perex.cz>
References: <20200413145957.22459-1-youling257@gmail.com>
 <ae69c1b0-b347-4366-4bb0-383aed69c4b1@redhat.com>
 <d6146d62-a20a-f6a0-64f0-65cea7253948@perex.cz>
From: youling 257 <youling257@gmail.com>
Date: Wed, 15 Apr 2020 14:26:27 +0800
Message-ID: <CAOzgRdbgOykctcteVMLJqqyeXwww2ekzUrbzLbu0jtCoU_5Xgg@mail.gmail.com>
Subject: Re: [PATCH] bytcht-es8316: fix Speaker or Headphone no sound if
 enable Mic or Headset
To: Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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

boot enter ubuntu no sound at all if EnableSeq.conf disable all output.
=E2=80=9C The PA should activate HiFi verb only once.=E2=80=9D i don't thin=
k so.


2020-04-14 16:07 GMT+08:00, Jaroslav Kysela <perex@perex.cz>:
> Dne 13. 04. 20 v 17:46 Hans de Goede napsal(a):
>> Hi,
>>
>> On 4/13/20 4:59 PM, youling257 wrote:
>>> alsaucm -c bytcht-es8316 set _verb HiFi set _enadev Mic, Speaker will n=
o
>>> sound.
>>> alsaucm -c bytcht-es8316 set _verb HiFi set _enadev Headset, Headphone
>>> will no sound.
>>
>> I see the problem, so the idea of the global EnableSequence is
>> to set defaults and then the EnableSequence of currently active
>> devices run on top.
>
> It's ok, it's just a wrong use of the alsaucm command. The PA should
> activate
> HiFi verb only once. Those two commands run the verb EnableSequence twice=
.
>
> The correct test should be:
>
> alsaucm -i -c bytcht-es8316 set _verb HiFi
> alsaucm>> set _enadev Speaker
> alsaucm>> set _enadev Headphone
> alsaucm>> set _enadev Mic
> alsaucm>> set _enadev Headset
>
> ... you may run the enable commands with a delay for tests.
>
> The current UCM is designed for one task (application). I am playing with=
 an
>
> idea to extend the alsactl state daemon to preserve the UCM settings and
> state
> for multiple applications using an RPC mechanism (dbus?).
>
> 						Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
