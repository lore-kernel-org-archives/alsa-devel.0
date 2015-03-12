From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Thu, 12 Mar 2015 19:54:20 +0000
Message-ID: <20150312195420.GB28806@sirena.org.uk>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9209488429956638151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CB626060B
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 20:54:29 +0100 (CET)
In-Reply-To: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, vinod.koul@intel.com, mengdong.lin@intel.com, jarkko.nikula@intel.com, yao.jin@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9209488429956638151==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sjH5kukjteSWPjDM"
Content-Disposition: inline


--sjH5kukjteSWPjDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 10:31:55PM +0800, Jie Yang wrote:
> In order to prepare for the upstreaming of Skylake drivers and to
> allow reuse of code between different Intel audio DSP products,
> this patch series restructures the Intel directory as follows:

This is all fine by me - I'd just like to see an ack before we do this
=66rom the other Intel people to make sure they're not going to get
surprised, and also make sure that any in flight patches (particularly
bug fixes) get merged before the rename since this will make it easier
to apply things.  Indeed, do we have an ETA for the Skylake code?  If
it's not due before the merge window then it might be best to apply
these (or changes like them) at the very end of this development cycle. =20

--sjH5kukjteSWPjDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAe7rAAoJECTWi3JdVIfQWCQH/2pjhRZvd0CrVyOgasgBGy1S
V5/iHLPzfP9I1Je5wNk429oFJUBP57OtbYm0atcPDa1yez3tD0PjUBFURT1pF70G
ZRz7GIKGgdGIj6NmpEbQaHpLKMp+/9FXWeIlLfWXIKMnsy4rU2e/LYzDpnMM8Tv/
Pd/Hm0NsEmmDYOgWAfwA5hXavWc13qU0t/tXDqvmdse5umDvJcwm17mLIZiCttkQ
T5kgsUjXVJCFlF8mp0j3v5ncLjxsOvq+SlUr9vFAIv4uVcDe0FYaSUsFw2g7QY67
9qmXZHXNJ/R4jS9ficqF/BTIyhJdCfjqo5A64O1nThSaGahBD36JjBgOVVR0ljg=
=xtwU
-----END PGP SIGNATURE-----

--sjH5kukjteSWPjDM--

--===============9209488429956638151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9209488429956638151==--
