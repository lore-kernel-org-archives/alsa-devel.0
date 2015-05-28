From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Dump DSP_SCRATCH1 on DSP shutdown
Date: Thu, 28 May 2015 20:23:35 +0100
Message-ID: <20150528192335.GD21577@sirena.org.uk>
References: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150528135751.GV21577@sirena.org.uk>
 <20150528142431.GA19558@opensource.wolfsonmicro.com>
 <20150528143724.GY21577@sirena.org.uk>
 <20150528161313.GB19558@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6KchevI7DAOLL/Ks"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150528161313.GB19558@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6KchevI7DAOLL/Ks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 05:13:13PM +0100, Richard Fitzgerald wrote:
> On Thu, May 28, 2015 at 03:37:24PM +0100, Mark Brown wrote:

> > The default is that dev_dbg() is available in dmesg but not on the
> > console which usually seems like a reasonable balance for this sort of
> > thing - it's there if people want it but not included in the default
> > logging.

> What you're describing seems to be the default for dev_info().
> For me I don't get any dev_dbg() output in the dmesg log unless the source
> file has a #define DEBUG at the top.

Interesting...  the dev_dbg default appears to have been changed at some
point, possibly with the addition of dynamic debug (which I tend to have
on in my configurations and is common for distros and so on).  The info
default is overridden by a lot of distros.  In any case, it's still the
way we generally do debug - doing this on every DSP stop does seem quite
chatty from a system point of view (and yes, some of the existing
logging in the driver does seem a bit enthusiastic here too in
retrospect, IIRC at the time request_firmware() was chatty too but that
has been fixed).

Users will typically have the option to get this via ftrace as well (we
have trace points for register read), and you might also want to
consider the option of exporting the value via a sysfs file so people
can grab the latest value whenever they like.

--6KchevI7DAOLL/Ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZ2s2AAoJECTWi3JdVIfQkoYH/A95ztJTbS8GVPOSLrW8HCfQ
rigChVehhG56OfjJrulUv+EpwLYvgaGNaSm3ImTzkleA4dFc2Vlwchh3zrjufMdD
X1bJ/opWfObQC09hSXkHnltzaTndNs4r10Fx39uAW9DLtwOvoR5ctw0lb3QG/ZVO
cU1oeMSLYRWpVJUqSwPCOCcjGeiavutk6UbMFXlxiJv+CmZIJF7sN4k4i5mbMSns
PXadhDpvKeZ3/I2ibEuNw1VEaOZ6fGPhe/HNOdEyXJX/htg2TNNW+eS6eEgc0+hV
3cKZ7uyRDXzbc2px/YqrfVhFRK4M2J1KnDnS0jIUwiFUO0FWTN7HJxm+xicQO90=
=AEB7
-----END PGP SIGNATURE-----

--6KchevI7DAOLL/Ks--
