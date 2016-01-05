From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm_adsp: Add a handler for
 the compressed IRQ
Date: Tue, 5 Jan 2016 14:20:25 +0000
Message-ID: <20160105142025.GA6588@sirena.org.uk>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151223001907.GI16023@sirena.org.uk>
 <20151223095806.GY6058@localhost.localdomain>
 <20151224193137.GI579@sirena.org.uk>
 <20151229154313.GA1490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5768879474586368342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C96CF260710
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 15:20:40 +0100 (CET)
In-Reply-To: <20151229154313.GA1490@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============5768879474586368342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 29, 2015 at 03:43:13PM +0000, Charles Keepax wrote:
> On Thu, Dec 24, 2015 at 07:31:37PM +0000, Mark Brown wrote:

> > > I am somewhat torn between a comment and renaming the function. I
> > > will try to add some sort of reasonable comment.

> > This doesn't sound like it's really acknowledging an IRQ - you have
> > level triggered interrupts here so if the interrupt isn't acknowledged
> > the interrupt handler will constantly be called.

> It kinda is acking the IRQ just at the firmware level, not the
> hardware level. The physical IRQ all gets acked through regmap
> so that is all handled. This code here lets the firmware know,
> which it will then use to decide whether it should send a new IRQ
> or not.

That's not an interrupt acknowlegement, it's a request for more data.

> I could perhaps rename the function to
> wm_adsp_buffer_request_irq? and buf->irq_ack to buf->irq_count?
> That might make the usage a little more clear.

That might be a bit clearer, yes - it looks like this is a mailbox on
the DSP that you're kicking?

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi9EmAAoJECTWi3JdVIfQumkH/0oPwsbuoREH/KdQ67tOmGHc
vRV6zmI4gDFjT6y4hDHr9DGky1lodY50tGmnbLVLru5ZSaGR4y5l8C6X4WBAgKsE
92YFXccMxsY+uESKNpdJs976xoz863fpAbekDc6KLYsl3xgSjydeL5GlzF7UKm7A
gMxBIPhPrSd5yGzFitpZ6aQv3ty1edpOZSwT8YWm58G68VL836i3hRsaD9LSpekC
u5TCQFNBvBxtDZ5Ku2Xwty1elUQ3RxSIXsfGzzbSPECQatRXUuW6gcaHx9JlL/wR
CUaZdMHr3vAeNE4dx1Hc93BOSnxMbD1ebdMEhtMvh6hC/BI311yRkBXroHYi+8w=
=yN3N
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

--===============5768879474586368342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5768879474586368342==--
