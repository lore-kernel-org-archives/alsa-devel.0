From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 resend] ASoC: cs4271: switch to
	mute_stream
Date: Fri, 22 Mar 2013 11:13:25 +0100
Message-ID: <20130322101325.GB22890@opensource.wolfsonmicro.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0800302945637241787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DD0326515C
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:13:27 +0100 (CET)
In-Reply-To: <1363895035-20356-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0800302945637241787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 08:43:54PM +0100, Daniel Mack wrote:
> Use the newly introduced mute_stream DAI operation, and don't mute the
> codec if it's called for the _CAPTURE stream.

Applied, thanks.

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTC6+AAoJELSic+t+oim9QzoP/i8BjHGZz0cqaaHtT3UjHCLH
BDxBBdEQokm6K9/LoeRXWRAgYhD1EkMkjDhaBcaUoGB+P++0VeCQnp/fb2u2z/EL
njyxqLq/w8OOwFlJSgnP4fb/FZ6OQ0qb7JhD3mVFYLoitRR1tvsl+SqCw24RdT96
ACAgehafdmpMBEJ9OUYWzWsIpcdhBl8kyBChdeZDct5mJcJplBywt0uGo6mWmgCJ
NkaN/0RimdrNAyRrsF3glVga+mdlCWi1VQt+cWg9nZ1AoO0wczdxb1YrkASjSUMI
VdXMGeanSKuAZQdJkJBU1OIUtXLTqTo2xLEZU/V204lrmoeF9/Qc9fXPR8piZFyu
7FNYo6AgcXSIEEoPFg7gtNtR6vtAn5sdQCG/o8zL0vWHC0/Td8+YUmfXjnhVGx4P
E4VsBdofVDiMX2Tb98LwrwxDvJ68lKdUNMQTgEsXblPwo522fiOp9eEKVlcFn+HP
XyWZ59gU6NfqJTyKZxafUfNQx2e0Xj3N9xjeCx7zkcK0rrYFdcekBA8gfhyGenzw
Trxwoa9PBiFzI8p2zmXA1XE5i5kzwyB6CY7A0woOWLA6nROcT46Cz6k/NCJuUh8a
Q9SCwjAlCiugoLzTI6enBY81uOQwtGXQQTrTrd1+dY40/35C3Ff5olJUU2KraJzz
8ZXgXJc3inYckxbtGgfH
=gXkp
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

--===============0800302945637241787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0800302945637241787==--
