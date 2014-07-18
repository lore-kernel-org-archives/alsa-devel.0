From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: Intel: sst: add power management
	handling
Date: Fri, 18 Jul 2014 18:14:01 +0100
Message-ID: <20140718171401.GR17528@sirena.org.uk>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-6-git-send-email-vinod.koul@intel.com>
 <20140718114611.GM17528@sirena.org.uk>
 <20140718142309.GF1985@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2792831062867063511=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95BEF2608E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 19:14:10 +0200 (CEST)
In-Reply-To: <20140718142309.GF1985@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2792831062867063511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bebzX59uVWocTrAI"
Content-Disposition: inline


--bebzX59uVWocTrAI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2014 at 07:53:09PM +0530, Vinod Koul wrote:
> On Fri, Jul 18, 2014 at 12:46:11PM +0100, Mark Brown wrote:

> > > +	/* Move the SST state to Reset */
> > > +	sst_set_fw_state_locked(ctx, SST_RESET);

> > > +	flush_workqueue(ctx->post_msg_wq);
> > > +	synchronize_irq(ctx->irq_num);

> > This is very strange - we're flushing the work *after* resetting the DSP
> > which suggests there might be something else trying to access the DSP
> > while it is being put into reset.  Presumably that'd be bad.

> the macro sst_set_fw_state_locked is used here :)

> And state is marked reset, we dont do HW reset, so this is okay. After we return the
> suspend handler, PCI will put the device to D3.

It's still setting off alarm bells from a code review point of view -
having the DSP marked as in reset may well break something that some of
the other activity that's going on is doing.

> > > +static int intel_sst_suspend(struct device *dev)
> > > +{
> > > +
> > > +	return intel_sst_runtime_suspend(dev);
> > > +}

> > You currently need to check that the device isn't runtime suspended
> > before you try to reuse runtime PM ops in suspend.

> Sorry didnt quite get why?

The driver should be restoring the device to the state it was in prior
to suspend, and not repeating work that's already been done.

--bebzX59uVWocTrAI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyVXWAAoJELSic+t+oim9gIgQAJRQ9yCc71ASdiP6Yg+pcQXY
nqN3QZZwiSDkzOiUur2ajr3HSgUw25DxCX6qXnjTUareT4czgDIDHZCEFC48rd2O
2ml4wJ5yHBp9ilhv+xyhR4lANMHhPgoa+EtXDlvgDW3gAI8VOqIWHnw0utT+lJ7C
eMr45XVLWvlJgF8r3CMgQd593Auegq4P+va8FYg6716sIU0AphGwKyfmNA65aab6
VXgus7VJxaXjjRmgRd3OCfEng8olOPLGJF5rdiF5ShSyHqL4PAIesMpdlPy7fFIh
IcuOknH/qF0dZN4zSOXNFT2ixOAHnzROh3dtPm9Y/w6a3GUfpjqRp8pe42NNGtle
4QMAHFl6WeFNpO44RDHAye1yPGhAHZEUrGuOZKP7aUUjUBOtQPC+YcF8ztLTGJ+n
ylsU0L4q7Y7bW4ZVPv/cXQWxoGXNSdGewUGU9JpEOZc0nHw6l2khDlvD7U3x/5D4
bLGBeURFkUTdhrhoaEdtCO9R9Z7NlnTyO5cMQ5hW/WaI/T91zqlF7NeIiprvuDLy
1P6FCvHKOU009xwmnhfcqTt7Gmo53Ddo5nFZcOyk5ZDQ07iaJ7a2FFjGX5VoOwpl
+FZDIF79KxQ+lLbS9aOb4atbpCX+3IAinMYaLT0gM2GFE7WRr1x6Z2SL1/nPOWW+
T8D6DUiz6w+YSRcdmlK7
=uJWV
-----END PGP SIGNATURE-----

--bebzX59uVWocTrAI--

--===============2792831062867063511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2792831062867063511==--
