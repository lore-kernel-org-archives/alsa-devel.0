From: Fabian Fagerholm <fabbe@paniq.net>
Subject: Re: Bug#410163: Debian Bug#410163: alsa-base:
	Recording with Intel	82801FB/FBM/FR/FW/FRW (ICH6 Family)
	needs additional module parameter
Date: Fri, 16 Feb 2007 16:12:50 +0200
Message-ID: <1171635170.4923.2.camel@localhost>
References: <20070208094834.3995.33509.reportbug@localhost>
	<20070216134434.GC3162@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1477279842=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070216134434.GC3162@aragorn.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Elimar Riesebieter <riesebie@lxtec.de>, 410163-quiet@bugs.debian.org
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1477279842==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3dgxJW/k3KcgnPG8ZstV"


--=-3dgxJW/k3KcgnPG8ZstV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-16 at 14:44 +0100, Elimar Riesebieter wrote:
> Hmm, snd-hda-intel is used by different sound cards. So I am not
> sure wether all these need that option? If yes, it would be
> hardcoded, though.

You're absolutely right, it's not needed for all chips. Hopefully, there
is some way to autodetect when it's needed and when not. Unfortunately,
I have no idea how to do that. I'd be happy to run any tests on my
machine that might be necessary to work it out, though.

Cheers,
--=20
Fabian Fagerholm <fabbe@paniq.net>

--=-3dgxJW/k3KcgnPG8ZstV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF1bvi76VUNpZBmeIRAn2CAJ0TM0t8sKDwVO+/uqaH6Kt4KS2zRACeI5/2
puCG/FWJB434Uh3YRW39U28=
=G4cT
-----END PGP SIGNATURE-----

--=-3dgxJW/k3KcgnPG8ZstV--



--===============1477279842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1477279842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1477279842==--
