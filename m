From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/10] ASoC: Add support for dummy DAI
 links and PCM runtimes
Date: Fri, 14 Aug 2015 21:22:10 +0100
Message-ID: <20150814202210.GQ10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <0364569ce2898a20d08243ba59a92973b2dc4735.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5631125723579816664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF512664D4
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:58 +0200 (CEST)
In-Reply-To: <0364569ce2898a20d08243ba59a92973b2dc4735.1439217448.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5631125723579816664==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a1taQt+5gib656GU"
Content-Disposition: inline


--a1taQt+5gib656GU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 10:47:47PM +0800, mengdong.lin@intel.com wrote:

> Add dummy flag to a DAI link and PCM runtime. A dummy link will create
> a dummy PCM runtime.

> A machine driver can define dummy dai links to specify the expected
> platform and codec. And its dummy runtime is used to probe the platform
> and codec components, which can bring real DAI/DAI links based on topology.
> After components probing, all dummy PCM runtimes will be removed.

This isn't very clear to me either in terms of the description or the
interface.  As far as I can tell these links that are being created here
are placeholders representing links that will actually be instantiated
later but if that's the case they're not really dummies as I'd
understand them, they are real links which physically exist and will be
created later by topology data.  If we are going to do things this way
we need a better way of talking about these not yet instantiated links.

I'm really confused as to why physical links that exist in the board are
coming in via topology information loaded from userspace - it's not like
the DSP firmware is going to be able to physically connect the DSP to
things where no links existed before.  I'd expect that these links are
connections between physical devices which just exist in the system and
that while the topology information might leave some of them dangling
they wouldn't be created or removed.

Presumably we're also going to need to handle the case where the
firmware is unloaded and we destroy the links if we do this...

--a1taQt+5gib656GU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzk3yAAoJECTWi3JdVIfQtm8H/3o3e2ol7duZ+zAiV33y/5Zf
Tu52IQhyGPucl09GxIOeQc39uu6dfBHGHAJ60fz0MTvOfekw/FwAlgk7Fdm77LLZ
3fiV98YrfgEXs8FiOaP7JL5GOhrIZh/wDEYAYdwhvy/DXO+7UYmm+JTq66uK1OvO
aclXFs5O5qN2r8Ebo43kV4wiTMuFcqSuvRrE7Zd6CtlWLxR+3yrTaHXBb8IqSamA
j4Gg5eVfvSSN/mdmaZmi+u8otv3eXcYSigBNUAdluhud797q4bVGAWa6NKd6D70Q
yjpR2RdgTPGGnx3CPlSp8Hcgs0K41Nf425UHij2v/m095ZFJX30RKmmYlanuIB4=
=1Pec
-----END PGP SIGNATURE-----

--a1taQt+5gib656GU--

--===============5631125723579816664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5631125723579816664==--
