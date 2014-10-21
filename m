From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: Intel: Make ADSP memory block
 allocation more generic
Date: Wed, 22 Oct 2014 00:02:24 +0100
Message-ID: <20141021230224.GF2344@sirena.org.uk>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6328201911536125909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F95D2614F1
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 01:02:43 +0200 (CEST)
In-Reply-To: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6328201911536125909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 03:06:46PM +0100, Liam Girdwood wrote:
> Current block allocation is tied to block type and requestor type. Make the
> allocation more generic by removing the struct module parameter and adding
> a generic block allocator structure. Also pass in the list that the blocks
> have to be added too in order to remove dependence on block requestor type.

I'm having trouble apply this - patch 1 manages to apply with some fuzz
but patch 5 is failing.  Probably needs refreshing against Vinod's
recent changes?  I applied everything up to patch 4 (ASoC: Intel: Add
runtime module support).

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURuX/AAoJECTWi3JdVIfQOoEH/1OVqXU6Ucsmx/QIi9VWu64W
vwNJdG+NCCrgR6C5OyvCBF8l0YkV+U62u1/NVdWxspnWhye0LxVLusv5h5kWqq03
MTlu5cg2Yjn8POztUFZkVcnLmIxJpCgvaT2bcpbjBm3l7bc3kaAzRBK5FRO7CyIt
qvie+UkOFEoVCHYtraw71c7yRLRZvDzVaNy6fasN1i3/6W+at0MAv06hrHM1T5C0
5JHvE0lB2WMy7AckFO/lSGX79QbldBktm0Ry5yEZZ2Iphae4dWrkcYo9xyeGq1XX
ozzMbqG4h1hgiAe0LSjwWOchgfw6lqzFQkVCtULekuWDEHuwpYksOfLSUxIUfZo=
=B9GP
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

--===============6328201911536125909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6328201911536125909==--
