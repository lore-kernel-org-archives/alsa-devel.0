From: Nicolas George <george@nsup.org>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 3 Jul 2015 13:12:51 +0200
Message-ID: <20150703111251.GA1657242@phare.normalesup.org>
References: <20150624101115.GI19530@localhost> <558ABDB6.4010702@gmail.com>
 <20150624160314.GM19530@localhost> <558BA1D8.8040508@intel.com>
 <55931EE8.5000604@gmail.com>
 <20150702184035.GA1418140@phare.normalesup.org>
 <1435913462.2478.14.camel@loki>
 <20150703110838.2cef7f669102bd60b5ee1b8c@ao2.it>
 <20150703094606.GA1643220@phare.normalesup.org>
 <20150703123208.31881e788efd500dba8fe1dd@ao2.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6495307644913413227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nef2.ens.fr (nef2.ens.fr [129.199.96.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 866DA260527
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 13:12:53 +0200 (CEST)
In-Reply-To: <20150703123208.31881e788efd500dba8fe1dd@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Tyler Yeomans <tyeo098@gmail.com>, Jarkko Nikula <jarkko.nikula@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6495307644913413227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le quintidi 15 messidor, an CCXXIII, Antonio Ospite a =E9crit=A0:
> snd-soc-sst-bytcr-rt5640 will be loaded automatically if you use
> snd-intel-sst-acpi instead of snd-soc-sst-acpi, you can blacklist
> the latter using a file in /etc/modprobe.d (look up the details), or
> just remove snd-soc-sst-acpi.ko from the installation dir as a dirty
> hack.

Indeed. I always loaded snd-soc-sst-acpi before snd-intel-sst-acpi, so I
could not observe it gives a different result.

> In my tests I used the code from mainline linux.

Ok. That is what I am doing too.

> Note that different drivers expect different firmwares, you cannot mix
> them:
>=20
>  snd-soc-sst-acpi   -> fw_sst_0f28.bin-48kHz_i2s_master
>  snd-intel-sst-acpi -> fw_sst_0f28.bin
>  snd-intel-sst-acpi -> fw_sst_0f28_ssp0.bin (renamed to fw_sst_0f28.bin)

Ok. I re-ran the tests like that.

After loading snd-intel-sst-acpi, the kernel says:

[   35.160330] intel_sst_acpi 80860F28:00: LPE base: 0x90a00000 size:0x2000=
00
[   35.160339] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0000
[   35.160372] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00000
[   35.160384] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40000
[   35.160395] intel_sst_acpi 80860F28:00: Mailbox base: 0x90b44000
[   35.160405] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[   35.161373] intel_sst_acpi 80860F28:00: Got drv data max stream 25

After loading snd-soc-sst-bytcr-rt5640 it says:

[   69.130424] bytt100_rt5640 bytt100_rt5640: snd-soc-dummy-dai <-> media-c=
pu-dai mapping ok
[   69.130482] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mappin=
g ok
[   69.130536] bytt100_rt5640 bytt100_rt5640: rt5640-aif1 <-> ssp2-port map=
ping ok
[   69.130650] bytt100_rt5640 bytt100_rt5640: Connecting non-supply widget =
to supply widget is not supported (Int Mic -> LDO2)
[   69.130657] bytt100_rt5640 bytt100_rt5640: ASoC: no dapm match for Int M=
ic --> (null) --> LDO2
[   69.130663] bytt100_rt5640 bytt100_rt5640: ASoC: Failed to add route Int=
 Mic -> direct -> LDO2
[   69.165392] sst-mfld-platform sst-mfld-platform: Slot control: codec_out=
 tx interleaver slot 0 doesn't have DAPM widget!!!
[   69.165427] sst-mfld-platform sst-mfld-platform: Slot control: codec_out=
 tx interleaver slot 1 doesn't have DAPM widget!!!
[   69.165460] sst-mfld-platform sst-mfld-platform: Slot control: codec_out=
 tx interleaver slot 2 doesn't have DAPM widget!!!
[   69.165494] sst-mfld-platform sst-mfld-platform: Slot control: codec_out=
 tx interleaver slot 3 doesn't have DAPM widget!!!
[   69.165521] sst-mfld-platform sst-mfld-platform: Slot control: codec_in =
rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[   69.165551] sst-mfld-platform sst-mfld-platform: Slot control: codec_in =
rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[   69.165583] sst-mfld-platform sst-mfld-platform: Slot control: codec_in =
rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[   69.165618] sst-mfld-platform sst-mfld-platform: Slot control: codec_in =
rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!

The sound card appears, but then if I try to play something:

aplay -D hw:0 -c 2 -r 48000 -f S16_LE /dev/urandom
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 48000
PERIOD_TIME: 125000
PERIOD_SIZE: 6000
PERIOD_BYTES: 24000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 24000
BUFFER_BYTES: 96000
TICK_TIME: 0

[   95.164749]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Bayt=
rail Audio Port

The messages are exactly the same with both firmwares (fw_sst_0f28.bin and
fw_sst_0f28_ssp0.bin).

Maybe I forgot to load another module?

Side note: snd-intel-sst-acpi and snd-soc-rt5640 both have usage count 1
without dependent modules, that requires a reboot between each test.

Thanks for your help, it helped me make progress even if it still is not
success.

Regards,

--=20
  Nicolas George

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlm4zAAoJEHGVSyPKTcYMLNMP/ROtPo0wbkFlPy79pqE6CKg6
CS2uf0ozSP96WBSGKQRlLblFfz+WzRNXmf6mxJ5lO8fzkN96IJmrUjmquo5v5ohl
vOz41anum6P8nqaNn+PLS5Nw1G+GrW4d2h4I2WPnIwxXQ4WM2hbENI/2SJ9029RV
FHWW3hUJw50jLFNc6Rukh2R0mZLRY8FhumtEcqY0IbzY+SeMvnKt5Qu2qfIZc70p
bVY8lS2Mfy/6ZYed4+zTN4PI4xIe/re/ytP5JAqrA4TqZWBUSOwubKdNlG8+9M36
llbb58f8+lxsM7pVVqbySO4oQ7tBAIlGDPHXFZah+aBNiqBxOZ1AuwJ8+8FEbufN
jLpX4LSuwla+sSGQDqq981lX14bsuJu3U9iwSx6zPll4H4uTOv+zrz2poa9v8GYT
82cJIRhvdVQWMz/mr0dLgdgIV8G2WMhgbc/ZPdZQuO99tWkgYZQlX51oBXinKsLl
zGWJwc/vb1umsRv8aY5r6EpTW/jzb3s6Ccz/N/pgNtt4HGqZK6LM4EJQZYh5iTAQ
s7iFNum1Q+mZfe2FI2G+m+MIv5X1Y7qPFcEA0fZFaPLUI0MZIrvbPjjDB30Re2ht
LUV/MFNp3XaOI/eLwFZgpcBjn5UNEAkk/g2/NnBtRoHSX+IFhStWwm51j8oASKCD
GwLHLZQ2r8jzaTyZ/XEP
=n29Q
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

--===============6495307644913413227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6495307644913413227==--
