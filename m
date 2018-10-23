From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:for-4.20 333/424]
 sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration of
 function 'pci_iomap'; did you mean 'pcim_iomap'?
Date: Tue, 23 Oct 2018 11:00:49 +0100
Message-ID: <20181023100049.GK2103@sirena.org.uk>
References: <201809111307.iuux6Toj%fengguang.wu@intel.com>
 <s5h4lew34fv.wl-tiwai@suse.de>
 <20180912113128.GF6062@sirena.org.uk>
 <s5hworq6i2m.wl-tiwai@suse.de>
 <20180912120422.GG6062@sirena.org.uk>
 <f9c55e50-234f-7b89-cbfa-89606b52f570@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8653049544366733134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BC68A26770D
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 12:00:56 +0200 (CEST)
In-Reply-To: <f9c55e50-234f-7b89-cbfa-89606b52f570@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============8653049544366733134==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxRQSzdsN/lOP445"
Content-Disposition: inline


--dxRQSzdsN/lOP445
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 22, 2018 at 12:44:21PM -0500, Pierre-Louis Bossart wrote:
> On 9/12/18 7:04 AM, Mark Brown wrote:

> > > I don't think arch/sh/include/asm/io.h includes the necessary thing.

> > I'm just about to submit a patch which makes it the (or at least a)
> > necessary thing.  This stuff shouldn't be complicated or inconsistent.

> Mark, did you submit the patch you mentioned? I can reproduce the issue with
> the latest code so something is still missing - or I didn't find it. Thanks!

Yes, the SH maintainers didn't acknowledge the patch in any way yet.

--dxRQSzdsN/lOP445
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvO8VAACgkQJNaLcl1U
h9CVBgf/Xay6brifnPj0HLdygIxRlSiuOBcijQZ4q9shARV9j8fb+b5H57xa/SaB
Wair3m+X8ajSzy3k37BvCQ/ZwZ5YtJnjhJKv7GNu0L6KTBEbOyNMwCLfmXDx/Se2
+ZeapzvFR8sB2bOCkqdi7aHAhFso191r983dEfbvAn5LDeOmqvubK701XT3zfrCE
TaJJbyzUKQp+UJGnjnT6qptrY+vfz9BAsJVdwsf5drJj/Im316NZx3GXumn0RRgu
6R7p4NxVBqZc6zbOJQe5Q1HbxxYPYKUHy7n9QtoMAJs6uFZWPP4dHkcA8ajN2SNi
niUEq3dzLxKk3Pe/sKjaHt5mbGuEQg==
=cY4W
-----END PGP SIGNATURE-----

--dxRQSzdsN/lOP445--

--===============8653049544366733134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8653049544366733134==--
