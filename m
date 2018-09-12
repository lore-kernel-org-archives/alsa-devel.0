From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:for-4.20 333/424]
 sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration of
 function 'pci_iomap'; did you mean 'pcim_iomap'?
Date: Wed, 12 Sep 2018 12:31:28 +0100
Message-ID: <20180912113128.GF6062@sirena.org.uk>
References: <201809111307.iuux6Toj%fengguang.wu@intel.com>
 <s5h4lew34fv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2521092019730626614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A24C42673F4
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 13:31:33 +0200 (CEST)
In-Reply-To: <s5h4lew34fv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============2521092019730626614==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2018 at 08:59:16AM +0200, Takashi Iwai wrote:

> Hrm, the header file inclusion of pci_iomap() looks fairly
> inconsistent over architectures.  SH doesn't include asm/pci_iomap.h
> from asm/io.h.  And x86 includes it from linux/io-mapping.h.

> As a quick fix, we can just include <asm/pci_iomap.h> from
> patch_ca0132.c, I suppose.

Not on x86 we can't, it's not there - asm/io.h seems safest AFAICT,
everyone has it and both SH and x86 include the pci_iomap.h.

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluY+Q8ACgkQJNaLcl1U
h9DCxwf+M/hx33LFftulIOc/wTXKURZmyFCZBtl+T/5vLqRWyjVQ8Uy+3zYYo3VR
M3j11Ya22CBetEqVwbd2DdaCp18XS1H8lzPDBGn357x0WZDC1anLzSxAGRakLQcs
yrMLSIwSM4JhDptIdI5IQgZahyEBkiWbB9xamlEJOvf3UEm+RfCtDF97t+G32oHd
bhoJkAOSVoUc6FsTtc18dkjbhSx5QMUQ+PzVNPDb8RPNVD5zlxfWfvOthhOA1i8m
hQ3u1esp0DqCfv0ODt3i7jwZAw6+lnpgngXuNK6A9y95A9G1yWoPP3rljc1JWq1K
k6DQd/Vfs1qLfpj10DLqtM1gYqMxKQ==
=+XjM
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--

--===============2521092019730626614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2521092019730626614==--
