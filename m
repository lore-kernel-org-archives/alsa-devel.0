From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: rt5677: Convert to use
	rl6231_get_clk_info
Date: Thu, 12 Jun 2014 10:49:58 +0100
Message-ID: <20140612094958.GT5099@sirena.org.uk>
References: <1402361856.4636.0.camel@phoenix>
 <CAFRkauCDgnGt1HpRQQDY59ASF8=oSYX+NdOgGan2iZEiwry6pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2168752816131289079=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0CBC265753
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 11:50:09 +0200 (CEST)
In-Reply-To: <CAFRkauCDgnGt1HpRQQDY59ASF8=oSYX+NdOgGan2iZEiwry6pg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2168752816131289079==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0bQ+oXmfTh/YqQi"
Content-Disposition: inline


--z0bQ+oXmfTh/YqQi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 12, 2014 at 08:26:25AM +0800, Axel Lin wrote:

> This patch ensures SND_SOC_RL6231 will be built.
> This patch is required to fix build error with commit
> "ASoC: rt5677: Convert to use rl6231_calc_dmic_clk".

Sure, but remember that that patch isn't in -next yet since the merge
window is still open.  I'll get to it at some point before it is.

--z0bQ+oXmfTh/YqQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmXfDAAoJELSic+t+oim9Za8P/R5yypDHwFQo39sKNZODV4lo
ZrKX9JI9WEpRi9FsuRIBwnL4vARpwuYJmkxJvhZsB6tBWg+T1A8KAKS+Utm5NjAw
FoWrS+p8KQanZZmy5kgOOCniXxzXwmDpjEF8TIt19vbFEQe5xXoB/TwZsQ0o/gya
W27zNveMKXAATBs2CpfGTcFH9ANgSXI54DQ5aYRlkb/S5O/Nl2OiVQ3NJFQRSKG5
QTaJMPHsaNIGQbwrQvWI9L5e2bdb5wotqo9CLo77PY6EMs81OqD1J1v9VmhtageR
isBLvG4PY6rCpFbK5xq9mmPkvHAy2+euFx8pJTnY/hG0FQPxwSU32CYaffipaoO5
1VavIBc2wJjbmx8mKpBQiZE5nudqmyqEZ6RjhqyyJfendsrVy+biiG9xrMBVhZjb
FqZV8YB/NphwzYghKBJjSAqezl9U1EtTijQqLPuxo/X9TdKmg/oMJvHfaHGYeq4V
iTTUVKLGYbvt1BreS9+MbcIMgI0r+tm6CdvmH/36mZgvn6uVp8ed/IneBmcffGQW
ABt4hfpN42Qe8jVsHdDHoCuuBytUrrd/IrPA0mSQYu3S78G+WyJWpeRLEQ0lxCgc
b5iABkXBLwDmFwaNVZoM2q8dOuFOaPlA3o4vMCPOtGMSPUPEu9igvHCPHHWQ9xHK
0of0lRwGb3nq9hVj08eC
=Hrsd
-----END PGP SIGNATURE-----

--z0bQ+oXmfTh/YqQi--

--===============2168752816131289079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2168752816131289079==--
