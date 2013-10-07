From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Mon, 7 Oct 2013 21:45:57 +0100
Message-ID: <20131007204557.GU21581@sirena.org.uk>
References: <20131003181754.GE27287@sirena.org.uk>
 <5252EDE2.9070902@codeaurora.org>
 <20131007174448.GT21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8181275973716235200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7300C265193
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 22:46:08 +0200 (CEST)
In-Reply-To: <20131007174448.GT21581@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8181275973716235200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ImSVV91IQg5ga+3z"
Content-Disposition: inline


--ImSVV91IQg5ga+3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2013 at 06:44:48PM +0100, Mark Brown wrote:

> What are the problems you're seeing here?  This used to be a big
> problem for modern CODECs with big sets of widgets and routes but the
> optimisations I did a while back (which made it into v3.4 so I think
> everyone is using them now) and the work that Tsutsui-san did in v3.10
> on improving the graph reset got it reasonably under control for the
> systems that I was aware of having trouble.

I did think of one area that might be usefully improved here - we
currently don't do async I/O for any of the DAPM generated writes.  It's
not going to be anything too massive but for faster buses like SPI or
Slimbus it should deliver something.

This would require an annoying amount of plumbing in regmap to pass
flags around but might be worth it for faster buses.  The core I/O code
is fine with it but the abstraction to allow buses to hook in at the
register read/write level makes this more annoying a refactoring than
I'd like while we've got all the ASoC conversions to regmap in progress.

--ImSVV91IQg5ga+3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUx2BAAoJELSic+t+oim93PcP/j0q8n7uQddga1LQ4J3lJelD
lExlD+DlkBuMhsASq0lTFNwBui3bIe+wgej9wjUJ/qZFJI4rYPEN/VHWJD1oWrVI
kaF/IgNaBmKaGLv5FcsCtloSwGpPJ6IDC0Ncs9jsXiK+Ep1BW2a9G34oyRPNPmnJ
o8kS9dGMDPaGs2T5gSzTRDNy21nqsmBnMu/01v9mL2Kw1Xo85bg6QtfHkn3VELsc
QEvwIxQXAy4zVg3CJLuOVMLKc7sVxwOnGfDv/zATkfrZeB42UHVPKZnnU6zlZJ5e
m+orYZ57usItxBw95JVfp1GoUx0fmeld2lIeBgLltXaZMQpdlmiYZMQZcAtL3d/F
QQnw+yZQNibH7cIwuLtDLwlX9OyvDtBscHQCzsuDgwjcAIDgKvJ5euVYsFHKwZYY
CiZ0z9JxBZAOAA+jvK/fFr2Sdw9BI3Fm+lcda9zMnaYwCrVlxIhZDt81HfzXvaZo
7LckuzPpI7PoULSrE3gjs0E83v21t5o8cO0rReUWs9dWtvgK40xlcupIGFOdLvdl
h3y1N9lkOaLPgimzO0SxuGjndCZRVUHkNxKUEF3c7/XnCF0qhC/qHyFhisnNr7ZO
AIhIpdo5vBkMHA0V9ahiJm2f9okc0MhkikvBlbWQoMINrWgJFki3mj83JVAgKP/h
CF7G4PDIgkoShmnI3B/E
=nuYE
-----END PGP SIGNATURE-----

--ImSVV91IQg5ga+3z--

--===============8181275973716235200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8181275973716235200==--
