From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Fri, 26 Feb 2010 15:05:54 +0100
Message-ID: <1267193154.29204.0.camel@localhost.localdomain>
References: <hm5aba$p65$1@dough.gmane.org>
	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>
	<hm5u2i$2h7$1@dough.gmane.org>
	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>
	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>
	<hm8cus$56i$1@dough.gmane.org>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6427658045217265536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp02.jazztel.es (smtp02.jazztel.es [62.14.3.171])
	by alsa0.perex.cz (Postfix) with ESMTP id DACFC1037F8
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:06:04 +0100 (CET)
In-Reply-To: <hm8cus$56i$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6427658045217265536==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QQHuSRQ1+nmPd+uU3hi/"


--=-QQHuSRQ1+nmPd+uU3hi/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 26-02-2010 a las 13:57 +0200, Angel Tsankov escribi=C3=B3:
> Raymond Yau wrote:
> > 2010/2/25 Jaroslav Kysela <perex@perex.cz>
> >=20
> >> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> >>
> >>> Jaroslav Kysela wrote:
> >>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> >>>>
> >>>>> Hello,
> >>>>>
> >>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a built-=
in
> >>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (r=
ev
> >>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
> >>>>> Controller] (rev 03) -- and get the following message:
> >>>>>
> >>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84" "AC97a:838476=
00"
> >>>>> "0x1073" "0x000d"
> >>>>> Hardware is initialized using a guess method
> >>>>>
> >>>>> As a consequence the volume levels of the Yamaha card do not get
> >>>>> restored to the levels stored in /etc/asound.state.  The volume lev=
els
> >>>>> of the built-in card however are properly restored.  The asound.sta=
te
> >>>>> file has been created by executing 'alsactl store'.
> >>>>>
> >>>>> The kernel has been built with support for ALSA.  I've built and
> >>>>> installed the kernel modules for both cards (not the ones in the
> >>>>> alsa-driver package but those that come with kernel version 2.6.30.=
2).
> >>>>> Any ideas why alsactl cannot find the hardware it has previously
> >>>>> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?
> >>>> The logic of alsactl is to restore the state from /etc/asound.state =
if
> >> it
> >>>> is valid. It seems like the set_controls() function in alsactl/state=
.c
> >>>> returns an error code for a reason.
> >>>>
> >>>> Could you try to compile the latest alsa-utils snapshot
> >>>> (http://www.alsa-project.org/snapshot/) and run './alsactl -d restor=
e'
> >> in
> >>>> alsa-utils/alsactl directory? A warning (fail reason) should be prin=
ted.
> >>> I've attached a bash shell script that I used to download, configure,
> >>> compile, and run alsactl.  I've also attached a .log file with stdout=
 and
> >>> stderr that I got while executing the script.
> >> Thanks. I've added more debug print lines to state.c. Could you rerun =
your
> >> script and append also '/etc/asound.state' file and output from
> >> 'alsa-info.sh --no-upload' to your output tarballs? Send me this tarba=
ll
> >> privately or just an URL to this list.


Looks similar to my problem:
http://www.spinics.net/lists/alsa-devel/msg31422.html


--=-QQHuSRQ1+nmPd+uU3hi/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuH1UIACgkQCaWpQKGI+9QI1gCfbJ94iWO7LLPmbQMZZdR6Ckvj
heUAn30MewehVny3dW1c7ngEyptUeGaa
=+oSD
-----END PGP SIGNATURE-----

--=-QQHuSRQ1+nmPd+uU3hi/--


--===============6427658045217265536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6427658045217265536==--
