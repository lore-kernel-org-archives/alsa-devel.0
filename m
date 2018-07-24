From: Christopher Head <alsa@chead.ca>
Subject: Re: Incorrect name of PCM
Date: Tue, 24 Jul 2018 08:39:35 -0700
Message-ID: <20180724083935.6e6799c4@amdahl.home.chead.ca>
References: <20180722083850.5283c197@amdahl.home.chead.ca>
 <s5h7elm1k39.wl-tiwai@suse.de>
 <3E9578B3-156B-40D9-BC11-F8D11B73E722@chead.ca>
 <s5hsh4a3p34.wl-tiwai@suse.de>
 <56F88318-0461-4587-AE9D-A885BB121ADC@chead.ca>
 <s5hin55zw8b.wl-tiwai@suse.de>
 <20180723201722.2f96a07c@amdahl.home.chead.ca>
 <s5h6015yzpv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5099150714491913865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lovelace.chead.ca (lovelace.chead.ca [162.223.226.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B62826733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 17:40:04 +0200 (CEST)
In-Reply-To: <s5h6015yzpv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5099150714491913865==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cstTKBrtbpW+=gJPBuLwtNf"; protocol="application/pgp-signature"

--Sig_/cstTKBrtbpW+=gJPBuLwtNf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jul 2018 07:22:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> You just need to disable the unused HDMI pin by setting the pin config
> value, even without recompiling drivers.  It can be overridden by
> "patch" file, as mentioned in Documentation/sound/hd-audio/notes.rst.

I didn=E2=80=99t disable it, rather switched the config words between the t=
wo
pins (since all the research I=E2=80=99ve done suggests that both outputs do
exist, they=E2=80=99re just labelled backwards). Now the PCM is named =E2=
=80=9Ciec958=E2=80=9D
and everything is perfect. Thanks for the help!
--=20
Christopher Head

--Sig_/cstTKBrtbpW+=gJPBuLwtNf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQQl7biEw6IqP57fjDtLFNZko10+CwUCW1dIOgAKCRBLFNZko10+
C4IRAQCeB41y8x5a1V8d1+FB56BSIFfOs7JOwayPmuf3ubETQAEA8QqASmqD4/aN
NzO2hWNk5s/XTgsq2EhIe+nF36eRJgM=
=A+Yo
-----END PGP SIGNATURE-----

--Sig_/cstTKBrtbpW+=gJPBuLwtNf--

--===============5099150714491913865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5099150714491913865==--
