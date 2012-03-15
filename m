From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
Date: Thu, 15 Mar 2012 14:27:03 +0000
Message-ID: <20120315142702.GL3138@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1831195172470775038=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F612319.50302@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <b04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1831195172470775038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2012 at 06:00:41PM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> So using imx-audio-sgtl5000.txt as an example, you're saying that if I
> have two SSIs, I should do this in my device tree:

> sound1 {
> };

> sound2 {
> };

That's a totally sensible option if you've got two unrelated audio
subsystems on your board for some reason.  If you've got a system where
that's not applicable and the two devices are related in some way then
you'd define a new sound card binding that reflects that.

> >>> The biggest improvement is that the SoC binding knows nothing about t=
he
> >>> card binding at all, cards are completely separate and are free to
> >>> define any binding they choose using any number of on-SoC and off-SoC
> >>> devices.

> >> Ok, I don't understand that at all.

> > Do you have some questions about the above?  What is it that you find
> > unclear?  =20

> What's the difference between an "SoC binding" and a "card binding"?

The SoC is the bit of silicon with the CPU and other devices on it like
the DMA controller and SSI or whatever ports.  The card is the PCB this
has been soldered down onto.

> > We've been through this *repeatedly*, including in the message you're
> > replying to, and we're still going back to square one every time you
> > decide to start talking about device tree again.  This is frustrating
> > in the extreme.

> I'm sorry you're frustrated, but so am I.  I still don't understand why
> the binding that I invented for the SSI driver isn't good enough for i.MX.
>  The binding and the code was documented and approved a long time ago.
> Why can't we keep the same binding on i.MX, to keep the code simpler?

The problem with your binding has always been, and continues to be, that
it's based on the idea that there's one CODEC per SSI and that the CODEC
is a simple appendage of that SSI.  There's no real real binding for the
machine driver, it's just silently created by a single SSI port.  Really
there's nothing new with this issue, there's always been this absence of
a representation for the machine distinct from the individual devices it
is built up from.

This means that when you get systems which have auxiliary devices (like
most of the Wolfson reference boards which have a power amplifier for
the sub speaker not connected to an SSI port) or that need to set up
things like complex accessory detection mechanisms there's no real place
in your binding to support those systems.  Things like the configuration
of the input and output connections which the nVidia WM8903 drivers are
able to do over multiple boards are another example.

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYfv5AAoJEBus8iNuMP3dmFAQAIc54NVSMMWDUGJ+N2rPNRe8
+bwFyVdRsKUNOk6Nz4PFdzXFsOf2nUPhnCYLahMjP5ckIUlUIhFiG8xDQPY9JXfb
JNrMOJJ6rAjAHTdwV5+l0hheaIvlsXGrb4q2ufIFhXdCXS4ydOoxTIS97Pj5FBVF
DBoEVAdz+ZozWTJK3DmZ3HJDsYFrqu0vApAlCBdlrfD/Piqo7faQCWwlaDyzudd2
bsFqSuC8b2zY/XCDYcb4qX8qaXNiekI2NOAvQovOcgLm2i/WbEiiCIz9mtBCuqUn
Y4Vv3iDO30cG73P4bvsd8bm79RqiVabxxlSlviBRsHoeSVtmboV3g9UfKzXKAQXv
UU4E2Mf+pAc+QrXroAPoyGHPCTWfNwdfsvRmZ1/WX+DkEfw9TtMMsfGs6RItoqCb
Y29H/7Tl5N/2DlAvues4btr20d+Wz3xcWG1KtbPyWu/+NZAKPNPCwhErCW7LaNrH
GUK/QUqpz0zH2ACeaCMxen60j+f3jZZ6ZDos6FEsPvjShmPmm6L4xjHXVth/4L+B
E9My6Mv1ByYddbdU+EqbT4odfmfT/RLWTmDSCcxueMWjtYImEB9X5PEAqjFgA52x
a2BjNO87T0LGvTFVidCaHo4d8BRbng79Dv8TRTxicltaHMM1+d2gN4hyH3exYOIc
T83czhHd95OyGsmnPItT
=mMTo
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--


--===============1831195172470775038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1831195172470775038==--
