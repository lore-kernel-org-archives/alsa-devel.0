From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: mt6797: add mt6797 platform
	driver
Date: Thu, 19 Apr 2018 12:29:21 +0100
Message-ID: <20180419112921.GC27188@sirena.org.uk>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-4-kaichieh.chuang@mediatek.com>
 <20180418164626.GH10061@sirena.org.uk>
 <1524102673.3290.8.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2762712098572956247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ABB88266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 13:29:29 +0200 (CEST)
In-Reply-To: <1524102673.3290.8.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============2762712098572956247==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19, 2018 at 09:51:13AM +0800, KaiChieh Chuang wrote:
> On Wed, 2018-04-18 at 17:46 +0100, Mark Brown wrote:

> > > +		/* turn of mute function */
> > > +		dl_src2_con0 |= (0x03 << 11);

> > Is there any reason for not implementing this as a mute_stream()
> > callback?  That'll keep the DAI muted during startup and before teardown
> > which will do the most to avoid any noise making it into the output.

> We used to avoid the pop sound from user space by closing hw path from outside to inside.
> The control here is just to avoid the state is leaved in muted state.
> I'll take a look at the mute_stream() though.

Right, that's the goal of mute_stream() too - it's the last thing we do
during startup and first thing we do on tear down so that there's less
chance of any noise making its way out of the DAI.  If it doesn't work
for your system it's fine to do this though.

> > This unconditionally returns IRQ_HANDLED even if we didn't get an
> > interrupt - it's better to return IRQ_NONE unless we actually handled
> > something since that is more robust if something goes wrong, it lets the
> > IRQ core shut up interrupts that get latched on and works with shared
> > interrupts if any future designs do that.

> this IRQ num is not shared with other module, it's only for audio.

In current designs...

> We error handle by clearing the all the irq status again, when
> interrupts is sent but status not matched. we consider this handled?

You should at least complain somewhere if you get an interrupt that the
driver doesn't know how to handle.

> I'm concerned if returing IRQ_NONE, will i no longer be able
> to receive irq from this irq line?

Well, that's kind of the goal in a way - if what's going wrong is
something that's just going to keep flagging the interrupt up then
the system will just get stuck handling the interrupt constantly which
is especially nasty if the interrupt is just silently acknowledged.  If
you return IRQ_NONE eventually the core will decide that the interrupt
is stuck and disable it which contains whatever the problem is.  I'd at
least put some logging in there so if something goes wrong there's an
obvious indication that something's gone wrong with the interrupt.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYfZEACgkQJNaLcl1U
h9D3Kwf+IaP+LgEIq7poctDws9IcNmKIQ83vP/OW2JstIZK1KDhpoGaXYAC1U+fH
PDqK/H+8ySGVudyPeWyWo8l1r58dJmJwyio9TE9SBo4JnOc89Dzo9eiM+/oMRdSZ
O4SeWeLjVhmb97Kp0G5N1Od9FS3z4rIJYVx70E0wWeTKgMmeSU3wp1kXbvBrFEY+
J9/ZOe1q4ENQFHp0smnQGri91Y1njfHSMKUBoqlC9uARQQBdAaedzaTVuWRY5Uws
SWKJkI3mGqYAST8iNRDUnAeIB/dl404CwAb4NkMw7WbnMU0MC8nocvERTg47ICBr
PJsetlZ8NpJLDyOix3mbGd4Y1CEYLw==
=mH1c
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

--===============2762712098572956247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2762712098572956247==--
