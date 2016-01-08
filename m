From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 04/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Fri, 8 Jan 2016 13:42:17 +0000
Message-ID: <20160108134217.GR6588@sirena.org.uk>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0713138298835853761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ECA626040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:44:30 +0100 (CET)
In-Reply-To: <1449677781-7997-4-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0713138298835853761==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q6K/XF9FZiHksLwH"
Content-Disposition: inline


--Q6K/XF9FZiHksLwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 09:46:11PM +0530, Subhransu S. Prusty wrote:

> This patch uses i915 component framework to register for hotplug
> notification. And once it identifies valid pin sense and valid eld,

You say this patch uses the i915 component framework but...

> +	if (pin->eld.monitor_present && pin->eld.eld_valid) {
> +		/* TODO: Use i915 cmpnt framework when available */
> +		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,

...that's a TODO according to the code?

--Q6K/XF9FZiHksLwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj7y4AAoJECTWi3JdVIfQha4H/R0bDv3jkJ26Sn7HVmTlT8Xk
XG+p4ZuYJJJuHGzE+wxw1vBzp3a+jsQWWfKihLKYNG/rFlPZU+62TzNKkXX/cZvo
f7Gz8x60EBFyLqKSBd2DH8sqT55MSCuuS6d0KGfr4hdRjDQ2R4HZTTEaMEGFijBA
PmLh/wgKBPvz76K+Fg+E+znkR9vZ8wRC9pKxNXbOzu6YXdELWScPYKwdnLCxevPP
UZLimb5sp5xZJqrF8YLEs+nqQc2xC+5xmNhk2UjXZRUc2djzhA4CXUlwx3i/FaNf
ttrhWoJ9GQ7IJ58jwCb0j6T6IT/vuMnjplN6zbc9Kpnhqc05+05zpZtRUEQ2aqs=
=6PYz
-----END PGP SIGNATURE-----

--Q6K/XF9FZiHksLwH--

--===============0713138298835853761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0713138298835853761==--
