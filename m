From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_new_dai
Date: Thu, 21 Mar 2019 14:09:48 +0000
Message-ID: <20190321140948.GD5684@sirena.org.uk>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
 <20190321123156.GB5684@sirena.org.uk>
 <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2019 at 08:59:55AM -0500, Pierre-Louis Bossart wrote:
> On 3/21/19 7:31 AM, Mark Brown wrote:
> > On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:

> > This is very non-obvious - it's not at all clear why we'd need the text
> > to free controls.  If there is an issue here it seems like it'd be
> > better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
> > being NULL, that will be clearer and also avoid potential issues with
> > other callers.

> I believe the issue is real, but you need to look at the entire code to figure it out

Yeah, I'm fairly sure there's an actual issue here - it's just that the
fix is obscure and feels fragile.

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTmysACgkQJNaLcl1U
h9C+eQf7Bnc/qA2kIaN+pwHVUzmOvzF4woWYt1c8PNct6q6whX8CI++mtMcTFLp6
OihVNA9Y81AS9mM4v/UFOeR8DT66/8X6N3gpo8x9UCrzDjPT4fa/6RdxEJOt9njX
05SU+q1FLg3K4+cjq0e9chDN0WpWRbgKQKJnlvmyaSRA/T6MDbYiMq9Okm8KXg+Q
8sub2DQnSz3NNfUOTftQ90TqAibcTEvvGbx78XPZCMBYtC6MncpMXboh8ctvWUyw
zcNsn+ZAP9+CSHZnX7lPWJke+b92wZfZGQeIsbQocFsicGQDreY43zW13y7CBxw9
d6bDevREUeUMWbYiH6HxTjsiogcpJw==
=C3gk
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
