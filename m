From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Thu, 16 May 2013 18:35:59 +0100
Message-ID: <20130516173559.GD1627@sirena.org.uk>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
 <5194AC3C.4080206@metafoo.de>
 <CAGsJ_4yoXj+e7A20SM5+ctLvE2QRTp0bzDeKfCZSUHTO8BPq5A@mail.gmail.com>
 <5194C2FC.70804@metafoo.de>
 <CAGsJ_4yn2uodRKrFKYrX85XA7A=hQs2w0cyGoEEHsYgCJHD7eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6273244161827852584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 83BD4261A5E
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 19:36:14 +0200 (CEST)
In-Reply-To: <CAGsJ_4yn2uodRKrFKYrX85XA7A=hQs2w0cyGoEEHsYgCJHD7eQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6273244161827852584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2013 at 08:00:17PM +0800, Barry Song wrote:

> i did think it is a good idea to have device id list while i sent the
> last mail. and it matches with the generic device driver engineering
> sense. the problem is i don't how long the list will be.
> if you like to keep dfbmcs320 at least for the moment, i would agree.

I'd prefer to see the ID list; we shouldn't be throwing away
information.  Probably we can go a long way towards cutting down the
length of the list if it gets silly with use of wildcards in the device
names listed.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlRj8AAoJELSic+t+oim9U6sQAJowLjnHtOsjMPWg44tZU5D0
FyvXp5tVUYbq2E9/cJ4iqxmZGvfgWDzTHPZ31w8L3F9yhCtGFJD0lyktFXo0oaMZ
XMr6+S3UC9wanMDSHQsEocVSIrX4cWKXIdFpn0hFUJznSOp59b0L0PWR4HfMvTdC
UFp+XHbIa3qQg4gZuijN+rACVTeJkKjs0ek2BXlIPG1PCp1ckkDfAuqJj2HOTxcX
XC6i7JTdk6P6n8nlSQ/P0N/z4tCUoVP7n36Qd6Tp2fEp1R+jlV4YtxCioFQ1K8R2
X/IC+uAJHcmgNbwbJMcuOqCycQoIEU+eYgEwaibZIZVMf3jvInuaBTMuKdYFrZY2
KJAdhC//rTwEMLRGzAloN5qSYKd9KZ5tPnN2j7XrFSALOk9Q7EaRUm7gzXbG2s41
s3id14hO2/aZNlx7lek3M16NOm8wp/Q5yIJH+GBjFdyp6tCpHs1odPZq8boPU1Om
iSbkIrbxO+ksV2Az3+/IsYMc1HwAeXJrbSnlMl1RrCgvkdW6InkEclx4lpi/pl4b
IqIR6RiwHuNvANvQ4OLQOlqhzKkLnu3LLxIS1kECIn+GZyb8hE0wSnWUybeChfuN
YmhWgjfivV5u4PTnhFbmVItBeweE1WoB8jgcAP33CWb0TXix30IzVkHlKYH5dlIv
ouxj2hYWpPeSnth46HeS
=lyr7
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

--===============6273244161827852584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6273244161827852584==--
