From: hugo.ferreira@mail.telepac.pt
Subject: RE:  Opti 931: Med931 ver.2.0
Date: Fri, 9 Aug 2002 10:03:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020809090309.UVJU12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fep06-svc.mail.telepac.pt (fep06-svc.mail.telepac.pt [194.65.5.211])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA06474
	for <alsa-devel@alsa-project.org>; Fri, 9 Aug 2002 11:03:28 +0200
Received: from [127.0.0.1] by fep06-svc.mail.telepac.pt
          (InterMail vM.5.01.04.13 201-253-122-122-113-20020313) with SMTP
          id <20020809090309.UVJU12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
          for <alsa-devel@alsa-project.org>; Fri, 9 Aug 2002 10:03:09 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

>the patch was already in cvs.  but i'm not sure whether it was >already
>fixed on rc2.  please try the cvs version.
>you'll need to update alsa-lib, too, if you use the cvs drivers.

I downloaded the cvs version and attempted the =93cvscompile=94 in the
driver, libs, tools and utils. Unfortunately I could not compile the=20
lib because of an error. Seems to be occurring in the control/=20
control_shm.c file. I have attached the output for you to see.

I am sorry I took so long to answer but my disk was full and I had
to move some stuff around to be able to compile ok.

I would like to confirm the following though:
1. All I need to do is a =93cvscompile=94, the modules will be=20
automatically installed (no need to depmod =96a for example?).
2. I need not remove the rc2 compilation output (no =93make clean=94=20
necessary?)

TIA,
Hugo Ferreira.

FROM: Takashi Iwai
DATE: 08/07/2002 06:20:43
SUBJECT: RE:  [Alsa-devel] Opti 931: Med931 ver.2.0
=20
At Wed, 7 Aug 2002 13:52:19 +0100,
<EMAIL: PROTECTED> wrote:
>=20
> Hi,
>=20
>  1.	I am using kernel 2.4.8 (from Mandrake 8.1). In the ftp sight
> I came across kernel patches. My question is do I have to apply these
> patches? BTW, I only found patches for 2.4.7 and 2.4.9. Does this
> mean 2.4.8 is not supported/tested or its ok.=20

no, as long as you compile alsa-driver externally from alsa-driver
package, you don't have to apply a patch to the kernel.


>  2.	I also found in the patches section a patch for the Opti 931
> chip. It was submitted on the 2002-05-07 by Michael Corlett and
> assigned Jaroslav Kysela. Its status is still open. Does this mean
> it still has not been applied to cvs or is not included in rc2 of
> ver. 0.9.0? A simpleton=EF=BF=BD question: how is the =EF=BF=BDtatus=EF=
=BF=BDclassified?

the patch was already in cvs.  but i'm not sure whether it was already
fixed on rc2.  please try the cvs version.
you'll need to update alsa-lib, too, if you use the cvs drivers.


>  On a more general note, could someone out there that has the Opti
> 931 working give me a hand on this? Specifically I would like to
> know if the driver=EF=BF=BD pnp detection was on or if the isapnp tools
> where used. Please note that I have successfully bused the OSS
> drivers and am using the same settings with the ALSA drivers to no
> avail.=20

i could help for general fixes but such a hardware specific problem is
difficult to handle without the card in hands...

perhaps Massimo, the original author of opti9x drivers, can help
better.  (now cc'ed, too)


Takashi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Alsa-devel mailing list
<EMAIL: PROTECTED>
https://lists.sourceforge.net/lists/listinfo/alsa-devel






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
