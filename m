From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Update: emu1212m
Date: Wed, 21 Jun 2006 13:14:47 +0400
Message-ID: <20060621091447.GW3206@master.mivlgu.local>
References: <44951964.9020509@superbug.co.uk> <4498FBC4.5090900@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1232400684=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4498FBC4.5090900@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1232400684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7rykKtsZvepKFKR"
Content-Disposition: inline


--c7rykKtsZvepKFKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2006 at 08:56:52AM +0100, James Courtier-Dutton wrote:
> For (1), the FPGA array is filled with 78756 bytes of netlist code.
> I suppose one could consider this 78756 bytes as firmware.
> Should this firmware sit somewhere in userspace?

Probably must, due to license issues :(

> The trouble is, that if one changes some controls on the device, e.g.
> switching from SPDIF to ADAT digital outputs, a whole new different
> firmware image is loaded. So, one has multiple different firmware
> images, with one swapping between them. Should these firmware images be
> left in the kernel then, instead of using the userspace firmware api?

There are some drivers in the kernel which load different firmware images
in different modes.  E.g., the ipw2200 driver can load ipw2200-bss.fw,
ipw2200-ibss.fw or ipw2200-sniffer.fw depending on the mode set by
iwconfig (and can switch between them at runtime).

There is also an option to use a single firmware file consisting of
multiple parts used for different modes, but this obviously has a higher
memory overhead.  IMHO this should be used only when there are some
latency restrictions for switching modes (so that a driver can request all
firmware parts during initialization and then load different parts without
waiting for userspace helpers).

--c7rykKtsZvepKFKR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEmQ4GW82GfkQfsqIRAiJ4AJ4xCSHx6X7ewCuakPyC5q1vMAI2lwCdFjVv
kesLTB+EIRwRKA9FF2otLVE=
=rRUs
-----END PGP SIGNATURE-----

--c7rykKtsZvepKFKR--


--===============1232400684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1232400684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1232400684==--
