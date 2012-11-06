From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Remove boot_done variable as
 no longer required.
Date: Tue, 6 Nov 2012 09:19:56 +0100
Message-ID: <20121106081955.GD3283@opensource.wolfsonmicro.com>
References: <1352126665-6708-1-git-send-email-scott.ling@wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0394791145914836539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD7AC2616C9
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 09:19:58 +0100 (CET)
In-Reply-To: <1352126665-6708-1-git-send-email-scott.ling@wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Ling <scott.ling@wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============0394791145914836539==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2012 at 02:44:25PM +0000, Scott Ling wrote:
> Remove the boot_done counter variable and check the wm0010 state
> variable instead.

Applied, thanks.

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmMgaAAoJELSic+t+oim9Nm4P/iKbUtuouxY2iNPmpfRksGIg
YdM9lfvq0Fqx8juHKrULH0x07TLxpSvoln675Z6xW0SFZ+Zn3rjJJyutLKN+e3pF
3hWm6JZfDFZFGQac1u0fSvjA57Pw9QBKpMMujMTGhYG6MF9arFt9iwy9pphJh9kE
XfU+H18VFUC9k32nPfTNHEM87EaFtYjuWYOiGvTx0GoTTM88uMmOwAcQ1ZEHGt7i
wnvFVak6pvPnzn5T0i9uqoJvlMRw0I0irkoKnuuEKVXcl5TW39qa82axVUe4DyQT
pVF6wjHBP4YpnG0GbA+XJACKygTH2vAHRacy6csrcvOpdhcUpWU43My+LG0uoGy7
DkBdZgUKi6ZfYAii6HCI5oe7ukvdpGf1+dbD9HbbC4aSREfgpTz+WXB46p1vc8w+
wsP2lvGaL9ztthvxmV5XPsbBKsHrE0gVY5qm07gBxtMUlYVuXTbvJccWMW+K7MTr
bgMIFen3//rS0swL/5rrLEz0o0B7U+K4EO+0Aw/P7ULskzJispoCSbO8xNFhIhtv
oHazavHOqtYaPmTkgslmnJcDv0XRHGOI9uDQgsri5s3Se6ARpwD5Idx5yYx3ueNk
aR7olciQay5E/tbKwURjXMMaTyjkZXXPvF7hyCYtvqmDn4afapwFVHpb8X/SDvxU
WMcEGsEsTIhDDHpJUGF5
=oM/f
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--

--===============0394791145914836539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0394791145914836539==--
