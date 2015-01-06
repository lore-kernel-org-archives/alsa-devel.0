From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add NULL checks for the
	stream pointer
Date: Tue, 6 Jan 2015 17:22:23 +0000
Message-ID: <20150106172223.GE2634@sirena.org.uk>
References: <1420556647-17270-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7050087560939745117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 450DC26047C
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 18:22:32 +0100 (CET)
In-Reply-To: <1420556647-17270-1-git-send-email-yang.jie@intel.com>
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


--===============7050087560939745117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjJPTMFqUKxQUast"
Content-Disposition: inline


--PjJPTMFqUKxQUast
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 11:04:07PM +0800, Jie Yang wrote:

> We should not send IPC stream commands to FW when the stream is
> NULL, dereference the NULL pointer may also occur without precheck.
> Here add NULL pointer checks for these stream APIs.

> @@ -1420,6 +1423,9 @@ int sst_hsw_stream_commit(struct sst_hsw *hsw, stru=
ct sst_hsw_stream *stream)
>  	u32 header;
>  	int ret;
> =20
> +	if (stream->commited)
> +		return 0;
> +
>  	trace_ipc_request("stream alloc", stream->host_id);
> =20
>  	header =3D IPC_GLB_TYPE(IPC_GLB_ALLOCATE_STREAM);

This is a bit worrying, it means that we will silently ignore any
attempts to pass in a NULL stream.  Sometimes that's an OK thing to do
(like in deallocation paths) but this seems to more generally silently
ignore errors which means we're less likely to spot other coding issues.
Race conditions worry me especially - trying to use something before
we've quite allocated it for example.

I'd be much happier if this warned in cases where it wasn't totally
obvious that attempting to use a NULL pointer is sensible.

--PjJPTMFqUKxQUast
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrBnOAAoJECTWi3JdVIfQz3oH/jZUZ8FI9gPbnG/yKe2xkzIv
gSquJr0bOHug8ZjJfrh7jnncU0AWXzumw620+Uqe3KwRGm90JBi5suc/D1A3WDTa
UWlGAuAQdvYtbs7vsXw7E1cr3qLF3kcttcnsEmAnMBd453oCLa+6u/RV+gK7Ch+i
RrhvT+okf7WJy8eGOhJv8FsCuLetjeYQsO/FvWaiwibrnWvLmcBiTzru4KcYDnF1
lOEMzfcA8KNxD+IpRJiU1aGVEhRM0kh1n/7cjvWeaIweax6cXYzta424MlaiDiM7
Wuea/7DT8bva9CUeJKG7tte3pIyG96LxdFBuERXONdUo0bmwAd48dDh3Eep0SAc=
=6TyG
-----END PGP SIGNATURE-----

--PjJPTMFqUKxQUast--

--===============7050087560939745117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7050087560939745117==--
