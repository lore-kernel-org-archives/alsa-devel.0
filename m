From: Mark Brown <broonie@kernel.org>
Subject: Re: 3.13 regression on panda board
Date: Wed, 4 Dec 2013 16:29:05 +0000
Message-ID: <20131204162905.GZ29268@sirena.org.uk>
References: <s5hfvq84qxd.wl%tiwai@suse.de>
 <20131204155531.GY29268@sirena.org.uk>
 <s5hzjog38k8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5445300476063039318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CF4B2619DE
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 17:29:10 +0100 (CET)
In-Reply-To: <s5hzjog38k8.wl%tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5445300476063039318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXo2lOxbfudqq8ta"
Content-Disposition: inline


--AXo2lOxbfudqq8ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 05:05:59PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > could you update the bugzilla report below?
> > >    https://bugzilla.kernel.org/show_bug.cgi?id=66451

> > That's probably not even directly audio related but rather from core DMA
> > changes (though perhaps the driver is buggy).  When akpm forwards stuff
> > to the lists he tend to include the entire report and CC bugzilla -
> > that's generally more helpful in getting responses since people don't
> > need to click on a link or anything.

> I'm not sure whether bugzilla mail interface works now...

Me either, I don't actually use bugzilla, but I guess if Andrew's using
it then it ought to.

--AXo2lOxbfudqq8ta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSn1hOAAoJELSic+t+oim9DccP+wbyignVEK6ZpAVJFTNnCZ0f
bcsuV0cEUR7yQiZZxgFLfEAJLSukUGlBxo2ws/3ypjYXiFdbsJnlCP73EZMC6Nav
/jHqhFt8Ve9/MQG1bC72J/Gul90NOI/QvWx6Lj1DPct7WRscCB98IsTc6HdEC/vM
aDkB3ZeyZ386Pbut5Oy/NeAjmnTi4A0tyonCNo06AWb5MXJazo9T3xFR8m+FYv31
esWTk8wVRcpJWmqLfgUW13gL2lxWLVXRI8W04D0lWxfso9wgaNsp8T6FHeSUgsDA
uDsUrvocr/t5YjfEyPFUbdZW6lv4oQi/Zr5WdlnazpJWFbH2N8CCZ6UwpizXf0fY
uQAwq7XCITtMy77hAEsZKRlz9DBU9/P/BOXqnsarpAD8pbrt/65I6N8XhL32h+Z3
kaLRUloLoLpyhGzvFhacrSEEJet68usK/797MWVEd/BBj/bL9lgmj3vgD52pcCo5
VS+HnVjG5xzALMpwrM2TGZli2otNRs8BpmpxIad0GDa0xkYpI0pUlsBeyPJ8//vS
6uDsHVWjMiSIfh9WPPr3ipyel+8uyYvixhl3uauwD4K2xeX15jIsbaO4fLVjGEfT
48jahvfkJj4kBCe9W3zEB+9mYutzwbmmSts+vL/LBwI+bPGoFIInGFwHh4D9ni88
fjpOVF3X60UICu4C8EqO
=mjbE
-----END PGP SIGNATURE-----

--AXo2lOxbfudqq8ta--

--===============5445300476063039318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5445300476063039318==--
