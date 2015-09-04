From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH (alsa-lib)] pcm: Modify check condition
 in snd_pcm_sw_params_set_avail_min
Date: Fri, 4 Sep 2015 16:15:29 +0100
Message-ID: <20150904151529.GM5313@sirena.org.uk>
References: <1441250454-38271-1-git-send-email-koro.chen@mediatek.com>
 <s5hfv2wvv35.wl-tiwai@suse.de>
 <1441266346.32609.18.camel@mtksdaap41>
 <20150903093810.GE5313@sirena.org.uk>
 <1441334975.32609.30.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6024732592107240175=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8525F260484
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2015 17:15:40 +0200 (CEST)
In-Reply-To: <1441334975.32609.30.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, lgirdwood@gmail.com, srv_heupstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============6024732592107240175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7H0CdmT9ysYyfjsg"
Content-Disposition: inline


--7H0CdmT9ysYyfjsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 10:49:35AM +0800, Koro Chen wrote:
> On Thu, 2015-09-03 at 10:38 +0100, Mark Brown wrote:

> > This does sound like something that should be handled in the kernel -
> > one thing we should be doing is providing a uniform interface to
> > userspace.

> Hmm, I thought those param settings are used to handle different HW
> behavior like my case, but maybe I am wrong. It is more important to let
> a single driver to be used under many different cases. I will find
> solution in my driver, thank you!

Yes, the params do generally handle things that differ between systems
(mostly things like buffer sizes, formats and so on) but there's a few
things that are pretty much required, one of them being delivering the
period elapsed notifiations when a period has actually elapsed rather
than before then.  Setting a very small period size will tend to mask
problems but it's not great.

--7H0CdmT9ysYyfjsg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6bWQAAoJECTWi3JdVIfQgkwH/2SWnPJ26U/oBwX0faTWShm9
eMujy82WA/XsSqXXZ4ec96ntA5Ds/MKOTlPTC2dua6pcBC98khBRgCzEmbX64co+
ZQWeQuOfBfF+pb/jdgoXYR3A3hIuogDbJk49fVV1FGWWFe4Wzh+pzoFLlj7SzW8K
vsoK29NIvhMJnBH2Glucbbtlk+yVaIX2ACPM3xbETf3CekAVE2mpJM3TAdNuUvFv
2bv+3jsXGt3YShbs+0Tnj8s13pdFzgVQ5H6V5lzOvnbClfnKTQf5CYNgLdscvYr3
qoebyNVfS2hVdUOpNHlt5p0CbDjFKmYprnB+P0r5EXL3O6/Hr6XDZN0y/0cxbeU=
=I8tv
-----END PGP SIGNATURE-----

--7H0CdmT9ysYyfjsg--

--===============6024732592107240175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6024732592107240175==--
