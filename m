From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Tue, 24 Jun 2014 10:18:43 +0100
Message-ID: <20140624091843.GE23300@sirena.org.uk>
References: <1402059931-10731-1-git-send-email-peter.ujfalusi@ti.com>
 <20140609202403.GX5099@sirena.org.uk> <53A82519.6050506@ti.com>
 <20140623151822.GA23300@sirena.org.uk> <53A91960.1040108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2586384885109547646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48101265E32
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 11:19:01 +0200 (CEST)
In-Reply-To: <53A91960.1040108@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2586384885109547646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2014 at 09:23:28AM +0300, Peter Ujfalusi wrote:
> On 06/23/2014 06:18 PM, Mark Brown wrote:

> > The number of bits on the wire should be the number specified in the
> > format.

> So you are saying that for S24_3LE, S24_LE and S32_LE (msbits=24) we should
> have 24 bits on the wire?

No - when the format is S32_LE then that's 32 bits.

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqUJvAAoJELSic+t+oim9s68P/1MWM2ceiLXErLRor7qnNC2s
5Ko99luvr7R1qXKjQkh/zr8W/4YEwesFvZagYOCytVA2rqoP7F1mXiMYsdF8rB2n
hB/MVzyyVYR0+3eM1TSJa3QaEF6aWS89bYCssG4FB92YCak0J4ySgIHcMKWhUOCM
jk5U2rZGd67xcWJshxrFtSISzRqRxo2uHdlNAbQ4TPvmoIg+hjA9bkbn1mFanK/v
SqAqXebXhhpLGOYeDI512D6AeE6//oEH96WrqFBb6GqdQh92lKs3VBX5qFOs2g0n
ZCrvVPxvKaDr5b/BwWy7E9voi2Omdy0qxfRrQYhkcxy3WvemqvzrKUT+3MyPswR2
HkswDRyJEMprIUPb5mbaB8Mkf5fV+JgLubifaQRdsN0deikBDOGXP9XP2+tiZQy4
G3AkkL4TI29mKI1UgQUn3L2ZTdNBPeI8/T3r239R5sl9H6RwbPeXOidJK2vBLlDs
V3TpNq7fYPXepTm3pWR+oMbi1aYlotRkE+nboaqG62j4PmIxfkefRRenKmYwYC/C
1Z6zCHQfyvRTqWoHmJOntWWH/Xpj339iOIwmWyBbTl48796sJqPdt3Gv20wDy0HK
gCZ/qhKt/Gz7Jpsr/N62jjujGEpsxGshz8eznL05NfdrwHIagksaFLoJtFW8YcMH
uAIwNfBe+zZ2rMc4OJlr
=UsYQ
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--

--===============2586384885109547646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2586384885109547646==--
