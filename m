From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Problems with a PCM driver
Date: Sat, 30 Aug 2003 20:51:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308302051.30128.adrian@mcmen.demon.co.uk>
References: <200308301956.52235.adrian@mcmen.demon.co.uk> <200308302022.13365.adrian@mcmen.demon.co.uk> <3F50FED1.6020905@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA23555
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2003 21:51:22 +0200
In-Reply-To: <3F50FED1.6020905@superbug.demon.co.uk>
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

On Saturday 30 August 2003 20:45, James Courtier-Dutton wrote:
> Adrian McMenamin wrote:
> > On Saturday 30 August 2003 20:14, James Courtier-Dutton wrote:
> >>Adrian McMenamin wrote:
> >>>I am writing a PCM driver for the AICA device on the Sega Dreamcast =
for
> >>> a 2.6.0-testX kernel.
> >>>
> >>>The driver is far from complete, but I am having various problems wh=
en I
> >>>test bits of it...
> >>>
> >>>A simple write of a file gives me this...
> >>>
> >>>/dev/snd # cat /test.txt > pcmC0D0p
> >>>ALSA sound/sh/aica.c:165: In snd_aica_playback_open
> >>>ALSA sound/sh/aica.c:80: Disabling AICA device
> >>>ALSA sound/sh/aica.c:66: Enabling AICA device
> >>>cat: write: File descriptor in bad state
> >>>
> >>>The three snd_printk messages are just what I would expect but I am =
not
> >>>sure why I get the message about the file descriptor.
> >>
> >>Why don't you do instead: -
> >>aplay test.txt
> >
> > Is aplay a system call?
> >
> > All I get is this...
> >
> > /dev/snd # aplay /test.txt
> > aplay: No such file or directory
> >
> >
> > Incidentally, the mini-HOWTO on the site says this:
> >
> > Now you are ready to put any soundfile you want into the PCM device o=
f
> > the first card. So try to cat any textfile (any file) to
> > /dev/snd/pcmC0D0, like this: cat <filename> > /dev/snd/pcmC0D0.
> >
> > Thanks for the help anyway :)
> >
> > Adrian
>
> Have you installed alsa correctly?
> alsa-driver, (Kernel modules like the one you are developing)
> alsa-lib, (the alsa api.)
> alsa-utils, (the one with aplay in it.)
> alsa-tools (other useful tools.)
> alsa-oss (if you want oss emulation in userland.)
>
Errr, no. I suppose that might have something to do with it :)

To be frank, the site doesn't exactly make it particularly clear this is =
what=20
you need to do - though I suppose I could always have asked :p

Thanks

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
