From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Problems with a PCM driver
Date: Sat, 30 Aug 2003 20:22:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308302022.13365.adrian@mcmen.demon.co.uk>
References: <200308301956.52235.adrian@mcmen.demon.co.uk> <3F50F789.6070509@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA23151
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2003 21:22:05 +0200
In-Reply-To: <3F50F789.6070509@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Saturday 30 August 2003 20:14, James Courtier-Dutton wrote:
> Adrian McMenamin wrote:
> > I am writing a PCM driver for the AICA device on the Sega Dreamcast f=
or a
> > 2.6.0-testX kernel.
> >
> > The driver is far from complete, but I am having various problems whe=
n I
> > test bits of it...
> >
> > A simple write of a file gives me this...
> >
> > /dev/snd # cat /test.txt > pcmC0D0p
> > ALSA sound/sh/aica.c:165: In snd_aica_playback_open
> > ALSA sound/sh/aica.c:80: Disabling AICA device
> > ALSA sound/sh/aica.c:66: Enabling AICA device
> > cat: write: File descriptor in bad state
> >
> > The three snd_printk messages are just what I would expect but I am n=
ot
> > sure why I get the message about the file descriptor.
>
> Why don't you do instead: -
> aplay test.txt
>
Is aplay a system call?

All I get is this...

/dev/snd # aplay /test.txt
aplay: No such file or directory


Incidentally, the mini-HOWTO on the site says this:

Now you are ready to put any soundfile you want into the PCM device of th=
e=20
first card. So try to cat any textfile (any file) to /dev/snd/pcmC0D0, li=
ke=20
this: cat <filename> > /dev/snd/pcmC0D0.=20

Thanks for the help anyway :)

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
