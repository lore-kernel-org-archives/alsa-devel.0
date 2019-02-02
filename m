From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Sat, 2 Feb 2019 15:53:45 +0000
Message-ID: <20190202155345.GM20797@sirena.org.uk>
References: <1549049601-26177-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4399252490934406646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A6EFE267477
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 16:53:47 +0100 (CET)
In-Reply-To: <1549049601-26177-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4399252490934406646==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z1Z8UV8BNhgCynIS"
Content-Disposition: inline


--Z1Z8UV8BNhgCynIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 01:33:21PM -0600, James Schulman wrote:

> +  - cirrus,boost-peak-milliamp : Boost-converter peak current limit in mA.
> +  Configures the peak current by monitoring the current through the boost FET.
> +  Range starts at 1600mA and goes to a maximum of 4500mA with increments of
> +  50mA.
> +  (Default) 4.50 Amps

This is a required property according to the code, either the binding or
the code needs an update.

--Z1Z8UV8BNhgCynIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxVvQkACgkQJNaLcl1U
h9A+SAf/U/eH0QYGoZgirCK69EYgMIw7POtpU9VCOQvqYuWslfqyavZjsLyzzpSk
aUFxP3wmCzQmhWmwGtUH9rMI/ZCMyJLqG1Vb8Ou6OeGOWg2gaaDpLrucUsHcWQlw
h0IthOJnCOG446QfFVraN9MyIUy1R4cUs3uXutG5UE6pPtqRhxGWvyFnCd1BhfSO
WKpF/lFS1NFzZVWe+XDpdRzcLOwA+fb734fQkkzNL3PaxhkNtdydEajU9r5XxuzR
5WlR80issPedkvl34hWQzwZVjMhR0h5IVIOatc6JEJe2PxWJiQLjbkQawz9Ur4mi
uLwWhhAeSlPqeCSNxfgQfHsPR/mLlA==
=4UiH
-----END PGP SIGNATURE-----

--Z1Z8UV8BNhgCynIS--

--===============4399252490934406646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4399252490934406646==--
