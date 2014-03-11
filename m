From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ak4642: show error if register write fails
Date: Tue, 11 Mar 2014 14:21:38 +0000
Message-ID: <20140311142138.GU28112@sirena.org.uk>
References: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140310234038.GE28112@sirena.org.uk>
 <531EF106.3020809@codethink.co.uk>
 <20140311112112.GP28112@sirena.org.uk> <531F16DB.30200@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0893620299879537687=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9558A261A12
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 15:21:51 +0100 (CET)
In-Reply-To: <531F16DB.30200@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, Ben Dooks <ben.dooks@codethink.co.uk>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============0893620299879537687==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FSa9uEq14kwVElD1"
Content-Disposition: inline


--FSa9uEq14kwVElD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 02:59:55PM +0100, Lars-Peter Clausen wrote:
> On 03/11/2014 12:21 PM, Mark Brown wrote:

> >>If you think that changing the two snd_soc calls to print errors
> >>when anything bad happens then that would also be a good idea then
> >>I can send a patch for that.

> >That would be better, yes.

> In my opinion it's better to pass the error on to the upper levels.
> E.g. if userspace opens the PCM device and there is an IO error in
> the startup callback then that error should be passed on to the
> userspace application rather than doing a out of band error
> reporting and adding a entry to the kernel log.

It would, overall, be much better to be passing errors back.  However
what's actually happening now is I/O errors are routinely ignored and
our error handling is somewhat shaky (and realistically it's hard to
know what to do a lot of the time when I/O with the device is failing).
Given that improving the diagnostics seems like it's going in the right
direction, we can always remove this later.

--FSa9uEq14kwVElD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHxvvAAoJELSic+t+oim9BHQP/0OmScYODYgKHbVEMf+yD3ny
/1TF1RCSrSuNQe27jPR4OFLAw7b/eIsEf+66SDfCEun/m2z/PozEFyStWGDt7ahf
CZBD3TAYIblLGyiWEigBEf5NV/+FN/yntvnyRvoSx1sRvvds6q8AckSjLrwU5GBl
YBs2qInVQfojsF90JEGASMQBtKyEUg6UufQLPHyvwFzaqjTm8T7qOWwW6KiXmFKV
ImQDb2kj11niMkEgkjaWyb0SZbISItCh2jDLeFGEPYHWR2h/sPE2t9p5VPy+nbEw
HjNPD/zhPXAaf1uWObvAQOnB5JsQ9AOd51lWAMvY9doG1KSMjsYQWaS4FXn4sYFD
eZx67k0odv6zDBmwKC4uvaz1MciygUfMZQilnIik/RZdIKPB7qqmt1pvUhBNsc4J
LZ1gZBJrBDgqlL8AXZR1gC7wcrpoTa2p+yUhHPJLothZSWSyHmpz01SyuHym8ere
Vw9wz743pSyRQcuIro10PoWZz0JDQZNYAHzQ0Rwyv3vLhcScC0yVCOnBQddQtyIz
SHnJPHJbX+hfQeHN3bjpoDmFGIoqlygM/VCYoQlYupcgytfXI8py8u4uKd4tlBZ6
y+aO3zjR8OXGBp6h9hQxVz+05PbI0VbtiyGacCy3RTtGRAoHj83SRIV2dodYZAkD
OC2Bm1Ec2qDOv3pHhIXc
=t40C
-----END PGP SIGNATURE-----

--FSa9uEq14kwVElD1--

--===============0893620299879537687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0893620299879537687==--
