From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 11:18:51 +0100
Message-ID: <20120723101851.GG4435@opensource.wolfsonmicro.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1870352498605684716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1DB026523D
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:18:50 +0200 (CEST)
In-Reply-To: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
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


--===============1870352498605684716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 03:36:37PM +0530, Vinod Koul wrote:

> In many modern SoCs the audio DSP can buffer the PCM ring buffer data. Today we

This isn't particularly new, we've had SRAM buffers in SoCs for ages.

> have no means to represent this buffering and ALSA wrongly detects an overrun
> when hw_ptr reaches app_ptr value, though DSP may still have some buffered data.

It's not immediately clear to me that we shouldn't be flagging an
overrun here - obviously if there's just a pure delay introduced by the
DSP then we will underrun if we catch up with the input, it's just that
there will be a delay in the user hearing it.  It seems like the thing
we need to say here is more that the DSP or DMA knows where the
application pointer is and can halt the DMA when it underruns, together
with the fact that we have some buffering beyond the application visible
DMA which means that an underrun isn't (yet) a user audible problem.
We'd also want some other way of saying that that these further buffers
did overrun.

> This patch tries to add a new field "soc_delay" to represent buffering done in
> DSPs. This value is also used for the xrun calculations in ALSA.

soc_delay seems like a very unclear name for this.

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDSUFAAoJEBus8iNuMP3dPEEP/14jef3qEN/bHuoMUaAIRUi9
VtNQ17r0ObWR25xUSXBBXLa0xTgbG3DRAi19iXf3lJekCEFT/X38j8JKvSF86QZy
Ps5rWDH08MW+mWkJZfMvQEOVYrX/yR4ccuNBFX4XpZ2d9RK6yYEyHRz+kex18JnS
WjOR6VJmmBSu/XRxR3o+h4aMRToRw5MVjubN4wYofmnowQPDjjSQXdvmQvu2Oh+K
pd6s4QTciJOcraW8AJOFgl4ach1Y4FmMDUzqq55NjAxt07TZHoKz3PprCT9m7zyK
O4ONJl8N4ZYMPD0e08xotSlz+3AE5Y8G2o/kazKQeTZRJ45XpxdVKeK4wE2fUgn5
oooibfo7tS0FAU2KyG8UqXoW8ILTcdiR5IWtCGb83VCKZfXoPiiEN6nrPR4+m0Mj
TSBOaCPqQDv1Sp5i6VS+jQNzFIoJK3lni1EOHTTTa8GUVjyn7XzLaDj/F6eXx0u6
29QLZarMmqzknA7zR7puxtK4Xwek2pmwUIefUsGLLy6ZyX2OA25i4h5M4KaNMEJk
asK3glKRSR3Kv9XBASkoLFLFBfo4ZwelL20uVNZosBIfV9syb/pIQSEL1mqfI607
3BEQLnM4qFknBTWPnxG/xtcv/Z1I9B7qGjP8KradzqEB4LUKwO3YcJAiyZJ8uJ0M
OQO7Y5nHDrvvQ+6tbGeX
=dYH8
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--

--===============1870352498605684716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1870352498605684716==--
