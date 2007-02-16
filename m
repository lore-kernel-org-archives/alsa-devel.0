From: Fabian Fagerholm <fabbe@paniq.net>
Subject: Re: Bug#410163: Debian
	Bug#410163:	alsa-base:	Recording with
	Intel	82801FB/FBM/FR/FW/FRW (ICH6 Family)	needs	additional
	module parameter
Date: Fri, 16 Feb 2007 22:49:08 +0200
Message-ID: <1171658948.4923.114.camel@localhost>
References: <20070208094834.3995.33509.reportbug@localhost>
	<20070216134434.GC3162@aragorn.home.lxtec.de>
	<1171635170.4923.2.camel@localhost>  <s5hd54a85qy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2030421336=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd54a85qy.wl%tiwai@suse.de>
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
Cc: 410163-quiet@bugs.debian.org, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============2030421336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LQ27HCGVj5YCzV4umOli"


--=-LQ27HCGVj5YCzV4umOli
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-16 at 16:46 +0100, Takashi Iwai wrote:
> If needed, it's a bug.  The model option is just a workaround.
>=20
> Whether a certain device is supported or not purely depends on the
> driver version.  So, without proper information which version is being
> used, the report makes little sense...

I think I included the version information in the original report (in
the Debian BTS). Just in case:

alsa-base 1.0.13-3
the kernel is 2.6.18-3-686

Do you need anything else?

Cheers,
--=20
Fabian Fagerholm <fabbe@paniq.net>

--=-LQ27HCGVj5YCzV4umOli
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF1hjE76VUNpZBmeIRAgiHAJ9TnKOgVyZiDpd1rvsPz5EthyxPBACfXozz
5u/AoghoiHex5npJqkj8Vj0=
=tLZe
-----END PGP SIGNATURE-----

--=-LQ27HCGVj5YCzV4umOli--



--===============2030421336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2030421336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2030421336==--
