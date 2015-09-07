From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-classd: add the Audio
 Class D Amplifier code
Date: Mon, 7 Sep 2015 17:23:50 +0100
Message-ID: <20150907162350.GV5313@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5867310463049268299=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 668072605C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 18:24:10 +0200 (CEST)
In-Reply-To: <55EC0AF5.8060403@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Wu, Songjun" <songjun.wu@atmel.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, lgirdwood@gmail.com, ijc+devicetree@hellion.org.uk, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============5867310463049268299==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="00Xftji29zlN/ZGB"
Content-Disposition: inline


--00Xftji29zlN/ZGB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2015 at 05:44:21PM +0800, Wu, Songjun wrote:
> On 9/3/2015 19:37, Mark Brown wrote:
> >On Tue, Sep 01, 2015 at 01:41:40PM +0800, Songjun Wu wrote:

> >>+static const char * const eqcfg_bass_text[] =3D {
> >>+	"-12 dB", "-6 dB", "0 dB", "+6 dB", "+12 dB"
> >>+};
> >
> >>+static const unsigned int eqcfg_bass_value[] =3D {
> >>+	CLASSD_INTPMR_EQCFG_B_CUT_12,
> >>+	CLASSD_INTPMR_EQCFG_B_CUT_6, CLASSD_INTPMR_EQCFG_FLAT,
> >>+	CLASSD_INTPMR_EQCFG_B_BOOST_6, CLASSD_INTPMR_EQCFG_B_BOOST_12
> >>+};

> >This should be a Volume control with TLV information, as should the
> >following few controls.

> The Volume control with TLV information is not suitable for this case.
> Bass, Medium, and treble are mutually exclusive.
> So I think the SOC_ENUM control is suitable for this case.
> The register layout is not very good,
> The register is defined as below.
> =E2=80=A2  EQCFG: Equalization Selection
> Value Name       Description
> 0     FLAT       Flat Response
> 1     BBOOST12   Bass boost +12 dB
> 2     BBOOST6    Bass boost +6 dB
> 3     BCUT12     Bass cut -12 dB
> 4     BCUT6      Bass cut -6 dB
> 5     MBOOST3    Medium boost +3 dB
> 6     MBOOST8    Medium boost +8 dB
> 7     MCUT3      Medium cut -3 dB
> 8     MCUT8      Medium cut -8 dB
> 9     TBOOST12   Treble boost +12 dB
> 10    TBOOST6    Treble boost +6 dB
> 11    TCUT12     Treble cut -12 dB
> 12    TCUT6      Treble cut -6 dB

OK, so that's not actually what the code was doing - it had separate
enums for bass, mid and treble.  If you make this a single enum with all
the above options in it that seems like the best way of handling things.

> >>+static const struct snd_kcontrol_new atmel_classd_snd_controls[] =3D {
> >>+SOC_SINGLE_TLV("Left Volume", CLASSD_INTPMR,
> >>+		CLASSD_INTPMR_ATTL_SHIFT, 78, 1, classd_digital_tlv),
> >>+
> >>+SOC_SINGLE_TLV("Right Volume", CLASSD_INTPMR,
> >>+		CLASSD_INTPMR_ATTR_SHIFT, 78, 1, classd_digital_tlv),
> >
> >This should be a single stereo control rather than separate left and
> >right controls.

> Since the classD IP defines two register fields to control left volume and
> right volume respectively, I think it's better to provide two controls to
> user.

No, this is really common, we combine them in Linux to present a
consistent interface to userspace.

> >>+	dev_info(dev,
> >>+		"Atmel Class D Amplifier (CLASSD) device at 0x%p (irq %d)\n",
> >>+		io_base, dd->irq);

> >This is a bit noisy and not really based on interaction with the
> >hardware...  dev_dbg() seems better.

> This information will occur only once when linux kernel starts.
> It shows the classD is loaded to linux kernel.
> I think it's better to provide more information to user.

This stuff all adds up and since it'll go out on the console by default
it both makes things more noisy and slows down boot - printing on the
serial port isn't free.  If we want to have this sort of information we
printed we should really do it in the driver core so it appears
consistently for all devices rather than having individual code in each
driver.

--00Xftji29zlN/ZGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7boVAAoJECTWi3JdVIfQTeIH/RSCB5SwyrLUV06en5LRJROJ
Drti/NZzOoqlrGCvzH+lRHS9vyzijbVyu10Op8eEuTub62b7ycUHq40tF35B+NQc
Xcd1sk+B7tEa9hNKvBtUR4vRjbtz52GsHm2HZnLsvfh9/+GE40IbtS8zCyP/Tl9K
rY3/z2Kab+stLkgX+uusnLIa7QvwPGmU7QloBfKCiNtwhoZAO3vGUxqtRZIuarOU
UH183AQ9/yBKPg6+9eJmD0+hWBJp+rydtlR2noQme80MJ0rz1lmTEULSonmXm9G9
QVOZPb929h5NZWFvQK99NenEx+JlTF6BPCvW+d5M+WAcCNQQNzH79C9Cthsozh4=
=8G+y
-----END PGP SIGNATURE-----

--00Xftji29zlN/ZGB--

--===============5867310463049268299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5867310463049268299==--
