From: hugo.ferreira@mail.telepac.pt
Subject: Re: Re: Opti 931: Med931 ver.2.0
Date: Mon, 12 Aug 2002 10:30:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020812093015.MHDE12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fep06-svc.mail.telepac.pt (fep06-svc.mail.telepac.pt [194.65.5.211])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA31929
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 11:30:22 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Massimo, anyone

Takashi, in response to this last e-mail I patially solved the problem. J=
ust to be in the safe side, I:
1. cleaned the rc2 installation.
2. downloaded the cvs version again (10-08-2002)
3. did a =93./cvscompile=94
4. did a =93make install=94

It all went fine. I then proceeded to insert =93snd_printk=94 statements =
in the code of the drive to see what was happening. The process is slow a=
nd somewhat stressfull 8-[ (Cyrix 200+ with 64Mega). I would  like to kno=
w:
1. How may I compile/make and install just the modules that I am interest=
ed in (--with-card ?)
2. Do  have to ./cvscompile all the time? I did try just using =93make=94=
 after the 1st config, but this did  not seem to work.
3. Do you have any pointers on debugging ALSA diver module? I am sorry bu=
t my experioence in this platform is somewhat lacking (make. autoconfig, =
etc.).
=20
Massimo,=20

I hope you are reading the list. I did as you indicated:
1. I compiled and installed the drivers, libs, tools and utils (from cvs)
2. I  did not create any /etc/isapnp.conf file, nor did I execute any =93=
pnpdump=94 or =93isapnp=94 commands
3. I then used a working /etc/modules.conf that used the OSS driver (mad =
16-pro)
4. Finaly I executed (repeatedly) a modprobe.

Small note: the O.S=92s messages (kernel 2.4.8) indicate that the isa car=
d was detected.

The error I get is always a =93chip still busy=94, which is written by th=
e snd_opti93x_busy_wait(..). With the aid of the =93snd_printk=94 I see t=
hat all parameters are passed correctly and that all the steps are execut=
ed until the call to snd_opti93x_probe() in the snd_opti93x_create() rout=
ine.  On furher investigation I found that snd_opti93x_busy_wait(..)'s =93=
inb=94 call always seems to return 0xFF from the (WssBase + 4) address. S=
o the card is considered not initialized. Naturally the test for =93&& 0x=
80" always fails.

Ok, I have some questions you most probably can answer:

1. Because I am compiling via cvs, the isa-pnp is set to true, and becaus=
e the parameters are set and isa_pnp option is set to 1 by default, then =
no pnp scan is made for available resources. Is this the way you set up a=
nd tested the cards? I would like to replicate you test-bed.

2. Once probing has been sucessfully done, I take it that only then you c=
onfigure the card, or am I wrong? Do we need to configure the card so tha=
t it sucessfully terminates initialization?

3. If I read correctly,  on dma channel is 16 and the other an 8 bit chan=
nel. In this case, is dma1 the 8 bit channel and dma2 the 16 bit channel?=
 I would like to set this as per OSS.

4. On one of your answers to the list you stated that you had one card wo=
rking and another not. I would like to confirm that the card that is not =
working is the MED931 ver 2.0?=20

5. How should the /proc/isapnp show up? Does it only have to have the cor=
rect settings after the driver is load?

6. When I used the OSS drivers, dma1=3Ddma2=3D0. When I try this out with=
 the driver, this is not allowed. Furthermore, you do not allow dma2=3D2 =
or 3 also. Is this correct?

Ok, this is a long e-mail, but pleae bear with me. After a trying weekend=
, I finally decided to look at the mad16.c source code. Low and behold, t=
he detection code (which is executed when probing the card), makes provis=
ion for:
1.  testing for the 0x80 status (as per alsa driver)
2.  if this is not sucessfull, tries a software reset. [line 238]
3. if this does not work, powers the card off and on again. [line 245]
4. finally, if nothing else works, the pnp mode is turned off. [line 257]=
. (Potential PnP Bios problem is indicated in this case.)

Ok, it would be interresting to know what this driver actually does on my=
 box. To be honest, I don=92t really want to check this because it would =
mean configuring the kernel and activating the OSS drivers again. For any=
one out there that thinks I am being lazy... it takes nearly a day to com=
pile and install a new kernel. 8-[

Massimo, what do you think of the above strategy? Worth a try?

To anyone/everyone else,

I would like to collect some statistics. I would like to know:
1. Who has a Opti based ISA card working with Alsa (MED 931 from ExpertCo=
lor)
2. I would like to know what chip is used (92c931)
3. I would like to know what revision  of the PCB/card is being used (ex.=
 version 2.0)
4. I would like to know what set-up or configuration is being done (isapn=
ptools or Alsa=92s ISA support)
5. What OS is being used (kernel version 2.4.x)
6. Is Pnp is is supported by BIOS
7. Is Pnp is supported by the OS

Hmm, I think this is it. If you have read until this point, thank you for=
 attention. I hope our efforts will solve this small dilemma  because I k=
now I am not the only one.

Regards,.
Hugo Ferreira.

>=20
> De: Takashi Iwai <tiwai@suse.de>
> Data: 09/08/2002 11:29:52
> Para: hugo.ferreira@mail.telepac.pt
> CC: <alsa-devel@alsa-project.org>
> Assunto: Re: [Alsa-devel] Opti 931: Med931 ver.2.0
>=20
> At Fri, 9 Aug 2002 10:03:09 +0100,
> hugo.ferreira@mail.telepac.pt wrote:
> >=20
> > Takashi,
> >=20
> > >the patch was already in cvs.  but i'm not sure whether it was >alre=
ady
> > >fixed on rc2.  please try the cvs version.
> > >you'll need to update alsa-lib, too, if you use the cvs drivers.
> >=20
> > I downloaded the cvs version and attempted the ?vscompile?in the
> > driver, libs, tools and utils. Unfortunately I could not compile the=20
> > lib because of an error. Seems to be occurring in the control/=20
> > control_shm.c file. I have attached the output for you to see.
> =20
> hmm, not found.  did you forget to attach it actually?
>=20
> anyway, to track down the bug, we need the precise information about
> your environment - which distribution, glibc, and kernel version,
> etc.
>=20
> > I am sorry I took so long to answer but my disk was full and I had
> > to move some stuff around to be able to compile ok.
> =20
> perhaps that was the reason -- disk full.
>=20
> > I would like to confirm the following though:
> > 1. All I need to do is a ?vscompile? the modules will be=20
> > automatically installed (no need to depmod ? for example?).
>=20
> no.  cvscompile does only compile.
> after that, you need to install the drivers by running "make install"
> as root.
>=20
> > 2. I need not remove the rc2 compilation output (no ?ake clean?
> > necessary?)
>=20
> no.  the very latest makefile on alsa-driver will remove all old
> modules before installation.
>=20
>=20
> ciao,
>=20
> Takashi
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
