From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sst: Fix firmware name size
	handling
Date: Sun, 8 Feb 2015 11:52:11 +0800
Message-ID: <20150208035211.GA19229@finisterre.sirena.org.uk>
References: <1423348852-29466-1-git-send-email-cengelma@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2045929257515241588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0932604D4
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 07:24:47 +0100 (CET)
In-Reply-To: <1423348852-29466-1-git-send-email-cengelma@gmx.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: alsa-devel@alsa-project.org, wsa@the-dreams.de, vinod.koul@intel.com, mengdong.lin@intel.com, lgirdwood@gmail.com, tiwai@suse.de, yongjun_wei@trendmicro.com.cn, yang.a.fang@intel.com, jarkko.nikula@linux.intel.com, kevin.strasser@linux.intel.com, fengguang.wu@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2045929257515241588==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 07, 2015 at 11:40:52PM +0100, Christian Engelmayer wrote:
> Function sst_acpi_probe() uses plain strcpy for setting member firmware_name
> of a struct intel_sst_drv from member firmware of a struct sst_machines.
> Thereby the destination array has got a length of 20 byte while the source may
> hold 32 byte. Since eg. commit 64b9c90b8600 ("ASoC: Intel: Fix BYTCR firmware
> name") increased strings from "fw_sst_0f28.bin" to "intel/fw_sst_0f28.bin"
> there is an actual possibility that the 20 byte array at the end of struct
> intel_sst_drv is overrun.

Applied, thanks, though it seems more robust to stop copying the strings
at all and instead just make as many of the fields char * as we can.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1t1qAAoJECTWi3JdVIfQhmMH/RX592uem+Gd0x92nJHWFITt
wCz4dG15sNNAq29L8ut78nxk48kLt8zt/qu0/jaibWptiadVPf9bjdkqXeoMPxoU
UdKMjSc6FxKBrbCUjLTuZ69aFF1M+VhYlF8fmlhb+G1m5jUYSNRpTSZmjW5jIUH9
9Sy3ACqdDosECgN3aroMQE3d0EB0oQSAjSp6uGaTuguonN03sJjFBFwDja8N65wT
vTIx7uNO/oHmuJZv+SvuwuAVO96ryJdTptKiwxHPO2nwrmD8/6kAaRNYKW7eTTIW
FG7Y6u1GHuvAo2YND9yvB2IdtNyRJjzKHuZxRhUiL0LKHrN51MMyu8yVnGwqgUs=
=6w10
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--===============2045929257515241588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2045929257515241588==--
