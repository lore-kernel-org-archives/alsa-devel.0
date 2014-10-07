From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: mc13783: Fix of_node_put() call
 with uninitialized object
Date: Tue, 7 Oct 2014 19:04:34 +0100
Message-ID: <20141007180434.GU4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-2-git-send-email-tiwai@suse.de>
 <20141007170938.GM4609@sirena.org.uk>
 <s5hppe3lrzf.wl-tiwai@suse.de>
 <20141007172337.GR4609@sirena.org.uk>
 <s5hlhorlqyw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3782160417875215619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9048E2604A2
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:05:04 +0200 (CEST)
In-Reply-To: <s5hlhorlqyw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3782160417875215619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jwSnfOBD38i7UC9C"
Content-Disposition: inline


--jwSnfOBD38i7UC9C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 07:39:03PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Well, in this case I'd just move the of_node_put() into the existing
> > check for pdata since we don't ever reference np outside of that anyway.

> Yeah, that's an option, too, but it'd make the code less readable.
> So I chose the straightforward way.

I don't actually see it as a readability concern - to me having the get
and release close to each other and especially having them at the same
level of indentation helps.

--jwSnfOBD38i7UC9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNCsxAAoJECTWi3JdVIfQm/AH/1DZpwxBACWnLYRQ5aJudyw2
p68iXzeoxARk6NhfYsNFf1o7nBmeBCVLNu37DoxP3mp+DASCo9ZYDkG7OAM915Sn
bqItaLCR7clvuSh2Ur1Gf4jrczGC9q9dIoffAR8d1gmJspq7SW81GJuuDjiZCpzO
ZkOpEpsQ7mhYziFWlhznW6V7HY0lK/Jixu4SFNmQtjmINlZn826CzfjAIMoqVkR4
ZK741CSHjv4KN6LQmug6RKE9QoGJp1tkBy+qkn5p77H+e0BRd79YQD1RwX3MhP0d
wU1wAGAuLMzlqQVIaj0H9hwwVQCRTekiu/Ih6jndRnkMykph2zkJATxfgMBXpnk=
=B0ce
-----END PGP SIGNATURE-----

--jwSnfOBD38i7UC9C--

--===============3782160417875215619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3782160417875215619==--
