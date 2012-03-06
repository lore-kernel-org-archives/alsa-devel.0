From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Tue, 6 Mar 2012 12:12:22 +0000
Message-ID: <20120306121222.GK19635@opensource.wolfsonmicro.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<20120229235147.GM8295@opensource.wolfsonmicro.com>
	<CANKRQngOkGTPM9AWEaHoaNQCyN65B_ESB24ctcT_DiEen050fg@mail.gmail.com>
	<20120302125819.GE3230@opensource.wolfsonmicro.com>
	<CANKRQngoDf_U8U7txG0AT1TKmSeq2FfqwjWD7EEiLROWzn+f5Q@mail.gmail.com>
	<20120306100012.GC19635@opensource.wolfsonmicro.com>
	<CANKRQniUnEPawXZHcPH9kG0hDiaZ-eJ_vOQrCefB0ntCu98D6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2201010551173976924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0FA124361
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:12:28 +0100 (CET)
In-Reply-To: <CANKRQniUnEPawXZHcPH9kG0hDiaZ-eJ_vOQrCefB0ntCu98D6g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2201010551173976924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6d1KVhp94hk3Jrm"
Content-Disposition: inline


--d6d1KVhp94hk3Jrm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 07:49:16PM +0900, Tomoya MORINAGA wrote:
> On Tue, Mar 06, 2012=E3=80=8019:00 Mark Brown <broonie@opensource.wolfson=
micro.com>:

> > This is not what the above prototype says, the above prototype has only
> > one register in it.  You need to make this *much* clearer for the
> > registers it's affecting.

> Sorry, I couldn't understand your saying / concern.
> Do you mean I shouldn't use ml26124_update_bits() but snd_soc_update_bits=
() ?

Ideally you should be using the framework features.  If there is some
reason why you can't you need to make it much clearer what the reason
is so people reading the code can understand.

--d6d1KVhp94hk3Jrm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVf8CAAoJEBus8iNuMP3dibcQAI1KPNAY/jNVrMEXGxiWhIBq
bmU0WGsAg+0ssc6P6V8yWubSo2k2F0VLZcWFCHQ20LMGIRFjS1qZkbDxEI3l4eDC
tTUQTKDmTkEA8u0pjjZy8BdI+JyCOwqzxwWfOvGu2jJdS2nrPO31HIVaDUzpNO78
ef/MTH7ZBQSwPmmqgCmq6N83ly/ClE8YYknc9VswJUhI7aEPea9SRCPM/KYL8ACR
0M2dmaxg6cppyBgpL31ahLFMrYcNhbCUBOZlEef5JKaHXN0AX5RX+3e1zJTDGb3U
HFtkC5dE+pgZw7Dm16S8b+AR7YTgBdPtQnM+aIvi7HRFsr3UilK8FYkDNByx9LBN
kgoQgRgvPg2vSd0zpw5ccKfUvkUy30rJH8IOdwxFPINTZ1N6H7hkeVi1+NfrGKHD
AjIqN9Uy4P9g7q3l6VWE9j4jBc9+Jjb71SSTBDoQAOQepWsBV0345/Hw0njmvHCr
pkJYZErsPaX1YO8mWfu05D0EnmdctfX0ylAlhU+L0pWiopKzgCuBNtbhGtZttWVz
TVq9AGHn+8J8Zc/C7PdHt57LpZcKhbHt0hcelL3XR1Tl9p6xCfZDJ5mJfqPQe1Ti
aLfSR+A5UkdJRrLsJbP6SNgoXUHhThWfxN2PhbNt/l72znzbJVwbHve78eEqiPj9
WDive/SlB7Q/40jbzXVp
=UySq
-----END PGP SIGNATURE-----

--d6d1KVhp94hk3Jrm--

--===============2201010551173976924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2201010551173976924==--
