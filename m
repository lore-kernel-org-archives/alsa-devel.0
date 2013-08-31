From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] Remove ASoC-level I/O functions from cq93vc
Date: Sat, 31 Aug 2013 14:07:41 +0100
Message-ID: <20130831130741.GG18608@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067629129=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--===============2067629129==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline

--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series removes the use of the ASoC-level read and write
functions from the cq93vc driver as part of a wider push to remove them
completely and just use regmap for all register I/O.  Since the driver
is essentially doing what regmap-mmio is doing this is done by adding a
MMIO regmap to the core device and using that.  This is compile tested
only, I don't have any hardware to run on.

Since I anticipate doing more cleanups over the CODEC drivers during the
next release cycle it'd be good to merge via ASoC, though there
shouldn't be any overlap with the first patch.

Mark Brown (5):
      mfd: davinci_voicecodec: Remove unused read and write functions
      mfd: davinci_voicecodec: Provide a regmap for register I/O
      ASoC: cq93vc: Use core I/O functions
      ASoC: cq93vc: Don't use control data for core driver data
      ASoC: cq93vc: Use regmap for I/O

 drivers/mfd/davinci_voicecodec.c       | 23 +++++++++++--------
 include/linux/mfd/davinci_voicecodec.h |  3 +++
 sound/soc/codecs/cq93vc.c              | 42 +++++++++++-----------------------
 3 files changed, 29 insertions(+), 39 deletions(-)


--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIeqaAAoJELSic+t+oim9g0kQAJqC4LjvgDuA0CCBWMDiu1t1
9mMl8fTqQmk+IWRTkKMgkEWz4+k5LIaCDp9y4ITS65J7YbaHZrOQJmrnRtXJUL3f
qQPPstoIcnn88cyEXI3ssw65lY6A3G4+fG7b2lDqGfkqsUwpzkGaPm69w6TXyFsj
+b5ZWqAQgSbpVHrtwL9VCYepHsCIWUEd/OaAvDl2a0ygfj3A1NPiYl8Clpe8fEKy
0nhBVkYZwqqPGRY4yWaNh2t/8EWhy9ZmLxOsx+/I2jRrKp64LxeTu+Sr3ZBQxcJj
/DW2P25EoUTFhlXSTQbgFjuzQovZTAFB3VoVOvs43vJGML5oq1jZJ7YO75aRKien
azvGo4IjXpiStmiGHw+e2/aQ+AD9mz0txyoFHQJfLKpQT0YdVk+d1dBxFwl53wZw
Cbx8pe1OQRjqT0ZrLuwRADqMWw9r3vZ44DEPHe6CdwsD+gS50b1MGbeMTMtkV1Y2
FlTC1EsnSTEq+uIjUNF8d7eU+BgQNLywcyPJC+CKaYntKDnEDC08eYR+tNReDqQL
k+OQE4bZeiyrL+bLXiNOH/VfyE05AvwBF3qzkzvUuSnY+a/VgC6tRUSTda03DQjx
Gc7jkAHSdjOjGUOdz1GpEA6UaGere0sJUhyPMf5Q2We1C7iYDqmUpuOi4e7eg1Q0
K2tW0WHuxedUy6a8aFks
=Bh88
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--

--===============2067629129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2067629129==--
