From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/3] ASoc: TAS6424: Add support for mute, standby,
 and faster power on
Date: Wed, 2 May 2018 05:42:40 +0900
Message-ID: <20180501204239.GC2714@sirena.org.uk>
References: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1158229332812794907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33DDB266C1C
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 22:42:49 +0200 (CEST)
In-Reply-To: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1158229332812794907==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2018 at 10:30:15AM +0200, Jean-Jacques Hiblot wrote:
> mute and standby pins are available on the codec. If they are connected, they
> should be managed by the driver, instead of relying on gpio hogs or on the
> initial state of the GPIOs.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0T8ACgkQJNaLcl1U
h9Ad/Qf/emHR5/nYvWAYhMpBMTXLXgR75j75hZWawgl1qYSox9lMkg7whJUj1aEr
tclFJY8ur33dFsJf5qoozovVfA3ZahUDQ87uniegKZ1bWnHR5DSJl23ioF5yRCjP
+xPZOvtrm13GUzUQWzbcfajnrY77HhHiNJmf7xrRdsyQfk0Chb8/VyQqe0NQ5lgw
gvg/F4eEBHhK1PSbKGmzHfInaN+56bxujDHaXwqJirOq+NuziCdx1CNgQOobvs8h
2cG08PsgGCIa88kYHhQq/dBDLd4qOoyYV65VtlCRtN4xuD7kjW1+SmF61ZDySF1K
b+vBQsu7xFGtXRpqrIusLJHVPYVQCQ==
=Yom0
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--

--===============1158229332812794907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1158229332812794907==--
