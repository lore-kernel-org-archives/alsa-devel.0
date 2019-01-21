From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Mon, 21 Jan 2019 19:17:14 +0000
Message-ID: <20190121191714.GG12679@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5171187491011329269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C8B026680F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:17:17 +0100 (CET)
In-Reply-To: <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Rohit kumar <rohitkr@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5171187491011329269==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 05:02:08PM -0600, Pierre-Louis Bossart wrote:

> This PROBE_DEFER support actually breaks the topology override that we've
> been relying on for SOF (and which has been in Mark's branch for some time
> now). This override helps us reuse machine drivers between legacy and
> SOF-based solutions.

> With the current code, the tests in soc_register_card() complain that the
> platform_name can't be tied to a component and stop the card registration,
> but that's mainly because the tests are done before the topology overrides
> are done in soc_check_tplg_fes(). Moving soc_check_tplg_fes() from
> soc_instantiate_card() to an earlier time in soc_register_card()
> works-around the problem but looks quite invasive (mutex lock, etc).

Right, I see.  I don't think there's going to be any non-invasive
solution here, either we need to stop overriding bits of the machine
driver relevant to binding in the topology files like this or we need to
look at the topology files in the probe deferral stuff so it's either
going to be very invasive for the machine driver or the core.  I'm
tempted to say that the machine driver is a better option here.

> This last assignment guarantees that memory will be allocated every time
> this function is called, and whatever overrides are done later will
> themselves be overridden by the new allocation. I am not sure what the
> intent was here, Curtis can you please double-check?

The intent is to avoid modifying statically allocated data so we can
tell the difference between pointers set up statically as init data and
those that are filled in at runtime.

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGGrkACgkQJNaLcl1U
h9BbKQf+J6unfU3lGiLZVjb2hKojpp7QoEMpMTY0qRP0NuUfiBlBrRpkIq3i9hR7
wBcqNI2lRBh3sb03R5kdkD2wDzw208wVDscH7ijeKp+k0UbZwkhNthr0U3+EJFt0
5j/yLk2fcNhMRnMvyucc0ChXQjsUsYLaCZIswO3FfSuFp3jOSHGx15Dc6E8yY8xQ
ziU8h02vga+M9RHBtGFcDDXlxmaPw50gWlDeMmkI9HsCYeB6N8xdmYNtj3t5XKS4
PiJTkvlFVKptngEK+5fzRJuluQijWGrkz3nDEOqMh/7m61GrIHm3lDpAsiFOq1Um
9/7KmsmyOJOgziIOwa7iIIFQJf1fEg==
=J68C
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--

--===============5171187491011329269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5171187491011329269==--
