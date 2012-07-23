From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 14:47:18 +0100
Message-ID: <20120723134718.GV4435@opensource.wolfsonmicro.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
 <20120723104720.GK4435@opensource.wolfsonmicro.com>
 <1343041578.1726.4876.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1725932723653627759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76CD7265CD1
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 15:47:17 +0200 (CEST)
In-Reply-To: <1343041578.1726.4876.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1725932723653627759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6h64vBu9tReNbGLX"
Content-Disposition: inline


--6h64vBu9tReNbGLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 04:36:18PM +0530, Vinod Koul wrote:
> On Mon, 2012-07-23 at 11:47 +0100, Mark Brown wrote:

> > I'm having a hard time relating this to what I was saying.  The point
> > here is that if the device keeps marching on consuming data (as most
> > cyclic DMAs would) then there's still going to be an underrun even if
> > there's a buffer that causes a delay in the user hearing it.

> yes there would be overrun but that is correct one. At that point I can
> see that the DSP would have rendered everything it has (all buffers
> exhausted). At this point app_pointer = hw_pointer and soc_delay would
> be zero.

> I am assuming dsp driver reports the soc_delay dynamically as it would
> do for hw_pointer.

This is sounding exactly like the existing delay parameter and how it's
handled in ASoC.

> This doesn't stop all underruns, they would still be reported.

> This only prevents false underrun when DSP still has something to
> process and give to output DMA.

I don't think you're quite getting my point here.  The DSP still has
something to process but unless whatever is feeding the data to the DSP
stops sending data to the DSP when it catches up with where the
application is writing then there will still be a glitch.

Reporting the delay is useful anyway but it's not the whole picture as
far as recovering from and masking the underrun is concerned.

--6h64vBu9tReNbGLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDVXgAAoJEBus8iNuMP3dEwoQAJJp94ljzsZBuxvsyJBZcK5P
iUO0h+9Ase+lgjXwWSBwOiQ6zRcCzDDFirOagGn+GL0yv976oHhsKfUpbQR4ZbAY
daeXRruqLvEr0Iv/JeViSLIePDZkG5+RN+Yqven0a9hbdM1joynlpa+SE124WEpv
pbh6ww2INGuToMFIWL3gQqj5NPMKjcdf6VcP7F4xRzHSDITKOo/N3EVJjQD2UfSc
IiRuK9pTldL7vi4LvT0/I08z3aCNB/eo3zAWFHCXXZ2In31PHOoMetRvemXK9ksq
rrMFS6rOY1TWP6ahWJuYcqk3f3oKvsLlTmGeLgj29DZU0WIrG5/l72YWdIFNd7KV
H2x0LqRcuvpeTFglaANwKaybRMiO77MFwvxvAiwwpgIZEIxO4mVdZGUWrjzd1on4
Ng+ztqMo6cfWKwkPp9kFz945Gsy0dLPzm6q8JLGy4FI8XG7kFOMUbmjRJkqXXnLU
BdDshlu+efy+MCJQRXiQNuOADiFvZ6JBuFCMG9cqe+rH4sD6tjj2q7gXfek5Loym
KWFduEyPiw6Lc4lfALfPPYMU+Ek0qlThu2XKDrXlU3/Ac7CaJ5+EW7BMpb8hq4y4
Xkt2YrjMAepLZ6w2EUe4plvsfgYPs5uqmoAguiaFnf1Rj17j/BRBwzUXqhIPuEwj
7r8Rn3/wgCux+UOzsW5e
=9kEB
-----END PGP SIGNATURE-----

--6h64vBu9tReNbGLX--

--===============1725932723653627759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1725932723653627759==--
