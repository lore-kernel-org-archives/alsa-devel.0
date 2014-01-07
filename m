From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: compress: add num_sample_rates in
	snd_codec_desc
Date: Tue, 7 Jan 2014 17:47:51 +0000
Message-ID: <20140107174751.GG31886@sirena.org.uk>
References: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
 <20140107173510.GD31886@sirena.org.uk>
 <s5h8uurpu40.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7130423075006462913=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCA1E265087
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:47:56 +0100 (CET)
In-Reply-To: <s5h8uurpu40.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7130423075006462913==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5o+xNwJos2W1xoQY"
Content-Disposition: inline


--5o+xNwJos2W1xoQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 06:41:35PM +0100, Takashi Iwai wrote:

> The previous commit for sample_rates[] already broke it, so it doesn't
> matter for this commit :)  I applied the update patches since
> snd_codec_desc isn't used anywhere in the upstream code, and this is
> the request from Vinod, so he must know well the ABI regression if it
> really matters.

Yeah, it's not just Vinod though.  Like I say pushing to stable so
anyone trying to build on top of it might be the best thing, can't
remember if that happend with the previous change or not.

--5o+xNwJos2W1xoQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzD3DAAoJELSic+t+oim9L8EP/2ih3tS7GZUcCEFNoMQl07K+
ZM8qc3qgac/yZaJm+78uqKUmY3l6bAlLCRqm5jRJHna9IHv+4eBK5epl1sdbDAPU
1XBeWxyJYtcz732JkEELUKATXt7pRVxviWMyr2zFRPOUdEAnhablvhedSTq/rueC
I5bVl/sV3MbWD3VwoDF8YbRMp0lQztYz8q7qTWwnsdPWR54BzZbWh5AVnU5Atdyt
oUeALrHwhOnQ9t4Y33Xs2jYlgO4G+yZxc4ItnkWqlMhsVNBsAQ5ZedhW5oHFquPU
w2adM76VB5J3YmbfK2MF7IktOOVb87uox610S7yuGgBqIaD+D7MLkAniI6r337L7
eGbnEyTS3XqY9X08etyQSn9ay1fZk3wiZLDHOfkRunPuYqyhRXJy+0LMIDC7F+3Z
aPkRJw/VO7FNVxOGDUzXBKLV0lTn6AuSZUh+2KdEUpAnPwJ/bd1+tDnNR7u7hx3a
aB9L31iYw4T2YCQ8ZDfpGz5/ycVRs8evZ4pp6Nw1t+IGQ8wXDARLOM5ygGN3KyPt
9XICd8fWLcpOWlUc5abVsjEv3Y8AA6gVoc1B5ZkHRP48qkvYxH4Q2xT2pF0ahmMr
0mKaOFFQrUzd7X0PJziXbn3tFc6TCv/+XPw5CddVViSe3mIin7n33rR3XuKt0Ix6
PeM0Udl25xkA+KX8HjQ/
=XlkI
-----END PGP SIGNATURE-----

--5o+xNwJos2W1xoQY--

--===============7130423075006462913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7130423075006462913==--
