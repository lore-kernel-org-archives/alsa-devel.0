From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 2/2] Documentation: dt: bindings: sound:
 Add bindings for CS42L56 CODEC
Date: Mon, 5 May 2014 21:32:04 +0000
Message-ID: <F1AEB906-8BB1-4699-909A-DF29343F2B6F@cirrus.com>
References: <1399320549-16645-1-git-send-email-brian.austin@cirrus.com>
 <1399320549-16645-2-git-send-email-brian.austin@cirrus.com>
 <47E0FD7A-D2C0-425E-A7FB-917B65D74B2D@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4809995928604573419=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0094.outbound.protection.outlook.com [65.55.169.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 6818B2615B6
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 23:33:05 +0200 (CEST)
In-Reply-To: <47E0FD7A-D2C0-425E-A7FB-917B65D74B2D@codeaurora.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kumar Gala <galak@codeaurora.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============4809995928604573419==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5EBAE0D6-6939-4150-A598-AC8A91AC76DA";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_5EBAE0D6-6939-4150-A598-AC8A91AC76DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On May 5, 2014, at 4:18 PM, Kumar Gala <galak@codeaurora.org> wrote:

>=20
> On May 5, 2014, at 3:09 PM, Brian Austin <brian.austin@cirrus.com> =
wrote:
>=20
>> This patch adds binding documentation for the Cirrus Logic CS42L56 =
Low Power Stereo I2C CODEC
>>=20
>> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
>> ---
>> .../devicetree/bindings/sound/cs42l56.txt          |   63 =
++++++++++++++++++++
>> 1 file changed, 63 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/sound/cs42l56.txt
>>=20
>> diff --git a/Documentation/devicetree/bindings/sound/cs42l56.txt =
b/Documentation/devicetree/bindings/sound/cs42l56.txt
>> new file mode 100644
>> index 0000000..9ae074f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
>> @@ -0,0 +1,63 @@
>> +CS42L52 audio CODEC
>> +
>> +Required properties:
>> +
>> +  - compatible : "cirrus,cs42l56"
>> +
>> +  - reg : the I2C address of the device for I2C
>> +
>> +  - VA-supply, VCP-supply, VLDO-supply : power supplies for the =
device,
>> +  as covered in =
Documentation/devicetree/bindings/regulator/regulator.txt.
>> +
>> +Optional properties:
>> +
>> +  - cirrus,gpio-nreset : GPIO controller's phandle and the number
>> +  of the GPIO used to reset the codec.
>> +
>> +  - cirrus,chgfreq-divisor : Values used to set the Charge Pump =
Frequency.
>> +  Allowable values of 0x00 through 0x0F. These are raw values =
written to the
>> +  register, not the actual frequency. The frequency is determined by =
the following.
>> +  Frequency =3D MCLK / 4 * (N+2)
>> +  N =3D chgfreq_val
>> +  MCLK =3D Where MCLK is the frequency of the mclk signal after the =
MCLKDIV2 circuit.
>> +
>> +  - cirrus,ain1a-ref-cfg, ain1b-ref-cfg : boolean, If present, AIN1A =
or AIN1B are configured
>> +  as a pseudo-differential input referenced to AIN1REF/AIN3A.
>=20
> What happens if a DT had both bools?
That would not cause any issues, but you can only tie the ref to one of =
the inputs

>=20
>> +
>> +  - cirrus,ain2a-ref-cfg, ain2b-ref-cfg : boolean, If present, AIN2A =
or AIN2B are configured
>> +  as a pseudo-differential input referenced to AIN2REF/AIN3B.
>> +
>> +  - cirrus,micbias-lvl: Set the output voltage level on the MICBIAS =
Pin.
>> +  0 =3D 0.5 x VA
>> +  1 =3D 0.6 x VA
>> +  2 =3D 0.7 x VA
>> +  3 =3D 0.8 x VA
>> +  4 =3D 0.83 x VA
>> +  5 =3D 0.91 x VA
>> +
>> +  - cirrus,adaptive-pwr-cfg : Configures how the power to the =
Headphone and Lineout
>> +  Amplifiers adapt to the output signal levels.
>> +  0 =3D Adapt to Volume Mode. Voltage level determined by the sum of =
the relevant volume settings.
>> +  1 =3D Fixed - Headphone and Line Amp supply =3D + or - VCP/2.
>> +  2 =3D Fixed - Headphone and Line Amp supply =3D + or - VCP.
>> +  3 =3D Adapted to Signal; Voltage level is dynamically determined =
by the output signal.
>> +
>> +  - cirrus,hpf-left-freq, hpf-right-freq : Sets the corner frequency =
(-3dB point) for the internal High-Pass
>> +  Filter.
>> +  0 =3D 1.8Hz
>> +  1 =3D 119Hz
>> +  2 =3D 236Hz
>> +  3 =3D 464Hz
>> +
>=20
> Add a include/dt-bindings for all the various enums
Could you explain more please?

Thanks

--Apple-Mail=_5EBAE0D6-6939-4150-A598-AC8A91AC76DA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTaANUAAoJEHdXZdGWfiO7uucH/2IPZCEAwdHurlvbdRGgzmsz
82faV6rqlWoLXY66neR2hCJSsbcKXWNZuSnj4f+sR/2pibOZ+Vmwgj7Xw0p+DsMY
2tdZREYEutPsXQpEud1ta7MzdcOX7Tf0leUscCt5itv2sjk2fCG2fraX//qSLYI0
58TXiNHwuA0m7sY9vL68NPj2xulbe7+BR2Q2kwhbXRBeR3yiWALGN+z0+lCNUcdM
oM6lJuSx2OppI4bES+CXwrqKb38Vfhd2D+wTq9qgAhWMGOzFLM4AxwoBfC5ZLhJP
47fFT4OcHXIkEfUXyw68gUjL+lnVwutFUEi+CEGG6F7Ao5atS85BpGmCP2sjVTc=
=JnXB
-----END PGP SIGNATURE-----

--Apple-Mail=_5EBAE0D6-6939-4150-A598-AC8A91AC76DA--

--===============4809995928604573419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4809995928604573419==--
