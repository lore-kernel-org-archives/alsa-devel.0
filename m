From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
Date: Wed, 23 Jan 2013 23:48:12 +0800
Message-ID: <20130123154804.GB4565@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6654928875579751763=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5F51265315
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 16:48:24 +0100 (CET)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob@landley.net" <rob@landley.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6654928875579751763==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 23, 2013 at 12:39:35PM +0000, Hebbar, Gururaja wrote:
> On Fri, Jan 04, 2013 at 17:56:12, Mark Brown wrote:

> > The CODEC driver biases should be changed over to be supplies, this
> > makes the above much more natural - the routing there is a hack for
> > older versions of ASoc.  Otherwise this looks fine.

> ON TLV320AIC3x Codec, MIC Bias power on/off share the same register bits
> with Bias voltage output.

So you need to use an event to write the actual enable bit.

> SGTL5000 --> Single register for MIC BIAS enable & output impedance of MIC
> Bias. The driver uses SND_SOC_DAPM_POST_PMU & SND_SOC_DAPM_PRE_PMD macro to
> handle the MIC Bias enable & disable event.

This is the way these things should be handled.

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAAXBAAoJELSic+t+oim9rrgQAISesYdjuKRSOr7Cl6Wov66E
W8yoSKFgyszYduCsI6vvqbsTYdIWo959GrZ8iL07K5IDKQcIVOW3mAvwiHwnSRA6
WUNNeYV8xVuF8ydqgOA5Ak7BHfhnbJg7PQ05QE8bCHD+Y5j5ROKFdcE8pLIpyJXk
dzzB1f8RQ7U03kOvQbfRvFhCJguK+NJZRG31LPj314wbrXNqk5j66fwNWZIR2ALO
mJWVlG5cdZ5T5wPhbW3QLcFY9sCOm8yIWvnt4qbm49VFWrS+UPDA07Hi4CJtURUq
VBPJuoXPcalzwgG2rL9efn2qY21ZDx34GplICMFEncVMuuQbwWmrwmSPdYAuM9ns
KLBiO+mFmJxvFv5SYWUkj0n7X7HFsWsKD8+4Ohes6Z1CeLYk+oLjojH6PNQ6bsg0
JeMNv10hCTszfzCr79nEY7v0sbkeZhVFY3A2RLXWzEUb5kFE5wV5oXT/9O0yFVGi
Plbx1P7WTyzKqEp/Z++vgt3gEsjVKKgrpkNgkK5UZzi0Fu4VqaoWrNTIVu554dqv
n40c1juxtZm8HUa1nC21MNmHL7TPRv6elXPjJdIME7puh7QaT0l4KIHw58oRemlQ
alyCXrFcR0bO2W63wIcYOKL9XhgBBjaFQTiwGD0EIRg2/3yXPstleMeF2D0nA6W3
XCvL/4nH/KQKLC0VWidG
=C8iW
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

--===============6654928875579751763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6654928875579751763==--
