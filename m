From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 04/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Fri, 8 Jan 2016 19:29:50 +0530
Message-ID: <20160108135949.GN11778@localhost>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-4-git-send-email-subhransu.s.prusty@intel.com>
 <20160108134217.GR6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4316686111423612273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2956126040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:56:17 +0100 (CET)
In-Reply-To: <20160108134217.GR6588@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4316686111423612273==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 01:42:17PM +0000, Mark Brown wrote:
> On Wed, Dec 09, 2015 at 09:46:11PM +0530, Subhransu S. Prusty wrote:
>=20
> > This patch uses i915 component framework to register for hotplug
> > notification. And once it identifies valid pin sense and valid eld,
>=20
> You say this patch uses the i915 component framework but...
>=20
> > +	if (pin->eld.monitor_present && pin->eld.eld_valid) {
> > +		/* TODO: Use i915 cmpnt framework when available */
> > +		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
>=20
> ...that's a TODO according to the code?

ah sorry, Shubranshu meant use i915 eld presence fwk when available.
Takashi was working on it so we will convert this to use shiny new
framework a bit later :)


--=20
~Vinod

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWj8DVAAoJEHwUBw8lI4NHJw0QAKrD/xaFaTC/QY0G1Dg4SjQg
kPjCeo4KS4lPKdTSay0vRDC0uI62gUfWCc4vehuiSKvVwBOkRIOXjj2MQ1ZWhs6x
MuD8+/8uNE5y1VZLioyLDDCr+hz73Sjyyv8xeOg2DXB5wqwK3V2e05zdBs4sgLXA
lNWdrzB/pvtkmzruZ/JZU1TLM61cDVY6MX4IacWKNZ7PaVw39RbJZeHnNfS3pZG8
B1qyRuN8/lbwWR8UhhD9MK9ewgsQ+AuqTg30v+OuHp6lt7k6cy/Zj/zKf4maOAS9
Xx27bUldQFnCP9WTP1TNJNoQ4UmUC9c3Q+QxrR1MZI04mS+7Fu8xxlUpKeMrZ7oq
EgaU7zA6sK0DeRoq3NMaobxKXkzd0I3V+jFIxiSradz7eiCx09LzpnqbbDL5EF9F
PATAfV2Y04XaxdsXC3f0Ybzpi4GTwM6VyrYVeLblMIvGvZ1Sz0j2M5qYpiC0UwYJ
yCqxWRJ0bmw+jz/ZvqQ6OcS0Ao7LjU5fGpW3XvXAgbqA8bdgWw7gnGClerYPk+e5
XtN8ezOdyK29DAYeiMMt7LQjyehTqxCLubW+30WCXH2TGBjRLgmMhsAYNmL4Xy6c
I5qoBIIdtP4TiSxw7XjFa9MyVlQOoVVlC3PTdZtyya/A37MlzmwSvokeYVJfxm0I
ssdvPNqCpMjKgT3OxrwQ
=IiND
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--

--===============4316686111423612273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4316686111423612273==--
