From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 4/7] ASoC: Intel: sst: Add IPC handling
Date: Fri, 17 Oct 2014 17:25:24 +0530
Message-ID: <20141017115524.GS1638@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-5-git-send-email-vinod.koul@intel.com>
 <20141017120918.GH1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5223806935103490722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D6CD926063B
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:31:41 +0200 (CEST)
In-Reply-To: <20141017120918.GH1820@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5223806935103490722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mzmkN2k+aDjaU9Rr"
Content-Disposition: inline


--mzmkN2k+aDjaU9Rr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 02:09:18PM +0200, Mark Brown wrote:
> On Thu, Oct 16, 2014 at 08:00:16PM +0530, Vinod Koul wrote:
>=20
> > +	spin_unlock_bh(&ctx->block_lock);
> > +	dev_dbg(ctx->dev,
> > +		"Block not found or a response received for a short msg for ipc %d, =
drv_id %d\n",
> > +		ipc, drv_id);
> > +	return -EINVAL;
>=20
> Shouldn't this be a dev_err() or something?
Not really.

We get response from FW which cna be short or long. In former there wont be
anyone waiting as all blocked ones are large.
We cant distiguish between the two thats why we log debug message here. If
its real then finally the message will timeout and we would see that as
error. Yes this is limiation in IPC.
Putting this as err makes log very noisy :(

--=20
~Vinod

--mzmkN2k+aDjaU9Rr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUQQOsAAoJEHwUBw8lI4NHQiIQAIXDTdm1DM96KDueC/Fwj6s5
G2iTl+j/cnC2UHkrSlW13CeIEhwoAz5eoSq7TOJbPpjt0JlhC15bgHPanmNqjo/e
hKYwaBrpVZb+IRQuuSztKDyoQUbPwNnabQ1CMLYPlO8NDiPrX9hrI0CBlGtFZkuH
nUl1U1xd0kHmDUB772RNB4xQiR1vTXf5neNq7CSdymBlAdJlQEjIp0gI8sBHw9fL
HQun4MZhw7cph8OU3oz/AMflbqSeOdYf6BJzYu6on6q8zJLEl11q1nMpl6igH+DU
vfeVFs/lTyQf345JmGcqvJ5UL493US5WEDBdl4vEuZACB2iPtms4HlFRIMqBU82N
QvOa4/+1i3iGF5wayZ6jYPutwXnipi3vpd4jr7v5+P5wCdb3MSGXYswgkuAojTLe
vuvi7ogEE9gpK5l0DVQbPQhfwYlWu8CxY/wIFjxHm+Zbd0VM/6dv8vVYc8yDjTIq
svest3GgPmOkQHWGQLCdfIMoZ+Wi8uBn2IsorR58rmzabHWh7IbCX8lnQrQW3GS2
mZsSW/YGDsSaGsKyVXqUXogUE6G6ToLQkH3qXnLNTCQaAEXsw5ghzQ4kyrAzKkB7
qIH/od2kQQMXrGjoga5yrPJW7MaV5oB8jG1B6hN/6n4g/RmEYVzTH8UWLnQGnqnS
qrxJRigwW7BK7ZlMKuPL
=rp12
-----END PGP SIGNATURE-----

--mzmkN2k+aDjaU9Rr--

--===============5223806935103490722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5223806935103490722==--
