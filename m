From: Christopher Head <chead@chead.ca>
Subject: Re: Incorrect name of PCM
Date: Mon, 23 Jul 2018 09:11:38 -0700
Message-ID: <3E9578B3-156B-40D9-BC11-F8D11B73E722@chead.ca>
References: <20180722083850.5283c197@amdahl.home.chead.ca>
 <s5h7elm1k39.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0647791902746471408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lovelace.chead.ca (lovelace.chead.ca [162.223.226.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C2A426720C
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 18:11:56 +0200 (CEST)
In-Reply-To: <s5h7elm1k39.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0647791902746471408==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/signed; boundary="----QWSH8KD9UEGGPPTN5ZVR27EQE4OUZ9";
  protocol="application/pgp-signature"; micalg="pgp-sha512"

------QWSH8KD9UEGGPPTN5ZVR27EQE4OUZ9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
 charset=utf-8

On July 23, 2018 12:34:34 AM PDT, Takashi Iwai <tiwai@suse=2Ede> wrote:
>
>For playing via HDMI on your machine, you'd need to pass as "aplay -L"
>shows, one of the following:
>
>> hdmi:CARD=3DNVidia,DEV=3D0
>>     HDA NVidia, HDMI 0
>>     HDMI Audio Output
>> hdmi:CARD=3DNVidia,DEV=3D1
>>     HDA NVidia, HDMI 1
>>     HDMI Audio Output
>> hdmi:CARD=3DNVidia,DEV=3D2
>>     HDA NVidia, HDMI 2
>>     HDMI Audio Output
>> hdmi:CARD=3DNVidia,DEV=3D3
>>     HDA NVidia, HDMI 3
>>     HDMI Audio Output
>
>The device number depends on the HDMI port you plugged in=2E
>The above can be in a shorter form like "hdmi:1,0", too=2E

Hi,
Thanks for responding=2E Did you miss this part of the aplay -L output?

hdmi:CARD=3DPCH,DEV=3D0
HDA Intel PCH, VT1708S Digital
HDMI Audio Output

This is the part I think is wrong, not the parts mentioning the NVidia HDM=
I outputs=2E

Thanks,

--=20
Christopher Head
------QWSH8KD9UEGGPPTN5ZVR27EQE4OUZ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iIEEABYKACkiHENocmlzdG9waGVyIEhlYWQgPGNoZWFkQGNoZWFkLmNhPgUCW1X+
OgAKCRBlX9lfCltNgcPfAQCH1B+tTU/BoGU+mhf32ENRC2LEIW2uTkx46WwmSsyg
BwEAy+Gus4EaZYw2UDeIh//6rIp/OmuABMi+Vdk3dtqm4Ac=
=QeCV
-----END PGP SIGNATURE-----

------QWSH8KD9UEGGPPTN5ZVR27EQE4OUZ9--

--===============0647791902746471408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0647791902746471408==--
