From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 16 Apr 2014 22:11:45 +0100
Message-ID: <20140416211145.GC12304@sirena.org.uk>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4478180066135247611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ADDA2650BC
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 23:12:00 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4478180066135247611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fuiho1aubMFfXcAs"
Content-Disposition: inline


--fuiho1aubMFfXcAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 01:26:41PM +0000, Bard Liao wrote:

> > *MUST* use regmap to do this.  What's not been clear is if this device =
has a
> > control interface that looks enough like a register map to be implement=
ed like one
> > but since we're just guessing based on a combination of the code and th=
e HDA spec
> > it's not entirely clear.

> I am a little bit confused about it. I thought you told me not using regm=
ap.
> Actually, I don't know how to use dapm without implementing register I/O.
> Can I just convert rt286_hw_read/write to regmap?

As far as we've been able to tell thus far (based on inferring stuff
=66rom the HDA spec) you shouldn't be doing register I/O at all, the
device doesn't really have things that look enough like registers.

You can implement non-register DAPM widgets - look at the virtual
controls in the core, or things using SND_SOC_NOPM.

--fuiho1aubMFfXcAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTvINAAoJELSic+t+oim9YLcP/iD6EueE0gRSxdw/Pz1Ab5qq
yD/TccrAUx0xFPuq9GZsKijxJ8fNgBpjauoNNSOrnLkkDOtShVM9/hP7r4jiroDj
aFrXNgTG+L2pZMUiiYs3YFKyuTNrqQHp1VKgcf52cRZN3lG+prH/jSux9YtQ/aYm
tGjuaDVTbamZHakKf1LmT+nKHsT92v28lcqDZ6s/JaMhOH1hwDZrUD3aJ/yNb21C
atjryPPOXh13HKFCgq+OJhDXi4zoe1HhB7Hkkkxk8yfUnN89Z30s4Vhj/PteNiZu
w1hKQqfcTC9GGxuWcAQ0eTsg/Cujr4gf2MAd0wnlOlN9/tJWhYcPpkqPgcokJu9Y
jGCRptaReqXaoXxhSelFyjrSyw/8d3OTfJeTr3i6JU+AFI13NyaEWqdd8Rit8Y9j
zBGh0diYB9GG8otu3XIx7gXCkMPBIajqpwJJA8Wv8vUw4KT8FvSNquEuvUsiVKya
a0xWW7VRrT/TqivwSoLVv68vAAbCNNAZAaCEMPPe4I6hobTlsDBDGa0RBawUHHNC
4is43gww2AHB6Wi1tlKsYbXYvmvwLCA63SVOovCk+6mpaHrEqUXqPFeHR+9NuL5s
1kEtj3pKNhlKs6uvPY00ykHAv4Yzy0RKZINjZ2agPl+X7S5+TA/XA640Qrxlba37
VyqvENlxyDaQOb2SYgob
=M7mq
-----END PGP SIGNATURE-----

--fuiho1aubMFfXcAs--

--===============4478180066135247611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4478180066135247611==--
