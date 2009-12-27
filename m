From: "Markus Vogl" <markus.vogl@gmx.net>
Subject: Re: frequency analysis with alsa and fftw
Date: Sun, 27 Dec 2009 14:50:20 +0100
Message-ID: <DCFE698CA76D4C32B964618FB02D7745@RDF2008PC>
References: <20091227122631.62660@gmx.net> <20091227125343.GG7599@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0258424347
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 14:50:22 +0100 (CET)
In-Reply-To: <20091227125343.GG7599@lug-owl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi,

i have to do this in realtime (like a guitartuner) and with my "project" i
have to see the frequency shift in realtime in a terminal window.

regards
markus =


-----Urspr=FCngliche Nachricht-----
Von: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] =

Gesendet: Sonntag, 27. Dezember 2009 13:54
An: Markus Vogl
Cc: alsa-devel@alsa-project.org
Betreff: Re: [alsa-devel] frequency analysis with alsa and fftw

On Sun, 2009-12-27 13:26:31 +0100, Markus Vogl <markus.vogl@gmx.net> wrote:
> my project is to analyse the mic input frequency from my asus eepc =

> 1008ha with ubuntu 9.10  and show it in a terminal window. i would use =

> my acoustic 6 string guitar to play in front of my netbook.
>  =

> i=B4ve testet the howto from linuxjornal.com ..
> http://www.linuxjournal.com/article/6735
>  =

> ...but i=B4ve no plan to use the mic input and  then analyse it with fftw.

Why do you need to do ALSA programming in the first place? Isn't it enough
to use any given ALSA-capable audio recorder (eg. arecord) to record some
sound, convert it to raw PCM data (eg. cut off the WAV
header) and then shift all the data into the FFT lib?

MfG, JBG

-- =

      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
 Signature of:                            If it doesn't work, force it.
 the second  :                   If it breaks, it needed replacing anyway.
