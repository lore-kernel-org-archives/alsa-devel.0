From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 01/11] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Mon, 1 Sep 2014 12:15:58 +0100
Message-ID: <20140901111557.GR29327@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-2-git-send-email-subhransu.s.prusty@intel.com>
 <20140827194021.GT17528@sirena.org.uk>
 <20140901103751.GA12898@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4615769251215932144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94653261B23
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 13:16:17 +0200 (CEST)
In-Reply-To: <20140901103751.GA12898@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4615769251215932144==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fV3mxwFPWhsKHyX"
Content-Disposition: inline


--2fV3mxwFPWhsKHyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 04:07:55PM +0530, Subhransu S. Prusty wrote:
> On Wed, Aug 27, 2014 at 08:40:21PM +0100, Mark Brown wrote:
> > On Thu, Aug 21, 2014 at 06:20:40PM +0530, Subhransu S. Prusty wrote:

> > > +static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx)
> > > +{
> > > +	unsigned int local;
> > > +
> > > +	spin_lock(&sst_drv_ctx->block_lock);
> > > +	sst_drv_ctx->pvt_id++;
> > > +	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
> > > +		sst_drv_ctx->pvt_id = 1;
> > > +	local = sst_drv_ctx->pvt_id;
> > > +	spin_unlock(&sst_drv_ctx->block_lock);
> > > +	return local;
> > > +}

> > The comments about overflow continue to apply here.

> Vinod has already replied to you regarding this, below is a snippet from
> the conversation earlier. Is there anything else we need to address?

Yes, and as I said I just don't buy that argument.  It's code that has
fairly clear problems on inspection, saying "we've not hit the problem
yet" isn't particularly persuasive.  Something like a new firmware could
easily trigger problems.

--2fV3mxwFPWhsKHyX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBFVqAAoJELSic+t+oim9xmgQAJwLw0UDbvix1JiSCEoMbHEQ
6yaLZsjc/bjjU+pmDCA7Da9ttHwVqUR4c/0Hw64+zTEVnZcFQuySm25lzQGqOEFh
/SMPO8YIbvdwE6PNXm5WNC6ts85Fe8y5Ushg5tKXQ9N1mdlBsCBgdZ2tAlG9SU4A
+hd/Qv0ETIJ8mIa/nZ1edC/7B5LH+6Jm43PxyDbKnfqZj2ZoclbnPBwWTEQ3VK5m
02uUiePtj+W50cw+baKzXXu7mxwnpfM2h43KtDXjpiMXa5jJtZIN9jxKbt97zZ/+
YdPitnWhr8UcgQsCdsKrrqQe3tGCSoDbnsMwve1eWtaxsFimTBC/ca0icUYhTjNW
4UqJv72TnZzEr6ZjQHR8/iC1mA38qeOjBbc4dAmxs8WtFwSblhxjfVBkAX06Arv+
SgXZmNuWRliax5pmIPeUOhJ/XHmPNGuYwsdDVbHLEF/2OCInV3ozcwRPn0HHkySc
N6PffALYiqf/tayBM+mkLUtvmIhtVGzGTJEw8idgp83gruJks7GmZLpLEJilijtv
rrYiHBUacb5Cdvm6OXc2CcUlNj6AK/D4qEvK+IF48WHhED/9QcvCG1ifZ7sIB1KB
U6Zmo4qTXmFQzd/y2S4/ELhh3rDeUuKH74rKXJZLVknXQr+9zeHTintdc3mjW14K
LLWKVv4VS5II9nEXczg8
=9ygt
-----END PGP SIGNATURE-----

--2fV3mxwFPWhsKHyX--

--===============4615769251215932144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4615769251215932144==--
