From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] sound/soc/davinci: remove sffsdr machine support
Date: Mon, 17 Jun 2013 10:05:24 +0100
Message-ID: <20130617090524.GW1403@sirena.org.uk>
References: <1371458791-7530-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0095586764=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371458791-7530-1-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============0095586764==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QmpK7ckl6/soFui9"
Content-Disposition: inline

--QmpK7ckl6/soFui9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2013 at 02:16:31PM +0530, Sekhar Nori wrote:
> sffsdr machine support does not build since at least v2.6.36
> (~3 years). There is little hope of it being fixed, so remove
> the support.

This doesn't actually apply against -next and I had to fix up the
subject line too but applied anyway, thanks.

--QmpK7ckl6/soFui9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvtFRAAoJELSic+t+oim91KsP/jqKCttV4QOlXXDXK7kdkoxE
vMXB61qdPuWdDXNJVa/ttxPBtR1qhXA59DQBQcwdmrzwB6hAn8hDIYF7TMfP7xB3
E0HKG227IUK+J2hT8YXrEAlTG0YtqFdV5X2Fz4R6e7kqY6y+C7dUY1bhIVfffZGq
UMzQSsRvC6gE6IPaRSO/SpwEF8lFdDUaAHZBqDEH/vTJCSQ/nPiLkEBwt9wF67Rw
/+lHW4un2HufPA5CM4TlGJWLKpwSdPUvyXekR+BBVt8oOaBJPRxFblBp687lSvwy
RwTSvOJimwtpnBpuDlU8SCk+WjY72THllCH0QABeyKAiaKIAOi+e6Zr4TnPS2kmj
EKRYv5epVhaKqAs1SEhUvOJQMWDEl3q8etG4NtmeL+OPaq1yYQJo2S7RscQRWZcg
Ub7LpVynM/1xKedsd/WdkaDm5GZ2hXpEO/zvyGJkV2ymmbPF6JESc/oBB4KASL3/
uKdPmjK5BMTwFzC0Ix5r+diNYczNU6LqcPjCkSkshQHpmEr6/HKzGNribNQp4VEu
wMJ3v1el/17Y+8mFZzXMv7/LTfXDIFhXx0Y/YzL38viy9RrsCng3B8YHdSe40TM+
IRVXmcXVEcEnpFmOgRw3HsSKgp3rOsrzDmAoR6srVG261kLzTZ4QJY6NQT18UCoW
aDJqJSXcEoUuZq4QmfIK
=9t7A
-----END PGP SIGNATURE-----

--QmpK7ckl6/soFui9--

--===============0095586764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0095586764==--
