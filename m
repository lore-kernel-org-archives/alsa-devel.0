From: "Ignacy Kasperowicz" <fikufik@gmail.com>
Subject: Re: Problem with setting period time and buffer time.
Date: Tue, 19 Feb 2008 21:19:40 +0100
Message-ID: <9673d3ac0802191219v52a4ddb8p6742760c06292c60@mail.gmail.com>
References: <9673d3ac0802181557m6bd35f28w7680c9a9a979ab67@mail.gmail.com>
	<47BA908B.7040700@ladisch.de>
	<9673d3ac0802190320gab8bb7ara92a27b7f602d28b@mail.gmail.com>
	<47BACED0.9090709@ladisch.de>
	<9673d3ac0802190449x7130357cg6518402f7e9862d0@mail.gmail.com>
	<47BAEB9E.4050202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-13"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.190])
	by alsa0.perex.cz (Postfix) with ESMTP id A4873103933
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 21:19:42 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so1114309tia.8
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 12:19:40 -0800 (PST)
In-Reply-To: <47BAEB9E.4050202@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/2/19, Clemens Ladisch <clemens@ladisch.de>:
> Ignacy Kasperowicz wrote:
> >> Just write the data to the device.
> >
> > Ok, but when I just write data to the device I don't really know how
> > long it'll be playing.
>
> But you know how many sample you are writing, and you know the sample
> rate.
>
> > There is no problem when I've infinite loop with writei inside. but I
> > need to change freq of my sound signal with exact 843 us period time.
>
> Assuming a sample rate of 48 kHz, 1/1200 s corresponds to exactly
> 40 samples.  At 44.1 kHz, this would be 36.75 samples, so you'd have to
> use groups of 37+37+37+36 samples with appropriate phase shifting.
>
> BTW: 1 / 1200 Hz =3D 833.33... =B5s
>
>
> HTH
> Clemens
>

Thanks for correction, I was trying to make this too complicated :P
I dunno why I even thought about just setting how many samples to
write in writei() :P

Although, when from calculations indeed I should set 40 samples to get
sine played for 1/1200Hz, in my code I need to set frames size value
for 400. Do You know why? I have 48kHz rate, one channel and 16 bit
PCM.
>From what I've read there:
https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=3DFramesPeriods ,
"A frame is equivalent of one sample being played" so why I need
multiply calculation result by 10 ?
I think this is a last rookie question :)

Thanks for answers :)
ignacy

PS. Yeah I know its 833.33...us, I've just rounded it up for experimenting =
;)


-- =

################################################
gry =FAwietlicowe drog=E0 do wy=FDszej fazy przemian.
gg:681548 jid: fik@jabbim.pl usecide.net
################################################
