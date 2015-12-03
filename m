From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/16] ASoC: Intel: Skylake: Add support
 for Load/Unload IPCs
Date: Thu, 3 Dec 2015 00:59:14 +0000
Message-ID: <20151203005914.GA5727@sirena.org.uk>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-7-git-send-email-vinod.koul@intel.com>
 <20151201225854.GZ1929@sirena.org.uk>
 <20151202050702.GD1854@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0444998981847050662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BBB9B26510C
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 01:59:21 +0100 (CET)
In-Reply-To: <20151202050702.GD1854@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0444998981847050662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 10:37:02AM +0530, Vinod Koul wrote:
> On Tue, Dec 01, 2015 at 10:58:54PM +0000, Mark Brown wrote:

> > So the multiple modules are a block of at most 255 16 bit words?  That's
> > a bit surprising - is it really a count of the number of modules or
> > rather the size of the block of data that's being squirted at the DSP?

> Nope, as you would think that does not make sense :)

> So we do not point to module memory here, we are sending IPC saying module
> X, Y and Z are being loaded, data contains the module IDs only. The IDs are
> 16 bits so sizeof(u16) and number of modules pass as arg

> The modules are transfered with Code Loader DMA which invokes this as IPC
> after preparing DMA from Host.

> This way IPC allows us to load One or multiple modules at one shot

Can you please at least put this in the same patch as the user if not
merge it more closely?  This is another of those abstractions that's
really unclear just sitting by itself with no explanation.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWX5PhAAoJECTWi3JdVIfQbXcH/jsgMlY9fCDTckMoVCBkVqWL
aUTmHhdJr86rX5gDlEux9ssYccVxEyjfbvaXKcHBPEEn6KoFvvI/C9NCRGXJZwlw
wC7Tk+AFHQKhhXqT4jSlyG+bRTZrfA9Cb69O2sv/2w2vdKh3AbxDVlMsFHZuW7z4
AvptIz1nJWXRV3R/xXlkDAk14ehTTVASA2nF1TmdHm8VMNm6YsTxnDeOnh3hQY5r
IYXAm+XHu9cHSGNItgd9rKQMTR7OuQ/VzSEdtYzNyrriSYKDChglc/j1xCoF0vN3
E+U6sz549hT2mlAZu8vru34TvZ4WZkOMiUgmsaj4OXSKOL/snntOqo004Vb+3ng=
=ObPu
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--===============0444998981847050662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0444998981847050662==--
