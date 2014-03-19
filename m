From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] Documentation: Describe the SiRF audio
 hub Device Tree bindings
Date: Wed, 19 Mar 2014 18:55:47 +0000
Message-ID: <20140319185547.GU11706@sirena.org.uk>
References: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
 <1394707111-9539-3-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3623617021741193561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69BEE26517F
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 19:56:01 +0100 (CET)
In-Reply-To: <1394707111-9539-3-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============3623617021741193561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GNE9ETaGyP7vJxQo"
Content-Disposition: inline


--GNE9ETaGyP7vJxQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 06:38:31PM +0800, RongJun Ying wrote:

> +	audiocodec: audiocodec {
> +		compatible = "sirf,atlas6-audio-codec";
> +		interrupts = <35>;
> +		clocks = <&clks 27>;
> +	};
> +
> +	audioport: audioport {
> +		compatible = "sirf,audio-port";

> +	i2s: i2s {
> +		compatible = "sirf,prima2-i2s";

Given that this is all one single IP block which doesn't really exist
independently at the hardware level it shouldn't have separate nodes or
compatible strings for the functions at the DT level - that's all to do
with how Linux structures things, not about the hardware.  As ever DT
should represent the hardware, not Linux's abstractions for it.

--GNE9ETaGyP7vJxQo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKegvAAoJELSic+t+oim9L1oP/1nNKjjVe6IPXthxLzY9R2iC
W99G0BKDh7DU4uotY+u/zLba4n8m3OIXVqoC4fqM0AWX+d8IeJPBt7MXLXzgB34z
+3f01IqrZeQgz7IP9cqr/d3GQTpHLVdezyOibAacwK8fDUtBukkVdA0nsA7tZRYS
PaeILNBk+1AEDsOezm4Nixa1y1ZoeNHoV66j9e/3G5TVP7mcRYM54xa3Dl4TANP0
yu0eJfJ3Ly4PpJBoycX5BAFgsBBhmzuNpiwNrFrTY0ActYVlPHQKqt8Bsk5zyeoO
p8TOSr4se+sLr05X8WZukTsRrpEuaNnyIS6ELuErGYpJFXD5x+mnYem+nxnPrz+X
k13kLJ978dMCe6Ypz3zkr2xEG4jvu1dFEsIMmghKvMoflAV6XRdTomasgs7uTUgt
NeKERAFqzR9/0DIyLL4A/Tznma3UsCPD7CtAPpOvBQrBTeQqWVUFSdrPuVGLfnNz
pv2XVrarnmK9nUaFrgk4bqQWSqTij64Ylh/BjE5E8ebLO54kW8dsEWFwoEPt6eiL
CPhBECZ085aT9M8cQvBBHxO0fwPswjFZTQ3xFf0xsxmHOln/N+nHDd8O7U8JMG5d
mQBMi41JT6Ai19VdL385TBkubnng4jTllH6sbkKDPlMMeq/lFhWpGCjxkEmTJmwv
Pj/NN4/jInWzEdplvvGg
=qo5o
-----END PGP SIGNATURE-----

--GNE9ETaGyP7vJxQo--

--===============3623617021741193561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3623617021741193561==--
