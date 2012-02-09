From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: PCM - Add PCM creation API for
 internal PCMs.
Date: Thu, 9 Feb 2012 10:44:34 +0000
Message-ID: <20120209104434.GA3058@opensource.wolfsonmicro.com>
References: <1328733211-3234-1-git-send-email-lrg@ti.com>
	<s5hk43xypmq.wl%tiwai@suse.de>
	<20120208225728.GA6596@sirena.org.uk>
	<s5hhaz0jtw4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7296512599782923185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BDCC2439A
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 11:44:36 +0100 (CET)
In-Reply-To: <s5hhaz0jtw4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7296512599782923185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2012 at 09:25:15AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Since Liam's got a whole raft of ASoC changes depending on this one can
> > you please either apply it to a branch or ack it for merge via ASoC?

> OK, now I fixed coding-style issues by myself and applied the patch.
> It's found in an individual branch, topic/pcm-internal of sound git
> tree.  Feel free to pull this branch to your trees.

Now pulled into 3.4 and I'm waiting with baited breath for the soc-dsp
patches :)

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM6OLAAoJEBus8iNuMP3dlM8P/RoZJs5FeAm0KsS5gnUjrLYJ
HOaNOldGTeYNHrD0HNhseOYfgB75AIu9Tbd1Qy4So0IyTWlzmqZ5xYr+Op1U7JMQ
zVdWMmM16ubDR3z2LKc9vL3Uk2/rlZOlO9JubPJcX1AuOWstC72Lt6TgQYNgjph4
EIux28jIzfoyudgf4wKJj9p2abi0GIJw5v2DSix7goglGr6JavtPVIlvVkv4Ofa/
AomenqAyt+fYnpuvZq1nW8dNeo6NUPdT9wkj83yG98Fymmv6/W1YbKURLsePWZXF
Im9VgLrkgr84csMM+OR2cR7w2wn+dJt76CcaECEvpPmQGfv8KuqDLawbb9Bcq1Q8
IGJ5CxBBaF2S9/yT73eB0fV5aZqPFTIT5kr3GTOLxFFI+6skAOYS0ej1KWvoNu/+
1ybqi8Xr2RFLYOu/mkVGwV9UMsYZvT+8qdXbVzIc0/rAj+6MaLRzzM3e+wUAbKzw
HtmJZdXGcrEJl+S2BDFFIKZwrY4Mv6AVD2BEquEPcBLiB47IHhgv+o1GxxIqOhVC
glagIGQvRscf0+SFCnF9Ej6SjxustQEh0w/oKjTmJ9SKSDu9I+6/GSi+96UBYDVI
dRcvVCFcyJ1LFQRnm31kQfuazWxKeiRAY28miYv/vdDS8nu9mx71dHtRmA9+8izS
+fCLnwUS80RUGjSj7BYc
=tbmz
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--===============7296512599782923185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7296512599782923185==--
