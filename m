From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] HP nx6110 quirks
Date: Sat, 20 Aug 2005 23:34:31 +0400
Message-ID: <20050820193431.GB12485@procyon.home>
References: <20050820181730.GA12485@procyon.home> <1124563311.26949.23.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1124563311.26949.23.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 20, 2005 at 02:41:51PM -0400, Lee Revell wrote:
> On Sat, 2005-08-20 at 22:17 +0400, Sergey Vlasov wrote:
> >=20
> > Also ac97_quirk=3Dhp_only is needed to make a single Master volume in
> > the mixer instead of separate volumes for internal speakers and
> > headphones, which just confuses the user.=20
>=20
> The ALSA driver is supposed to expose all the hardware functionality.
> It's up to the mixer apps to present it to the user in a sane way.  So
> if the hardware supports separate volume controls for the headphones and
> internal speakers we should not disable this functionality.  Why not
> make three controls, Master, External Speakers and Headphones?

Then we will need to create virtual controls - the chip has only two
volume control registers for this, so we will need to make three
virtual controls for volumes, then combine values and write them to
the chip.  And this will need to be done inside the driver (otherwise
where the values of virtual controls will be stored while no ALSA
programs are running?).  Would this be acceptable?

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDB4XHW82GfkQfsqIRAhAFAJwJdGJpnE+xQBoI0X+IwBciVRPBdwCfRPtB
RGw9ix+2j9cCvuqFOqlZRxs=
=/vMZ
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
