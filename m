From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 11:37:42 +0000
Message-ID: <20171115113742.27b2nvfsbtvv7gfs@sirena.org.uk>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5844778915621529453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E6730266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 12:37:55 +0100 (CET)
In-Reply-To: <s5hmv3oatce.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============5844778915621529453==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="utuvffa5eas4pbsx"
Content-Disposition: inline


--utuvffa5eas4pbsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 08:34:09AM +0100, Takashi Iwai wrote:

> And I believe there are a few more possible cleanups / fixes in the
> messy Intel ASoC Kconfigs.  For example, SND_SOC_INTEL_SST is almost
> always set.  The only exception is via SND_SST_ATOM_HIFI2_PLATFORM.
> But all machine drivers using Atom Hifi2 do set SND_SST_IPC_ACPI,
> which also requires SND_SOC_INTEL_SST.

I'm not 100% convinced that the recent changes away from just having the
only user selectable options be the board ones have really helped that
much.  Though transitioning back would probably just create more misery.
It's a real shame that ACPI doesn't have standards for the machine
descriptions here like DT does, it'd cut down on the amount of stuff
that needs configuring.

--utuvffa5eas4pbsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMJwUACgkQJNaLcl1U
h9C+Gwf/XSNv9M9VGZPI0s1BeIwBmc8xoFtdwuPi7CpxvGA2rPE7HbTLmytpP+2g
gX4PpwXK16kOSPqhdHjyZBm1gzMZLKrRYJAbDWp0xM688QELD6zhnXQptW5OPXXE
PwGNT1u8Knxs9Qf4MGuNpQqSgExLQKLMyZpUFN0WkoLlQmLsViK9JjYfAN7D2mbr
CLtI+tTxKrSJsarvws4EQVhk3twL3yW6QTLRu9HG5G7QFYC21LquEOaLJe/sICFM
X6KyzoHh8ii7BXr2FlpIrYgrAuSO5Xfws9QG5RLv4ioAbZ4UjUONzFX510jIULnD
0CKxtiQWSst+Mdwn0UVB3N2VrUZxKA==
=Gzmn
-----END PGP SIGNATURE-----

--utuvffa5eas4pbsx--

--===============5844778915621529453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5844778915621529453==--
