From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/8] ASoC: topology: ABI - Add flags to
	PCM
Date: Thu, 6 Oct 2016 16:44:19 +0200
Message-ID: <20161006144419.z6ntryxtrxpwsqad@sirena.org.uk>
References: <cover.1475127338.git.mengdong.lin@linux.intel.com>
 <7e8185f7a2eb642b52efe0de1369354c3a902daf.1475127338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8580617881554322395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96367266847
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 17:14:25 +0200 (CEST)
In-Reply-To: <7e8185f7a2eb642b52efe0de1369354c3a902daf.1475127338.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8580617881554322395==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="onvnr4amytt4keen"
Content-Disposition: inline


--onvnr4amytt4keen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 29, 2016 at 02:08:51PM +0800, mengdong.lin@linux.intel.com wrote:

> +	__le32 flag_mask;       /* bitmask of flags to configure */
> +	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
>  } __attribute__((packed));

I just followed up on the userspace patches but to repeat what I was
saying there I think given that users are actively complaining about
topology ABI files breaking we need to handle any extensions in a
backwards compatible fashion.

--onvnr4amytt4keen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9mNCAAoJECTWi3JdVIfQvToH+gN96Llpgrp8buHQsTQOr25e
wotKT8d61NX2KokVCflqP4GponTVc+UCBhQ1CF1rgjwNzsKfWHDNJ6svpkhNeWZI
gW/gXQxawniicftZiEGcwXkunh3Pc7FnFuXwIF+Uq2pE7URXZdgIhRiL3oF4LcWe
otz2iU//xNJQMlElCafdmEgxJUJwUURXXUl3BfG7QPv6DcfwbGf2qzo/3ckwqqhT
AVuqFvMQ6xxwqdeW95AL01peEpvtsxfc598wZYsl/tO+9q4VVTAsXU5ggC+uVm33
hsyNuCfA4vpyGgEAmUJbFp5r1GOMXMz4pcbEOiZF8e8JR9QAhAjCseYvpoU2WLU=
=ZEbk
-----END PGP SIGNATURE-----

--onvnr4amytt4keen--

--===============8580617881554322395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8580617881554322395==--
