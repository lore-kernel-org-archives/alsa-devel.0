Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDECEC33C99
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:40:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0CD2077B
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="be58JgZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0CD2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AEC4181F;
	Tue,  7 Jan 2020 11:39:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AEC4181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578393615;
	bh=47prFzq6NQSAomil+gbOKDA8itgTtQ1MwRHfj9I4scE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=be58JgZpLwkWZmnA1t4M2JP+GLYWZ3ePPWtNWf3+L3+aMX6KPT24hw8IgMBGJDRWr
	 epx7Mtbrawa4oUkuS5esHJPAMQs8EjNNr9jOfqc3YVU44OO79LNhj3g++VUsTWkH9B
	 WsCS7KCzDHhJ2PzUfUE+1bGIv8wAX+8o7DPHZg6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34D04F8014A;
	Tue,  7 Jan 2020 11:39:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36F86F8014A; Tue,  7 Jan 2020 11:39:23 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA65BF8010B
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 11:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA65BF8010B
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuDsZ-1jh0FX2AqT-00uXdS for <alsa-devel@alsa-project.org>; Tue, 07 Jan
 2020 11:39:18 +0100
Received: by mail-qt1-f181.google.com with SMTP id g1so4556497qtr.13
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2020 02:39:18 -0800 (PST)
X-Gm-Message-State: APjAAAWsvTd3rlDK2rH77TPGUai4S58LeIvX/0wNBRsr/yrEFph0xNVb
 WXJpyO3nTnekQLu3zPImdyf86gH0OgMS6KFTxiw=
X-Google-Smtp-Source: APXvYqyZhmN1eLl6pt96KksAU6g7g17LqbBD1ix7k6Tl4UknhAbwyEGN+KnksbzRm55kVluXwuoazvSU6xkSWIKNn+U=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr77340587qtr.142.1578393557482; 
 Tue, 07 Jan 2020 02:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20191218163701.171914-1-arnd@arndb.de>
 <CACRpkdbqzLUNUjx_kt3-7JLZym2RZ47edW5qp0MgXmpW4-Xf9Q@mail.gmail.com>
In-Reply-To: <CACRpkdbqzLUNUjx_kt3-7JLZym2RZ47edW5qp0MgXmpW4-Xf9Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jan 2020 11:39:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2BoVcdgRZqYutA=_SVHLtJwQzP3mKKN-q8n1ROj_iPgw@mail.gmail.com>
Message-ID: <CAK8P3a2BoVcdgRZqYutA=_SVHLtJwQzP3mKKN-q8n1ROj_iPgw@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
X-Provags-ID: V03:K1:KzwVab4sF4ncM0UCr0rZa1TgG8j6hLpw21yFIqfGz575Cvog3KI
 4i+O4pYkFMAebrVpBlpAADXKeQ56+L/zVn8R2rktOB9TFm6uNIgugTLASDvNq9GCvl9h0H5
 +vJyUfRxAlEBPOn8CS3BChs5NAHSBK3T49PslKvCYAvE9sLml1dtNWBXnAWNIAGJjReo6kJ
 RYjFRzqKoNoZdE8tmZAMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GfQP1XaPnZk=:Je5LX+G7indbKnesktahR4
 2e1lZakdP4rSTTk6P60F6YZDY1XHJrqPLZhMYx9aQhLODaFNoVe0ot2j0h/P1yelS9viN5HTS
 QfgpZBYUDgXQtXbT1I9xOWXjH69W27jpVAdHVNqH60uMjtYotahvU80H5uM8yuyWUUj0MizZL
 hzx9k4SnWTkTI1CM57ol1vftn4JVGAbiqk5QAQrWWWnItietTrjF2fs8TckRxFnI0OjhDe2t+
 l+9R34n5fSTufyRMSctjeD2iEcomCsQUsUHUFXPjNqtwV6frgzN6JkB9qeqg9G4ltEIXHfsgm
 q0kMOt975Rw8UxoUpVXgm5cJfuNkdCxiwKiPyPM2eRycB8faidWmWvfePvI6G1w3eIywuiHKJ
 GO7feR4sfhWjtsO1a5uA0FyU6FUSdZXmRaruH70wo5zYR79pX7JDj2x0xGvD7Q27BGTuf3iQC
 4YQqzid/BCWEmm9p/WW5haMoC0Bke7taB7JK8FHpfgg9IjoaJdIzZ1wPhrPZrUG0uo0Pnxol6
 tria9+5tB6qKG/peoFc6ftfnaRTWThKCeOCNaFOYJseVRxbqNTaIQApoNH27Kn8xbw9IeWdqg
 mq/bkAvmSHPbyJxQ5qv4L3HrCZgp16r6EdFF359pj05eb6bWK18HdMjGr+KDuhTSQca+6KOVQ
 xDliMKRgutUgaFsJhp+WMZInDyHA0IcnQLa0DB5yOc1Bj8S3bnc36A5y2OmvzMnGSUAgwZr56
 gRd3hMjp0AIum48RIqyozHt46er/oAlwwueimbaMcbzoiJvtptLX8j3AtCoopB3pjIKrRsR6O
 9/H1p6Xw5XqG3BHnDz0cNii7xUVEqfZDzNXioK6gvy6UDccFcOnj9wgvEaIoipF56tG3ui2Ny
 y2iehlTgRgUMWAu+fImg==
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [alsa-devel] [PATCH] pinctrl: lochnagar: select GPIOLIB
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

On Tue, Jan 7, 2020 at 10:45 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Dec 18, 2019 at 5:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I wonder if GPIOLIB should just become mandatory when enabling the pinctrl
> > subsystem, or if there are still good reasons for leaving it disabled
> > on any machine that uses CONFIG_PINCTRL.
>
> Hm that is a tricky question, they almost always come in pair but are
> technically speaking separate subsystems.

I think there are a number of use cases for GPIOLIB drivers without PINCTRL, but
are there any examples of the reverse?

       Arnd
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
