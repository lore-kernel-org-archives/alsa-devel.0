From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 18:29:52 +0000
Message-ID: <20131213182952.GI11044@sirena.org.uk>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
 <20131213133444.GZ11044@sirena.org.uk> <52AB1244.5010506@ti.com>
 <20131213141814.GG11044@sirena.org.uk> <52AB1A4C.3030907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4247143208754132904=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE6AD261A4D
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 19:29:59 +0100 (CET)
In-Reply-To: <52AB1A4C.3030907@ti.com>
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


--===============4247143208754132904==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOmSpbqtysumMR8M"
Content-Disposition: inline


--TOmSpbqtysumMR8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 04:31:40PM +0200, Peter Ujfalusi wrote:

> Hrm, not sure about other SoCs but on OMAP most of the formats from memory
> ends up on the I2S bus without any bits added/removed so the format actually
> applies to the codec side as well since the data arriving to the codec will
> have the same layout as it had in the memory.
> But, yes some level of logic in the core might help.

For every other CPU or CODEC where I know what it does the number of
bits expected on the bus is the sample size.

> > This isn't the way to do it, though - if the TWL drivers were ever used
> > with other CPUs (admittedly unlikely) they'd run into trouble.

> The twl drivers (and the dac33) is doing the correct thing IMHO: reporting
> S32_LE with set .sig_bits = 24. Just to let the user space know that thay
> should not use the whole 32bit range.

Ah, OK - that's good and correct.  Your mail made me think they were
using one of the S24 formats.

--TOmSpbqtysumMR8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSq1IdAAoJELSic+t+oim9bkIP/jcCMtwBqC/cqHfmuu/Rh974
Bot4NeuJlP0SlaVcJR1wBZXzqT7ZpPhPz5/UqXYQD0mEXWdOpsq+y4/DxwsJmERV
nwoMuiQcGC2V4DBbNOJ+RNfCR/Q47f61xEuGBsLU2xI7VFl6yNKDds2WSdVHfJ5Y
QZnZtMN5JlifsAQUAJI4i4376MhIbadkd8e0eXNBkjavuaKKrcJgmzY5Fqmfzrfg
5X/2VBl1aRTUFbk9tTknPxiAqZMJ+UPFTeuvl2oi7cYGWHEg1Dv3pwPtHGSl1YfS
ZYMCkWMeePmm9urOhtDm6kenxDbpwiBy4joOzNDVk436g1dRukaSm5tX+WSvbK2C
G3lBH2mrYaxptTMhDcuVO0SXioj9aXApZTIAFk93tJVHA8yr9DueoyXBN15VIQpc
uolOn2KEBrSbGTXfyIXo/M9ivQZOWM57a9NOUaCQcT9Xh/eJlCF3ys3nxwL9ampJ
jDjwXix7/X8ld/HV4sqH7eQ6TfM+3fhapm4tJDsW1WluyrqKA94aTCYXowKtPplH
ZQNTC+6VPmEBMb9zpjCoTgwDEfOvh3p1lVGxO9jY1Mqv1L1YzVobjOFWI2mS7hoX
lbG1bpOx61YkAPcxndzZFaRPCVt/gvfOyNj8edHirqFiQnwviIo+eymLx+ZUYE2i
anQaXfUH+x/TBjt8rkdN
=4AoQ
-----END PGP SIGNATURE-----

--TOmSpbqtysumMR8M--

--===============4247143208754132904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4247143208754132904==--
