From: Daniel Mack <zonque@gmail.com>
Subject: Re: @Daniel Mack: Send you a FTU
Date: Tue, 14 Jun 2011 15:15:04 +0200
Message-ID: <BANLkTi=mba6pRRjJtEnQoTZWwjnnCRDgXg@mail.gmail.com>
References: <BANLkTinn8voTA8itkaP64xqzYDxFeJRqSQ@mail.gmail.com>
	<BANLkTimNHyp3_RqCjGQ8p-UOS8_LG+SKeQ@mail.gmail.com>
	<4DF74811.2080409@showlabor.de>
	<BANLkTinfQ60swYp-CF-yHa_DTSBQ3Fnqzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EF7CC103932
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 15:15:07 +0200 (CEST)
Received: by pzk26 with SMTP id 26so2762718pzk.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2011 06:15:04 -0700 (PDT)
In-Reply-To: <BANLkTinfQ60swYp-CF-yHa_DTSBQ3Fnqzw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2011 at 3:05 PM, Aur=E9lien Leblond <blablack@gmail.com> wr=
ote:
>> Are there any other issues?
>>
>> Felix
>
> I don't know how related to the Alsa Driver and the FTU that problem
> is, nor if it has any impact, but dmesg still reports the following to
> me when I plug the FTU, even with the latest git driver.
>
> [ 1846.736062] usb 2-1: new high speed USB device using ehci_hcd and addr=
ess 4
> [ 1846.869790] usb 2-1: config 1 interface 3 altsetting 0 bulk
> endpoint 0x7 has invalid maxpacket 8
> [ 1846.869802] usb 2-1: config 1 interface 3 altsetting 0 bulk
> endpoint 0x87 has invalid maxpacket 8

That is a warning about bogus USB descriptors, and there's nothing the
usb audio driver can do about them.

> @Daniel: You had some doubt about you having the time to work on these
> issues or even the need of getting your hands on the FTU. Can you
> confirm it now? If so, I'll get it shipped to you this evening and you
> can expect to receive it in the next few days. If you would prefer to
> wait, let me know.... Your call!

Send it out, and I will care as soon as I can :)

Daniel
