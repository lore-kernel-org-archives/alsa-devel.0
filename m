From: Nicolas George <george@nsup.org>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 3 Jul 2015 15:06:58 +0200
Message-ID: <20150703130658.GA1689228@phare.normalesup.org>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5044007695920128736=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nef2.ens.fr (nef2.ens.fr [129.199.96.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AE0F264F39
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 15:07:00 +0200 (CEST)
In-Reply-To: <20150703143608.7afb34c985d82982e929484e@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Tyler Yeomans <tyeo098@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5044007695920128736==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline


--lEGEL1/lMxI0MVQ2
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le quintidi 15 messidor, an CCXXIII, Antonio Ospite a =E9crit=A0:
> "Koul, Vinod" <vinod.koul@intel.com> wrote:
> > This is dpcm enabled driver
> > So please route the FE to BE and it should work...

> Nicolas, this can be done by using the commands from here:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080.html
>=20
> In particular:
> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> amixer -c0 sset 'media0_out mix 0 media1_in' on

Thanks for the explanations, that saved me a lot of time.

It changed the result a bit. Now, aplay fails, but it takes one or two
seconds before starting ("Playing raw data...") and again one or two seconds
before failing ("Unable to install hw params:..."). In the meantime, the
kernel printed this:

[ 1059.391088] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, ms=
g_id:0x1 fw_state 0x3
[ 1059.391114] intel_sst_acpi 80860F28:00: fw returned err -16
[ 1059.391147] sst-mfld-platform sst-mfld-platform: Enter: enable=3D1 port_=
name=3Dssp2-port
[ 1060.393182] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, ms=
g_id:0x1 fw_state 0x3
[ 1060.393208] intel_sst_acpi 80860F28:00: fw returned err -16
[ 1060.395179] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[ 1061.394976] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, ms=
g_id:0x1 fw_state 0x3
[ 1061.395006] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[ 1061.395023] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[ 1061.395040] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI prepare e=
rror: -5
[ 1061.395056]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port f=
ailed
[ 1061.397441] sst-mfld-platform sst-mfld-platform: Enter: enable=3D0 port_=
name=3Dssp2-port
[ 1062.396808] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, ms=
g_id:0x1 fw_state 0x3
[ 1062.396834] intel_sst_acpi 80860F28:00: fw returned err -16
[ 1063.398598] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, ms=
g_id:0x1 fw_state 0x3
[ 1063.398624] intel_sst_acpi 80860F28:00: fw returned err -16
[ 1063.398672] intel_sst_acpi 80860F28:00: free stream returned err -19

I have attached the full output of amixer in case it is useful. I am
shooting in the dark here. Is there a documentation to understand what all
these settings do?

Regards,

--=20
  Nicolas George

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename="amixer.txt.gz"
Content-Transfer-Encoding: base64

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
AA==

--vkogqOf2sHV7VnPd--

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlojxAAoJEHGVSyPKTcYMEqsP/3bya2i+TyoZwtJ03qXOyuGU
YZeM6ZtOI+2In+iS0j/vxP/CIvfTZqzAyRQDeLrI5H8xsIaSlRqDn1gUh4xXOV2N
fmuwP9oJCOilud93vMvphDguF2xJl5VeEScUR4HN7vpFZEciyDHBQXh284aelGo9
7t+gi2v88BhhOKuOlmNvxgRHRcP0EZZpV7ddgKoaX2xKkNLA1/2n6Z4ESnx8wNxw
v00boW/Ur6H+tz7rUDNteMYxqmpdnguzox37RcvwZmy9wOQVOMVJIVbeu9Bkz8pO
08cSGzmllkWwfgHbFcbVOkpTIx2OTpBpQAmG29xjDWV5efPZNqKflC4OflABd8VM
ZWOeJruiEjaCdkOT7legEm2x50bDNrcnUf96+NtUmOoXp1x+HWrSk2sgTpH8S0be
St29KMFb0XKFWbfl9Eao8ESJoIrXYKKweHSNUKqWxRRrGd40zvOnBGVql4t4We+e
u+XHul96h5r7GUDSmu6iBp9Qu8N+sK4GprIlWanAmYKaKH96R6hDsI7G0Rpd+nnk
KSSzStx32oItmGF78OKMbHebeHnidx0zGAuG5b4w5WqZdMFkM4otphfdStgLTB5+
0zzBjjZxxwxdH3LFKbYBwlmZ4nSBkdVRIOd+cqVu2fC4PoIwcr1AMDVlXmqQqn7T
uUL+e5O1SvjYtKNjT8SA
=uUKo
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

--===============5044007695920128736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5044007695920128736==--
