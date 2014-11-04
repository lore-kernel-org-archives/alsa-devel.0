From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] AXD Audio Processing IP ALSA support -
 Questions
Date: Tue, 4 Nov 2014 17:41:50 +0000
Message-ID: <20141104174150.GT3815@sirena.org.uk>
References: <20141104104002.GH1870@intel.com> <5458C0CA.9080903@imgtec.com>
 <5458FB68.407@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3363285526409977626=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95C4C260625
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 18:43:12 +0100 (CET)
In-Reply-To: <5458FB68.407@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Qais Yousef <qais.yousef@imgtec.com>, Clemens Ladisch <clemens@ladisch.de>, Neil Jones <neil.jones@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============3363285526409977626==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pP8l8ytKVQui4K7o"
Content-Disposition: inline


--pP8l8ytKVQui4K7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 10:14:32AM -0600, Pierre-Louis Bossart wrote:
> On 11/4/14, 6:04 AM, Qais Yousef wrote:

> >OK. I need to read more to completely understand this to be honest. I
> >don't know what's an FE and I don't know how they can be 'routed'.
> >That's why I was hoping to get an example or a pointer to anything that
> >does a similar thing.
> >Just to clarify, all the necessary bits are there and I just need to use
> >them?

> Front-ends are typically 'logical' streams visible to the host.
> Back-ends are typically physical links.

Well, they're both physical usually - generally the front end is the DMA
stream that userspace interacts with while a back end is an electrical
interface on the edge of the SoC.  Either can potentially be virtual,
though most implementations do have something physical behind them (a
DMA controller for the FE, a physical audio interface for the BE).

--pP8l8ytKVQui4K7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWQ/eAAoJECTWi3JdVIfQkikH/R14gacCUicB8BaWyclWpXkv
ZN4SmrNyPozkIJmTv36olzMvzr8oX+3UWyk+HQxhxw0OTDmGEQpNYfYbkgkhf+5C
K5X6WhMLthL3FwLHx05L25zQq0MT9611NPXACKvqc/6FFGVOUxPCVbxUW9YvN2df
ZkcELvKBjGxQBOomqDT6qK2r1SnYfCutX/+FIO1AAQj6z+NLW5k0zUNBUTYZi80x
JChg/zPS3Jl6Nl+IqACk8ejGeG28rqv9kkIwhpQtKCaEUNa0P8uk8Cbi8fdot0rU
mVL7bji6st8kn16cD3A4Nw7QTcc35/4yChHnkSG+iEVGhUoudAYOpnTplfPrtIw=
=b6Iz
-----END PGP SIGNATURE-----

--pP8l8ytKVQui4K7o--

--===============3363285526409977626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3363285526409977626==--
