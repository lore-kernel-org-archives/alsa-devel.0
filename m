From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm_adsp: Add a handler for
 the compressed IRQ
Date: Thu, 24 Dec 2015 19:31:37 +0000
Message-ID: <20151224193137.GI579@sirena.org.uk>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151223001907.GI16023@sirena.org.uk>
 <20151223095806.GY6058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1469671280620795247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F414260686
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 20:31:55 +0100 (CET)
In-Reply-To: <20151223095806.GY6058@localhost.localdomain>
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


--===============1469671280620795247==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 09:58:06AM +0000, Charles Keepax wrote:
> On Wed, Dec 23, 2015 at 12:19:07AM +0000, Mark Brown wrote:
> > On Tue, Dec 15, 2015 at 11:29:48AM +0000, Charles Keepax wrote:

> > > +static int wm_adsp_buffer_ack_irq(struct wm_adsp_compr_buf *buf)
> > > +{
> > > +	if (buf->irq_ack & 0x01)

> > This is confusing, this isn't actually in the interrupt path...

> Acking the last IRQ basically tells the firmware that it is free
> to send another. There is no point in doing so until we have
> to wait for data. As we are just actively streaming available
> data we can progress along fine without enabling the IRQ.

> I am somewhat torn between a comment and renaming the function. I
> will try to add some sort of reasonable comment.

This doesn't sound like it's really acknowledging an IRQ - you have
level triggered interrupts here so if the interrupt isn't acknowledged
the interrupt handler will constantly be called.

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWfEgXAAoJECTWi3JdVIfQWxsH/i9FKzdvZsQeOIXzkaRccRg6
PCBCW+LgZoiXioTq/g3kMwNa5Si5VploWQYc8XR3AWWSFMVVXvjuNPbwsruhYTHO
KumWTevosIPoH+T93NdY6FhdS1cEM29oV+EE6efGnDO2lTvglgMEdZwB5iD/NKAR
OM3RoyKpN3ADQMVcRY4xulX1hCltIT1E7GTAZ7sN2DZM+qfoMJzxG7b8oKPMVoCl
pvYIlqqxgH9GNYsEEx5oDoN8nbRWmt+zB8TdSOR/WKEJ4ALEp1oAesZRZtHtIvqr
UrqRAS66s1EnQxxrWVAZlUXXycHz7217R4xQVn6ALJPT1usWULIstKUzc/T87yI=
=oCpS
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--

--===============1469671280620795247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1469671280620795247==--
