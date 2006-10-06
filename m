From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: 2.6.19-rc1: hda_intel: azx_get_response timeout,
	switching to polling mode...
Date: Fri, 6 Oct 2006 13:26:06 +0200
Message-ID: <200610061326.07161.prakash__46735.7220165015$1160134118$gmane$org@punnoor.de>
References: <200610050954.57677.prakash@punnoor.de>
	<200610052311.35446.prakash@punnoor.de>
	<s5hejtlu2wv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0737242192=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F26A912E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 13:26:14 +0200 (MEST)
In-Reply-To: <s5hejtlu2wv.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============0737242192==
Content-Type: multipart/signed; boundary="nextPart2232465.9et51qUiE3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2232465.9et51qUiE3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag 06 Oktober 2006 12:58 schrieb Takashi Iwai:
> At Thu, 5 Oct 2006 23:11:35 +0200,
>
> Prakash Punnoor wrote:
> > Am Donnerstag 05 Oktober 2006 12:18 schrieb Takashi Iwai:
> > > At Thu, 5 Oct 2006 09:54:57 +0200,
> > >
> > > Prakash Punnoor wrote:
> > > > I didn't get above message with 2.6.18. Usign irqpoll above message
> > > > doesn't appear, but I think neither it optimal.
> > >
> > > The latest snd-hda-intel driver uses MSI as default.
> > > Pass disable_msi=3D1 module option and see whether it works.
> >
> > Yes, no more message, but what is even better: My nforce nic works again
> > (w/o using irqpoll)! So the alsa driver broke it. Now both are using sa=
me
> > irq and peaceful again.
>
> It's more likely a problem of IRQ routing than the driver itself...

Well, whom should I contact then?
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2232465.9et51qUiE3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJj1PxU2n/+9+t5gRAtz9AKCxBb5p35OP8Bq70cpbfvfStZdmTQCgwK3I
6nkjJMRyLu10S5VW9NvHthk=
=ve8/
-----END PGP SIGNATURE-----

--nextPart2232465.9et51qUiE3--


--===============0737242192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0737242192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0737242192==--
