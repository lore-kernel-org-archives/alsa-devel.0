From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Tue, 8 Oct 2013 10:34:13 +0100
Message-ID: <20131008093413.GX21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3099869832152892465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1897D26518E
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 11:34:20 +0200 (CEST)
In-Reply-To: <20131008082933.GA19005@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3099869832152892465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggEtdcIX3XIOBw6T"
Content-Disposition: inline


--ggEtdcIX3XIOBw6T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2013 at 10:29:33AM +0200, Markus Pargmann wrote:

> To make proper error handling and only STOP functions that successfully
> started, we have to store the state of each function. The command error
> handling is done in pcm_native.c so we don't have any influence on that.

I meant just unwinding the things done in the trigger call.

> Another possibility is to explicitly allow multiple _STOPs. Then I could
> fix the driver to store the clock state. But I would prefer a generic
> solution.

You're going to have to handle this anyway to be robust - what happens
if it's the clock enable that fails?

--ggEtdcIX3XIOBw6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSU9GRAAoJELSic+t+oim9jK8P/0MTr9Gy9FoIzS/xe3oXpiND
qpHRAAMs7vEs8RXP8fCP47AV9zkzTkGqxgqWe0hvCMRoy1KaW6qu2LRbYllWUr+m
0sAVMIsf1RG9Uy/s+wcf+3NEf91VSCgdoe5OT7/J4e4pr9N6FbIxirT2XosTvSob
3179xQub51PzM/HV9rXffgSC0VE80evg6lTRY9W2umz337GWdUxtzIqPCcMQAdK3
4LQnRwubK4grSHKFf39UWwTC3aO1scYaL/2EWt53Xmrqr0MlOjWu5I0uS3jwdUsl
r4SCK/ZnpaU0SzX6tohPiVGTAz+b4xLHHWdwAQW1OcPeGahxQnbJwLcEfnkAXd6P
2wxBM5/LicgVM4nKd0DPIOqjrJLlDLKYEnWp8vl2l1phCh7T5BcRaXoGY4kJEfX5
FxtJUlMYPrKRNpCANDRGH6wcvhQnFcmLVjYaW4C6LyIKO0dVv4VgSDPQdZ43GlEI
t8nXs8m/93BYa1l+hNCgk5RSjkxaUMhB/HET0dXlTptN+fWAY/AS8SWqSM2JZClz
sJpmgd87kiAIdx29GRFHK7JuZkDTz6N/2JGq+ztGnLqJX+xeA1yDwhRxzgjxxbd+
Sog0c2NLWcA93wgiE5l0GkaOXMQn28TKll59xZcAZSu/PRQ37gCw9iz1fVcOQ124
V5Fo2RH9FATbDee1s5iE
=U7xW
-----END PGP SIGNATURE-----

--ggEtdcIX3XIOBw6T--

--===============3099869832152892465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3099869832152892465==--
