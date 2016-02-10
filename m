From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 01/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Wed, 10 Feb 2016 07:23:28 +0000
Message-ID: <20160210072328.GP13270@sirena.org.uk>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
 <1454161428-7896-2-git-send-email-subhransu.s.prusty@intel.com>
 <20160209194206.GO13270@sirena.org.uk>
 <20160210043358.GS19598@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6542381715914054145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DC1260603
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 08:23:36 +0100 (CET)
In-Reply-To: <20160210043358.GS19598@localhost>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6542381715914054145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PdAWLd+WEPmMbsbx"
Content-Disposition: inline


--PdAWLd+WEPmMbsbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2016 at 10:03:58AM +0530, Vinod Koul wrote:
> On Tue, Feb 09, 2016 at 07:42:06PM +0000, Mark Brown wrote:
> > On Sat, Jan 30, 2016 at 07:13:35PM +0530, Subhransu S. Prusty wrote:

> > > +	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
> > > +
> > > +		dev_info(&edev->hdac.dev, "%s: disconnect for pin %d\n",
> > > +						__func__, pin->nid);
> > > +		goto put_hdac_device;

> > Will this get noisy?

> Not really, we print when we get the hotplug notification. Usually that wont
> happen too often unless someone is moneky testing :)

That sounds like it might get old very quickly, we presumably already
have the graphics stack doing the same thing.

> > > +
> > > +			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
> > > +					pin->eld.eld_buffer, pin->eld.eld_size);

> > ELD is an acronym, please write it properly (there's some other examples
> > in the patch).

> ELD is quite often used acronym in HDMI world, It is already there in
> drivers (did a quick grep :)

I know it's widely used, I'm saying you should write it properly.

> > > +		} else {
> > > +			dev_err(&edev->hdac.dev, "ELD invalid\n");
> > > +			pin->eld.monitor_present = false;
> > > +			pin->eld.eld_valid = false;
> > > +		}

> > Is it really invalid or did we fail to read it?  There's a difference as
> > far as debugging is concerned (one means there's an I/O problem, the
> > other means that the display is reporting nonsense).  Perhaps this
> > should be silent and let the read function be more specific?

> There is no way to know if this was IO or garbage from display. So we just
> throw up error and retry few times.

It seems implausible that there is no way of identifying I/O errors, and
even if that is the case the point about the message not being terribly
helpful still stands - moving the reporting to the point where we decide
there is an error would be a lot more helpful.

--PdAWLd+WEPmMbsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuuVnAAoJECTWi3JdVIfQhRIH/0c1UXVuJ3UpJaMCbmizl+tx
/rc0yKTnBN9rijEDVQeNRkYaNVe1e4LiDdmQd3gHksVyVJSiLwadH+L77NQ+HSnD
JsJXqgFwNjinTZlHYRm78fFIiFjrcHgyCgnAKworsYhRxPe7DKOk4jbm1Z7T9+br
Jek5BMQBxQgjVU2WGRPHybEbZphcjiAk+fv40Zt9578iBLrGgIV25kXtRFHFNlGT
BJ9RZ8Fq9tXsqQRLtKpo25Tc/Yuey6BwPeJBRqQZCvdmFti/phJFkIMkUolUKlpF
Toxmiw1R1olpZIxDikOartXQU6jsAuNL3NYtjHPaeahYomfptLJnJTH6WVzJuew=
=VPoI
-----END PGP SIGNATURE-----

--PdAWLd+WEPmMbsbx--

--===============6542381715914054145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6542381715914054145==--
