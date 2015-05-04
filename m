From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: zx: Add zx296702 SPDIF support
Date: Mon, 4 May 2015 14:54:16 +0100
Message-ID: <20150504135416.GZ15510@sirena.org.uk>
References: <1430366850-10281-1-git-send-email-jun.nie@linaro.org>
 <1430366850-10281-2-git-send-email-jun.nie@linaro.org>
 <20150501105503.GT22845@sirena.org.uk>
 <CABymUCNcD_7fxCh110A-w5=3Lo5Jn2aCHGy3DwLDroZP9oqi4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7071395849251265848=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40CB8260534
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:54:32 +0200 (CEST)
In-Reply-To: <CABymUCNcD_7fxCh110A-w5=3Lo5Jn2aCHGy3DwLDroZP9oqi4w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7071395849251265848==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UNifc18z8z6e1QHx"
Content-Disposition: inline


--UNifc18z8z6e1QHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 09:13:48PM +0800, Jun Nie wrote:
> 2015-05-01 18:55 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > This is adding a new device with DT bindings but there is no bindings
> > document.  All new DT bindings must be documented.

> Plan to add a separate patch to device tree. Or you prefer to add
> device tree patch in this patch set and loop device tree maintainer?

You *always* need to document new device tree bindings at the same time
as adding new code.

> There are more than one SPDIF controller on ZTE SOC. One of them
> support HDMI output, while the other SPDIF controller support direct
> output. So I want to separate SPDIF and HDMI and add SPDIF id 0 test

So this special HDMI S/PDIF controller is directly integrated with the
HDMI IP in the SoC and not usable as a generic S/PDIF controller?  That
seems to mirror system designs which have an external HDMI encoder which
use S/PDIF or I2S to connect the audio portion to an external device.

> Do you have any suggestion on what driver to look at for the interface
> between audio and video?

Half the problem right now is that the people working on HDMI don't
appear to be talking to each other very much so everything is very
inconsistent with no real code sharing.  I don't really feel I've got a
good enough picture of what the hardware looks like in general to be
100% clear on what the best way is forward beyond the fact that we
should be sharing the EDID parsing code.

I'd suggest for future versions reorganizing things so that you add the
S/PDIF driver with only S/PDIF support and then have a separate patch
that layers on the HDMI support.

--UNifc18z8z6e1QHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR3oHAAoJECTWi3JdVIfQ7REH+gNBPfcmJa2NZbkpENo5QpXa
BAaI+fQRF8UysQYSHA8FxbMftUzwWVMLVBz0/eM6xQ0ULxlxYDbsJgf+N3LjGc+t
Y4vtTdYwmjOhe1Q0L984tZ8MCesLi6CpwYgQuaOAAGB1fqs5gAVdr8rXgKGcyDTu
FqneOEsAn/jxkaJLb2BV7fDzY+MI7lUDgQTQbhljXlMs1eEJ3LbNKzZo7HjEmuEt
mWbdjGvcm5pP8MWz2mmJNketzhBHTmCoO3YUgozmK0NyO2ZDk2Vhafz3EwPYtYAL
5qfpH/Qd3vhmEMt9E8JNS57EnzDutX5Nvws3d2Sf30H6/2OC1aZfB3yA6DrOEsg=
=F27l
-----END PGP SIGNATURE-----

--UNifc18z8z6e1QHx--

--===============7071395849251265848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7071395849251265848==--
