From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 15:59:37 +0530
Message-ID: <20131129102937.GG8834@intel.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
 <20131129110549.GQ27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2809978114835988409=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B856C26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 12:27:05 +0100 (CET)
In-Reply-To: <20131129110549.GQ27568@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2809978114835988409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 11:05:49AM +0000, Mark Brown wrote:
> On Fri, Nov 29, 2013 at 10:48:29AM +0100, Takashi Iwai wrote:
> > Jaroslav Kysela wrote:
>=20
> > > I basically agree, but... I believe that these chunks can be divided =
to
> > > the 512 limit using continuous indexes (kcontrol->count) and a simple
> > > rule in the driver "write all to a DSP when the last control (index) =
is
> > > touched" may be enough. No API extensions are required. The question =
is:
> > > Do you rellay need 100+KB for coefficients? Do you expect to handle
> > > these data in standard tools like alsactl?
>=20
> It's certianly possible to do something like that while maintianing the
> ABI, however if we were going to do that we'd probably want to extend
> alsa-lib and tinyalsa to do this transparently and devise a naming
> scheme for the controls to trigger that behaviour.  The main thing is
> the API offered to users.
I think this would a bit problematic for DSPs with large controls. We are
looking at 3 digit number already and splitting to multiple calls is going =
to be
bad from a already constrained latency problem.

Most of the controls will be few KBs at most with few special cases which c=
an be
in MBs. I think Wolfson is also headed this way!

I am leading more towards adding new ioctl for this along with new ones for
enumerating controls. Then additional support for alsa-lib and tinyalsa.
That way existing tinymix, amxier can see these as controls while not distu=
rbing
existing apps. I dont think we need save and restor, then alsactl need not =
be
modified.

--
~Vinod

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSmGyQAAoJEHwUBw8lI4NHv68P/RbvYTQFkl1RW6yXYxOKNRZq
+VVSnL2W0t/Ogf6IpKs7jiUjQxw/pmyNgmx0I8e24KS+4IxSAD8UlFQtxhASfqPm
y/fXojocG6CT3zzMT/SMUc3FH0mT70aHf+asTE62QS8kOFnLxgwxHE5BxHAIfGN6
CitDS3qMo8j/5cLipK94D7WJQz5y5DwsxccCh/vybGPN6pEnDfhCepGKjDsyUgGK
TEy7MU6ZvJAs9ik+WlubZK/CPGxCQzUkZEExy7P65j8J2vxX4rXcsyan8o+lzmHD
5QOkYDlb/20ju8O8BEm/RQYAuEnC/jSrD2dXNbMuv3p3QzPbBaBczWh9WII9oiLk
S4Y7KwBuPsAnoG3JUN4D0WT85CV6Gf0NNF8AuWXItDlzFBy2JNzkdb/Y0YXTANX0
3q5GkP+Q+WSuObNvQKpesA+6Z/vrN3azRyIH8ZkvuIwrFNgz3NkK6ZNBEHVAH69d
cAJFXyvdkWxhN57KMNtZe2wak2oxHCRaU4j7t6OOHA5NjswdB6jI+87WShh3KUoJ
6TvOjvLGV4ANYw97f9kjtZIWynFs9zqO8WH9SOQWbmsupnVpVbluBlwP/e0VUjD/
2BsIMJeK0EE4GWwyOcBq10ndo8hdXF0W/mPWyqact/w2+lqzjAVyakrGxkhNdPa0
e51cMfWNR9EAK/pmivKo
=Eii6
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--

--===============2809978114835988409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2809978114835988409==--
