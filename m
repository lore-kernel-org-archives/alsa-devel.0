From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: topology: UAPI updates for
 TLV, ops and types
Date: Thu, 6 Aug 2015 11:16:31 +0100
Message-ID: <20150806101631.GR20873@sirena.org.uk>
References: <1438782075-19977-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4267161450090300551=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 289032604B5
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 12:16:41 +0200 (CEST)
In-Reply-To: <1438782075-19977-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4267161450090300551==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RV7I0FBcf2xGtwa1"
Content-Disposition: inline


--RV7I0FBcf2xGtwa1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2015 at 02:41:12PM +0100, Liam Girdwood wrote:
> This series updates the topology UAPI to allow easier addition of new TLV
> object types, generic operations and added a private data type for the kernel
> topology core.

Takashi, are you OK with these?  We'll need to update both the library
and kernel, and ideally get these into v4.2 so we don't have the old ABI
in a release.

--RV7I0FBcf2xGtwa1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwzP+AAoJECTWi3JdVIfQLT0H/iTgRF79kJX+jF6S2vik9NIc
OazP1MmuKdQL1h1Hg/wf5duUuerGGqFEbTemPbflh+TNgw/8lNHjOXS78lMVT5ne
r4Pd9A7iuokxffJjjzfVvKAHkVvCasWKN2p7k0Hf5QDgjWkjpvXoG2vtkRVdwjHC
fdkk/AbHJ/fswsYXUIFuSltqWtP3Tx1oQAOjhSlaAUAn1dfR1MyAnmNpzjRP/enk
EgePaBeJP+qbrPYkwmo4+ASjBIs3MTVHh7dMy4l/KUSY6kgwGAXkpWXnjiO10goa
VFiM+5Imc1KGqgkkJrtk13r6vr3B6xOp3bE6mwuBCpydwVGaKBpq7O+YV8jjqa8=
=dJZL
-----END PGP SIGNATURE-----

--RV7I0FBcf2xGtwa1--

--===============4267161450090300551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4267161450090300551==--
