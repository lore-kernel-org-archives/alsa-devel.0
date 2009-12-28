From: "Markus Vogl" <markus.vogl@gmx.net>
Subject: Re: frequency analysis with alsa and fftw
Date: Mon, 28 Dec 2009 13:16:13 +0100
Message-ID: <0B1B7B39A9124BCE97237B7DF412D83F@RDF2008PC>
References: <20091227122631.62660@gmx.net> <20091227125343.GG7599@lug-owl.de>
	<DCFE698CA76D4C32B964618FB02D7745@RDF2008PC>
	<20091227140454.GH7599@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id AC3361037FE
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 13:16:15 +0100 (CET)
In-Reply-To: <20091227140454.GH7599@lug-owl.de>
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

 =


> -----Urspr=FCngliche Nachricht-----
> Von: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] =

> Gesendet: Sonntag, 27. Dezember 2009 15:05
> An: Markus Vogl
> Cc: alsa-devel@alsa-project.org
> Betreff: Re: [alsa-devel] frequency analysis with alsa and fftw
> =

> On Sun, 2009-12-27 14:50:20 +0100, Markus Vogl =

> <markus.vogl@gmx.net> wrote:
> > Von: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de]:
> > > On Sun, 2009-12-27 13:26:31 +0100, Markus Vogl =

> <markus.vogl@gmx.net> wrote:
> > > > my project is to analyse the mic input frequency from =

> my asus eepc =

> > > > 1008ha with ubuntu 9.10  and show it in a terminal window.
> > > > i would use my acoustic 6 string guitar to play in front of my =

> > > > netbook.
> > > >  =

> > > > i=B4ve testet the howto from linuxjornal.com ..
> > > > http://www.linuxjournal.com/article/6735
> > > >  =

> > > > ...but i=B4ve no plan to use the mic input and  then =

> analyse it with =

> > > > fftw.
> > > =

> > > Why do you need to do ALSA programming in the first =

> place? Isn't it =

> > > enough to use any given ALSA-capable audio recorder (eg.
> > > arecord) to record some sound, convert it to raw PCM data =

> (eg. cut =

> > > off the WAV header) and then shift all the data into the FFT lib?
> >
> > i have to do this in realtime (like a guitartuner) and with my =

> > "project" i have to see the frequency shift in realtime in =

> a terminal =

> > window.
> =

> Sure. Just let eg. arecord write to stdout or to a FIFO and =

> read the data from there. You can directly request raw =

> output, all you need to do is to shouvle the data through the =

> FTT lib...

Who can me explain how i can transfer the frame/buffer to the
fftw3.lib? This is from the howto example at linuxjournal
and in the "while loop" is the frame that i can use for DFT =

...or i=B4m wrong? =


while (loops > 0) {
    loops--;
    rc =3D snd_pcm_readi(handle, buffer, frames);
    if (rc =3D=3D -EPIPE) {
      /* EPIPE means overrun */
      fprintf(stderr, "overrun occurred\n");
      snd_pcm_prepare(handle);
    } else if (rc < 0) {
      fprintf(stderr,
              "error from read: %s\n",
              snd_strerror(rc));
    } else if (rc !=3D (int)frames) {
      fprintf(stderr, "short read, read %d frames\n", rc);
    }
    rc =3D write(1, buffer, size);
    if (rc !=3D size)
      fprintf(stderr,
              "short write: wrote %d bytes\n", rc);
  }

regards
markus
