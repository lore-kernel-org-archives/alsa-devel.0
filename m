From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/6] ASoC: Intel: mrfld - create
 separate module for pci part
Date: Thu, 6 Nov 2014 12:36:41 +0000
Message-ID: <20141106123641.GZ8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8509480446671664146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 877732651FC
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:36:52 +0100 (CET)
In-Reply-To: <1415098520-14113-3-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8509480446671664146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NJ3GtppTlf/130kA"
Content-Disposition: inline


--NJ3GtppTlf/130kA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:25:16PM +0530, Vinod Koul wrote:
> Now the SST_IPC will support both ACPI and PCI, separate into core module
> and PCI module. This also move probe function into PCI module and exports
> the required symbols from core module

Applied, thanks.

--NJ3GtppTlf/130kA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW2tZAAoJECTWi3JdVIfQQr4H/02adURGCk6ZQrXXwfdxaSMY
nVeqcLmN37cVgm3CrwfWbTrd6g1VGOj8kWSHfro2t/ziitEsH6ACFMB8Dma6tkmQ
9wzhM4ES7IKYof1kGHcjN3eDeJAsX5+MhWQ/0UeJ7GePvZn7nYarC+i+gNWqaNbF
pKWexTyQFO6SyGuGzEwvAh+4PGiES4+p8qA+NpdJrcBWPXcpKjvOtiienqLJdF6N
L4MU8hJrLwGCNxrIkQwWcMp/SWjBHfRpKihiTR/quYM6EtBs5vMTt6WHLFBgyXG9
kpciVtBaOZBOB+d4yoS3hVrmDNdfoeoJx9xKSQdI5/Oz07Fk9745aU5nyozDKiM=
=gOnO
-----END PGP SIGNATURE-----

--NJ3GtppTlf/130kA--

--===============8509480446671664146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8509480446671664146==--
