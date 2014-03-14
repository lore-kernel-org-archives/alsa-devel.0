From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Fri, 14 Mar 2014 19:12:44 +0000
Message-ID: <20140314191244.GZ366@sirena.org.uk>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5543182482200275097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAA9E2654ED
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 20:12:52 +0100 (CET)
In-Reply-To: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5543182482200275097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="05AYo7Fj2eyhp+k+"
Content-Disposition: inline


--05AYo7Fj2eyhp+k+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 03:11:36PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch adds the ALC286 codec driver.
>=20
> ALC286 is a dual mode codec, which can run as HD-A or I2S mode.
> It is controlled by HD-A verb commands via I2C protocol.

Some or all of this documentation needs to end up in the code, we need
to be able to understand and maintain the code going forwards and
while the commit message is going to be kept it's still useful if the
code can be followed.  Right now that's extremely hard.

> The following is the I/O difference between ALC286 and general I2S codecs.
> 1. A HD-A verb command contains three parts, NID, VID, and PID.
>    And an I2S command contains only two parts: address and data.

It'd probably help to explain waht these are.

> 2. Not only the register address is written, but the read command also
>    includes the entire write command.
> 3. rt286 uses different registers for read and write the same bits.
> As a result, standard regmap is difficult to be used on ALC286.
> We don't request a standard I/O by snd_soc_codec_set_cache_io anymore.
> Now we have ,reg_write and .reg_read functions for ALC286's I/O.
> And we don't use cache due to item 3 above.
> Some dummy registers (address <=3D 0xff) are defined for dapm routing.
> Thhe dummy registers are cache only.

Don't use dummy registers, DAPM already has virtual controls of various
kinds - if you need more let's extend them.  Storing data in virtual
registers just makes things confusing and fragile.  Some older CODEC
drivers did it and they're harder to work with now than they should be.

> Due to item 2 above, HD-A verb commands are put into the address part of =
regmap.
> When we issue HD-A verb write commands, the data part of regmap is zero.

I'm having a really hard time understanding how this follows.  We do
have some other devices that do things like have multi-level register
addresses with registers collected in pages.  By analogy here what I'd
expect to see is something which combines the various pieces of
addressing information into a bitfields within a single number that can
be used as a register address.

Or perhaps this just isn't anything like a register map at all?
Whatever is going on something that ignores the value part of the regmap
interfaces doesn't seem like it is a very good fit.

--05AYo7Fj2eyhp+k+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTI1SpAAoJELSic+t+oim9XgkP/jcjlVTMo2V1RjPsUIYKSdmh
QtBRkTYOpFkORNHTHvZy2bQUV116PDE9lgFde1flMcQ239i8DzETNQ5AzEHMvvsH
olAd8JZ1lEnTBUPm7kGuYSYGxf5pW3LdZBOnE13izT7DGCiG6A9LTjdvzf/Kkj/M
Fv7ob4iEGn6uDTfDhSMfuDoP9WEcrrCoWtT774Bp/wrZUFpKhdxs6suPqnlndAO6
Z8GHRg9eTEZNQUbULC5VhrO6FgQDCBMsre9UgWR46gk3swSOsXE1ruF8MPekQdtW
Di7nf+B90pPFzH5+DtetEvORCw/HEd/JRfM3RqGLIHDCy+JkuaQ9YVKE3NDfLCz8
Di1KVns1cpNM2Oz8x4thVgfYwVl81dM+tf5RjCAKvktBiDd/hhXOLtSttqaIJCVM
mxGX048tTNx7FNu1MH3FXoasRWjpkOEv2Y0ZpMBlZ9/IUwnQ+xj8RQ5MtUiUtnQ2
Eyt6urT38cx987WzMlCReIIETyo5ImlnaxOwibSVek0AK3mR/UIf1qGnz6MxpNqZ
Kl7PF1HFk824jcZToz5Ix7OM24JPR10XZd2D8RPSWITS45pc7cCS/qzRzEPwIRma
h5dXr5vqyivlXyMiv5Cg1UdsrdRynmE65unRcj9HNpb3oPVOzpbzK2Pj7K8VL9PF
pBqREAkvUge7w5d1hw6s
=+uvk
-----END PGP SIGNATURE-----

--05AYo7Fj2eyhp+k+--

--===============5543182482200275097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5543182482200275097==--
