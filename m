From: Alexander Samad <alex@samad.com.au>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Thu, 20 Jan 2005 08:25:45 +1100
Message-ID: <20050119212545.GU27550@samad.com.au>
References: <1106091073.24484.60.camel@krustophenia.net> <20050119195154.GR27550@samad.com.au> <1106169110.3050.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WQ40utMgiyDduspJ"
Return-path: <alsa-user-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1106169110.3050.9.camel@krustophenia.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--WQ40utMgiyDduspJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Believe i did, I used a stock debian kernel source for 2.6.9 and then
retrieved the debian alsa-source package=20

ii  alsa-base      1.0.7-2        ALSA driver configuration files
ii  alsa-source    1.0.8-1        ALSA driver sources
ii  alsa-utils     1.0.7-2        ALSA utilities


I then ran patch -p1 < your patch

(I just checked and guess what --dry-run ......)

How annoying

Sorry, will try again and see what happens!

Thanks



On Wed, Jan 19, 2005 at 04:11:49PM -0500, Lee Revell wrote:
> On Thu, 2005-01-20 at 06:51 +1100, Alexander Samad wrote:
> > Hi
> >=20
> > Interested in this, been trying to get multi channel output from audigy2
> > card
> >=20
>=20
> What ALSA version do you have?  Are you sure you applied the patch
> correctly?
>=20
> Lee
>=20
>=20

--WQ40utMgiyDduspJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB7tBZkZz88chpJ2MRAhLQAJ9N6ACW3VtN9B3/No0D8ZzlP3ZuwwCeMF2l
tnviWd2ZFZ1HJOgkqatZD9I=
=LSYb
-----END PGP SIGNATURE-----

--WQ40utMgiyDduspJ--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
