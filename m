From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/10] ASoC: topology: Change stream
 formats to bitwise flag
Date: Sat, 15 Aug 2015 08:14:01 -0700
Message-ID: <20150815151401.GF10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
 <20150814203428.GR10748@sirena.org.uk>
 <s5ha8ttypc1.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D04D0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5067433885446405009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DA8426513F
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 17:14:07 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8480D04D0@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5067433885446405009==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EzoGi9kFQAnUjl0a"
Content-Disposition: inline


--EzoGi9kFQAnUjl0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 01:49:42PM +0000, Lin, Mengdong wrote:

> Is there some topic branch which can accept topology patches for next
> kernel release?  Can we change topology ABI in v4.3?

You're not quite getting the issue here - the problem is that once we
have released the ABI we need to keep supporting applications using it
so we can't just change the ABI, we also need to keep compatibility code
for the original ABI.  This makes it a lot more effort to change things.

> Now only Intel SKL driver is using topology code, so the affect should
> be limited.  And I feel using bitwise flag is simpler in both user
> space and in kernel coding.  We can increase the topology ABI number
> when there is ABI change, and the topology driver always checks this
> version.

Someone else may take this kernel and use it in their product, or some
distro may decide to ship v4.2 as their kernel.  Once it's in a release
we have to assume someone is going to start relying on the ABI.

--EzoGi9kFQAnUjl0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz1c5AAoJECTWi3JdVIfQ3H4H/iYSD8BdRVt/+kINCc2AXBiv
yhkElRktS3U/8m64x8GMwxGh/l7JimtpAGFrJ47viznlYkabs8FPxisqo1cWQ5Ob
Rd14i4DZArbmgjT+8wQHft6kcMJhMz9ROLy05KcY6wwDxjqpky+nKWRtDvH6kRmv
i9V9mFU933mAEnOlOYt+99QydqbShmIPkiw+YvqIKPRQki3Pj2pq43Plxie4lCD1
BNdmhEAaka/J9SPwiZ3byfV48gNL00hveZgJY9Pb1/bzn+n1RQvFn0/SopaSJhNg
x4nDVqlPcqHx4sG3gM8Pa4mTiyCNZJMRNlPdP6sG6lMqd0aAzai4z2G2Y1Lhvxg=
=v6yE
-----END PGP SIGNATURE-----

--EzoGi9kFQAnUjl0a--

--===============5067433885446405009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5067433885446405009==--
