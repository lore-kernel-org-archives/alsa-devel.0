From: Martin Soto <soto@informatik.uni-kl.de>
Subject: Re: Re: [Alsa-user] Re: Broken emu10k/SB Live driver?
Date: 11 Oct 2002 10:34:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034325263.474.37.camel@diesel>
References: <200210110751.g9B7pcKa017014@mailgate2.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-z+oU9WsU56FVpsvPbQ8u"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210110751.g9B7pcKa017014@mailgate2.uni-kl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: torben hohn <torbenh@gmx.de>
Cc: alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-z+oU9WsU56FVpsvPbQ8u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all:

On Fri, 2002-10-11 at 11:53, torben hohn wrote:
> > 
> > > Does emu10k1 work at a user settable sample rate? 44100 Hz? 32000Hz?

I answer to the original poster first.  The Emu10k1 is *locked* at a
48Khz rate.  All sources and outputs will be converted to and from this
rate for processing.  This was a very discussed and criticized design
decision, but the EMU/Creative people argue it makes thinks easier (and
certainly cheaper as well).

> > > MS Windows driver has a good sounding reverb. Could this reverb dsp
> > > code be extracted from the MS Windows driver and used "as is" in Alsa?
> > 
> > It's not so easy and I'm sure that we'll violate some patent doing things 
> > in this way.

A doubt it'd violate a patent, but it will violate the copyright of the
code, for sure.

> There is a reverb in the oss driver from http://opensource.creative.com
> it comes as source (i gues it is the same as the windows reverb)

It could be the same microcode.  Is it GPL'd?

> so if we provide a method for the user to load patches into the dsp we
> are fine.
> i will query Martin Soto on his status.

Now, regarding my status:  I have a little example C program, that
installs a new microcode (not really a patch but the whole microcode
program) to the card.  It is not able to load standard patches, so you
have to put the microcode directly inside the program.  I shamelessly
stole some of the macros in emufx.c to be able to do that, but it works
well ;-)

The program deletes all of the mixer controls associated to the standard
Alsa microcode, and puts in new controls if that's necessary.  
It'd be really nice to have a decent interactive front end to this
feature, because it would allow to reconfigure the mixer to offer just
those controls that the user needs.  That would make SBLive! cards much
more usable under Linux.

> (hi martin can you send me your patchloader code ?)

Unfortunately, I have the code at home, so I'll only be able to post to
the list today evening (GMT+2).  I wanted to improve it a bit, but have
been really busy at work lately, and haven't found any time to do it. 
I'll post what I already have, and keep working on it as time permits.

I'm however attaching a small patch to emufx.c that fixes a bug in the
implementation of the CODE_PEEK ioctl.  It must be applied to alsa in
order for my userland program to work.

Cheers,

M. S.
-----------------------------------------------------------------
Martin Soto

AG Software Engineering
Universitaet Kaiserslautern              Tel:  +49 (631) 205-3449
Kaiserslautern, Germany         E-mail: soto@informatik.uni-kl.de
-----------------------------------------------------------------

--=-z+oU9WsU56FVpsvPbQ8u
Content-Description: 
Content-Disposition: attachment; filename=emufx.c-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Index: emufx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.20
diff -u -r1.20 emufx.c
--- emufx.c	17 Sep 2002 13:44:38 -0000	1.20
+++ emufx.c	17 Sep 2002 23:43:26 -0000
@@ -2174,6 +2174,10 @@
 		icode =3D (emu10k1_fx8010_code_t *)snd_kcalloc(sizeof(*icode), GFP_KERNE=
L);
 		if (icode =3D=3D NULL)
 			return -ENOMEM;
+		if (copy_from_user(icode, (void *)arg, sizeof(*icode))) {
+			kfree(icode);
+			return -EFAULT;
+		}
 		res =3D snd_emu10k1_icode_peek(emu, icode);
 		if (res =3D=3D 0 && copy_to_user((void *)arg, icode, sizeof(*icode))) {
 			kfree(icode);

--=-z+oU9WsU56FVpsvPbQ8u--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
