From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: initial stream_hw_id to
	invalid value
Date: Wed, 14 Jan 2015 20:24:13 +0000
Message-ID: <20150114202413.GO3043@sirena.org.uk>
References: <1421054254-25716-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6518457041900492091=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 683BD26052A
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 21:24:23 +0100 (CET)
In-Reply-To: <1421054254-25716-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6518457041900492091==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aTCJOP0qgkSGqHWA"
Content-Disposition: inline


--aTCJOP0qgkSGqHWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2015 at 05:17:34PM +0800, Jie Yang wrote:
> The stream_hw_id for System stream is 0x0, if we use initial stream_hw_id
> value 0, it may return wrong(not committed) stream when calling function
> get_stream_by_id() with stream_id=0. Here initial stream_hw_id to invalid
> value to fix this issue.

Applied, thanks.

--aTCJOP0qgkSGqHWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUttBsAAoJECTWi3JdVIfQPYcH/22OIKtfy8ijlxKcrHT0bjvQ
u9xQVkCxv0iltG27evrKctsyZ6VQs8vB8nlolzeiCH4hoQZm61JzOvVPb8G9Ksr2
bTw4RooOtCJdBAcngpDrPvnMtM/m9LXPe1cySoc8UQf1wQIQ6JEnAxc/1LDIgyV0
6NJszEcowb7GYdQXPbg3oBf/Ws1DfM8Qetuqbc0tzbtlgmGsxOWVSzj1c5eMJIZl
A3lLjvDZl7CyCTULVWEI9idA0BLM68PjlWyP+zUNquTZxraHf0a/TizhjSQHpLbr
p2syklrxDxUVEe0sMS6lLiiDh9ulqROfKT4RUnuLAEKMhwDhRoZgkcQ1SAi7X5M=
=MWl1
-----END PGP SIGNATURE-----

--aTCJOP0qgkSGqHWA--

--===============6518457041900492091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6518457041900492091==--
