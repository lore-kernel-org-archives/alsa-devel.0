From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Tue, 21 Apr 2015 17:45:06 +0100
Message-ID: <20150421164506.GN22845@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <20150418111622.GD26185@sirena.org.uk>
 <CAJzqFtYBvNAgwROZ09MGanYOyyF0EXEL7W9ZF4eAhprQVquNcQ@mail.gmail.com>
 <20150420220338.GZ14892@sirena.org.uk>
 <CAJzqFtbseDe8c19ZpZjw3y72-+eO1+Zcq7D+DC=0G5_LbimRJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtbseDe8c19ZpZjw3y72-+eO1+Zcq7D+DC=0G5_LbimRJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 03:48:19PM -0700, Kevin Cernekee wrote:

> I don't understand the statement: "those are three separate supplies
> that are typically tied together."  AVDD/DVDD are 3.3v fixed but PVDD
> is 8V minimum (5711) or 4.5V minimum (5717/5719).  So AVDD/DVDD can
> never be driven by the same regulator output as PVDD.  Perhaps you
> were thinking of HPVDD/AVDD/DVDD on 5717/5719?

Yes, all the supplies.  I'd misremembered which ones you were saying
were tied together on your board.

> The simplified application diagram on page 2 does show that AVDD/DVDD
> are typically tied together, and that PVDD_* are also typically tied
> together.  But as you pointed out, there may be situations where that
> isn't the case, so that leaves us with up to 6 separate supplies on
> 5711, or 5 on 5717/5719.  The typical case is probably closer to 2 or
> 3, though.

To repeat, the typical case is *not* *relevant*.  All that matters is
the set of supplies the device has.

> > Have the driver accurately reflect the hardware, request one regulator
> > per supply.

> So, request one regulator per VDD pin?  Or group all of PVDD_* into a
> single regulator?

Please group them into supplies as documented in the datasheet.  If they
are documented as distinct things they should be distinct things, if
they are just the same supply coming in through multiple pins for power
reasons they should be one supply.

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNn6RAAoJECTWi3JdVIfQBqgH/0tlKVV/Vg0BZm9J/MQHRLmt
o6GCF3Bju4ChTlYPOn/Tj59gji6lmT8DhG3JcPyUbucuveWkORK2uPBwKXzQsLJN
y6IEPTx/pQ35RCFE9mUepiZCcCLFWfYZnUR1kmEeT0M4Qm+5UO906IaecqrVM6+Y
hikrtT3d/Zg1FGxksO8DN/B8vDByU5AoPnpJsdY7tHTpCUocRt2u3gTnRsh/hxNH
79XGvoSM+TYx1rh9+aIyJCs/UVosEIyq27oRzbOwpX6lClmW8cenX5owjAzkmlH7
595rM8EPuqSyBvyOLiLApqpaQOxxAfib6OHnrGQgOlfNcxOnQch4BdpTzBcWQCw=
=+qUs
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
