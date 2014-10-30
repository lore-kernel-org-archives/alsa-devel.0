From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/9] ASoC: Intel: move PCI probe to a
 seprate	file
Date: Thu, 30 Oct 2014 16:28:29 +0000
Message-ID: <20141030162828.GA18557@sirena.org.uk>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
 <1414666312-4657-8-git-send-email-vinod.koul@intel.com>
 <s5hmw8d4n1c.wl-tiwai@suse.de> <20141030143444.GA28745@intel.com>
 <s5hh9yl4lyq.wl-tiwai@suse.de> <20141030153719.GE28745@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7509446423656952166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EC2326059A
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 17:28:57 +0100 (CET)
In-Reply-To: <20141030153719.GE28745@intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7509446423656952166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8zEuvTefQLoMiHqU"
Content-Disposition: inline


--8zEuvTefQLoMiHqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 09:07:19PM +0530, Vinod Koul wrote:

> Hmmm, that makes me wonder why cant we do (based on your input above)

> snd-intel-sst-y := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o

> then either this:
> snd-intel-sst-$(CONFIG_SND_SST_IPC_PCI) += sst_pci.o
> snd-intel-sst-$(CONFIG_SND_SST_IPC_ACPI) += sst_acpi.o

> Or:
> snd-intel-sst-pci-y += snd-intel-sst.o sst_pci.o
> snd-intel-sst-acpi-y += snd-intel-sst.o sst_acpi.o

> And the machine will select required ones..

That's what I would expect to see.

--8zEuvTefQLoMiHqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUmcsAAoJECTWi3JdVIfQ7EsIAIVWwciG+dItw+tsJIIDRhh1
U/eW0TNiIlYoN02l+7h75dbxrOCI1BTSc5peX0VOKt2GJvV2QopoPNIkMrDLyphz
PF9RQXIm+r+iGzUtuS+mb394OqNVKQOUC60AoSaVsXTweVuKNC3RSPXJ92yFlLrO
clENMFCcbVme8tDU4gOQu63r2lN1H9/wrgWhIEkOBiXAJh9zjk49xcf/IbJkYxeq
uewfnucip8BxKLY5WH2jwLCUE6KnCzxxOwcuyn+81KMPnYlMCfYiyZ4PGuih1FQ8
IKu2oisvqOWDy+j32sqN24IWIJ1GCB+YPWobJfxRf7922A88GFGVlTW0mMF+A/s=
=u7AQ
-----END PGP SIGNATURE-----

--8zEuvTefQLoMiHqU--

--===============7509446423656952166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7509446423656952166==--
