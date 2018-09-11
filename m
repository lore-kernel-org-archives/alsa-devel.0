From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] Revert "ASoC: Intel: Skylake: Acquire
 irq after RIRB allocation"
Date: Tue, 11 Sep 2018 17:36:36 +0100
Message-ID: <20180911163636.GC10123@sirena.org.uk>
References: <20180910211718.200802-1-yuzhao@google.com>
 <s5hd0tk3712.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3209507457198309034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B9E92676EB
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 18:36:42 +0200 (CEST)
In-Reply-To: <s5hd0tk3712.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Yu Zhao <yuzhao@google.com>, Jie Yang <yang.jie@linux.intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3209507457198309034==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2018 at 08:03:21AM +0200, Takashi Iwai wrote:
> Yu Zhao wrote:

> > Will fix the problems in the following patches. Also attaching the
> > crash for future reference.

> > [   16.950887] RIP: 0010:snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core]
> > [   16.950889] RSP: 0000:ffff88015c807c08 EFLAGS: 00010003
> > [   16.950891] RAX: 0000000000000101 RBX: 000000000000080c RCX: 1ffff10026822185

> Please try to rip off uninteresting hex values and other stuff there.

Right:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluX7xQACgkQJNaLcl1U
h9ARRAf/Q5qEa3zePsa30sANzk+V1KkvPnxJE4fHJbtvPY8Reia43ia3WGb9ijyZ
Yn94Cie18uVetrVdmROu/TbAZvorguH6U89hG5kv83p3coTa2HS7lmEqyUP9vW8W
ZcI7XaFij3hJPsgwwHUyPLmfpnn5HZjEAcmuEEFF1u3447UQlgppO91huIHmGXJl
yp2sCvku/XVi88MBys8UEMNS50iVKggON7bnWWJRTiaYCODiXUBzenQoz2DoiCs1
83JVhaT6LlxYbD0F4lrlyTzu8Ih3yfKkEhydRsCJcOEHaa7QCmGhSksZcF+IR4jZ
qC2IFpnXIsuOKBMsReG/z/ckyVAqCg==
=sKQD
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

--===============3209507457198309034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3209507457198309034==--
