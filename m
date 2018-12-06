From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on
 reg read and write
Date: Thu, 6 Dec 2018 19:56:19 +0000
Message-ID: <20181206195619.GA3084@sirena.org.uk>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
 <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <50cffd9e-74f4-b0af-5eed-3dad5f32d8f9@amd.com>
 <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20181205112832.GA6205@sirena.org.uk>
 <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8571069616266716954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BD3D2267AAE
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 20:56:22 +0100 (CET)
In-Reply-To: <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: alsa-devel@alsa-project.org, Support.Opensource@diasemi.com, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com, Adam.Thomson.Opensource@diasemi.com, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============8571069616266716954==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:50:29AM -0700, Daniel Kurtz wrote:

> I agree, there is no guarantee here once things have gone wrong, and
> the concerns above are reasonable.  However, in the real world, I2C
> transactions do sometimes fail for various reasons.  The I2C (and

It's *vanishingly* rare and like I say we don't have any constructive
recovery plans - I've never seen a practical system that had any better
idea than hoping the user noticed a problem and reboots.  Probably the
best we can really do is try to reset the device, or at least resync the
register map.  That would probably do something useful in the
vanishingly rare case where it were a singular glitch, at the cost of
obvious and painful user visible issues (which would probably be
happening anyway).  The nearest I've seen to that is one of the CODEC
drivers which has watchdog code to monitor the device in case it
spontaneously reboots and will resync the register cache if that happened.

I'm gathering that there are Chromebooks that do have I/O problems here?

> other bus) APIs have ways of reporting up their errors so callers can
> take appropriate action.  This codec driver can run on all kinds of
> hardware that can experience transient I2C errors, thus it sounds like
> a reasonable idea to have the driver do some error checking on the
> APIs it calls and take whatever action it can.  Just ignoring the
> errors and proceeding like nothing is wrong is one option, but we can
> probably do a little better by at least checking for errors, abort the
> current operation, and pass up errors to higher layers when an i2c
> transaction failure is detected.  If nothing else, this would enable
> higher policy layers to take appropriate corrective action - for
> example, if there is an i2c error when configuring a codec, it seems
> advisable to report this up so that a machine driver would know to
> abort and not turn on downstream amplifiers [I am assuming here that
> something like this would happen, I don't know if the sound stack
> really works this way].

Yeah, so this is partly why I'm not super thrilled here - none of the
layers currently have any especially bright ideas about how to handle
things and giving up part way through an operation and returning an
error without any attempt to unwind or recover feels like it's just
trying to give a false sense of security. =20

> Once the default "check, abort and report" error checking is in place,
> we could perhaps think about actions that the driver could take to
> recover from various failures, such as resetting the device or
> unwinding previous transactions before aborting, or retrying....  but
> those are all policy, and this patch is more mechanism that enables
> policy.

But is this going to be a useful way of handling such policy and is any
work on that from whoever has these unreliable systems likely to be
forthcoming?  We're going to end up with partially done reconfigurations
in the register cache which is a potential issue for recovery strategies
based around resyncing that, it's not so bad on things like starting a
stream but bias level reconfigurations could be fun.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJfuIACgkQJNaLcl1U
h9ByIAf9Fs4MIvnokH1GaamyWnCsns/7ZZsboXYWmErv7jwTVyMkFazNGGj5WvHo
PIfTXXHAXmnRgSwrr0NG/fZmSuT5ipEyuVvK5a/6jQChCfa1eqctnzy0ufWyvprh
t/IxAsfywfJvLXEH789+khJkA6OMz2A9F6bhEQPW5bNEgQJxTN3RX6h069dHtbRt
tbKhTEzQfe/LSmD6oyP70yJvunrguFNDOMQ/RjOR2h0oo0YatvvwUY4dNcCPAixd
JqxFlMnC9mYk8J1lR4JWIKsMcQ/R+Q2ecdMNqZfLvtjSVFq23lzCtchI+okeNVOI
QoNmX7cXNuqY5PgijXoh0XO16wuiqQ==
=oW7T
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--===============8571069616266716954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8571069616266716954==--
