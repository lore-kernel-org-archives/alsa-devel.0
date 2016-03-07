From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: ERROR: "isa_io_base"
	[sound/pci/vx222/snd-vx222.ko] undefined!
Date: Mon, 7 Mar 2016 10:20:37 +0200
Message-ID: <56DD39D5.80402@ti.com>
References: <201603062033.hlQ3Lfnm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4773823766117376591=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 117572607F7
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 09:20:42 +0100 (CET)
In-Reply-To: <201603062033.hlQ3Lfnm%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, Nicolai Stange <nicstange@gmail.com>, alsa-devel@alsa-project.org, Michal Simek <monstr@monstr.eu>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--===============4773823766117376591==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pCFCG5OkCLGfFguUheO0K51qVoTQlPHKf"

--pCFCG5OkCLGfFguUheO0K51qVoTQlPHKf
Content-Type: multipart/mixed; boundary="INWoJHrmlS9GOldWKLdD4tBvCmQLO4Ogi"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: kbuild test robot <fengguang.wu@intel.com>,
 Nicolai Stange <nicstange@gmail.com>, alsa-devel@alsa-project.org,
 Michal Simek <monstr@monstr.eu>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Message-ID: <56DD39D5.80402@ti.com>
Subject: Re: ERROR: "isa_io_base" [sound/pci/vx222/snd-vx222.ko] undefined!
References: <201603062033.hlQ3Lfnm%fengguang.wu@intel.com>
In-Reply-To: <201603062033.hlQ3Lfnm%fengguang.wu@intel.com>

--INWoJHrmlS9GOldWKLdD4tBvCmQLO4Ogi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/03/16 14:38, kbuild test robot wrote:
> Hi Nicolai,
>=20
> FYI, the error/warning still remains.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> head:   67944024c1cdd897e49a09b0d6af3ea38d1388ca
> commit: 48fd8ecf29e3c1199432e173858f5ca4bc529738 framebuffer: disable v=
gacon on microblaze arch
> date:   7 months ago
> config: microblaze-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests=
=2Egit/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 48fd8ecf29e3c1199432e173858f5ca4bc529738
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dmicroblaze=20
>=20
> All errors (new ones prefixed by >>):
>=20
>>> ERROR: "isa_io_base" [sound/pci/vx222/snd-vx222.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/trident/snd-trident.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-via82xx.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-via82xx-modem.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-sonicvibes.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-maestro3.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-fm801.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-es1968.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-es1938.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-ens1371.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-ens1370.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-cmipci.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-azt3328.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/snd-als300.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/riptide/snd-riptide.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/pcxhr/snd-pcxhr.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/oxygen/snd-oxygen-lib.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/lx6464es/snd-lx6464es.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/ice1712/snd-ice1724.ko] undefined!
>>> ERROR: "isa_io_base" [sound/pci/ice1712/snd-ice1712.ko] undefined!

I didn't look at this closely, but sounds like disabling vgacon on
microblaze made sound drivers fail because they or microblaze does not
enable something in the kernel config.

 Tomi


--INWoJHrmlS9GOldWKLdD4tBvCmQLO4Ogi--

--pCFCG5OkCLGfFguUheO0K51qVoTQlPHKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3TnVAAoJEPo9qoy8lh71N5wQAKLgxWOPbM7nDR+NmE7aU3qD
B/h/77NAMyRJ1P3jCrvA09NpnJKKTv4zXbq2sUsp8XXwlUUE7RqfGHUE3nu7kvJP
zq82ly7URI+EkSKSVZkqNkNt+LMh55L/D1JauBg3qYSFr/AyMrvgn8d8kDSaRE8R
ZFKjAagsLp6WjSMvcPstYi5ROOg1GRk2L2Z0b24Q5DKJRJxVoNXpok7gilTH5XgA
SimaoPPURFP05nBzfxtybGtWlHWqUWqvX/LRWCc7KMwmyvcdePPIvY/4dFG330rr
AOAe0xJiEuzHa1pDvhm2pLe8grUorsrILW0ShQxMAtBMLGHiCQBDpGQVT9C7/rpQ
a+pK0KI86Y0ALD/54W7daIKagvtiA1KRHMZrOLunpLbD32Z5ois7SSu3vsU9EJO8
Zn/29Mctc6h05YImxs1wXQPyHNj5uGVxObMeN/vwwdD2zpcsNRnCjhhaLWdH48TR
KWRbaNObcj6vUlvVBiF54kKVroKpjOIWqRiPbdynS55FWI0NBkEGu0gGP4ugqtyH
fpmD+fsd562MfpuFkNCav4q975eBZGL6xEKtPytlxFwfFaD/RYp+4vcxIQnU7j9B
UNFL7t68Et4izCT2WSHMvLklAZs+OJK+w4jT9qLniLuULGHyGDAxXhSVrFKAiI5m
39+1IVbHIgHfwpXSwidG
=4wGA
-----END PGP SIGNATURE-----

--pCFCG5OkCLGfFguUheO0K51qVoTQlPHKf--

--===============4773823766117376591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4773823766117376591==--
