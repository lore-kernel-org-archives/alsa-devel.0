From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/9] ASoC: Intel: move PCI probe to a
 seprate	file
Date: Thu, 30 Oct 2014 17:31:12 +0000
Message-ID: <20141030173112.GF18557@sirena.org.uk>
References: <1414666312-4657-8-git-send-email-vinod.koul@intel.com>
 <s5hmw8d4n1c.wl-tiwai@suse.de> <20141030143444.GA28745@intel.com>
 <s5hh9yl4lyq.wl-tiwai@suse.de> <20141030153719.GE28745@intel.com>
 <s5h7fzh4j3n.wl-tiwai@suse.de> <20141030155947.GF28745@intel.com>
 <s5h1tpp4i58.wl-tiwai@suse.de> <20141030161428.GG28745@intel.com>
 <s5hwq7h32rv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5631381275943256426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E0C260682
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 18:31:47 +0100 (CET)
In-Reply-To: <s5hwq7h32rv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5631381275943256426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7CFpnXo1AEAmHop"
Content-Disposition: inline


--c7CFpnXo1AEAmHop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 06:07:00PM +0100, Takashi Iwai wrote:
> Vinod Koul wrote:

> > snd-intel-sst-pci-y += sst-intel-core.o sst_pci.o
> > snd-intel-sst-acpi-y += st-intel-core.o sst_acpi.o

> Kbuild doesn't allow this syntax, AFAIK.

I've not followed the whole discussion but why not just have the core
code as a separate module, this seems like an awful lot of trouble for
something that's normally straightforward...

> > well both can be compile tested and we will put in symbols about limitation
> > of having bpth apci and pci as built-in or module.

> No, the point is that the exclusiveness in Kconfig level gives more
> demerits.  This makes impossible to build the both codes in a single
> shot, which makes also impossible to cover wider build tests, etc.
> My concern isn't about the actual operation but about testing.

> That is: don't try to side step such a build issue.  I bet it'll
> strike back later.  Better to keep rather the simple and common
> approach other drivers take.

Right.

--c7CFpnXo1AEAmHop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUnXfAAoJECTWi3JdVIfQSGQH/jqoK3srOG4FgrX5QodCAlf+
vHNferMsH97Bn7wUDIGiyRt75LevArv49ZOJgbSjxO4NYwuVbSO5ZQxBZpHUNAnE
BmGC55hOKt3bTWdXrx2kPAVYyDBlffMXcxPBWXPj8Zf3Q/gvcC09dFjZN5ahePM1
M9BggWLYDv8mrcP1VTV4F+tsB9HLcfMN1TZ8xiHwC7bpF2HTItx7bPV41mw+vSG5
9XWgFPte5L/N/7BAixNq5Q1/O5k8Nb9UrEpCEcD8EoLL8poiaQo+UC2nuLtonptL
7YreE/1GnCoqtw1I683D/7eqOvSbJLZ15BHlRKYvNBqZ59Pao1YJIBQUYkPldOs=
=+J9k
-----END PGP SIGNATURE-----

--c7CFpnXo1AEAmHop--

--===============5631381275943256426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5631381275943256426==--
