From: Mark Brown <broonie@kernel.org>
Subject: Re: broonie-sound/for-next build: 207 builds: 13
 failed, 194 passed, 38 errors, 9 warnings (v4.12-rc5-151-g2eb01858cc80)
Date: Wed, 14 Jun 2017 01:14:27 +0100
Message-ID: <20170614001427.dbuiknoe34yk2vap@sirena.org.uk>
References: <59406c7d.cc471c0a.d6f51.6fe3@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8394492455796606098=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0687E2668BF
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 02:14:33 +0200 (CEST)
In-Reply-To: <59406c7d.cc471c0a.d6f51.6fe3@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8394492455796606098==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzmodvi3ygg4picb"
Content-Disposition: inline


--wzmodvi3ygg4picb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 03:51:41PM -0700, kernelci.org bot wrote:

Morimoto-san, it looks like your simple-card changes break the build -
it's late so I'm not going to fix right now but it looks like you're
missing some EXPORT_SYMBOL_GPLs.

> Full Build Summary: https://kernelci.org/build/broonie-sound/branch/for-n=
ext/kernel/v4.12-rc5-151-g2eb01858cc80/
>=20
> Tree: broonie-sound
> Branch: for-next
> Git Describe: v4.12-rc5-151-g2eb01858cc80
> Git Commit: 2eb01858cc80d3b9a29f1a8d355eeaef5830ce3c
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> Built: 4 unique architectures
>=20
> Build Failures Detected:
>=20
> arm64:    gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>=20
>     allmodconfig: FAIL
>=20
> arm:    gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>=20
>     davinci_all_defconfig: FAIL
>     multi_v7_defconfig: FAIL
>     multi_v7_defconfig+CONFIG_ARM_LPAE=3Dy: FAIL
>     multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy: FAIL
>     multi_v7_defconfig+CONFIG_EFI=3Dy: FAIL
>     multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy: FAIL
>     multi_v7_defconfig+CONFIG_LKDTM=3Dy: FAIL
>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=3Dy: FAIL
>     multi_v7_defconfig+CONFIG_SMP=3Dn: FAIL
>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=3Dy+CONFIG_ARM_MODULE_PLTS=3D=
y: FAIL
>     omap2plus_defconfig: FAIL
>=20
> x86:    gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
>=20
>     allmodconfig: FAIL
>=20
> Errors and Warnings Detected:
>=20
> arm64:    gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>=20
>     allmodconfig: 8 errors
>     defconfig+CONFIG_KASAN=3Dy: 4 warnings
>=20
> arm:    gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>=20
>     davinci_all_defconfig: 2 errors
>     multi_v7_defconfig: 2 errors
>     multi_v7_defconfig+CONFIG_ARM_LPAE=3Dy: 2 errors
>     multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy: 2 errors
>     multi_v7_defconfig+CONFIG_EFI=3Dy: 2 errors
>     multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy: 2 errors
>     multi_v7_defconfig+CONFIG_LKDTM=3Dy: 2 errors
>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=3Dy: 2 errors
>     multi_v7_defconfig+CONFIG_SMP=3Dn: 2 errors
>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=3Dy+CONFIG_ARM_MODULE_PLTS=3D=
y: 2 errors
>     omap2plus_defconfig: 2 errors
>=20
> x86:    gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
>=20
>     allmodconfig: 8 errors
>     defconfig+CONFIG_KASAN=3Dy: 5 warnings
>=20
> Errors summary:
>=20
>      13  ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-=
simple-card.ko] undefined!
>      13  ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc=
-simple-card.ko] undefined!
>       2  ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-=
simple-scu-card.ko] undefined!
>       2  ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-=
audio-graph-scu-card.ko] undefined!
>       2  ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-=
audio-graph-card.ko] undefined!
>       2  ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc=
-simple-scu-card.ko] undefined!
>       2  ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc=
-audio-graph-scu-card.ko] undefined!
>       2  ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc=
-audio-graph-card.ko] undefined!
>=20
> Warnings summary:
>=20
>       1  net/wireless/nl80211.c:5779:1: warning: the frame size of 2064 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/wireless/nl80211.c:4476:1: warning: the frame size of 2240 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/wireless/nl80211.c:4476:1: warning: the frame size of 2224 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/wireless/nl80211.c:1905:1: warning: the frame size of 3904 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/wireless/nl80211.c:1905:1: warning: the frame size of 3848 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/wireless/nl80211.c:1411:1: warning: the frame size of 2216 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/wireless/nl80211.c:1411:1: warning: the frame size of 2208 b=
ytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  net/bridge/br_netlink.c:1356:1: warning: the frame size of 2544 =
bytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>       1  drivers/tty/vt/keyboard.c:1471:1: warning: the frame size of 234=
4 bytes is larger than 2048 bytes [-Wframe-larger-than=3D]
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> Detailed per-defconfig build reports:
>=20
> -------------------------------------------------------------------------=
-------
> acs5k_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> acs5k_tiny_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> allmodconfig (x86) =E2=80=94 FAIL, 8 errors, 0 warnings, 0 section mismat=
ches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-audio=
-graph-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-audi=
o-graph-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-audio=
-graph-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-audi=
o-graph-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> allmodconfig (arm64) =E2=80=94 FAIL, 8 errors, 0 warnings, 0 section mism=
atches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-audio=
-graph-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-audi=
o-graph-scu-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-audio=
-graph-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-audi=
o-graph-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> allmodconfig+CONFIG_OF=3Dn (x86) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismat=
ches
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismatc=
hes
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (arm64) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (x86) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismatc=
hes
>=20
> -------------------------------------------------------------------------=
-------
> am200epdkit_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches
>=20
> -------------------------------------------------------------------------=
-------
> ar7_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> aspeed_g4_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> aspeed_g5_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> assabet_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> at91_dt_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> ath25_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> ath79_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> axm55xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> badge4_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> bcm2835_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> bcm47xx_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> bcm63xx_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> bigsur_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> bmips_be_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> bmips_stb_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> capcella_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> cavium_octeon_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches
>=20
> -------------------------------------------------------------------------=
-------
> cerfcube_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> ci20_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> clps711x_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> cm_x2xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> cm_x300_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> cns3420vb_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> cobalt_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> colibri_pxa270_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches
>=20
> -------------------------------------------------------------------------=
-------
> colibri_pxa300_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches
>=20
> -------------------------------------------------------------------------=
-------
> collie_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> corgi_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> davinci_all_defconfig (arm) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 secti=
on mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> db1xxx_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> decstation_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig (arm64) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismatc=
hes
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy (arm64) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_EXPERT=3Dy+CONFIG_ACPI=3Dy (arm64) =E2=80=94 PASS, 0 err=
ors, 0 warnings, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_KASAN=3Dy (x86) =E2=80=94 PASS, 0 errors, 5 warnings, 0 =
section mismatches
>=20
> Warnings:
>     net/wireless/nl80211.c:1411:1: warning: the frame size of 2216 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>     net/wireless/nl80211.c:4476:1: warning: the frame size of 2224 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>     net/wireless/nl80211.c:5779:1: warning: the frame size of 2064 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>     net/wireless/nl80211.c:1905:1: warning: the frame size of 3848 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>     drivers/tty/vt/keyboard.c:1471:1: warning: the frame size of 2344 byt=
es is larger than 2048 bytes [-Wframe-larger-than=3D]
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_KASAN=3Dy (arm64) =E2=80=94 PASS, 0 errors, 4 warnings, =
0 section mismatches
>=20
> Warnings:
>     net/bridge/br_netlink.c:1356:1: warning: the frame size of 2544 bytes=
 is larger than 2048 bytes [-Wframe-larger-than=3D]
>     net/wireless/nl80211.c:1411:1: warning: the frame size of 2208 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>     net/wireless/nl80211.c:1905:1: warning: the frame size of 3904 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>     net/wireless/nl80211.c:4476:1: warning: the frame size of 2240 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_LKDTM=3Dy (x86) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_LKDTM=3Dy (arm64) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_LKDTM=3Dy (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_OF_UNITTEST=3Dy (x86) =E2=80=94 PASS, 0 errors, 0 warnin=
gs, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_OF_UNITTEST=3Dy (arm64) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> defconfig+CONFIG_RANDOMIZE_BASE=3Dy (arm64) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> dove_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> e55_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> ebsa110_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> efm32_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> em_x270_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> ep93xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> eseries_pxa_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches
>=20
> -------------------------------------------------------------------------=
-------
> exynos_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> ezx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> footbridge_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> fuloong2e_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> gemini_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> generic_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> gpr_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> h3600_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> h5000_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> hackkit_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> hisi_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> i386_defconfig (x86) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> imote2_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> imx_v4_v5_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> imx_v6_v7_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> integrator_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> iop13xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> iop32x_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> iop33x_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> ip22_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> ip27_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> ip28_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> ip32_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> ixp4xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> jazz_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> jmr3927_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> jornada720_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> keystone_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> ks8695_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> lart_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> lasat_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> lemote2f_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> loongson1b_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches
>=20
> -------------------------------------------------------------------------=
-------
> loongson1c_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches
>=20
> -------------------------------------------------------------------------=
-------
> loongson3_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> lpc18xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> lpc32xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> lpd270_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> lubbock_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> magician_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mainstone_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> malta_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> malta_kvm_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> malta_kvm_guest_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> malta_qemu_32r6_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> maltaaprp_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> maltasmvp_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> maltasmvp_eva_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches
>=20
> -------------------------------------------------------------------------=
-------
> maltaup_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> maltaup_xpa_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches
>=20
> -------------------------------------------------------------------------=
-------
> markeins_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mini2440_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mips_paravirt_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mmp2_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> moxart_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> mpc30x_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> mps2_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> msp71xx_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mtx1_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> multi_v4t_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> multi_v5_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig (arm) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section =
mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_ARM_LPAE=3Dy (arm) =E2=80=94 FAIL, 2 errors, 0 =
warnings, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy (arm) =E2=80=94 FAIL, 2 erro=
rs, 0 warnings, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_EFI=3Dy (arm) =E2=80=94 FAIL, 2 errors, 0 warni=
ngs, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy (arm) =E2=80=94 FAI=
L, 2 errors, 0 warnings, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_LKDTM=3Dy (arm) =E2=80=94 FAIL, 2 errors, 0 war=
nings, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_PROVE_LOCKING=3Dy (arm) =E2=80=94 FAIL, 2 error=
s, 0 warnings, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_SMP=3Dn (arm) =E2=80=94 FAIL, 2 errors, 0 warni=
ngs, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig+CONFIG_THUMB2_KERNEL=3Dy+CONFIG_ARM_MODULE_PLTS=3Dy (a=
rm) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> mv78xx0_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> mvebu_v5_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mvebu_v7_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy (arm) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> mxs_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> neponset_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> netwinder_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> netx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> nhk8815_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> nlm_xlp_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> nlm_xlr_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> nuc910_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> nuc950_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> nuc960_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> omap1_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> omap2plus_defconfig (arm) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section=
 mismatches
>=20
> Errors:
>     ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simpl=
e-card.ko] undefined!
>     ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simp=
le-card.ko] undefined!
>=20
> -------------------------------------------------------------------------=
-------
> orion5x_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> palmz72_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> pcm027_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> pic32mzda_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> pistachio_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> pleb_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> pnx8335_stb225_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches
>=20
> -------------------------------------------------------------------------=
-------
> prima2_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> pxa168_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> pxa255-idp_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> pxa3xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> pxa910_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> pxa_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> qcom_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> qi_lb60_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> raumfeld_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> rb532_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> rbtx49xx_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> realview_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> rm200_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> rpc_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> rt305x_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> s3c2410_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> s3c6400_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> s5pv210_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> sama5_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> sb1250_swarm_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches
>=20
> -------------------------------------------------------------------------=
-------
> shannon_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> shmobile_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> simpad_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> socfpga_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> spear13xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> spear3xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> spear6xx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> spitz_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> stm32_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> sunxi_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> tango4_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> tb0219_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> tb0226_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> tb0287_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches
>=20
> -------------------------------------------------------------------------=
-------
> tct_hammer_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches
>=20
> -------------------------------------------------------------------------=
-------
> tegra_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismatc=
hes
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (x86) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismatch=
es
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (arm64) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismat=
ches
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismatch=
es
>=20
> -------------------------------------------------------------------------=
-------
> trizeps4_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> u300_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> u8500_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> versatile_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> -------------------------------------------------------------------------=
-------
> versatile_defconfig+CONFIG_OF_UNITTEST=3Dy (arm) =E2=80=94 PASS, 0 errors=
, 0 warnings, 0 section mismatches
>=20
> -------------------------------------------------------------------------=
-------
> vexpress_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> viper_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> vt8500_v6_v7_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches
>=20
> -------------------------------------------------------------------------=
-------
> workpad_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> x86_64_defconfig (x86) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches
>=20
> -------------------------------------------------------------------------=
-------
> xcep_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> xilfpga_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches
>=20
> -------------------------------------------------------------------------=
-------
> xway_defconfig (mips) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mis=
matches
>=20
> -------------------------------------------------------------------------=
-------
> zeus_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> zx_defconfig (arm) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mismat=
ches
>=20
> ---
> For more info write to <info@kernelci.org>

--wzmodvi3ygg4picb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAf+IACgkQJNaLcl1U
h9C/bgf/b1V2JjdoFNtgjN3Mr5CFFn1o8/sdZld8v6G7wHZ11r6uIAHSVO7aAMTJ
rX/NdSFI9CW0yxTL+m9KNqxu+bH7Iixj7QihTcXkq5lEux84GdIweJYwjMpGRF6Z
qKxFfLaL9tscK3bgHSuWetR7gthlDXlaVQx2KiIJOnFjSHoKfVIzWk93rPry521o
jtQh+Ak44jXgBTu16Jwr0hbTiLekOTEs6+ym8cJimqjgGsTEcVR6dbygsIj++EbT
Z7REo8BC3s80wUhcxeqiuyf12wbxfTsb+5IGO3RnNN9Lc81JW9har3fQ+FV868Ed
EtOB81u/FDhPpi8BNuZN5I86YMfWSg==
=saf/
-----END PGP SIGNATURE-----

--wzmodvi3ygg4picb--

--===============8394492455796606098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8394492455796606098==--
