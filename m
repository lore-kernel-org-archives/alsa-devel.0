From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/10] ASoC: Intel: Add
	sst_ipc_tx_message_nopm
Date: Fri, 28 Oct 2016 19:05:34 +0100
Message-ID: <20161028180534.r6osk4mz253xeuwc@sirena.org.uk>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
 <1474868137-29712-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6887634342321221329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E912D266B28
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 20:05:53 +0200 (CEST)
In-Reply-To: <1474868137-29712-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6887634342321221329==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="otkcgffrumn2d5fl"
Content-Disposition: inline


--otkcgffrumn2d5fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 11:05:29AM +0530, Vinod Koul wrote:
> Add a IPC API to send IPC without waking up DSP.
>=20
> This is helpful when the DSP is already in woken up state(not in any low
> power mode) and an IPC is to be sent.

Why is the IPC API for cases where the DSP needs to be woken not
implemented in terms of this one?

--otkcgffrumn2d5fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE5NuAAoJECTWi3JdVIfQ+AgH/A5m5u5+10PtkwqFj++puF2P
y0SrMkeSo67VzlwFSTd9F1QusBmaZlVx98VJly6hO6+H8miKnRKWpt181goFSZZ5
t0iFBLXrMwIAyOILLai5opj5iuCjTEv5vZOhWwcjzQuIk3KapzanYab4r6ENMJg8
ZRlXJoxcsdemOGGME1ibOc6nBXdN+Sid0OT2rlsBO5jf7hyXhxYZn7TXJmTt5lYv
myM/xn+l36DDP/JRS3d++yIG0MmVJtmn5/NdShE4xm/PCN1vwxPqo8FFz2XNjTaK
Brcj/5CYTDJssumY2ZK7OicrND+tdojAYifoIf73Lv1MNJZjUNJbVjlKdTzL4LY=
=ibLK
-----END PGP SIGNATURE-----

--otkcgffrumn2d5fl--

--===============6887634342321221329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6887634342321221329==--
